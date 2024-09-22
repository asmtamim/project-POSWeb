using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace POSWeb.App.Models
{
    public class CartViewModel
    {
        public List<SaleViewModel> Sales { get; set; }

        public int SelectedCustomerId { get; set; }
        public IEnumerable<SelectListItem> Customers { get; set; }
    }
}