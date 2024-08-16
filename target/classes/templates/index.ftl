<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Log In to the System</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body style="text-align:center">
    <h1>LOG IN</h1>
    <br><br>

    <#if error??>
        <script>
            alert(${error});
        </script>
    </#if>

    <form action="/login" method="post" id="loginForm">
        <label for="username">Username: </label>
        <input name="username" id="username" required>
        <br><br>
        <label for="password">Password: </label>
        <input type="password" name="password" id="password" required>
        <br><br>
        <input type="submit" value="Click to log in">
    </form>

    <script>
        $(document).ready(function () {
            $("#loginForm").on("submit", function (event){
                event.preventDefault();

                const formData = {
                    username: $("#username").val(),
                    password: $("#password").val()
                };

                $.ajax({
                    url: "api/login",
                    type: "POST",
                    contentType: "application/json",
                    data: JSON.stringify(formData),
                    success: function(response){
                        if(response === "log in to normal account"){
                            window.location.href = '/mainPage?username=' + encodeURIComponent(formData.username);
                        }else if(response === "log in to admin account"){
                            window.location.href = '/adminPage?username=' + encodeURIComponent(formData.username);
                        }
                    },
                    error: function(xhr, status, error) {
                        if (xhr.status === 401) { // Unauthorized
                            // Handle the unauthorized case (e.g., show an error message to the user)
                            alert("Invalid username or password. Please try again.");
                        } else {
                            // Handle other potential errors (e.g., show a general error message)
                            alert("An unexpected error occurred: " + xhr.responseText);
                        }
                    }

                })
            })
        })
    </script>

    <br><br>

    <button onclick="window.location.href='/newuser';">Register an account</button>


</body>
</html>