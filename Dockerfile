FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

COPY EmployeeManagement.Api/EmployeeManagement.Api.csproj EmployeeManagement.Api/
RUN dotnet restore EmployeeManagement.Api/EmployeeManagement.Api.csproj

COPY . .
RUN dotnet publish EmployeeManagement.Api/EmployeeManagement.Api.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

COPY --from=build /app/publish .

ENV ASPNETCORE_URLS=http://+:10000
EXPOSE 10000

ENTRYPOINT ["dotnet", "EmployeeManagement.Api.dll"]
