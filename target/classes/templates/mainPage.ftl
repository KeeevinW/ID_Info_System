<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>

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

    <h1 style="margin-top: 10%">Welcome, ${username}!</h1>
    <br><br>
    <h2>Your birthday is: ${response.User_Birthday}</h2>
    <br><br>
    <h2>Your address is: ${response.User_Address}</h2>
    <br><br>
    <h2>Your Chinese ID number is: ${response.User_ID}</h2>
    <br><br>
    <button class="custom-button" onclick="window.location.href='/logout'">Log Out</button>


</body>
</html>