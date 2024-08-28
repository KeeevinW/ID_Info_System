<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Log In to the System</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <style>
        .container {
            margin-left: auto;
            margin-right: auto;
            margin-top: 13%;
            width: 30%;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            background-color: whitesmoke;
            border-radius: 5%;
        }

        .custom-button {
            background-color: darkslategray;
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
            background-color: lightslategray;
            transform: translateY(-2px); /* Slight lift on hover */
        }

        .custom-button:active {
            transform: translateY(0); /* Reset lift when clicked */
        }

        input[type=text], input[type=password] {
            width: 80%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
            border-radius: 10px;
        }

        label {
            font-weight: bold;
        }
    </style>

</head>
<body style="text-align:center; background-color: antiquewhite">
    <div class="container">
        <br><br>
        <h1>LOG IN</h1>
        <br>

        <#if logoutSuccess?? && logoutSuccess==true>
            <script>
                alert("You have successfully logged out.");
            </script>
        </#if>

        <form action="/login" method="post" id="loginForm">
            <label for="username">Username/Phone Number</label><br>
            <input type="text" name="username" id="username" placeholder="Enter your username or phone number" required>
            <br><br>
            <label for="password">Password</label><br>
            <input type="password" name="password" id="password" placeholder="The default password is 12345678" required>
            <br><br>
            <input class="custom-button" id="loginButton" type="submit" value="Click to log in">
        </form>

        <br><br>
        <button class="custom-button" onclick="window.location.href='/newuser';">Register an account</button>
        <br><br>
    </div>

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

                        if(response === "There are more than one password"){
                            let PhoneNumber = prompt("Since there is one or more user have the same username with you, please enter your phone number to help us clarify your identity");
                            if(PhoneNumber === null || PhoneNumber === ""){
                                alert("please log in again");
                                location.reload();
                            }else{
                                $("#username").val(PhoneNumber);
                                $("#loginButton").click();
                            }
                        }else if(response === "log in to normal account"){
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




</body>
</html>