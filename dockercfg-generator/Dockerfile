FROM docker:17.09
LABEL maintainer='Codeship Inc., <maintainers@codeship.com>'

COPY docker_creds.sh /bin
RUN chmod u+x /bin/docker_creds.sh

ENTRYPOINT ["docker_creds.sh"]
