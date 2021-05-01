using System;
using System.Collections.Generic;

namespace BookShelf.Data.Models
{
    public class Author
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public string OriginalName { get; set; }

        public List<Book> Books { get; set; }
    }
}
