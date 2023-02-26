<!-- 
    FILE          : animals.php
    PROJECT       : A03
    programmer    : Yujung Park
    FIRST VERSION : 2022-10-09
    DESCRIPTION   : This program is to demonstrate the PHP version operation of the server-side website.
                    Along with the completion of form submission of client site of Zoo website, 
                    this animals.php file receives keyand value pair from the client side and
                    displays the animal's image and text for the selected animal by the user into HTML format.
                    !!!!! All of animals pictures and contents are the property of Toronto ZOO.
 -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP ZOO</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>

<?php
$secretUser = $_POST["secretUser"];
$animal = $_POST["animal"];
$imgFile = "theZoo/".$animal.".jpg";
$txtFile = "theZoo/".$animal.".txt";
?>

<body>

<div class="container-lg">
    <h1 class="text-bg-success p-3">Hi, <?php echo $secretUser ?>!   Yes, it's all about animals.</h1>
    <table class="table">
        <tr>
            <td>
            <img src="<?php echo $imgFile ?>" alt=<?php echo $animal ?> width="350">
            </td>
            <td>
                <?php
                if(!file_exists("$txtFile"))
                {
                    die("Sorry :( Unable to open file!");
                }
                else
                {
                    $txtContent = fopen("$txtFile", "r");
                    echo fread($txtContent,filesize("$txtFile"));
                    fclose($txtContent); 
                }
                ?>
            </td>
        </tr>
    </table>
</div>
</body>

</html>