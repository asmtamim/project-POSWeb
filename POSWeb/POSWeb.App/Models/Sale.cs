using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace POSWeb.App.Models
{
    public class Sale
    {
        public int idSale { get; set; }

        [ForeignKey("Product")]
        public int fk_productID { get; set; }

        [ForeignKey("Customer")]
        public int fk_customerID { get; set; }

        public int qtySold { get; set; }
        public decimal totalAmt { get; set; }
        public DateTime saleDate { get; set; }

        public virtual Product Product { get; set; }
        public virtual Customer Customer { get; set; }
    }

}