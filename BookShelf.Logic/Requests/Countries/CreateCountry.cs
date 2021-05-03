using BookShelf.Logic.Models;
using BookShelf.Logic.Responses;

namespace BookShelf.Logic.Requests
{
    public class CreateCountry : BaseRequest<CreateCountryResponse>
    {
        public CountryForm Country { get; set; }
    }
}
