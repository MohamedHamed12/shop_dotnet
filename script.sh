#!/bin/bash

# Set the project name
PROJECT_NAME="ShopApp"

# Create solution
dotnet new sln -n $PROJECT_NAME

# Create project directories
mkdir -p src/$PROJECT_NAME.Domain
mkdir -p src/$PROJECT_NAME.Application
mkdir -p src/$PROJECT_NAME.Infrastructure
mkdir -p src/$PROJECT_NAME.API

# Create Class Library projects
dotnet new classlib -n $PROJECT_NAME.Domain -o src/$PROJECT_NAME.Domain
dotnet new classlib -n $PROJECT_NAME.Application -o src/$PROJECT_NAME.Application
dotnet new classlib -n $PROJECT_NAME.Infrastructure -o src/$PROJECT_NAME.Infrastructure

# Create ASP.NET Core Web API project
dotnet new webapi -n $PROJECT_NAME.API -o src/$PROJECT_NAME.API

# Add projects to solution
dotnet sln add src/$PROJECT_NAME.Domain/$PROJECT_NAME.Domain.csproj
dotnet sln add src/$PROJECT_NAME.Application/$PROJECT_NAME.Application.csproj
dotnet sln add src/$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj
dotnet sln add src/$PROJECT_NAME.API/$PROJECT_NAME.API.csproj

# Add project references
dotnet add src/$PROJECT_NAME.Application/$PROJECT_NAME.Application.csproj reference src/$PROJECT_NAME.Domain/$PROJECT_NAME.Domain.csproj
dotnet add src/$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj reference src/$PROJECT_NAME.Domain/$PROJECT_NAME.Domain.csproj
dotnet add src/$PROJECT_NAME.API/$PROJECT_NAME.API.csproj reference src/$PROJECT_NAME.Application/$PROJECT_NAME.Application.csproj
dotnet add src/$PROJECT_NAME.API/$PROJECT_NAME.API.csproj reference src/$PROJECT_NAME.Infrastructure/$PROJECT_NAME.Infrastructure.csproj

# Install MediatR packages in Application layer
dotnet add src/$PROJECT_NAME.Application package MediatR.Extensions.Microsoft.DependencyInjection
dotnet add src/$PROJECT_NAME.Application package MediatR

dotnet add src/$PROJECT_NAME.Application package MediatR.Extensions.Microsoft.DependencyInjection
dotnet add src/$PROJECT_NAME.Application package MediatR

# Install SQLite packages in Infrastructure layer
dotnet add src/$PROJECT_NAME.Infrastructure package Microsoft.EntityFrameworkCore.Sqlite
dotnet add src/$PROJ

# Create Application commands and handlers
mkdir -p src/$PROJECT_NAME.Application/Products/Commands
mkdir -p src/$PROJECT_NAME.Application/Products/Handlers

# Create Infrastructure repository implementation
mkdir -p src/$PROJECT_NAME.Infrastructure/Repositories

# Create initial API controller
mkdir -p src/$PROJECT_NAME.API/Controllers

dotnet ef migrations add InitialCreate --project src/$PROJECT_NAME.Infrastructure --startup-project src/$PROJECT_NAME.API
dotnet ef database update --project src/$PROJECT_NAME.Infrastructure --startup-project src/$PROJECT_NAME.API
