FROM node:20-alpine as builder

ENV LANG en_US.UTF-8
COPY install-base.sh install-base.sh
COPY install-ibmcloud.sh install-ibmcloud.sh

RUN ./install-base.sh
RUN  ./install-ibmcloud.sh
RUN rm -f install-base.sh install-ibmcloud.sh
# RUN useradd -m -g users -G wheel -s /bin/bash dev
# RUN chsh -s /bin/bash dev
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd
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
