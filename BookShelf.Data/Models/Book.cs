using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BookShelf.Data.Models
{
    public class Book
    {
        public Guid Id { get; set; }
        public Guid CountyId { get; set; }
        public Guid AuthorId { get; set; }
        public string Title { get; set; }
        public string OriginalTitle { get; set; }
        public BookStatus Status { get; set; }

        public Country Country { get; set; }
        public Author Author { get; set; }
        public ICollection<Genre> Genres { get; set; }
        public List<BookGenre> BookGenres { get; set; }
        public ICollection<Tag> Tags { get; set; }
        public List<BookTag> BookTags { get; set; }
        public List<AlterName> AlterNames { get; set; }
        public List<Chapter> Chapters { get; set; }
    }
}
