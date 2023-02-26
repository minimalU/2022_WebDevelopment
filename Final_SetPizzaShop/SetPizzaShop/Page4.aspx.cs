using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SetPizzaShop
{
    public partial class Page4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (Session["User"] != null && Session["User"].ToString() != "")
            {
                string user = Session["User"].ToString();
                string[] userName = user.Split(' ');
                greeting4.InnerText = "Thank you, " + user;
            }
            else
            {
                greeting4.InnerText = "Thank you, User!";
            }

            if (Session["Choice"] != null && Session["Choice"].ToString() == "confirm")
            {
                finalStatus.InnerText = "You confirmed the order. Yay! Pizza Party!";
            }
            else if (Session["Choice"] != null && Session["Choice"].ToString() == "cancel")
            {
                finalStatus.InnerText = "You cancelled the order.";
            }
            else
            {
                finalStatus.InnerText = "someting bad happen :(";
            }


        }
    }
}