using BookShelf.Logic.Models;

namespace BookShelf.Logic.Responses
{
    public class GetCountriesResponse : BaseResponse
    {
        public Country[] Countries { get; set; }
    }
}
