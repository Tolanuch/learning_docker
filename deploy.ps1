dotnet publish
docker build -t learning-image:1.0 .
docker-compose -f container.yml up
