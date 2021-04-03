using Microsoft.AspNetCore.Identity;
using System;

namespace BookShelf.Data.Models
{
    public class User: IdentityUser<Guid>
    {
    }
}
