using BookShelf.Logic.Models;
using BookShelf.Logic.Responses;

namespace BookShelf.Logic.Requests
{
    public class GetProductInfo : BaseRequest<GetProductInfoResponse>
    {
        public ProductInfo ApiInfo { get; set; }
    }
}
