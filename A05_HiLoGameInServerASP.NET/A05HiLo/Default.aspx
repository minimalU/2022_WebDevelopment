<%-- 
    FILE : Default.aspx
    PROJECT : A05HiLo
    PROGRAMMER : Yujung Park
    FIRST VERSION : 2022-11-10
    DESCRIPTION : This application of ASP.NET Web Forms demonstrates Hi-Lo game that the player guesses numbers in a specific range 
    until the correct number is found. Default.aspx is the Start Page.
--%>


<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="A05HiLo.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HI-LO Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous" />
</head>
<body>
    <form id="section1" runat="server">
        <div class="container text-center fs-2 bg-primary mb-4 ">WELCOME TO HI-LO GAME</div>
        <div class="container text-center p-2">
            <asp:Label ID="NamePrompt" 
                runat="server" 
                Text="Please enter your name"></asp:Label>
            <asp:TextBox ID="UserName" 
                runat="server" ></asp:TextBox>
            <asp:Button ID="NameSubmit" 
                runat="server" 
                Text="Submit" 
                OnClick="NameSubmit_Click" 
                class ="btn btn-primary mb-2"
                style="--bs-btn-padding-y: 3px"/>
            <asp:Label ID="Message" 
                runat="server" 
                Text=""
                ForeColor="red"></asp:Label>

            <%-- validation - the player's name is not blank --%>
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

