####################################
#
#  Dockerfile for Root the Box
#  v0.1.3 - By Moloch, ElJeffe

FROM python:3.8

RUN apt-get -qq update \
	&& export DEBIAN_FRONTEND=noninteractive \
	&& apt-get -qq upgrade -y \
	&& apt-get -qq install -y --no-install-recommends \
		build-essential \
		zlib1g-dev \
		python3-pycurl \
	# Clean up
	&& apt-get autoremove -y \
	&& apt-get clean -y \
	&& rm -rf /var/lib/apt/lists/*


ADD ./setup/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt --upgrade

# Create a new user guacamole
ARG UID=1001
ARG GID=1001
RUN groupadd --gid $GID rtb
RUN useradd --system --create-home --home-dir /opt/rtb --shell /usr/sbin/nologin --uid $UID --gid $GID rtb

# Run with user guacamole
USER rtb

ADD . /opt/rtb

VOLUME [ "/opt/rtb/files" ]
ENTRYPOINT [ "python3", "/opt/rtb/rootthebox.py", "--start" ]
