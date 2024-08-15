<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
</head>
<body style="align-content: center">
    <form action="api/newuser" id="newuser_info">
        <label for="username">Please enter your username</label>
        <input name="username" id="username">
        <br><br>
        <label for="password">Please enter your password</label>
        <input name="password" id="password" type="password">
        <br><br>
        <label for="c_password">Please enter your password again</label>
        <input name="c_password" id="c_password" type="password">
        <br><br>
        <input type="submit" value="Click to register">
    </form>

    <script>
        document.getElementById("newuser_info").onsubmit=function (event){
            event.preventDefault();

            const formData = new FormData(this);

            const xhr = new XMLHttpRequest();
            xhr.open("POST", this.action, true);

            // Handle response
            xhr.onload = function() {
                if (xhr.status === 200) {
                    alert("User registered successfully!");
                    // Handle success response
                } else {
                    alert("Error: " + xhr.statusText);
                    // Handle error response
                }
            };

            // Send the request
            xhr.send(formData);
        }
    </script>

    <br><br>
    <button onclick="window.location.href='/'">Back to Main Page</button>
</body>
</html>