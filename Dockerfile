FROM golang:1.17 as auth_service
WORKDIR /auth
COPY ./service/auth/main.go .
RUN go build -o /auth_service /auth/main.go
EXPOSE 9001
CMD ["/auth_service"]

FROM golang:1.17 as user_service
WORKDIR /user
COPY ./service/user/main.go .
RUN go build -o /user_service /user/main.go
EXPOSE 9002
CMD ["/user_service"]
