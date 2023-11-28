FROM ubuntu:latest as target

RUN apt-get update -q && \
    apt-get install -q -y gdb python3 binutils python-is-python3 libc6-dbg libssl-dev libssl3 && \
    apt-get clean -y

COPY main /opt/
COPY gdbcmds /opt/

FROM snapchange_snapshot
COPY --from=target / "$SNAPSHOT_INPUT"

ENV SNAPSHOT_ENTRYPOINT=/opt/main
ENV SNAPSHOT_CUSTOM_GDBCMDS=/opt/gdbcmds
