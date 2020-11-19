# Image with ruby 2.1.5 running on debian:jessie-slim
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

# Finally install ruby
RUN rbenv install 2.1.5

# Set the global version and install bundler
# RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc \
# && rbenv global 2.1.5 \
# && gem install bundler

# Default commands for docker run
CMD ["bash"]
