using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace A05HiLo.Game
{
    public partial class YouWin : System.Web.UI.Page
    {
        // Name    : Page_Load
        // Purpose : to load the page
        // Input   : object     sender
        //           EventArgs  e
        // Outputs : none
        // Returns : nothing
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // Name    : PlayAgain_Click
        // Purpose : to redirect MaxNumberPage
        // Input   : object     sender
        //           EventArgs  e
        // Outputs : none
        // Returns : nothing
        protected void PlayAgain_Click(object sender, EventArgs e)
        {
            Server.Transfer("MaxNumberPage.aspx");
        }
    }
}