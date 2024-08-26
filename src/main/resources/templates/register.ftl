<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
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
<body style="text-align: center">

    <h1>CREATE AN ACCOUNT</h1>
    <br><br>
    <form action="/api/newuser" id="newuser_info" method="post">
        <label for="username">Please enter your username: </label>
        <input name="username" id="username" required maxlength="10">
        <br><br>
        <label for="id">Please enter your ID: </label>
        <input name="id" id="id" type="text" required maxlength="18">
        <br><br>
        <label for="phoneNum">Please enter your phone number: </label>
        <input name="phoneNum" id="phoneNum" type="tel" required maxlength="11">
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
                let id = $("#id").val();
                let phoneNum = $("#phoneNum").val();

                if(!isValidID(id)){
                    alert("Please enter a valid Chinese id")
                }else if(phoneNum.length !== 11){
                    alert("Please enter the correct phone number");
                }else{
                    const formData = {
                        username: u_name,
                        password: "12345678",
                        phoneNum: phoneNum,
                        id: id

                    };
                    $.ajax({
                        url: "/api/newuser",
                        type: "POST",
                        contentType: "application/json",
                        data: JSON.stringify(formData),
                        success: function(response){
                            if(response === "Register Successfully"){
                                document.getElementById("username").value = "";
                                document.getElementById("id").value = "";
                                document.getElementById("phoneNum").value= "";
                                alert("User registered successfully!\nYour username: "+u_name+"\nYour Default Password is \"12345678\", remember to change one after your first login");
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
    <button class="custom-button" onclick="window.location.href='/'">Back to Main Page</button>
</body>
</html>