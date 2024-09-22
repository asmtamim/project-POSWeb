using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace POSWeb.App.Models
{
    public class Customer
    {
        public int idCustomer { get; set; }

        [Required(ErrorMessage = "Customer Name is required!")]
        public string customerName { get; set; }

        [EmailAddress(ErrorMessage = "Invalid Email Address!")]
        public string email { get; set; }

        [Required(ErrorMessage = "Phone number is required!")]
        [Phone(ErrorMessage = "Invalid Phone Number!")]
        public string phone { get; set; }

        //[NotMapped]
        public DateTime createdAt { get; set; }
    }

}