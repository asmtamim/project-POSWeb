using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;
using POSWeb.App.Models;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using System.Configuration;
using System.IO;
using POSWeb.App.Reports;

namespace POSWeb.App.Controllers
{
    public class SalesController : Controller
    {
        private AppDbContext db = new AppDbContext();

        // GET: Sales
        public ActionResult Index(string searchStr)
        {
            var products = db.Products.AsQueryable();

            if (!string.IsNullOrEmpty(searchStr))
            {
                products = products.Where(p => p.productName.Contains(searchStr));
            }

            return View(products.ToList());
        }


        // POST: Sales/ProceedToCart
        [HttpPost]
        public ActionResult ProceedToCart(int selectedProduct, int quantity)
        {
            var product = db.Products.Find(selectedProduct);

            var saleVM = new SaleViewModel
            {
                ProductId = selectedProduct,
                ProductName = product.productName,
                UnitPrice = product.price,
                Quantity = quantity,
                TotalPrice = product.price * quantity
            };

            var customers = db.Customers.Select(c => new SelectListItem
            {
                Value = c.idCustomer.ToString(),
                Text = c.customerName
            }).ToList();

            var cartVM = new CartViewModel
            {
                Sales = new List<SaleViewModel> { saleVM },
                Customers = customers
            };

            return View("Cart", cartVM);
        }



        // POST: Sales/CompleteSale
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CompleteSale(int productId, int quantity, int customerId)
        {
            if (productId > 0 && quantity > 0 && customerId > 0)
            {
                var LastSaleId = new SqlParameter("@NewSaleId", SqlDbType.Int) { Direction = ParameterDirection.Output };

                var totalPrice = quantity * db.Products.Find(productId).price;

                db.Database.ExecuteSqlCommand("EXEC sp_sale_and_stock_update @ProductId, @CustomerId, @Quantity, @TotalPrice, @NewSaleId OUTPUT",
                    new SqlParameter("@ProductId", productId),
                    new SqlParameter("@CustomerId", customerId),
                    new SqlParameter("@Quantity", quantity),
                    new SqlParameter("@TotalPrice", totalPrice),
                    LastSaleId);

                var saleId = (int)LastSaleId.Value;

                db.SaveChanges();
                return RedirectToAction("Invoice", new { saleId });
            }
            else
            {
                ModelState.AddModelError("", "Invalid input data. Please ensure all fields are filled correctly.");
            }

            return View("Cart", new CartViewModel
            {
                Sales = new List<SaleViewModel>(),
                Customers = db.Customers.Select(c => new SelectListItem
                {
                    Value = c.idCustomer.ToString(),
                    Text = c.customerName
                }).ToList()
            });
        }



        // GET: Sales/Invoice
        public ActionResult Invoice(int saleId)
        {
            if (saleId <= 0)
            {
                return HttpNotFound();
            }

            var invoice = db.Invoices.Include(i => i.Sale.Customer)
                .Where(i => i.Sale.idSale == saleId)
                .Select(i => new InvoiceViewModel.InvoiceDetails
                {
                    SaleId = i.Sale.idSale,
                    InvoiceId = i.idInvoice,
                    CustomerName = i.Sale.Customer.customerName,
                    InvoiceDate = i.invoiceDate,
                    TotalAmount = i.Sale.totalAmt
                })
                .FirstOrDefault();

            if (invoice == null)
            {
                return HttpNotFound();
            }

            var model = new InvoiceViewModel
            {
                SaleId = saleId,
                PreviousInvoices = new List<InvoiceViewModel.InvoiceDetails> { invoice }
            };

            return View(model);
        }

        // GET: Sales/InvoiceList
        public ActionResult InvoiceList()
        {
            var invoices = db.Invoices.Include(i => i.Sale.Customer)
                .Select(i => new InvoiceViewModel.InvoiceDetails
                {
                    SaleId = i.Sale.idSale,
                    InvoiceId = i.idInvoice,
                    CustomerName = i.Sale.Customer.customerName,
                    InvoiceDate = i.invoiceDate,
                    TotalAmount = i.Sale.totalAmt
                }).ToList();

            var model = new InvoiceViewModel
            {
                PreviousInvoices = invoices
            };

            return View(model);
        }


        // GET: Sales/RptSalesInvoice
        public ActionResult RptSalesInvoice(int invoiceId)
        {
            DataTable dt = new DataTable();

            using (var connection = new SqlConnection(db.Database.Connection.ConnectionString))
            {
                connection.Open();
                using (var command = new SqlCommand("sp_sale_invoice_info", connection))
                {
                    command.CommandType = CommandType.StoredProcedure;
                    command.Parameters.AddWithValue("@InvoiceId", invoiceId);

                    using (var reader = command.ExecuteReader())
                    {
                        dt.Load(reader);
                    }
                }
            }

            rpt_sales_invoice rpt = new rpt_sales_invoice();
            rpt.SetDataSource(dt);

            Stream stream = rpt.ExportToStream(ExportFormatType.PortableDocFormat);
            string fileName = $"Invoice_{invoiceId}.pdf";

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", $"inline; filename={fileName}");
            return File(stream, "application/pdf");
        }
    }
}
