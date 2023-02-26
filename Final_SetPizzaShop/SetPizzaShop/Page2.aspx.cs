using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SetPizzaShop
{
    public partial class Page2 : System.Web.UI.Page
    {
        public static double total = 10.00;
        public static bool ? pepperoni = null;
        public static bool ? mushrooms = null;
        public static bool ? olives = null;
        public static bool ? peppers = null;
        public static bool ? cheese = null;


        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;

            if (Session["User"] != null && Session["User"].ToString() != "")
            {
                string user = Session["User"].ToString();
                string[] userName = user.Split(' ');
                greeting.InnerText = "Ciao " + userName[0];
            }
            else
            {
                greeting.InnerText = "Ciao User!";
            }

            if (!IsPostBack)
            {
                total = 10.00;
            }
        }

        //a.As the toppings are selected, a total price is updated dynamically on the page
        [WebMethod]
        public static string Total(string toppingAdded)
        {
            // parse string and update variables
            string[] toppingArray = toppingAdded.Split('-');
            string topping = toppingArray[0];
            string toppingStatus = toppingArray[1];

            // update amount and toppings
            if (topping=="pepperoni" && toppingStatus=="true")
            {
                total += 1.5;
                pepperoni = true;
            }
            else if (topping == "pepperoni" && toppingStatus == "false")
            {
                total -= 1.5;
                pepperoni = false;
            }
            else if (topping == "mushrooms" && toppingStatus == "true")
            {
                total += 1.0;
                mushrooms = true;
            }
            else if (topping == "mushrooms" && toppingStatus == "false")
            {
                total -= 1.0;
                mushrooms = false;
            }
            else if (topping == "olives" && toppingStatus == "true")
            {
                total += 1.0;
                olives = true;
            }
            else if (topping == "olives" && toppingStatus == "false")
            {
                total -= 1.0;
                olives = false;
            }
            else if (topping == "peppers" && toppingStatus == "true")
            {
                total += 1.0;
                peppers = true;
            }
            else if (topping == "peppers" && toppingStatus == "false")
            {
                total -= 1.0;
                peppers = false;
            }
            else if (topping == "cheese" && toppingStatus == "true")
            {
                total += 2.25;
                cheese = true;
            }
            else
            {
                total -= 2.25;
                cheese = false;
            }


            string myJsonString;
            Dictionary<string, string> data;
            data = new Dictionary<string, string>();
            // topping status is true, concat into orderstaus, concat the -total into orderstatus
            // add the concat string into data
            string ordered = null;
            if (pepperoni == true)
            {
                ordered += "pepperoni, ";
            }
            if (mushrooms == true)
            {
                ordered += "mushrooms, ";
            }
            if (olives == true)
            {
                ordered += "green olives, ";
            }
            if (peppers == true)
            {
                ordered += "green peppers, ";
            }
            if (cheese == true)
            {
                ordered += "double cheese, ";
            }

            ordered += "-" + total.ToString("C2");
            data.Add("Success", ordered);

            myJsonString = (new JavaScriptSerializer()).Serialize(data);
            return myJsonString;
        }

        protected void MakeIt_Click(object sender, EventArgs e)
        {
            Session["OrderDetails"] = TextBox1.Text.ToString();

            Server.Transfer("Page3.aspx");
        }
    }
}