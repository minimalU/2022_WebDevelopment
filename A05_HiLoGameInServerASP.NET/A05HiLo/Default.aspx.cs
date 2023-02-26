using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A05HiLo
{
    public partial class Default : System.Web.UI.Page
    {
        // Name    : Page_Load
        // Purpose : to load the page
        // Input   : object     sender
        //           EventArgs  e
        // Outputs : nothing
        // Returns : nothing
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidationSettings.UnobtrusiveValidationMode = UnobtrusiveValidationMode.None;
        }

        // Name    : NameSubmit_Click
        // Purpose : to store the user name in the session according to page validity
        // Input   : object     sender
        //           EventArgs  e
        // Outputs : nothing
        // Returns : nothing
        protected void NameSubmit_Click(object sender, EventArgs e)
        {
            if(Page.IsValid)
            {
                Session["User"] = UserName.Text.ToString();
                Server.Transfer("Game/MaxNumberPage.aspx");

            }
        }

        // Name    : ServerValidataion
        // Purpose : to validate user input
        // Input   : object     sender
        //           EventArgs  e
        // Outputs : nothing
        // Returns : nothing
        protected void ServerValidation(object source, ServerValidateEventArgs args)
        {
            string regEx = @"\s+";
            if (Regex.IsMatch(args.Value, regEx))
            {
                args.IsValid = false;
                Message.Text = "Your name can contain any non-blank characters.";
            }
            else
            {
                args.IsValid = true;
            }
        }
    }
}