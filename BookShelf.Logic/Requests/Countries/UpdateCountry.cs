using BookShelf.Logic.Models;
using BookShelf.Logic.Responses;
using System;

namespace BookShelf.Logic.Requests
{
    public class UpdateCountry : BaseRequest<UpdateCountryResponse>
    {
        public Guid Id { get; set; }
        public CountryForm Country { get; set; }
    }
}
