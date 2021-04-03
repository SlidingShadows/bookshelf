using BookShelf.Logic.Requests;
using BookShelf.Logic.Responses;
using BookShelf.WebApi.Infrastructure.Extensions;
using MediatR;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace BookShelf.WebApi.Controllers
{
    [Route("auth")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IMediator _mediator;

        public AuthController(IMediator mediator)
        {
            _mediator = mediator;
        }

        [HttpPost("login")]
        public async Task<ActionResult<LoginResponse>> Login(
            [FromBody] Login request,
            CancellationToken cancellationToken
        )
        {
            if (string.IsNullOrEmpty(request.RequestId))
            {
                request.RequestId = this.GetRequestId();
            }

            var response = await _mediator.Send(request, cancellationToken);
            return Ok(response);
        }
    }
}
