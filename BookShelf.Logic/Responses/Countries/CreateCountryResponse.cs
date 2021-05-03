using BookShelf.Logic.Models;

namespace BookShelf.Logic.Responses
{
    public class CreateCountryResponse : BaseResponse
    {
        public Country Country { get; set; }
    }
}
