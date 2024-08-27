// using ShopApp.Domain.Entities;
// using ShopApp.Domain.Interfaces;
using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;

public class CreateProductCommandHandler : IRequestHandler<CreateProductCommand, Guid>
{
    private readonly IRepository<Product> _productRepository;

    public CreateProductCommandHandler(IRepository<Product> productRepository)
    {
        _productRepository = productRepository;
    }

    public async Task<Guid> Handle(
        CreateProductCommand request,
        CancellationToken cancellationToken
    )
    {
        var product = new Product(Guid.NewGuid(), request.Name, request.Price);
        await _productRepository.AddAsync(product);
        return product.Id;
    }
}
