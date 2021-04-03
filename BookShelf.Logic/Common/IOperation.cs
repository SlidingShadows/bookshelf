using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BookShelf.Logic.Common
{
    public interface IOperation
    {
        public string RequestId { get; set; }
    }
}
