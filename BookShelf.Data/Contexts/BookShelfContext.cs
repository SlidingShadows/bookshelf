using BookShelf.Data.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;

namespace BookShelf.Data.Contexts
{
    public class BookShelfContext : IdentityDbContext<User, Role, Guid>
    {
        public DbSet<Country> Countries { get; set; }
        public DbSet<Genre> Genres { get; set; }
        public DbSet<Tag> Tags { get; set; }
        public DbSet<Author> Authors { get; set; }
        public DbSet<Book> Books { get; set; }
        public DbSet<AlterName> AlterNames { get; set; }
        public DbSet<Chapter> Chapters { get; set; }

        public BookShelfContext(DbContextOptions<BookShelfContext> options)
        : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

            builder.Entity<Country>(model => {
                model.HasKey(p => p.Id);

                model
                    .Property(p => p.Id)
                    .ValueGeneratedOnAdd();

                model
                    .Property(p => p.Name)
                    .HasMaxLength(100)
                    .IsRequired();
            });

            builder.Entity<Genre>(model => {
                model.HasKey(p => p.Id);

                model
                    .Property(p => p.Id)
                    .ValueGeneratedOnAdd();

                model
                    .Property(p => p.Name)
                    .HasMaxLength(100)
                    .IsRequired();
            });

            builder.Entity<Tag>(model => {
                model.HasKey(p => p.Id);

                model
                    .Property(p => p.Id)
                    .ValueGeneratedOnAdd();

                model
                    .Property(p => p.Name)
                    .HasMaxLength(255)
                    .IsRequired();
            });

            builder.Entity<Author>(model => {
                model.HasKey(p => p.Id);

                model
                    .Property(p => p.Id)
                    .ValueGeneratedOnAdd();

                model
                    .Property(p => p.Name)
                    .HasMaxLength(100)
                    .IsRequired();

                model
                    .Property(p => p.OriginalName)
                    .HasMaxLength(100);
            });

            builder.Entity<Book>(model => {
                model.HasKey(book => book.Id);

                model
                    .Property(book => book.Id)
                    .ValueGeneratedOnAdd();

                model
                    .Property(book => book.Title)
                    .HasMaxLength(255)
                    .IsRequired();

                model
                    .Property(book => book.OriginalTitle)
                    .HasMaxLength(255);

                model
                    .HasOne(book => book.Country)
                    .WithMany(country => country.Books)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasForeignKey(book => book.CountyId)
                    .IsRequired();

                model
                    .HasOne(book => book.Author)
                    .WithMany(author => author.Books)
                    .OnDelete(DeleteBehavior.Restrict)
                    .HasForeignKey(book => book.AuthorId)
                    .IsRequired();

                model
                    .HasMany(book => book.Genres)
                    .WithMany(genre => genre.Books)
                    .UsingEntity<BookGenre>(
                        j => j
                            .HasOne(bg => bg.Genre)
                            .WithMany(genre => genre.BookGenres)
                            .HasForeignKey(bg => bg.GenreId),
                        j => j
                            .HasOne(bg => bg.Book)
                            .WithMany(book => book.BookGenres)
                            .HasForeignKey(bg => bg.BookId),
                        j =>
                        {
                            j.HasKey(bg => new { bg.BookId, bg.GenreId });
                        }
                    );

                model
                    .HasMany(book => book.Tags)
                    .WithMany(tag => tag.Books)
                    .UsingEntity<BookTag>(
                        j => j
                            .HasOne(bt => bt.Tag)
                            .WithMany(tag => tag.BookTags)
                            .HasForeignKey(bt => bt.TagId),
                        j => j
                            .HasOne(bt => bt.Book)
                            .WithMany(book => book.BookTags)
                            .HasForeignKey(bt => bt.BookId),
                        j =>
                        {
                            j.HasKey(bt => new { bt.BookId, bt.TagId });
                        }
                    );
            });

            builder.Entity<AlterName>(model => {
                model.HasKey(p => p.Id);

                model
                    .Property(p => p.Id)
                    .ValueGeneratedOnAdd();

                model
                    .Property(p => p.Title)
                    .HasMaxLength(255)
                    .IsRequired();

                model
                    .HasOne(alter => alter.Book)
                    .WithMany(book => book.AlterNames)
                    .HasForeignKey(alter => alter.BookId);
            });

            builder.Entity<Chapter>(model => {
                model.HasKey(p => p.Id);

                model
                    .Property(p => p.Id)
                    .ValueGeneratedOnAdd();

                model
                    .Property(p => p.Title)
                    .HasMaxLength(255)
                    .IsRequired();

                model
                    .Property(p => p.Markup)
                    .IsRequired();

                model
                    .HasOne(alter => alter.Book)
                    .WithMany(book => book.Chapters)
                    .HasForeignKey(alter => alter.BookId);
            });

            #region SeedAdmin

            // Seed Admin

            var AdminUserId = new Guid("{ADFFB8B5-E90D-4163-A60F-1D290509260E}");
            var AdminRoleId = new Guid("{E6A84561-2B8E-4C7B-A2C4-1E0269C8C593}");
            var hasher = new PasswordHasher<User>();

            builder.Entity<Role>().HasData(new Role
            {
                Id = AdminRoleId,
                Name = "admin",
                NormalizedName = "admin",
            });

            builder.Entity<User>().HasData(new User
            {
                Id = AdminUserId,
                UserName = "admin",
                NormalizedUserName = "admin",
                Email = "admin@bookshelf.fake",
                NormalizedEmail = "admin@bookshelf.fake",
                EmailConfirmed = true,
                PasswordHash = hasher.HashPassword(null, "Qwerty123@"),
                SecurityStamp = string.Empty,
            });

            builder.Entity<IdentityUserRole<Guid>>().HasData(new IdentityUserRole<Guid>
            {
                RoleId = AdminRoleId,
                UserId = AdminUserId,
            });

            #endregion
        }
    }
}
