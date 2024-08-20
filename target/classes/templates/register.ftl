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
        <input name="username" id="username" required>
        <br><br>
        <label for="password">Please enter your password: </label>
        <input name="password" id="password" type="password" required>
        <br><br>
        <label for="c_password">Please enter your password again: </label>
        <input name="c_password" id="c_password" type="password" required>
        <br><br>
        <label for="id">Please enter your ID: </label>
        <input name="id" id="id" type="text" required>
        <br><br>
        <label for="phoneNum">Please enter your phone number: </label>
        <input name="phoneNum" id="phoneNum" type="tel" required>
        <br><br>
        <input type="submit" value="Click to register">
    </form>

    <script>
        $(document).ready(function(){
            $("#newuser_info").on("submit", function(event){
                event.preventDefault();


                function isValidID(id){ //check if the id number is a valid Chinese id Number
                    if(id.length !== 18){
                        return false;
                    }
                    let coefficient = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
                    let last_digit = ["1", "0", "X", "9", "8", "7", "6", "5", "4", "3", "2"]

                    let sum = 0;
                    for(let x=0; x<id.length-1; x++){
                        sum += parseInt(id[x])*coefficient[x];
                    }
                    let result = sum%11;

                    if(result === 10){
                        if(id[17] === "X") return true;
                    }else{
                        return last_digit[result] === id[17];
                    }

                }

                let u_name = $("#username").val();
                let ini_p = $("#password").val();
                let check_p = $("#c_password").val();
                let id = $("#id").val();
                let phoneNum = $("#phoneNum").val();

                if(!isValidID(id)){
                    alert("Please enter a valid Chinese id")
                }else if(phoneNum.length !== 11){
                    alert("Please enter the correct phone number");
                }else if (ini_p !== check_p){
                    alert("Please ensure you input the same password twice");
                }else{
                    const formData = {
                        username: u_name,
                        password: ini_p,
                        phoneNum: phoneNum,
                        id: id
                    };
                    $.ajax({
                        url: "/api/newuser",
                        type: "POST",
                        contentType: "application/json",
                        data: JSON.stringify(formData),
                        success: function(response){

                            document.getElementById("username").value = "";
                            document.getElementById("password").value = "";
                            document.getElementById("c_password").value = "";
                            document.getElementById("id").value = "";
                            document.getElementById("phoneNum").value= "";

                            if(response === "Register Successfully"){
                                alert("User registered successfully!\nYour username: "+u_name+"\nYour Password: "+ini_p);
                                window.location.href='/';
                            }else{
                                alert(response);
                            }
                        },
                        error: function(xhr, status, error){
                            alert("An error occurred: " + error);
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