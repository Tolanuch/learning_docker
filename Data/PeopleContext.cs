using Microsoft.EntityFrameworkCore;
using HelloWorldApp.Models;

namespace HelloWorldApp.Data
{
   public class PeopleContext : DbContext
   {
      public PeopleContext(DbContextOptions<PeopleContext> options) : base(options) { }
      public DbSet<People>? PeopleList { get; set; }
   }
}