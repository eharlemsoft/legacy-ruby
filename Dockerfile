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

# Set up non-root user
# useradd is non-interactive alternative to adduser
RUN apt-get update && apt-get install sudo
RUN groupadd app \
&& useradd -m -g app -G sudo app \
&& echo "app:app" | chpasswd

USER app

# Install desired ruby
# RUN apt-get update

# Default commands for docker run
CMD ["bash"]
