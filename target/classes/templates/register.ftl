<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body style="text-align: center">

    <h1>CREATE AN ACCOUNT</h1>
    <br><br>
    <form action="/api/newuser" id="newuser_info" method="post">
        <label for="username">Please enter your username: </label>
        <input name="username" id="username">
        <br><br>
        <label for="password">Please enter your password: </label>
        <input name="password" id="password" type="password">
        <br><br>
        <label for="c_password">Please enter your password again: </label>
        <input name="c_password" id="c_password" type="password">
        <br><br>
        <input type="submit" value="Click to register">
    </form>

    <script>
        $(document).ready(function(){
            $("#newuser_info").on("submit", function(event){
                event.preventDefault();


                let ini_p = $("#password").val();
                let check_p = $("#c_password").val();
                if(ini_p !== check_p){
                    alert("Please ensure you input the same password twice");
                }else{
                    const formData = {
                        username: $("#username").val(),
                        password: ini_p
                    };

                    console.log(formData);

                    $.ajax({
                        url: "/api/newuser",
                        type: "POST",
                        contentType: "application/json",
                        data: JSON.stringify(formData),
                        success: function(response){
                            console.log(response);
                            document.getElementById("username").value = "";
                            document.getElementById("password").value = "";
                            document.getElementById("c_password").value = "";
                            if(response === "Register Successfully"){
                                alert("User registered successfully!");
                            }

                        }
                    });
                }

            });
        });

    </script>

    <br><br>
    <button onclick="window.location.href='/'">Back to Main Page</button>
</body>
</html>