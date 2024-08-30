<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>

    <style>

        .flip-card {
            background-color: transparent;
            width: 500px;
            height: 500px;
            border: none;
            perspective: 1000px; /* Remove this if you don't want the 3D effect */
            border-radius: 10px;
            margin: 5% auto;
        }

        /* This container is needed to position the front and back side */
        .flip-card-inner {
            position: relative;
            width: 100%;
            height: 100%;
            text-align: center;
            transition: transform 0.8s;
            transform-style: preserve-3d;
            border-radius: 10px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        }

        /* Do an horizontal flip when you move the mouse over the flip box container */
        .flip-card:hover .flip-card-inner {
            transform: rotateY(180deg);
        }

        /* Position the front and back side */
        .flip-card-front, .flip-card-back {
            position: absolute;
            width: 100%;
            height: 100%;
            -webkit-backface-visibility: hidden; /* Safari */
            backface-visibility: hidden;
            border-radius: 10px;
        }

        /* Style the front side (fallback if image is missing) */
        .flip-card-front {
            background-color: whitesmoke;
            color: black;
        }

        /* Style the back side */
        .flip-card-back {
            background-color: cornflowerblue;
            color: white;
            transform: rotateY(180deg);
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
            transform: translateY(-2px); /* Slight lift on hover */
        }

        .custom-button:active {
            transform: translateY(0); /* Reset lift when clicked */
        }
    </style>

</head>
<body style="text-align: center; background-color: antiquewhite">

    <#if firstTimeLogin>
        <script>
            alert("Since this is your first login / you have reset your password to the default one, please reset your password")
            window.location.href = '/setPassword'
        </script>
    </#if>

    <div class="flip-card">
        <div class="flip-card-inner">
            <div class="flip-card-front">
                <br>
                <h1 style="margin-top: 10%">Welcome, ${username}!</h1>
                <br><br>
                <h2>Your Chinese ID number is: ${response.User_ID}</h2>
                <br><br>
                <h3>Hover to see the info extracted from your ID</h3>
            </div>
            <div class="flip-card-back">
                <br><br>
                <h2>Your birthday is</h2><br>
                <h2>${response.User_Birthday}</h2>
                <br><br>
                <h2>Your address is</h2><br>
                <h2>${response.User_Address}</h2>
                <br>
            </div>
        </div>
    </div>



<button class="custom-button" <#if isAdmin>style="margin-right: 10%"</#if> onclick="window.location.href='/logout'">Log Out</button>

<#if isAdmin>
    <button class="custom-button" onclick="window.location.href='/adminLogin?username=${username}'">Back To Admin Page</button>
</#if>


</body>
</html>