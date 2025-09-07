# Build
FROM mcr.microsoft.com/dotnet/sdk:9.0-alpine AS builder

ARG source_dir=/etc/source
ARG publish_dir=/etc/publish

WORKDIR ${source_dir}

COPY . .

RUN --mount=type=cache,id=nuget,target=/root/.nuget/packages \
    dotnet publish --output ${publish_dir}

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
