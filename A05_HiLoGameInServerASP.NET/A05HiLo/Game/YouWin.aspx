<%-- 
    FILE : MaxNumberPage.aspx
    PROJECT : A05HiLo
    PROGRAMMER : Yujung Park
    FIRST VERSION : 2022-11-10
    DESCRIPTION : This application of ASP.NET Web Forms demonstrates Hi-Lo game that the player guesses numbers in a specific range 
    until the correct number is found. MaxNumberPage is the last page and the page redirects to the MaxNumberPage as user chooses replay 
--%>



<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="YouWin.aspx.cs" Inherits="A05HiLo.Game.YouWin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HI-LO Win</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous" />
</head>
<body style="background-color: darkmagenta">
    <form id="form1" runat="server">
        <div class="container p-4"></div>
        <div class="container text-center text-primary fs-1 fw-bold">YOU WIN!</div>
        <div class="container text-center p-4 ">
            <asp:Button ID="PlayAgain" 
                runat="server" 
                Text="PLAY AGAIN" 
                OnClick="PlayAgain_Click" 
                class ="btn btn-primary mb-2"
                />
        </div>
    </form>
</body>
</html>
