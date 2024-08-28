#!/bin/bash

# Set project names and paths
API_PROJECT_NAME="ShopApp.API"
TEST_PROJECT_NAME="ShopApp.IntegrationTests"
SOLUTION_NAME="ShopApp"
ROOT_DIR=$(pwd)

# Create Integration Test Project
dotnet new xunit -o "$ROOT_DIR/tests/$TEST_PROJECT_NAME"
cd "$ROOT_DIR/tests/$TEST_PROJECT_NAME"

# Add the integration test project to the solution
dotnet sln "$ROOT_DIR/$SOLUTION_NAME.sln" add "$ROOT_DIR/tests/$TEST_PROJECT_NAME/$TEST_PROJECT_NAME.csproj"

# Install necessary packages
dotnet add package Microsoft.AspNetCore.Mvc.Testing
dotnet add package Microsoft.EntityFrameworkCore.InMemory
dotnet add package FluentAssertions
dotnet add package Moq
dotnet add package xunit.runner.visualstudio

# Reference the API project
dotnet add reference "$ROOT_DIR/src/$API_PROJECT_NAME/$API_PROJECT_NAME.csproj"

# Create integration test folders
mkdir -p "$ROOT_DIR/tests/$TEST_PROJECT_NAME/IntegrationTests"
mkdir -p "$ROOT_DIR/tests/$TEST_PROJECT_NAME/IntegrationTests/Controllers"

# Create a basic integration test for a sample controller
cat <<EOL >"$ROOT_DIR/tests/$TEST_PROJECT_NAME/IntegrationTests/Controllers/ProductControllerTests.cs"
using System.Net;
using System.Threading.Tasks;
using Xunit;
using FluentAssertions;
using Microsoft.AspNetCore.Mvc.Testing;
using $API_PROJECT_NAME;

namespace $TEST_PROJECT_NAME.IntegrationTests.Controllers
{
    public class ProductControllerTests : IClassFixture<WebApplicationFactory<Startup>>
    {
        private readonly WebApplicationFactory<Startup> _factory;

        public ProductControllerTests(WebApplicationFactory<Startup> factory)
        {
            _factory = factory;
        }

        [Fact]
        public async Task Get_Products_Returns_Success_Status_Code()
        {
            // Arrange
            var client = _factory.CreateClient();

            // Act
            var response = await client.GetAsync("/api/products");

            // Assert
            response.StatusCode.Should().Be(HttpStatusCode.OK);
        }
    }
}
EOL

echo "Integration test project setup completed!"
