<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<body style="text-align: center">
    <h1>Welcome, ${username}!</h1>
    <br><br>
    <h2>Your birthday is: ${response.User_Birthday}</h2>
    <br><br>
    <h2>Your address is: ${response.User_Address}</h2>
    <br><br>
    <h2>Your Chinese ID number is: ${response.User_ID}</h2>
    <br><br>
    <button onclick="window.location.href='/logout'">Log Out</button>


</body>
</html>