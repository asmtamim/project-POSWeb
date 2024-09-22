using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;

namespace POSWeb.App.Models
{
    public class AppDbContext : DbContext
    {

        public AppDbContext() : base("Connection2AppDbContext") { }

        public DbSet<Product> Products { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Sale> Sales { get; set; }
        public DbSet<Invoice> Invoices { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Product>().HasKey(p => p.idProduct);
            modelBuilder.Entity<Customer>().HasKey(c => c.idCustomer);
            modelBuilder.Entity<Sale>().HasKey(s => s.idSale);
            modelBuilder.Entity<Invoice>().HasKey(i => i.idInvoice);

            base.OnModelCreating(modelBuilder);
        }

    }
}