<!--
    FILE : hiloGameSession2.asp
    PROJECT : A4 HI-LO
    PROGRAMMER : Yujung Park
    FIRST VERSION : 2022-10-20
    DESCRIPTION : This is ASP serverside page for Hi-Lo game pages that has game logic
-->


<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
	<title>Hi-Lo Game : SESSION Guess Number</title>
<script type="text/javascript">

    var whichDiv = 1;
    var numberEnteredCopy = 0;
    var maxNumCopy = 0;
    var minNumCopy = 1;

    // FUNCTION : nextDiv
    // DESCRIPTION : This function is to display each division to separately to user
    // PARAMETERS : none
    // RETURNS : nothing
    function nextDiv() {
        if (whichDiv == 1) {
            document.getElementById("guessNumForm").style.display = "block";
            document.getElementById("youWin").style.display = "none";
            document.querySelector("body").style.backgroundColor = "transparent";
        }
        else {
            document.getElementById("guessNumForm").style.display = "none";
            document.getElementById("section4").style.display = "block";
            document.querySelector("body").style.backgroundColor = "magenta";
            whichDiv = 1;

        }
    }

    // FUNCTION : validateGuessNum
    // DESCRIPTION : This function is to validate the guess number of user input
    // PARAMETERS : none
    // RETURNS : nothing
    function validateGuessNum() {

        const numberEntered = document.querySelector('#guessNumInput').value;
        var maxNum = document.querySelector('#maxNum').value;
        var minNum = document.querySelector('#minNum').value;
        var userName = document.querySelector('#name').value;
        var randomInt = Number(document.querySelector('#randomInt').value);

        var guessNumValid = false;
        var regexInt = /^[0-9]*$/gm;

        console.log(maxNum);


        // clean up the UI from the previous use
        document.getElementById('error').innerHTML = "";

        // not a number
        if (isNaN(numberEntered)) {
            document.getElementById('error').innerHTML = "Invalid input: Input value is not a number. Please choose your guess number between " + minNumCopy + " and " + maxNumCopy;
            document.getElementById('allowableRange').innerHTML = "Your allowable guessing range is any value between " + minNumCopy + " and " + maxNumCopy;
        }
        else {
            // only int
            if (numberEntered.match(regexInt)) {
                numberEnteredCopy = parseInt(numberEntered);
                maxNumCopy = parseInt(maxNum);
                // condition for out of range
                if (numberEnteredCopy <= minNum || numberEnteredCopy > maxNum) {
                    
                    document.getElementById('error').innerHTML = "Outside of the range: Your allowable guessing range is any value between " + minNumCopy + " and " + maxNumCopy;
                    document.getElementById('allowableRange').innerHTML = "Your allowable guessing range is any value between " + minNumCopy + " and " + maxNumCopy;
                }
                else {
                    // range condition for greater than random integer
                    if (numberEnteredCopy > randomInt) {
                        maxNumCopy = numberEnteredCopy;                        
                        document.getElementById('allowableRange').innerHTML = "Your allowable guessing range is any value between " + minNumCopy + " and " + maxNumCopy;
                    }
                    // range condition for less than random integer
                    else if (numberEnteredCopy < randomInt) {
                        minNumCopy = numberEnteredCopy;
                        if (maxNum == 0) { maxNumCopy = maxNum; }
                        console.log(maxNumCopy);
                        document.getElementById('allowableRange').innerHTML = "Your allowable guessing range is any value between " + minNumCopy + " and " + maxNumCopy;
                    }
                    // equal to random integer
                    else {
                        //guessNumValid = true;
                        whichDiv++;
                        nextDiv();
                    }
                }
            }
            else {
                document.getElementById('error').textContent = "Invalid input: Input value is not a integer.";

            }
        }
        // document.getElementById('allowableRange').innerHTML = "Your allowable guessing range is any value between " + minNumCopy + " and " + maxNumCopy;
        return guessNumValid;
    }

    // FUNCTION : resetGame
    // DESCRIPTION : This function is to reset the minimum and maximum guess number for replaying game
    // PARAMETERS : none
    // RETURNS : nothing
    function resetGame() {
        minNumCopy = 1;
        maxNumCopy = 0;
    }

</script>

  </head>

  <body>
  <%
    dim userName
    dim maxNum
    dim minNum
    dim numberEntered
    dim randomInt
    minNum = 1

    userName= Request.Form("name")
    if(userName <> "") then		        ' the form with "name" has just been submitted - so turn it into a session variable
    Session("userName") = userName
    end if

    maxNum = Request.Form("maxNum")
    if(maxNum <> "") then 		        ' the form with "maxNum" has just been submitted - so turn it into a session variable
    Session("maxNum") = maxNum
    end if

    minNum = Request.Form("minNum")
    if(minNum <> "") then 		        ' the form with "maxNum" has just been submitted - so turn it into a session variable
	Session("minNum") = minNum
    else
	minNum = Session("minNum")
    end if

    numberEntered = Request.Form("numberEntered")
    if(numberEntered <> "") then 		        ' the form with "numberEntered" has just been submitted - so turn it into a session variable
	Session("numberEntered") = numberEntered
    else
	numberEntered = Session("numberEntered")
    end if

    randomInt = Request.Form("randomInt")
    if(numberEntered <> "") then 		        ' the form with "numberEntered" has just been submitted - so turn it into a session variable
	Session("randomInt") = randomInt
    else
	randomInt = Session("randomInt")
    end if
      
    Randomize
	randomInt = int((rnd * maxNum) + 1)

  %>



      <form action="hiloGameSession2.asp" method="post" name="guessNumForm" id="guessNumForm" onsubmit="return validateGuessNum();">

        <p id="allowableRange">Your allowable guessing range is any value between 1 and <%=maxNum%> </p>
        <table>
            <tr>
                <td>Hey <%=userName%>!! Please enter your guess number</td>
                <td><input type="text" name="guessNumInput" id="guessNumInput"/></td>
                <td colspan="3" align="center"><input type="submit" value="Make This Guess" /></td>
                <td>&nbsp;</td>
                <td>
                    <p id="error" name="error" style="color:red;"> </p>
                </td>

			</tr>
		</table>
        <div>
            <input type="hidden" name="name" id="name" value="<%=userName%>" />
            <input type="hidden" name="maxNum" id="maxNum" value="<%=maxNum%>" />
            <input type="hidden" name="minNum" id="minNum" value="<%=minNum%>" />
            <input type="hidden" name="randomInt" id="randomInt" value="<%=randomInt%>" />
            <input type="hidden" name="numberEntered" id="numberEntered" value="<%=numberEntered%>" />
        </div>
	 </form>

      <!-- final screen of UI -->
      <form id="section4" style="display:none" action='hiloGameSession1.asp' method="post" name="youWin" onsubmit="resetGame();">
      <div align = "center">
      <div id="youWin">
       <h1>You Win!! You guessed the number!!</h1> 
       <input type="submit" value="Play Again" align="center" />
          <input type="hidden" name="name" value="<%=userName%>" />
      </div>
      </div>
          </form>
  
  </body>
</html>