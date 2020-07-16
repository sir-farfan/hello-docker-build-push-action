FROM alpine:3.12.0

WORKDIR /app

COPY hello.sh .

RUN chmod +x hello.sh

ENTRYPOINT [ "./hello.sh" ]

