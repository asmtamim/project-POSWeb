using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace POSWeb.App.Models
{
    public class Invoice
    {
        public int idInvoice { get; set; }

        [ForeignKey("Sale")]
        public int fk_saleID { get; set; }
        public DateTime invoiceDate { get; set; }

        [ForeignKey("Customer")]
        public int fk_customerID { get; set; }
        public decimal totalAmt { get; set; }
        public virtual Sale Sale { get; set; }
        public virtual Customer Customer { get; set; }

    }
}