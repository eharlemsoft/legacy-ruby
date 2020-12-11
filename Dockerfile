# Image with ruby 2.3.8 running on debian:jessie-slim
FROM debian:jessie-slim

# Install rbenv and ruby build dependencies
RUN apt-get update \
&& apt-get -y install curl \
autoconf \
bison \
build-essential \
libssl-dev \
libyaml-dev \
libreadline6-dev \
zlib1g-dev \
libncurses5-dev \
libffi-dev \
libgdbm3 \
libgdbm-dev \
git-core

# Install rbenv and ruby-build
RUN git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv &&\
    git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build &&\
    chgrp -R www-data /usr/local/rbenv &&\
    chmod -R g+rwxXs /usr/local/rbenv

ENV RBENV_ROOT="/usr/local/rbenv"
ENV PATH="$RBENV_ROOT/shims:$RBENV_ROOT/bin:$PATH"

# Switch global ruby to 2.3.8
# Finally install ruby and the bundler gem
RUN rbenv install 2.3.8
RUN rbenv global 2.3.8 &&\
    gem update --system &&\
    gem install bundler

# Set up a non-root user
RUN groupadd -g 999 app &&\
    useradd -m -r -u 999 -g app -G www-data app

# Switch to non-root user
USER app

# Default commands for docker run
CMD ["bash"]
