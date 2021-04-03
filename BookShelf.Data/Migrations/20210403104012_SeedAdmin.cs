using System;
using Microsoft.EntityFrameworkCore.Migrations;

namespace BookShelf.Data.Migrations
{
    public partial class SeedAdmin : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
                table: "AspNetRoles",
                columns: new[] { "Id", "ConcurrencyStamp", "Name", "NormalizedName" },
                values: new object[] { new Guid("e6a84561-2b8e-4c7b-a2c4-1e0269c8c593"), "69719f86-4f2a-45d3-b572-dca59e87534d", "admin", "admin" });

            migrationBuilder.InsertData(
                table: "AspNetUsers",
                columns: new[] { "Id", "AccessFailedCount", "ConcurrencyStamp", "Email", "EmailConfirmed", "LockoutEnabled", "LockoutEnd", "NormalizedEmail", "NormalizedUserName", "PasswordHash", "PhoneNumber", "PhoneNumberConfirmed", "SecurityStamp", "TwoFactorEnabled", "UserName" },
                values: new object[] { new Guid("adffb8b5-e90d-4163-a60f-1d290509260e"), 0, "dd59059e-010b-4913-b047-f2173ce781a5", "admin@bookshelf.fake", true, false, null, "admin@bookshelf.fake", "admin", "AQAAAAEAACcQAAAAEKvEYOXp7y+1i83v96BACfRc7fbi42ZTqr/GqKNyoadYqpcUAH8W/gm5/W3ZKildkg==", null, false, "", false, "admin" });

            migrationBuilder.InsertData(
                table: "AspNetUserRoles",
                columns: new[] { "RoleId", "UserId" },
                values: new object[] { new Guid("e6a84561-2b8e-4c7b-a2c4-1e0269c8c593"), new Guid("adffb8b5-e90d-4163-a60f-1d290509260e") });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "AspNetUserRoles",
                keyColumns: new[] { "RoleId", "UserId" },
                keyValues: new object[] { new Guid("e6a84561-2b8e-4c7b-a2c4-1e0269c8c593"), new Guid("adffb8b5-e90d-4163-a60f-1d290509260e") });

            migrationBuilder.DeleteData(
                table: "AspNetRoles",
                keyColumn: "Id",
                keyValue: new Guid("e6a84561-2b8e-4c7b-a2c4-1e0269c8c593"));

            migrationBuilder.DeleteData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: new Guid("adffb8b5-e90d-4163-a60f-1d290509260e"));
        }
    }
}
