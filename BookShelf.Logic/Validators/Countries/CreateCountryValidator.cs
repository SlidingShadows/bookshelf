using BookShelf.Data.Contexts;
using BookShelf.Logic.Requests;
using BookShelf.Logic.Resources;
using FluentValidation;
using Microsoft.EntityFrameworkCore;
using System.Threading;
using System.Threading.Tasks;

namespace BookShelf.Logic.Validators
{
    public class CreateCountryValidator : AbstractValidator<CreateCountry>
    {
        private readonly BookShelfContext _bookShelfContext;

        public CreateCountryValidator(BookShelfContext bookShelfContext)
        {
            _bookShelfContext = bookShelfContext;

            RuleFor(request => request.Country.Name)
                .Cascade(CascadeMode.Stop)
                .NotEmpty()
                    .WithErrorCode("name")
                    .WithMessage(Validation.CountryNameRequired)
                .MustAsync(CountryNameMustBeUnique)
                    .WithErrorCode("name")
                    .WithMessage(Validation.CountryNameTaken);
        }

        private async Task<bool> CountryNameMustBeUnique(
            string name,
            CancellationToken cancellationToken
        )
        {
            var country = await _bookShelfContext.Countries
                .FirstOrDefaultAsync(
                    country => country.Name == name,
                    cancellationToken
                );

            return country == null;
        }
    }
}
