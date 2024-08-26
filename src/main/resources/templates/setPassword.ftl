<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
        <input type="submit" value="Click to set a new password">
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