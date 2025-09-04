FROM mcr.microsoft.com/dotnet/sdk:9.0

ARG app_dir=/etc/app
ARG publish_dir=/etc/publish

RUN mkdir ${app_dir}
RUN mkdir ${publish_dir}

WORKDIR ${app_dir}

COPY . .

RUN dotnet publish --output ${publish_dir}

WORKDIR ${publish_dir}

CMD [ "dotnet", "HelloWorldApp.dll"]
