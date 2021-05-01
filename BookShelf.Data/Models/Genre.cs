using System;
using System.Collections.Generic;

namespace BookShelf.Data.Models
{
    public class Genre
    {
        public Guid Id { get; set; }
        public string Name { get; set; }

        public ICollection<Book> Books { get; set; }
        public List<BookGenre> BookGenres { get; set; }
    }
}
