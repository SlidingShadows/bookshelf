using BookShelf.Logic.Models;

namespace BookShelf.Logic.Responses
{
    public class GetProductInfoResponse : BaseResponse
    {
        public ProductInfo[] Products { get; set; }
    }
}
