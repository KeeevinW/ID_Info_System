<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <style>
        table {
            width: auto; /* Make the table wider */
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

        td:nth-child(6) input {
            width: 300px; /* Set a wider width for the Address input field */
        }

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
    <h1>Welcome, admin ${adminName}!</h1>
    <br><br>
<#--    <table>-->
<#--        <tr class="tableHeader">-->
<#--            <td>Username</td>-->
<#--            <td>User Phone Number</td>-->
<#--            <td>User Password</td>-->
<#--            <td>Is Admin</td>-->

<#--        </tr>-->
<#--        <#foreach User in Users>-->
<#--            <tr class="tableBody">-->
<#--                <td><input type="text" value="${User.username}"/></td>-->
<#--                <td><input type="text" value="${User.phoneNum}"/></td>-->
<#--                <td><input type="text" value="${User.password}"/></td>-->
<#--                <td><input type="checkbox" ${User.isAdmin?string('checked', '')}/></td>-->
<#--            </tr>-->
<#--        </#foreach>-->
<#--    </table>-->
<#--    <table>-->
<#--        <tr class="tableHeader">-->
<#--            <td>ID Number</td>-->
<#--            <td>Address</td>-->
<#--            <td>Date of Birth</td>-->
<#--        </tr>-->
<#--        <#foreach Info in userInfo>-->
<#--            <tr class="tableBody">-->
<#--                <td><input type="text" value="${Info.user_ID}"/></td>-->
<#--                <td><input type="text" value="${Info.user_Address}"/></td>-->
<#--                <td><input type="text" value="${Info.user_Birthday}"/></td>-->
<#--            </tr>-->
<#--        </#foreach>-->
<#--    </table>-->


    <table>
        <tr class="tableHeader">
            <th>Username</th>
            <th>User Phone Number</th>
            <th>User Password</th>
            <th>Is Admin</th>
            <th>ID Number</th>
            <th>Address</th>
            <th>Date of Birth</th>
        </tr>
        <#list Users as User>
            <#list userInfo as Info>
                <#if User.username == Info.username>
                    <tr class="tableBody">
                        <td><input type="text" value="${User.username}"/></td>
                        <td><input type="text" value="${User.phoneNum}"/></td>
                        <td><input type="text" value="${User.password}"/></td>
                        <td><input type="checkbox" ${User.isAdmin?string('checked', '')}/></td>
                        <td><input type="text" value="${Info.user_ID}"/></td>
                        <td><input type="text" value="${Info.user_Address}"/></td>
                        <td><input type="text" value="${Info.user_Birthday}"/></td>
                    </tr>
                    <#break>
                </#if>
            </#list>
        </#list>
    </table>


    <br><br>
    <button class="custom-button" onclick="window.location.href='/logout'">Log Out</button>
</body>
</html>