using BookShelf.Logic.Models;
using BookShelf.Logic.Requests;
using BookShelf.Logic.Responses;
using BookShelf.WebApi.Infrastructure.Extensions;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using System.Threading;
using System.Threading.Tasks;

namespace BookShelf.WebApi.Controllers
{
    [ApiController]
    [Route("")]
    public class HomeController : ControllerBase
    {
        private readonly IMediator _mediator;

        public HomeController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [Route("")]
        [HttpGet]
        public async Task<ActionResult<GetProductInfoResponse>> GetInfo(CancellationToken cancellationToken)
        {
            var assemblyName = this.GetType().Assembly.GetName();
            var request = new GetProductInfo()
            {
                RequestId = this.GetRequestId(),
                ApiInfo = new ProductInfo()
                {
                    Product = assemblyName.Name,
                    Version = assemblyName.Version.ToString(),
                },
            };

            var response = await _mediator.Send(request, cancellationToken);
            return Ok(response);
        }
    }
}
