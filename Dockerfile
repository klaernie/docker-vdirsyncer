FROM python:3.8
LABEL maintainer="Andre Klaerner <kandre@ak-online.be>"
ENV LC_ALL=C.UTF-8 LANG=C.UTF-8
RUN useradd -m -s /bin/bash vds
RUN pip3 install -U pip; \
    pip3 install vdirsyncer requests-oauthlib
USER vds
RUN mkdir -p /home/vds/.config/vdirsyncer/
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
