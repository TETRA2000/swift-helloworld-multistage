FROM swift:4.0 as builder

ADD . /opt/app
WORKDIR /opt/app
RUN swiftc -static-stdlib -O hello.swift

FROM ubuntu:16.04
RUN apt-get update && apt-get install -y \
    libatomic1 \
 && rm -rf /var/lib/apt/lists/*
COPY --from=builder /opt/app/hello /opt/app/hello
WORKDIR /opt/app
CMD ./hello
