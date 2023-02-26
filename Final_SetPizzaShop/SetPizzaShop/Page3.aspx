<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page3.aspx.cs" Inherits="SetPizzaShop.Page3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SET Pizza Shop | Review</title>
    <link href="custom.css" rel="stylesheet" />
</head>
<body>
    <div class="titlePizza"><h><b>SET Pizza Shop</b></h></div>
    <br />
    <div class="formDiv">
    <form id="page3" runat="server">
        <div class="textboxDiv">
            <label id="greeting3" name="greeting3" for="greeting3" runat="server"> Ciao !</label><br />
            <label for="description"> Your One(1) large pizza with sauce and cheese comes with</label><br/>
            <label id="OrderDetails" name="OrderDetails" for="OrderDetails" runat="server"> </label><br /><br />
            <label id="confirmPrompt" name="confirmPrompt" for="confirmPrompt" runat="server"> Please revew the order and confirm or cancel it.</label><br />
        </div>
        <div class="btnSubmit">
            <asp:Button ID="confirm" runat="server" Text="CONFIRM" OnClick="confirm_Click" />
            <asp:Button ID="cancel" runat="server" Text="CANCEL" OnClick="cancel_Click" />
        </div>
    </form></div>
</body>
</html>
