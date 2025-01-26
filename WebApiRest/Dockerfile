# Imagen base de .NET SDK para compilar la aplicación
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app
COPY . ./
RUN dotnet publish -c Release -o out

# Imagen base de .NET Runtime para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build /app/out .
EXPOSE 80
ENTRYPOINT ["dotnet", "WebApiRest.dll"]

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y wget

# Descargar e instalar .NET 9.0
RUN wget https://aka.ms/dotnet-install.sh -O dotnet-install.sh \
    && chmod +x dotnet-install.sh \
    && ./dotnet-install.sh --version 9.0.0 --install-dir /usr/share/dotnet \
    && rm dotnet-install.sh

# Establecer .NET 9.0 como la versión predeterminada
ENV DOTNET_ROOT=/usr/share/dotnet
ENV PATH="$DOTNET_ROOT:$PATH"
