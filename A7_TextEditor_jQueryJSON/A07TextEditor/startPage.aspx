<%--
FILE      : starPage.aspx
PROJECT       : PROG2001-A07TextEditor
PROGRAMMER    : Yujung Park
FIRST VERSION : 2022.12.08
DESCRIPTION   : This program provides text editor service. 
    The web service loads the file from its server and allows user to change the text and save it.
--%>


<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="startPage.aspx.cs" Inherits="A07TextEditor.startPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>A07-JQUERY AND JSON BASED TEXT EDITOR</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous" />
</head>
<body>
    <form id="form1" runat="server">
        <h1 class="container text-center fs-1 bg-primary mb-4">WDD ONLINE TEXT EDITOR</h1>
        <div class="container text-center">    
        <label for="fileSelect">Please select a file and click submit button</label>
            <br />
        <select id="selectfile" name="select" runat="server">
            <option value=""></option>
        </select>
            <button id="submit" type="button" class= "btn btn-primary" runat="server"> Submit </button>
            <label id="statusMessage" for="fileSelect"></label>
            <br />
        </div>
        
        <div class="container text-center">
            <br />
            <textarea id="textContentArea" name="textarea" class="textbox" rows="10" cols="100"></textarea>
            <br />
            <label id="fileStatus" for="fileStatus" width="200"></label>
            <label id="newFileLabel" for="newFileLabel">Please enter a new file name for Save As</label>
            <input id="newFileName" type="text" />
            <br />
            <label id="saveStatus" for="saveStatus"></label>
            <br />
            <button id="save" type="button" class= "btn btn-primary mt-2"> Save </button>
            <button id="saveAs" type="button" class= "btn btn-primary mt-2"> Save As</button>
        </div>

    </form>
    
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script type = "text/javascript" >

        var jQueryXMLHttpRequest; 

        var file0 = '<%=files[0]%>';
        var file1 = '<%=files[1]%>';
        var fileNames;
        var selectedfile;
        var originalContent;
        var newContent;


        //jquery activate only when ready
        //does the intial call to get the file list on document ready
        $(document).ready(function () {
            console.info('ready');

            $.ajax({
                type: "POST",
                url: "startPage.aspx/GetFiles",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    //$("#textContentArea").html(response.d);
                    if (response!= null && response.d != null) {
                        var res;
                        res = $.parseJSON(response.d);
                        var i = res.length;

                        for (var j = 0; j < i; j++) {
                            $('#selectfile').append(`<option value="file"> ${res[j]} </option>`);
                        }
                    }
                },
                failure: function (response) {
                    $("#statusMessage").html(response.d);
                }
            });
        });


        // jQuery AJAX call to GetData webmethod (code behind) for sending and receiving JSON
        var data;
        var strData;
        var changed;
        $('#submit').click(function () {
            // check selected file and save file name into variable
            selectedFile = $('#selectfile option:selected').text();
            console.log(selectedFile);
            data = { fileToLoad: selectedFile };
            strData = JSON.stringify(data);
            console.log(strData);

            $.ajax({
                type: "POST",
                url: "startPage.aspx/GetData",
                data: strData,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response != null && response.d != null) {
                        var res;
                        res = $.parseJSON(response.d);
                        $("#textContentArea").html(res.Success);
                        originalContent = $("#textContentArea").text;
                    }
                },
                failure: function (response) {
                    $("#statusMessage").html(response.d);
                }
            });

            $("textarea").change(function () {
                alert("file text is changed. Do you want to save changes? please click save. ");
                changed = true;
            });
        });

        // jQuery AJAX call to SaveFile webmethod (code behind) for sending and receiving JSON
        $('#save').click(function () {

            newContent = $('#textContentArea').html();
            data = { newText: newContent };
            console.log("where is the error 1");
            strData = JSON.stringify(data);
            console.log(strData);

            $.ajax({
                type: "POST",
                url: "startPage.aspx/SaveFile",
                data: strData,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response != null && response.d != null) {
                        var res;
                        res = $.parseJSON(response.d);
                        $("#saveStatus").html(response.d);
                    }
                },
                failure: function (response) {
                    $("#saveStatus").html(response.d);
                }
            });
        });


        // jQuery AJAX call to NewFile webmethod (code behind) for sending and receiving JSON
        $('#saveAs').click(function () {
            // new file name input is empty
            var newfilename;
            newfilename = $('#newFileName').text();
            var dt = { fileNew: newfilename };
            var JstringData = JSON.stringify(dt);
            // console.log(strDt);
            // send te file name
            $.ajax({
                type: "POST",
                url: "startPage.aspx/NewFile",
                data: JstringData,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (rspns) {
                    if (rspns != null && rspns.d != null) {
                        var res;
                        res = $.parseJSON(rspns.d);
                        $("#textContentArea").html(res.Success);
                    }
                },
                failure: function (rspns) {
                    $("#statusMessage").html(res.d);
                }
            });

            // send te contents for save as
            var newfiledata = { saveAs: newContent };
            var jsNewData;
            jsNewData = JSON.stringify(newfiledata);

            // jQuery AJAX call to SaveAs webmethod (code behind) for sending and receiving JSON
            $.ajax({
                type: "POST",
                url: "startPage.aspx/SaveAs",
                data: strData,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response != null && response.d != null) {
                        var res;
                        res = $.parseJSON(response.d);
                        $("#textContentArea").html(res.Success);
                    }
                },
                failure: function (response) {
                    $("#statusMessage").html(response.d);
                }
            });

        });
    </script>
</body>
</html>
