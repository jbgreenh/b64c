# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake clang

## Add source code to the build stage.
ADD . /b64c
WORKDIR /b64c

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN mkdir build && cd build && cmake .. && make && mv ../fuzz64.c fuzz64.c && clang fuzz64.c -o fuzz64 libb64c.so -fsanitize=fuzzer

# Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /b64c/build/fuzz64 /
COPY --from=builder /b64c/build/libb64c.so /
ENV LD_PRELOAD /libb64c.so
