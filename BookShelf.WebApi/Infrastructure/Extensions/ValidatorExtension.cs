using BookShelf.Logic.Requests;
using BookShelf.Logic.Validators;
using FluentValidation;
using Microsoft.Extensions.DependencyInjection;

namespace BookShelf.WebApi.Infrastructure.Extensions
{
    public static class ValidatorExtension
    {
        public static IServiceCollection RegisterValidators(this IServiceCollection services)
        {
            services.AddTransient<IValidator<CreateCountry>, CreateCountryValidator>();
            services.AddTransient<IValidator<UpdateCountry>, UpdateCountryValidator>();

            return services;
        }
    }
}
