FROM debian:jessie

RUN apt-get update && \
    apt-get install -y ruby2.1 && \
    # Install our PGP key and add HTTPS support for APT
    apt-get install -y dirmngr gnupg && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 && \
    apt-get install -y apt-transport-https ca-certificates && \

    # Add our APT repository
    sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger jessie main > /etc/apt/sources.list.d/passenger.list' && \
    apt-get update && \

    # Install Passenger + Nginx
    apt-get install -y nginx-extras passenger
