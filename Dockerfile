FROM ubuntu

ADD Celeste.tar.gz /home/ubuntu/

ARG MAIN_BUILD_URL
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl unzip libicu-dev \
    && cd /home/ubuntu \
    && curl -Lo everest.zip "${MAIN_BUILD_URL}" \
    && unzip everest.zip \
    && rm -v everest.zip \
    && mv -fv main/* celeste/ \
    && rm -rfv main \
    && cd celeste \
    && chmod -v u+x MiniInstaller-linux \
    && ./MiniInstaller-linux headless

ENV LD_LIBRARY_PATH="/home/ubuntu/celeste/lib64-linux"
WORKDIR /home/ubuntu/celeste
ENTRYPOINT ["/home/ubuntu/celeste/Celeste"]