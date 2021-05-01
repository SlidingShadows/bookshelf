using System;

namespace BookShelf.Data.Models
{
    public class AlterName
    {
        public Guid Id { get; set; }
        public Guid BookId { get; set; }
        public string Title { get; set; }

        public Book Book { get; set; }
    }
}
