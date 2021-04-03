using BookShelf.Logic.Infrastructure.Configuration;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace BookShelf.WebApi.Infrastructure.Extensions
{
    public static class ConfigurationExtension
    {
        public static IServiceCollection LoadApiConfiguration(this IServiceCollection services, IConfiguration configuration)
        {
            services.Configure<JwtConfig>(configuration.GetSection("JwtConfig"));

            return services;
        }
    }
}
