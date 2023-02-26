using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SetPizzaShop
{
    public partial class Page3 : System.Web.UI.Page
    {
        // use State management
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (Session["User"] != null && Session["User"].ToString() != "")
            {
                string user = Session["User"].ToString();
                string[] userName = user.Split(' ');
                greeting3.InnerText = "Ciao " + userName[0];
            }
            else
            {
                greeting3.InnerText = "Ciao User!";
            }
            if (Session["OrderDetails"] != null && Session["OrderDetails"].ToString() != "")
            {
                string order_detail = Session["OrderDetails"].ToString();
                string[] details = order_detail.Split('-');
                string confirm_details = details[0].TrimEnd(' ');
                confirm_details = confirm_details.TrimEnd(',');
                OrderDetails.InnerText = "Toppings chosen: " + confirm_details + " Total Price: " + details[1];
            }
            else
            {
                greeting3.InnerText = "Ciao User!";
            }
        }

        protected void confirm_Click(object sender, EventArgs e)
        {
            Session["Choice"] = "confirm";
            Server.Transfer("Page4.aspx");
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Session["Choice"] = "cancel";
            Server.Transfer("Page4.aspx");
        }
    }
}