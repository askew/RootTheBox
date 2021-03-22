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
RUN pip install --no-cache-dir -r requirements.txt --upgrade && pip install --upgrade pylint

# Create a new user dev (1000 matches the default user in WSL)
ARG USERNAME=rtbdev
ARG UID=1000
ARG GID=1000
RUN groupadd --gid $GID $USERNAME
RUN useradd --create-home --shell /bin/bash --uid $UID --gid $GID $USERNAME

# Run with dev user
USER $USERNAME
