<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <style>
        table {
            width: 50%; /* Make the table wider */
            height: auto; /* Adjust the height as needed */
            margin: 50px auto; /* Center the table horizontally and add space above */
            border-collapse: collapse; /* Ensure borders are collapsed for a cleaner look */
        }

        th, td {
            padding: 15px; /* Increase padding to make cells larger */
            text-align: center; /* Center text within cells */
            border: 1px solid #ddd; /* Add borders around cells */
        }

        th {
            background-color: #f2f2f2; /* Optional: add a background color to header cells */
        }
    </style>
</head>
<body style="text-align: center">
    <h1>Welcome, admin ${adminName}!</h1>
    <br><br>
    <table>
        <tr class="tableHeader">
            <td>Username</td>
            <td>User Phone Number</td>
            <td>User Password</td>
            <td>Is Admin</td>
        </tr>
        <#foreach User in Users>
            <tr class="tableBody">
                <td>${User.username}</td>
                <td>${User.phoneNum}</td>
                <td>${User.password}</td>
                <td>${User.isAdmin?string("true", "false")}</td>
            </tr>
        </#foreach>
    </table>
    <br><br>
    <button onclick="window.location.href='/logout'">Log Out</button>
</body>
</html>