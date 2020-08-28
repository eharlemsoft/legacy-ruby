# This creates an interactive debian container that starts in a bash
# login session.

# Use it to explore debian as a non-root user `app`
# with sudo capability.

# The password for the user is made available for learning and exploring
# purposes only. Because leaving a weak password out in the open in 
# a Dockerfile is a great way to get hacked, this image cannot be used in 
# any production setting.

# To build the image: docker build -t deb-tty:0.4
# To run the container: docker run -it --rm deb-tty:0.4
FROM debian:jessie

# Install rbenv and ruby build dependencies
RUN apt-get update \
&& apt-get -y install autoconf \
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

# Set up non-root user
# useradd is non-interactive alternative to adduser
RUN apt-get update && apt-get install sudo
RUN groupadd app \
&& useradd -m -g app -G sudo app \
&& echo "app:app" | chpasswd

# Install curl, which is required to install ruby using
# rbenv
RUN apt-get install -y curl

# Switch to using the non-root user to install ruby
USER app

# Set up the environment so the user can find rbenv
ENV HOME /home/app
ENV PATH $HOME/.rbenv/shims:$HOME/.rbenv/bin:$HOME/.rbenv/plugins/ruby-build/bin:$PATH
ENV CONFIGURE_OPTS --disable-install-doc

# Install rbenv and ruby-build
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
&& git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Finally install ruby
RUN rbenv install 2.3.8

# Set the global version and install bundler
RUN echo 'gem: --no-rdoc --no-ri' >> ~/.gemrc \
&& rbenv global 2.3.8 \
&& gem install bundler

# Clean up
USER root
RUN apt-get -y --purge remove \
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
git-core && apt-get -y autoremove

# Default commands for docker run
USER app
CMD ["bash"]
