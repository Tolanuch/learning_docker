# Build
FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS builder

ARG source_dir=/etc/source
ARG publish_dir=/etc/publish

COPY . ${source_dir}

WORKDIR ${source_dir}/src

RUN --mount=type=cache,id=nuget,target=/root/.nuget/packages \
    dotnet publish --use-current-runtime --self-contained false --output ${publish_dir}
RUN dotnet test ${source_dir}/tests

FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS dev
ARG source_dir=/etc/source
WORKDIR ${source_dir}
COPY ./src .
CMD dotnet run --no-launch-profile

# Run
FROM mcr.microsoft.com/dotnet/aspnet:9.0-alpine AS runner

ARG app_dir=/etc/app

WORKDIR ${app_dir}

COPY --from=builder /etc/publish .

# Create a non-privileged user that the app will run under.
# See https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
USER appuser

ENTRYPOINT [ "dotnet", "HelloWorldApp.dll"]
