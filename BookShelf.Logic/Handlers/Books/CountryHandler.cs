using BookShelf.Data.Contexts;
using DataModels = BookShelf.Data.Models;
using BookShelf.Logic.Models;
using BookShelf.Logic.Requests;
using BookShelf.Logic.Responses;
using FluentValidation;
using MediatR;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;

namespace BookShelf.Logic.Handlers
{
    public class CountryHandler :
        IRequestHandler<GetCountries, GetCountriesResponse>,
        IRequestHandler<CreateCountry, CreateCountryResponse>,
        IRequestHandler<UpdateCountry, UpdateCountryResponse>
    {
        private readonly BookShelfContext _bookShelfContext;
        private readonly IValidator<CreateCountry> _createCountryValidator;
        private readonly IValidator<UpdateCountry> _updateCountryValidator;

        public CountryHandler(
            BookShelfContext bookShelfContext,
            IValidator<CreateCountry> createCountryValidator,
            IValidator<UpdateCountry> updateCountryValidator
        )
        {
            _bookShelfContext = bookShelfContext;
            _createCountryValidator = createCountryValidator;
            _updateCountryValidator = updateCountryValidator;
        }

        public async Task<GetCountriesResponse> Handle(GetCountries request, CancellationToken cancellationToken)
        {
            var countries = await _bookShelfContext.Countries
                .OrderBy(country => country.Name)
                .Select(country => new Country()
                {
                    Id   = country.Id,
                    Name = country.Name,
                })
                .ToArrayAsync(cancellationToken);

            return new GetCountriesResponse()
            {
                RequestId = request.RequestId,
                Countries = countries,
            };
        }

        public async Task<CreateCountryResponse> Handle(CreateCountry request, CancellationToken cancellationToken)
        {
            var response = new CreateCountryResponse()
            {
                RequestId = request.RequestId,
            };

            if (response.FromResult(await _createCountryValidator.ValidateAsync(request, cancellationToken)))
            {
                var country = new DataModels.Country()
                {
                    Name = request.Country.Name,
                };

                _bookShelfContext.Countries.Add(country);
                await _bookShelfContext.SaveChangesAsync(cancellationToken);

                response.Country = new Country()
                {
                    Id   = country.Id,
                    Name = country.Name,
                };
            }

            return response;
        }

        public async Task<UpdateCountryResponse> Handle(UpdateCountry request, CancellationToken cancellationToken)
        {
            var response = new UpdateCountryResponse()
            {
                RequestId = request.RequestId,
            };

            if (response.FromResult(await _updateCountryValidator.ValidateAsync(request, cancellationToken)))
            {
                var country = await _bookShelfContext.Countries
                    .FindAsync(new object[] { request.Id }, cancellationToken);

                country.Name = request.Country.Name;

                await _bookShelfContext.SaveChangesAsync(cancellationToken);
            }

            return response;
        }
    }
}
