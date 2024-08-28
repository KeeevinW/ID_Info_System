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

    <h1 style="margin-top: 10%">SET PASSWORD</h1>
    <form id="setPassword">
        <label for="password">Please enter a new password: </label>
        <input name="password" id="password" type="password" required maxlength="20">
        <br><br>
        <label for="c_password">Please enter the password again: </label>
        <input name="c_password" id="c_password" type="password" required maxlength="20">
        <br><br>
        <input class="custom-button" type="submit" value="Click to set a new password">
    </form>

    <script>
        $(document).ready(function(){
            $("#setPassword").on("submit", function(event){
                event.preventDefault();

                let ini_p = $("#password").val();
                let check_p = $("#c_password").val();

                const formData = {
                    password: ini_p
                };

                let apiUrl = "api/setPassword?nameOrPhone=${username}&password=" + encodeURIComponent(ini_p);

                if(ini_p !== check_p){
                    alert("Please enter the same password twice.");
                }else{
                    $.ajax({
                        url: apiUrl,
                        type: "PUT",
                        contentType: "application/json",
                        data: JSON.stringify(formData),
                        success: function(response){
                            if(response === "password set"){
                                alert("password set successfully, please log in again")
                                window.location.href = '/logout';
                            }
                        },
                        error: function(xhr, status, error) {
                            // Handle other potential errors (e.g., show a general error message)
                            alert("An unexpected error occurred: " + xhr.responseText);
                        }
                    })
                }

            })
        })
    </script>
</body>
</html>