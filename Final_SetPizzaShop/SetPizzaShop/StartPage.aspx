<%-- 
    FILE          : starPage.aspx.cs
    PROJECT       : SET Pizza Shop
    PROGRAMMER    : Yujung Park, Philip Wojdyna
    FIRST VERSION : 2022.12.13
    DESCRIPTION   : This web application provides pizza shop web service, 
                    user can enter their name and make their pizza by selecting toppings
                    and get the information for their order with price and topping chosen
                    and user also can confirm or cancel their order.
    --%>


<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StartPage.aspx.cs" Inherits="SetPizzaShop.Page1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SET Pizza Shop | Home</title>
    <link href="custom.css" rel="stylesheet" />
</head>
<body style="text-align:center">
    <form id="section1" runat="server" >
        <div class="titlePizza"><h><b>SET Pizza Shop</b></h></div>
        <br />
        <div class="textboxDiv">
            <asp:Label ID="NamePrompt" 
                runat="server" 
                Text="Please enter first & last name:"></asp:Label>
            <div class="textboxDiv"><asp:TextBox ID="UserName" 
                runat="server" ></asp:TextBox>
            <asp:Button ID="NameSubmit" 
                runat="server" 
                Text="Submit" 
                OnClick="NameSubmit_Click" 
                class ="btn btn-primary mb-2"
                style="--bs-btn-padding-y: 3px"/>
                <br />
            <asp:Label ID="Message" 
                runat="server" 
                Text=""
                ForeColor="red"></asp:Label>
            </div>

            <%-- Client-side validation - the user name is not blank --%>
            <asp:RequiredFieldValidator ID="inputValidator" 
                runat="server" 
                ForeColor="red"
                ControlToValidate="UserName" 
                ErrorMessage="Your name cannot be BLANK">
            </asp:RequiredFieldValidator>

            <asp:CustomValidator id="CustomValidator1"
                ControlToValidate="UserName"
                ErrorMessage=""
                ForeColor="red"
                Font-Names="verdana" 
                Font-Size="10pt"
                OnServerValidate="ServerValidation"
                runat="server"/>
        </div>
    </form>
</body>
</html>
