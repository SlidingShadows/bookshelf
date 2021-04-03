using BookShelf.Data.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System;

namespace BookShelf.Data.Contexts
{
    public class BookShelfContext : IdentityDbContext<User, Role, Guid>
    {
        public BookShelfContext(DbContextOptions<BookShelfContext> options)
        : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            base.OnModelCreating(builder);

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
        }
    }
}
