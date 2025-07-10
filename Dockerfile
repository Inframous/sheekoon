FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY HelloWorldApp/*.csproj ./HelloWorldApp/
RUN dotnet restore HelloWorldApp/HelloWorldApp.csproj

# Copy all source files
COPY HelloWorldApp/. ./HelloWorldApp/

# Build and publish the app to /app/out
RUN dotnet publish HelloWorldApp/HelloWorldApp.csproj -c Release -o /app/out



FROM mcr.microsoft.com/dotnet/runtime:8.0
WORKDIR /app

# Copy the published output from build stage
COPY --from=build /app/out ./

# Set entrypoint
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]
