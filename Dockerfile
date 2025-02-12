FROM debian

ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini-armhf /sbin/tini
RUN chmod +x /sbin/tini

RUN mkdir -m 0750 /root/.android
COPY files/insecure_shared_adbkey /root/.android/adbkey
COPY files/insecure_shared_adbkey.pub /root/.android/adbkey.pub

COPY files/linux-armv7l/adb /usr/bin/
COPY scripts/startup.sh /root/.android/startup.sh

RUN chmod +x /root/.android/startup.sh

ENV ANDROID_ADB_SERVER_PORT 5037
EXPOSE 5037

ENTRYPOINT ["/bin/bash"]
CMD ["-c", "/root/.android/startup.sh"]
