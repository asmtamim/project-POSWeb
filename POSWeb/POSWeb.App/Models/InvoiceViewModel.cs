using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace POSWeb.App.Models
{
    public class InvoiceViewModel
    {
        public int SaleId { get; set; }
        public List<InvoiceDetails> PreviousInvoices { get; set; }

        public class InvoiceDetails
        {
            public int InvoiceId { get; set; }
            public int SaleId { get; set; }
            public string CustomerName { get; set; }
            public string Phone { get; set; }
            public string ProductName { get; set; }
            public decimal Price { get; set; }
            public int Quantity { get; set; }
            public DateTime InvoiceDate { get; set; }
            public decimal TotalAmount { get; set; }
        }
    }


}