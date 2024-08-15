<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Log In to the System</title>
</head>
<body>
    <h1 style="align-content:center">LOG IN</h1>
    <br><br>

    <form action="/api/login" style="align-content: center">
        <label for="username">Username: </label>
        <input name="username" id="username" required>
        <br><br>
        <label for="password">Password: </label>
        <input type="password" name="password" id="username" required>
        <br><br>
        <input type="submit" value="Click to log in">
    </form>

    <br><br>

    <button style="align-content: center" onclick="window.location.href='/newuser';">Register an account</button>


</body>
</html>