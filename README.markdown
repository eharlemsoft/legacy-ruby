## Quick Start

To build the image: docker build -t deb-tty:0.4
To run the container: docker run -it --rm deb-tty:0.4

## Features

- Creates an `app` user.

*Important note*

The password for the user is made available for learning and exploring
purposes only. Because leaving a weak password out in the open in 
a Dockerfile is a great way to get hacked, this image cannot be used in 
any production setting.

## Uses

- Create an interactive debian container that starts in a bash login session.
- Explore debian as a non-root user `app` with sudo capability.
