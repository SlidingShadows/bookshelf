using BookShelf.Logic.Common;
using BookShelf.Logic.Models;
using System.Collections.Generic;

namespace BookShelf.Logic.Responses
{
    public class BaseResponse : IOperation
    {
        private List<ResponseError> _errors;

        public string RequestId { get; set; }
        public bool Succeeded { get; protected set; }
        public IEnumerable<ResponseError> Errors { get => _errors; }

        public BaseResponse()
        {
            Succeeded = true;
            _errors   = new List<ResponseError>();
        }

        public void Failed(string code, string description)
        {
            _errors.Add(new ResponseError()
            {
                Code        = code,
                Description = description,
            });

            Succeeded = false;
        }
    }
}
