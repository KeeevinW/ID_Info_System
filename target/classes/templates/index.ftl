<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Log In to the System</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        .custom-button {
            background-color: #007BFF; /* Primary blue color */
            color: white; /* White text */
            border: none; /* Remove border */
            padding: 10px 20px; /* Add some padding */
            border-radius: 5px; /* Rounded corners */
            cursor: pointer; /* Pointer cursor on hover */
            font-size: 16px; /* Increase font size */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transitions */
        }

        .custom-button:hover {
            background-color: #0056b3; /* Darker blue on hover */
            transform: translateY(-2px); /* Slight lift on hover */
        }

        .custom-button:active {
            background-color: #004494; /* Even darker blue when clicked */
            transform: translateY(0); /* Reset lift when clicked */
        }
    </style>

</head>
<body style="text-align:center">
    <h1 style="margin-top: 15%">LOG IN</h1>
    <br><br>


    <#if logoutSuccess?? && logoutSuccess>
        <script>
            alert("You have successfully logged out.");
        </script>
    </#if>

    <form action="/login" method="post" id="loginForm">
        <label for="username">Username or Phone Number: </label>
        <input name="username" id="username" required>
        <br><br>
        <label for="password">Password: </label>
        <input type="password" name="password" id="password" required>
        <br><br><br><br>
        <input class="custom-button" type="submit" value="Click to log in">
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
                            window.location.href = '/normalLogin?username=' + encodeURIComponent(formData.username) + '&isAdmin=false&password=' + encodeURIComponent(formData.password);
                        }else if(response === "log in to admin account"){
                            window.location.href = '/adminLogin?username=' + encodeURIComponent(formData.username);
                        }
                    },
                    error: function(xhr, status, error) {
                        if (xhr.status === 401) { // Unauthorized
                            // Handle the unauthorized case (e.g., show an error message to the User)
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

    <button class="custom-button" onclick="window.location.href='/newuser';">Register an account</button>


</body>
</html>