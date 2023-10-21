FROM python:3.8
LABEL maintainer="Andre Klaerner <kandre@ak-online.be>"
ENV LC_ALL=C.UTF-8 LANG=C.UTF-8
RUN useradd -m -s /bin/bash vds
COPY requirements.txt /home/vds/requirements.txt
RUN pip3 install --no-cache-dir -r /home/vds/requirements.txt
USER vds
RUN mkdir -p /home/vds/.config/vdirsyncer/
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
