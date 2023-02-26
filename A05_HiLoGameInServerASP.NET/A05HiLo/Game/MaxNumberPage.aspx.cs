using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Expressions;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A05HiLo.Game
{
    public partial class MaxNumberPage : System.Web.UI.Page
    {

        // Name    : Page_Load
        // Purpose : to load the page
        // Input   : object     sender
        //           EventArgs  e
        // Outputs : message on the label
        // Returns : nothing
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null && Session["User"].ToString() != "")
            {
                MaxNumLabel.Text = "Hey " + Session["User"].ToString() + "! Please enter the maximum guess number for the game";
            }
            else
            {
                MaxNumLabel.Text = "Hey User! Please enter the maximum guess number for the game";
                MaxNumError.Text = "";
            }
        }

        // Name    : MaxNumSubmit_Click
        // Purpose : to check page validation and redirect the next page
        // Input   : object     sender
        //           EventArgs  e
        // Outputs : none
        // Returns : nothing
        protected void MaxNumSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Store the max number in the session
                // (The app either sets the session timeout or uses the default value of 20 minutes.
                // Session state is ideal for storing user data)
                Session["Max"] = MaxNumInput.Text.ToString();
                Server.Transfer("GuessGamePage.aspx");
            }
        }

        // Name    : ServerValidationMax
        // Purpose : to check the max number input is valid
        // Input   : object     source
        //           ServerValidateEventArgs args
        // Outputs : Error message on the text box according to validation
        // Returns : nothing
        protected void ServerValidationMax(object source, ServerValidateEventArgs args)
        {
            // condition for checking number
            string regExD = @"[^0-9]";
            Int32 max = Int32.MaxValue;
            Int32 min = 1;

            if (Regex.IsMatch(args.Value, regExD))
            {
                args.IsValid = false;
                MaxRange.Text = "Your allowable maximum guessing number range is any value between" + min + " and " + max;
                MaxNumError.Text = "Invalid input: Only positive integer value within the range is acceptable. \n" +
                    "Please choose your maximum guess number between " + min + " and " + max;
                MaxNumInput.Text = "";              // clean up ui input
            }
            else
            {
                int maxInput = 0;
                try
                {
                    maxInput = int.Parse(args.Value);
                }
                catch (OverflowException)           // catch Int32.Maxvalue overflow exception
                {
                    maxInput = 0;
                    args.IsValid = false;
                }

                // out of range error
                if((maxInput <= min) || (maxInput > max))
                {
                    MaxRange.Text = "Your allowable guessing range is any value between " + min + " and " + max;
                    MaxNumError.Text = "Invalid input: Input value is out of range. Please choose your maximum guess number between " + min + " and " + max;
                    MaxNumInput.Text = "";      // clean up ui input
                    args.IsValid = false;
                }
                else
                {
                    args.IsValid = true;

                }

                
            }
        }
    }
}