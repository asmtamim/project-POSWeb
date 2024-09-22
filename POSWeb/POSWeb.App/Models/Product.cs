using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace POSWeb.App.Models
{
    public class Product
    {
        public int idProduct { get; set; }

        [Required(ErrorMessage = "Product Name is required!")]
        public string productName { get; set; }

        [Required(ErrorMessage = "Product price is required!")]
        public decimal price { get; set; }

        [Required(ErrorMessage = "Stock quantity is required!")]
        public int stockQty { get; set; }
        
        //[NotMapped]
        public DateTime createdAt { get; set; }
    }
}