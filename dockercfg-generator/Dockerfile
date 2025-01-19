FROM docker:27.5.0
LABEL maintainer='Codeship Inc., <maintainers@codeship.com>'

COPY docker_creds.sh /bin
RUN chmod u+x /bin/docker_creds.sh

ENTRYPOINT ["docker_creds.sh"]
