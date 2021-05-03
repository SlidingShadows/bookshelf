using BookShelf.Data.Contexts;
using BookShelf.Logic.Requests;
using BookShelf.Logic.Resources;
using FluentValidation;
using Microsoft.EntityFrameworkCore;
using System;
using System.Threading;
using System.Threading.Tasks;

namespace BookShelf.Logic.Validators
{
    public class UpdateCountryValidator : AbstractValidator<UpdateCountry>
    {
        private readonly BookShelfContext _bookShelfContext;

        public UpdateCountryValidator(BookShelfContext bookShelfContext)
        {
            _bookShelfContext = bookShelfContext;

            RuleFor(request => request.Id)
                .Cascade(CascadeMode.Stop)
                .MustAsync(CountryMustBeFound)
                    .WithErrorCode("fatal")
                    .WithMessage(Validation.CountryNotFound);

            RuleFor(request => request.Country.Name)
                .Cascade(CascadeMode.Stop)
                .NotEmpty()
                    .WithErrorCode("name")
                    .WithMessage(Validation.CountryNameRequired)
                .MustAsync(CountryNameMustBeUnique)
                    .WithErrorCode("name")
                    .WithMessage(Validation.CountryNameTaken);
        }

        private async Task<bool> CountryMustBeFound(
            Guid id,
            CancellationToken cancellationToken
        )
        {
            var country = await _bookShelfContext.Countries
                .FindAsync(new object[] { id }, cancellationToken);

            return country != null;
        }

        private async Task<bool> CountryNameMustBeUnique(
            UpdateCountry request,
            string name,
            CancellationToken cancellationToken
        )
        {
            var country = await _bookShelfContext.Countries
                .FirstOrDefaultAsync(
                    country => country.Name == name,
                    cancellationToken
                );

            return (country == null) || (country.Id == request.Id);
        }
    }
}
