# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj and restore as separate layers (caching)
COPY HelloWorldApp/*.csproj HelloWorldApp/
RUN dotnet restore HelloWorldApp/HelloWorldApp.csproj

# Copy the entire source
COPY HelloWorldApp/ HelloWorldApp/

# Build and publish the app
WORKDIR /src/HelloWorldApp
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app

# Copy published output from build stage
COPY --from=build /app/publish .

# Run the app
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]
