# Build
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS builder

ARG source_dir=/etc/source
ARG publish_dir=/etc/publish

RUN mkdir ${source_dir}
RUN mkdir ${publish_dir}

WORKDIR ${source_dir}

COPY . .

RUN dotnet publish --output ${publish_dir}

# Run
FROM mcr.microsoft.com/dotnet/aspnet:9.0

ARG app_dir=/etc/app

RUN mkdir ${app_dir}

WORKDIR ${app_dir}

COPY --from=builder /etc/publish .

CMD [ "dotnet", "HelloWorldApp.dll"]
