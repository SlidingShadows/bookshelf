using System;

namespace BookShelf.Data.Models
{
    public class Chapter
    {
        public Guid Id { get; set; }
        public Guid BookId { get; set; }
        public string Title { get; set; }
        public string Markup { get; set; }
        public long TimeStamp { get; set; }

        public Book Book { get; set; }
    }
}
