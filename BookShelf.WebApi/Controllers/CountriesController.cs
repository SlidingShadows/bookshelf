using BookShelf.Logic.Models;
using BookShelf.Logic.Requests;
using BookShelf.Logic.Responses;
using BookShelf.WebApi.Infrastructure.Extensions;
using MediatR;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace BookShelf.WebApi.Controllers
{
    [Route("countries")]
    [ApiController]
    [Authorize(AuthenticationSchemes = JwtBearerDefaults.AuthenticationScheme)]
    public class CountriesController : ControllerBase
    {
        private readonly IMediator _mediator;

        public CountriesController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpGet]
        public async Task<ActionResult<GetCountriesResponse>> Get(CancellationToken cancellationToken)
        {
            var request = new GetCountries()
            {
                RequestId = this.GetRequestId(),
            };

            var response = await _mediator.Send(request, cancellationToken);
            return Ok(response);
        }

        [HttpPost]
        public async Task<ActionResult<CreateCountryResponse>> Post(
            [FromBody] CountryForm Country,
            CancellationToken cancellationToken
        )
        {
            var request = new CreateCountry()
            {
                RequestId = this.GetRequestId(),
                Country   = Country,
            };

            var response = await _mediator.Send(request, cancellationToken);
            return Ok(response);
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<UpdateCountryResponse>> Put(
            [FromRoute] Guid id,
            [FromBody] CountryForm Country,
            CancellationToken cancellationToken
        )
        {
            var request = new UpdateCountry()
            {
                RequestId = this.GetRequestId(),
                Id        = id,
                Country   = Country,
            };

            var response = await _mediator.Send(request, cancellationToken);
            return Ok(response);
        }
    }
}
