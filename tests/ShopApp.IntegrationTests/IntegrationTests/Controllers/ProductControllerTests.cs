// public class ProductControllerTests : IClassFixture<WebApplicationFactory<Startup>>
using System.Net.Http.Json;
using System.Text.Json;
using System.Threading.Tasks;
using FluentAssertions;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Xunit;

public class ProductControllerTests : IClassFixture<CustomWebApplicationFactory<Program>>
{
    private readonly HttpClient _client;
    private readonly CustomWebApplicationFactory<Program> _factory;

    public ProductControllerTests(CustomWebApplicationFactory<Program> factory)
    {
        _factory = factory;
        // _client = factory.CreateClient();
        _client = factory.CreateClient(
            new WebApplicationFactoryClientOptions { AllowAutoRedirect = false }
        );
    }

    [Fact]
    public async Task Get_ShouldReturnOk_WhenWeatherIsOk()
    {
        var response = await _client.GetAsync("/weatherforecast");
        response.StatusCode.Should().Be(System.Net.HttpStatusCode.OK);
    }

    [Fact]
    public async Task Post_ShouldReturnOk_WhenProductIsCreated()
    {
        var productData = new { name = "Product 1", price = 10.99 };
        var response = await _client.PostAsJsonAsync("/api/products", productData);
        response.StatusCode.Should().Be(System.Net.HttpStatusCode.Created);
    }

    // [Fact]
    // public async Task Register_ShouldReturnOk_WhenUserIsCreated()
    // {
    //     // Arrange
    //     var registerRequest = new RegisterRequest
    //     {
    //         Username = "newuser",
    //         Email = "newuser@example.com",
    //         Password = "StrongPassword123"
    //     };
    //
    //     // Act
    //     var response = await _client.PostAsJsonAsync("/api/auth/register", registerRequest);
    //
    //     // Assert
    //     response.StatusCode.Should().Be(System.Net.HttpStatusCode.OK);
    //     var responseContent = await response.Content.ReadAsStringAsync();
    //
    //     var responseObject = JsonSerializer.Deserialize<Dictionary<string, object>>(responseContent);
    //     responseObject.Should().ContainKey("success");
    //     // responseObject["success"].Should().Be(true);
    //     responseObject.Should().ContainKey("message");
    //     // responseObject["message"].Should().Be("User created successfully.");
    // }
}
