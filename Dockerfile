FROM ubuntu:22.04 as builder

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.UTF-8
COPY install-base.sh install-base.sh
# COPY install-ibmcloud.sh install-ibmcloud.sh

RUN ./install-base.sh
# RUN  ./install-ibmcloud.sh
RUN rm -f install-base.sh 
# RUN useradd -m -g users -G wheel -s /bin/bash dev
# RUN chsh -s /bin/bash dev
# RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd
RUN mkdir /app

FROM scratch
COPY --from=builder / /
COPY .bashrc /root
COPY .bash_aliases /root
VOLUME /app
ENV TERM xterm-256color
ENV LANG en_US.UTF-8
WORKDIR /app
ENTRYPOINT [ "bash", "-l" ]
