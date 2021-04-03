using BookShelf.Data.Models;
using BookShelf.Logic.Infrastructure.Configuration;
using BookShelf.Logic.Requests;
using BookShelf.Logic.Responses;
using MediatR;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace BookShelf.Logic.Handlers
{
    public class AuthHandler : IRequestHandler<Login, LoginResponse>
    {
        private readonly UserManager<User> _userManager;
        private readonly SignInManager<User> _signInManager;
        private readonly JwtConfig _jwtConfig;

        public AuthHandler(
            UserManager<User> userManager,
            SignInManager<User> signInManager,
            IOptions<JwtConfig> jwtConfig
        )
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _jwtConfig = jwtConfig.Value;
        }

        public async Task<LoginResponse> Handle(Login request, CancellationToken cancellationToken)
        {
            var response = new LoginResponse()
            {
                RequestId = request.RequestId,
            };

            var user = await _userManager.FindByEmailAsync(request.Email);

            if (user == null)
            {
                response.Failed("email", "Invalid username");
                return response;
            }

            var result = await _signInManager.CheckPasswordSignInAsync(user, request.Password, false);

            if (!result.Succeeded)
            {
                response.Failed("email", "Invalid password");
                return response;
            }

            response.Token = GenerateJwtToken(user);

            return response;
        }

        private string GenerateJwtToken(User user)
        {
            var jwtTokenHandler = new JwtSecurityTokenHandler();

            var key = Encoding.ASCII.GetBytes(_jwtConfig.Secret);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[]
                {
                    new Claim("id", user.Id.ToString()),
                    new Claim(JwtRegisteredClaimNames.Sub, user.Email),
                    new Claim(JwtRegisteredClaimNames.Email, user.Email),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
                }),
                Expires = DateTime.UtcNow.AddHours(6),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha512Signature)
            };

            var token = jwtTokenHandler.CreateToken(tokenDescriptor);

            var jwtToken = jwtTokenHandler.WriteToken(token);

            return jwtToken;
        }
    }
}
