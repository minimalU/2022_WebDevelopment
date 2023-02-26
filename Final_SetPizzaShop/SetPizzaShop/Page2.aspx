<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Page2.aspx.cs" Inherits="SetPizzaShop.Page2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <title>SET Pizza Shop | Build</title>
    <link href="custom.css" rel="stylesheet" />
</head>
<body>
    <div class="titlePizza"><h><b>SET Pizza Shop</b></h></div>
    <br />
    <div class="formDiv"><form id="form1" runat="server">
        <div class="textboxDiv">
            <label id="greeting" name="greeting" for="greeting" runat="server"> Ciao</label><br />
            <label id="inform" name="inform" for="inform"> 
                You can only order one(1) large pizza. the pizza comes automatically with sauce and cheese.
                <br />
                Base price: $10.00
            </label><br />

            <label id="pizza" name="pizza" for="pizza"> 
            </label>
                <br />
         
        </div>
        <div class="checkboxCon1">
        <div>
            <input type="checkbox" id="topping1" name="topping1" autocompte="off" value="Pepperoni" />
            <label for="topping1"> Pepperoni - add $1.50</label><br />
            <input type="checkbox" id="topping2" name="topping2" autocompte="off" value="Mushrooms" />
            <label for="topping2"> Mushrooms - add $1.00</label><br />
            <input type="checkbox" id="topping3" name="topping3" autocompte="off" value="Green olives" />
            <label for="topping3"> Green olives - add $1.00</label><br />
            <input type="checkbox" id="topping4" name="topping4" autocompte="off" value="Green peppers" />
            <label for="topping4"> Green peppers - add $1.00</label><br /> 
            <input type="checkbox" id="topping5" name="topping5" autocompte="off" value="Double cheese" />
            <label for="topping5"> Double cheese - add $2.25</label><br />
        </div>
        </div>
        <div>
            <br />
            <label for="total" id="total"></label> 
            <br />
            <asp:Button ID="MakeIt" runat="server" Text="Make It!" OnClick="MakeIt_Click" />            
            <asp:TextBox ID="TextBox1" runat ="server" style = "display: none"></asp:TextBox>

        </div>
    </form></div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
        <script type = "text/javascript" >
            var order;
            var amount;
            
            // jQuery/AJAX interaction with the server
            $(document).ready(function () {
                $("#topping1").click(function () {
                    if ($("#topping1").is(":checked")) {

                        postTopping("pepperoni-true");
                    }
                    else {
                        postTopping("pepperoni-false");
                    }
                });
                $("#topping2").click(function () {
                    if ($("#topping2").is(":checked")) {

                        postTopping("mushrooms-true");
                    }
                    else {
                        postTopping("mushrooms-false");
                    }
                });
                $("#topping3").click(function () {
                    if ($("#topping3").is(":checked")) {

                        postTopping("olives-true");
                    }
                    else {
                        postTopping("olives-false");
                    }
                });
                $("#topping4").click(function () {
                    if ($("#topping4").is(":checked")) {

                        postTopping("peppers-true");
                    }
                    else {
                        postTopping("peppers-false");
                    }
                });
                $("#topping5").click(function () {
                    if ($("#topping5").is(":checked")) {

                        postTopping("cheese-true");
                    }
                    else {
                        postTopping("cheese-false");
                    }
                });
            });

            function postTopping(toppingStatus) {
                console.log(toppingStatus);

                //set string data to send
                var topping = toppingStatus;
                var data = { toppingAdded: topping };
                var strData = JSON.stringify(data);

                $.ajax({
                    type: "POST",
                    url: "Page2.aspx/Total",
                    data: strData,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        if (response != null && response.d != null) {
                            var res;
                            res = $.parseJSON(response.d);

                            // parse the string
                            order = res.Success;
                            var amount = parse(order);

                            $("#total").html(amount);
                            $("#TextBox1").val(res.Success);
                            console.log(res.Success);

                        }
                    },
                    failure: function (response) {
                        $("#Total").text(response.d);
                    }
                });
            }

            function parse(string) {
                const order = string.split("-");
                console.log(order[0]);
                console.log(order[1]);
                return order[1];
            }

        </script>
</body>
</html>
