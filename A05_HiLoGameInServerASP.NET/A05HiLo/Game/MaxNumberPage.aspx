<%-- 
    FILE : MaxNumberPage.aspx
    PROJECT : A05HiLo
    PROGRAMMER : Yujung Park
    FIRST VERSION : 2022-11-10
    DESCRIPTION : This application of ASP.NET Web Forms demonstrates Hi-Lo game that the player guesses numbers in a specific range 
    until the correct number is found. MaxNumberPage is 2nd Page.
--%>



<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MaxNumberPage.aspx.cs" Inherits="A05HiLo.Game.MaxNumberPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HI-LO Max</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous" />
</head>
<body>
    <form id="MaxNumber" runat="server">
        <div class="container text-center fs-2 bg-primary">HI-LO GAME</div>
        <div class="container text-center p-2 bg-light">
            <asp:Label 
                ID="MaxRange" 
                runat="server" 
                Text=""></asp:Label> <br />
        </div>
        <div class="container text-center p-2">
            <asp:Label 
                ID="MaxNumLabel" 
                runat="server" 
                Text=""></asp:Label>
            <asp:TextBox 
                ID="MaxNumInput" 
                runat="server"></asp:TextBox>
            <asp:Button
                ID="MaxNumSubmit"
                runat="server" 
                Text="Submit" 
                OnClick="MaxNumSubmit_Click" 
                class ="btn btn-primary mb-2"
                style="--bs-btn-padding-y: 3px" /> <br />
            <asp:Label 
                ID="MaxNumError" 
                runat="server"
                ForeColor="red"
                Text=""></asp:Label>

            <%-- validation - the maximum input is not blank --%>
            <asp:RequiredFieldValidator ID="inputValidator" 
                runat="server" 
                ForeColor="red"
                ControlToValidate="MaxNumInput" 
                ErrorMessage="Your max number input cannot be BLANK">
            </asp:RequiredFieldValidator>
            <asp:CustomValidator id="CustomValidatorMax"
                ControlToValidate="MaxNumInput"
                ErrorMessage=""
                ForeColor="red"
                Font-Names="verdana" 
                Font-Size="10pt"
                OnServerValidate="ServerValidationMax"
                runat="server" />

        </div>       
    </form>
</body>
</html>
