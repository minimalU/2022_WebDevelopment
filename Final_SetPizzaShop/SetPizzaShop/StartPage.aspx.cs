using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SetPizzaShop
{
    public partial class Page1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        // State management
        protected void NameSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Session["User"] = UserName.Text.ToString();
                Server.Transfer("Page2.aspx");
            }
        }

        // Server-side validation
        protected void ServerValidation(object source, ServerValidateEventArgs args)
        {
            string regEx = @"([a-zA-Z]*\s[a-zA-Z]*)";
            if (Regex.IsMatch(args.Value, regEx))
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
                Message.Text = "Your name can contain alphabetic characters and one space [e.g. Darryl Poworoznyk]";
            }
        }
    }
}