using BookShelf.Logic.Common;
using MediatR;

namespace BookShelf.Logic.Requests
{
    public class BaseRequest<TResponse> : IRequest<TResponse>, IOperation
    {
        public string RequestId { get; set; }
    }
}
