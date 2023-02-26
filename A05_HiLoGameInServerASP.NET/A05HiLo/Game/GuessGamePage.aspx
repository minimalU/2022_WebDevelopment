<%-- 
    FILE : GuessGamePage.aspx
    PROJECT : A05HiLo
    PROGRAMMER : Yujung Park
    FIRST VERSION : 2022-11-10
    DESCRIPTION : This application of ASP.NET Web Forms demonstrates Hi-Lo game that the player guesses numbers in a specific range 
    until the correct number is found. GuessGamePage is 3rd Page.
--%>


<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GuessGamePage.aspx.cs" Inherits="A05HiLo.Game.GuessGamePage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HI-LO Guess</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container text-center fs-2 bg-primary">HI-LO GAME</div>
        <div class="container text-center p-2 bg-light">
            <asp:Label 
                ID="GuessRange" 
                runat="server" 
                Text=""
                EnableViewState="true"></asp:Label> <br />
        </div>
        <div class="container text-center p-2">
            <asp:Label 
                ID="GuessNumLabel" 
                runat="server" 
                Text=""></asp:Label>
            <asp:TextBox ID="GuessNumInput" 
                runat="server" ></asp:TextBox>
            <asp:Button ID="GuessSubmit" 
                runat="server" 
                Text="Make This Guess" 
                OnClick="GuessSubmit_Click" 
                class ="btn btn-primary mb-2"
                style="--bs-btn-padding-y: 3px" /> <br />
            <asp:Label ID="GuessError" 
                runat="server" 
                Text=""
                ForeColor="red" ></asp:Label>
             
             <%-- validation - the guess number is not blank --%>
             <asp:RequiredFieldValidator ID="guessInputValidator" 
                runat="server" 
                ForeColor="red"
                ControlToValidate="GuessNumInput" 
                ErrorMessage="Your guess number input cannot be BLANK">
            </asp:RequiredFieldValidator>
            <asp:CustomValidator id="CustomValidatorGuess"
                ControlToValidate="GuessNumInput"
                ErrorMessage=""
                ForeColor="red"
                Font-Names="verdana" 
                Font-Size="10pt"
                OnServerValidate="ServerValidationGuess"
                runat="server"/>

        </div>
    </form>
</body>
</html>
