FROM mcr.microsoft.com/dotnet/sdk:9.0

RUN mkdir /etc/app

WORKDIR /etc/app

COPY ./bin/Release/net9.0/publish .

CMD [ "dotnet", "HelloWorldApp.dll"]
