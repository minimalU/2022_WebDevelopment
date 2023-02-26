<!--
    FILE : hiloGameSession1.asp
    PROJECT : A4 HI-LO
    PROGRAMMER : Yujung Park
    FIRST VERSION : 2022-10-20
    DESCRIPTION : This is ASP serverside page for max number receipt for Hi-Lo game
-->



<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
	<title>Hi-Lo Game : SESSION Max Number</title>

	<script type="text/javascript">

	// FUNCTION : validateMaxNum
    // DESCRIPTION : This function is to validate the maximum guess number of user input
    // PARAMETERS : none
    // RETURNS : nothing
    function validateMaxNum() 
    {
        // get input value with id="maxNum"
        var min = 2;
        const kMax = Number.MAX_SAFE_INTEGER;
        var maxNumInput = document.getElementById("maxNum").value;
        var randomInt = 0;
        var maxNumValid = false;
        var maxNumInt;
        var maxNumvalid = 0;
        var regexInt = /^[0-9]*$/gm;
                
        // clean up the UI from the previous use
        document.getElementById("maxNumError").innerHTML = "";
        
        // condition for a number input? // is number? is integer?
        if (isNaN(maxNumInput)) {
            document.getElementById("maxNumError").innerHTML = "Invalid input: Input value is not a number. Please choose your maximum guess number between " + min + " and " + kMax;
        }         
        // condition for not a number input
        else {
            if(maxNumInput.match(regexInt)) {
                maxNumInt = parseInt(maxNumInput);
                // condition for out of range   // user's maximum number input had to have a value greater than 1
                if (maxNumInt < min || maxNumInt > kMax) {
                document.getElementById("maxNumError").innerHTML = "Invalid input: Input value is out of range. Please choose your maximum guess number between " + min + " and " + kMax;
                }
                else {
                  maxNumValid =true;
                  maxGuessNum = maxNumInt;
                  randomInt = Math.floor(Math.random() * maxNumInt +1);
                }
            }
            else {
                document.getElementById("maxNumError").innerHTML = "Invalid input: Input value is not integer. Please choose your maximum guess number between " + min + " and " + kMax;   
            }
        }

        return maxNumValid;
    }
	</script>
</head>

<body>
    <%
		' get name value from <form> submitted by POST and use the Request.Form object
        dim userName
        dim maxNum
        
        userName= Request.Form("name")
        if(userName <> "") then		        
        Session("userName") = userName
        end if

        maxNum= Request.Form("maxNum")        

	%>
    
    <form action="hiloGameSession2.asp" method="post" name="maxNumForm" onsubmit="return validateMaxNum();">
		<table>
			<tr>
				<td> Hey <%=userName%>! Please enter the maximum guess number for the game </td>
				<td><input type="text" name="maxNum" value=""/></td>
				<td colspan="3" align="center"><input id="maxNumSubmit" type="submit" value="submit" /></td>
				<td><div id="maxNumError" style="color:red;"></div></td>
				<td>&nbsp;</td>
			</tr>
		</table>
        <div>
            <input type="hidden" name="name" id="name" value="<%=userName%>" />
        </div>
	</form>
</body>
</html>