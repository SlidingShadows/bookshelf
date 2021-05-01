using System;

namespace BookShelf.Data.Models
{
    public class BookGenre
    {
        public Guid BookId { get; set; }
        public Guid GenreId { get; set; }

        public Book Book { get; set; }
        public Genre Genre { get; set; }
    }
}
