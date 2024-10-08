using System;
using System.Threading.Tasks;
using MediatR;
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api/[controller]")]
public class ProductsController : ControllerBase
{
    private readonly IMediator _mediator;

    public ProductsController(IMediator mediator)
    {
        _mediator = mediator;
    }

    //
    // [HttpPost]
    // public async Task<IActionResult> Create(CreateProductCommand command)
    // {
    //     Guid productId = await _mediator.Send(command);
    //     return CreatedAtAction(nameof(GetById), new { id = productId }, null);
    // }

    // public async Task<ActionResult<ProductDto>> AddProduct(CreateProductCommand command)

    [HttpPost]
    public async Task<IActionResult> Create(CreateProductCommand command)
    {
        Guid productId = await _mediator.Send(command);

        return CreatedAtAction(nameof(GetById), new { id = productId }, null);
        // var product = await _mediator.Send(command);
        // return Ok(product);
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(Guid id)
    {
        // Implementation for GetProductByIdQuery goes here
        return Ok();
    }
}
