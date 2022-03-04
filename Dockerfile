# BUILD AUTH SVC
FROM golang:1.17-alpine as auth_build

LABEL stage=build

WORKDIR /auth

COPY ./service/auth/main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -o /auth_service /auth/main.go

# DEPLOY AUTH SVC
FROM scratch as auth_service

WORKDIR /

COPY --from=auth_build /auth_service /auth_service

EXPOSE 9001

ENTRYPOINT ["/auth_service"]

# BUILD USER SVC
FROM golang:1.17-alpine as user_build

LABEL stage=build

WORKDIR /user

COPY ./service/user/main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -o /user_service /user/main.go

# DEPLOY USER SVC
FROM scratch as user_service

WORKDIR /

COPY --from=user_build /user_service /user_service

EXPOSE 9002

ENTRYPOINT ["/user_service"]
