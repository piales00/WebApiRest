# Imagen base de .NET SDK para compilar la aplicación
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# Copiar los archivos del proyecto
COPY . ./

# Restaurar dependencias y publicar la aplicación en modo Release
RUN dotnet restore
RUN dotnet publish -c Release -o /app/out

# Imagen base de .NET Runtime 9.0 para ejecutar la aplicación
FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app

# Copiar la aplicación publicada desde la etapa de compilación
COPY --from=build /app/out .

# Exponer el puerto 80 para el tráfico HTTP
EXPOSE 80

# Comando de inicio de la aplicación
ENTRYPOINT ["dotnet", "WebApiRest.dll"]
