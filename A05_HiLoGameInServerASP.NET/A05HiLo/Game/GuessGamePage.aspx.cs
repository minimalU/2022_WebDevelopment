using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A05HiLo.Game
{

    public partial class GuessGamePage : System.Web.UI.Page
    {
        public string gameMax, gameMin;
        int maxNumber;
        int minNumber=1;
        int randomNumber;
        string guessGameMax;
        string guessGameMin;


        // Name    : Page_Load
        // Purpose : to load the page
        // Input   : object     sender
        //           EventArgs  e
        // Outputs : messages on the label and text box
        // Returns : nothing
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1st time page load
            if (IsPostBack == false)
            {
                Random rand = new Random();
                maxNumber = int.Parse(Session["Max"].ToString());
                int GameRandomNum = rand.Next(minNumber, maxNumber+1);
                GuessRange.Text = "Your allowable guessing range is any value between " + "1" + " and " + maxNumber;
                GuessNumLabel.Text = "Hey " + Session["User"].ToString() + "! Please enter the maximum guess number for the game";
                ViewState["maxGuess"] = maxNumber.ToString();
                ViewState["minGuess"] = minNumber.ToString();
                ViewState["randomNum"] = GameRandomNum.ToString();
            }
            else
            {
                // if empty or invalid input in second load
                maxNumber = int.Parse(ViewState["maxGuess"].ToString());
                minNumber = int.Parse(ViewState["minGuess"].ToString());
                randomNumber = int.Parse(ViewState["randomNum"].ToString());

                GuessNumLabel.Text = "Hey " + Session["User"].ToString() + "! Please enter the maximum guess number for the game";
                GuessRange.Text = "Your allowable guessing range is any value " + minNumber + " and " + maxNumber;
                GuessError.Text = "";
            }

        }

        // Name    : GuessSubmit_Click
        // Purpose : to check page validation and redirect the next page
        // Input   : object     sender
        //           EventArgs  e
        // Outputs : none
        // Returns : nothing
        protected void GuessSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                // Store the max number in the session
                // (The app either sets the session timeout or uses the default value of 20 minutes.
                // Session state is ideal for storing user data)
                Server.Transfer("YouWin.aspx");
            }
           
        }


        // Name    : ReturnViewState()
        // Purpose : to control ViewState
        // Input   : nothing
        // Outputs : none
        // Returns : ViewState
        public StateBag ReturnViewState()
        {
            return ViewState;
        }

        // Name    : ServerValidationGuess
        // Purpose : to check the guess number input is valid
        // Input   : object     source
        //           ServerValidateEventArgs args
        // Outputs : Error message on the text box according to validation
        // Returns : nothing
        protected void ServerValidationGuess(object source, ServerValidateEventArgs args)
        {
            string regExGuess = @"[^0-9]";
            int guessInput = 0;
            guessGameMax = maxNumber.ToString();
            guessGameMin = minNumber.ToString();

            // clean up the UI from the previouse use
            //GuessError.Text = "";

            // condition for a number input
            if (Regex.IsMatch(args.Value, regExGuess) || args.Value == null)
            {
                args.IsValid = false;
                GuessError.Text = "Invalid input: Only a positive integer number within a range is acceptable. Please choose your guess number between " + guessGameMin + " and " + guessGameMax;
                GuessNumInput.Text = "";    //clean ui

            }
            else
            {
                guessInput = int.Parse(args.Value);
                // condition for out of range // user's maximum number input had to have a value greater than 1
                if ((guessInput < int.Parse(guessGameMin)) || (guessInput > int.Parse(guessGameMax)))
                {
                    args.IsValid = false;
                    GuessError.Text = "Invalid input: Input value is out of range. Please choose your guess number between " + guessGameMin + " and " + guessGameMax;
                    GuessNumInput.Text = "";    //clean ui
                }
                // range condition for higher input than random int
                else if (guessInput > randomNumber)
                {
                    
                    ViewState["maxGuess"] = guessInput.ToString();
                    maxNumber = guessInput;
                    args.IsValid = false;
                    GuessRange.Text = "Your allowable guessing range is any value " + minNumber + " and " + maxNumber;
                    GuessNumInput.Text = "";    //clean ui
                }
                else if (guessInput < randomNumber)
                {
                    ViewState["minGuess"] = guessInput.ToString();
                    minNumber = guessInput;
                    args.IsValid = false;
                    GuessRange.Text = "Your allowable guessing range is any value " + minNumber + " and " + maxNumber;
                    GuessNumInput.Text = "";    //clean ui
                }
                else
                {
                    args.IsValid = true;
                }
            }
        }
    }
}