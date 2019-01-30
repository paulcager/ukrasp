FROM centos:7

ENV BASEDIR=/root/rasp/ \
    NCARG_ROOT=/ \
    PERL5LIB=. \
    PATH=$BASEDIR/bin:/usr/local/bin:/usr/bin:/bin
    
RUN mkdir $BASEDIR
WORKDIR /root/rasp

EXPOSE 80

# required packages
RUN yum -y update && yum -y install epel-release && yum -y update && \
    yum -y install ncl netcdf-fortran libpng15 iproute-tc tcp_wrappers-libs sendmail procmail psmisc procps-ng mailx \
    findutils ImageMagick perl-CPAN ncl netcdf libpng libjpeg-turbo which \
    zip vim wget lighttpd bzip2 && \
    rpm -i http://ftp.tu-chemnitz.de/pub/linux/dag/redhat/el6/en/x86_64/rpmforge/RPMS/perl-Proc-Background-1.10-1.el6.rf.noarch.rpm

RUN mkdir -p /root/rasp/UK{4,2+1,12}/{LOG,HTML,GRIB,OUT}
ADD dotfiles/ /root/

RUN cd $BASEDIR && \
    curl http://rasp-uk.uk/SOFTWARE/RASP-V3/raspGM.tgz | tar xzf - && \
    curl http://rasp-uk.uk/SOFTWARE/RASP-V3/raspGM-bin.tgz | tar xzf - && \
    curl http://rasp-uk.uk/SOFTWARE/RASP-V3/rangs.tgz | tar xzf - && \
    curl http://rasp-uk.uk/SOFTWARE/RASPtableGM.tgz | tar xzf - && \
    echo "First set of downloads complete"

RUN \
    curl http://rasp-uk.uk/SOFTWARE/RASP-V3/UKregions.tgz  | tar xzf - && \
    curl http://rasp-uk.uk/SOFTWARE/RASP-V3/PANOCHE.tgz  | tar xzf - && \
    echo DONE

RUN sed -i 's/pauls@localhost/admin@localhost/' rasp.site.parameters && \
    cp rasp.site.parameters UK12 && \
    cp rasp.site.parameters UK4 && \
    cp rasp.site.parameters UK2+1 && \
    echo "Finished rasp.site.parameters"

CMD ["bash"]
