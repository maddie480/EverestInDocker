FROM max480/everest:stable

COPY tas-check.sh tas-prepare.sh /home/ubuntu/
RUN /home/ubuntu/tas-prepare.sh && rm /home/ubuntu/tas-prepare.sh

ENTRYPOINT [ "/home/ubuntu/tas-check.sh" ]