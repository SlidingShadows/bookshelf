using System;
using System.Collections.Generic;

namespace BookShelf.Data.Models
{
    public class Tag
    {
        public Guid Id { get; set; }
        public string Name { get; set; }

        public ICollection<Book> Books { get; set; }
        public List<BookTag> BookTags { get; set; }
    }
}
