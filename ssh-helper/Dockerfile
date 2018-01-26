FROM alpine:3.7

RUN apk --no-cache add \
	openssh-keygen

COPY ssh_helper.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/ssh_helper.sh

ENTRYPOINT ["ssh_helper.sh"]
