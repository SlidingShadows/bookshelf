using BookShelf.Data.Contexts;
using BookShelf.Logic.Models;
using BookShelf.Logic.Requests;
using BookShelf.Logic.Responses;
using MediatR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace BookShelf.Logic.Handlers
{
    public class ProductInfoHandler : IRequestHandler<GetProductInfo, GetProductInfoResponse>
    {
        private readonly BookShelfContext _context;

        public ProductInfoHandler(BookShelfContext context)
        {
            _context = context;
        }

        public Task<GetProductInfoResponse> Handle(GetProductInfo request, CancellationToken cancellationToken)
        {
            var response = new GetProductInfoResponse()
            {
                RequestId = request.RequestId,
            };
            var products = new List<ProductInfo>()
            {
                request.ApiInfo,
            };

            var assemblyName = GetType().Assembly.GetName();

            products.Add(new ProductInfo()
            {
                Product = assemblyName.Name,
                Version = assemblyName.Version.ToString(),
            });

            var contextName = _context.GetType().Assembly.GetName();

            products.Add(new ProductInfo()
            {
                Product = contextName.Name,
                Version = contextName.Version.ToString(),
            });

            response.Products = products.ToArray();
            return Task<GetProductInfoResponse>.FromResult(response);
        }
    }
}
