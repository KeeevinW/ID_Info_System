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

        .deleteButton {
            border: none; /* Remove border */
            background: none; /* Remove background */
            color: red; /* Set text color to red */
            padding: 0; /* Remove padding */
            font-size: 14px; /* Adjust font size */
            cursor: pointer; /* Make the text look clickable */
        }

        .deleteButton:hover {
            text-decoration: underline; /* Optional: underline on hover */
        }

    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body style="text-align: center">
    <h1>Welcome, admin ${adminName}!</h1>
    <br><br>

    <table>
        <tr class="tableHeader">
            <th>Username</th>
            <th>User Phone Number</th>
            <th>User Password</th>
            <th>Is Admin</th>
            <th>ID Number</th>
            <th>Address</th>
            <th>Date of Birth</th>
            <th></th>
        </tr>
        <#list Users as User>
            <#list userInfo as Info>
                <#if User.username == Info.username>
                    <tr class="tableRow">
                        <td><input type="text" value="${User.username}" class="username"/></td>
                        <td><input type="text" value="${User.phoneNum}" class="phoneNum"/></td>
                        <td><input type="text" value="${User.password}" class="password"/></td>
                        <td><input type="checkbox" ${User.isAdmin?string('checked', '')} class="isAdmin"/></td>
                        <td><input type="text" value="${Info.user_ID}" class="user_ID"/></td>
                        <td><input type="text" value="${Info.user_Address}" class="user_Address" disabled/></td>
                        <td><input type="text" value="${Info.user_Birthday}" class="user_Birthday" disabled/></td>
                        <td>
                            <button class="deleteButton" onclick="deleteUser(this)">DELETE USER</button>
                            <br>
                            <button class="resetPassword" onclick="resetPassword(this)">RESET PASSWORD</button>
                        </td>
                    </tr>
                    <#break>
                </#if>
            </#list>
        </#list>


    </table>

    <script>
        function deleteUser(button){


            let targetRow = button.closest('tr');
            let username = targetRow.querySelector('.username').value;
            let PhoneNum = targetRow.querySelector('.phoneNum').value;
            let isAdmin = targetRow.querySelector('.isAdmin').checked;


            if(username === "${adminName}"){
                alert("You can't delete yourself!")
                return;
            }else if(isAdmin){
                alert("You can't delete another admin!");
            }

            let confirmDelete = confirm('Are you sure you want to delete the user with username '+ username + ' and phone number '+PhoneNum+'?');

            if(confirmDelete){

                $.ajax({
                    url: "/api/deleteUser?phoneNum="+encodeURIComponent(PhoneNum),
                    type: "DELETE",
                    contentType: "application/json",
                    success: function (response) {
                        alert(response);
                        location.reload();
                    },
                    error: function (xhr, status, error) {
                        alert("An error occurred: " + error);
                    }
                })
            }

        }

        function resetPassword(button){
            let targetRow = button.closest("tr");
            let phoneNum = targetRow.querySelector(".phoneNum").value;
            let username = targetRow.querySelector(".username").value;

            let confirmReset = confirm("Are you sure to reset the password of the user with username " + username +" and phone number " + phoneNum + " ?");

            if(confirmReset){
                $.ajax({
                    url: "api/resetPassword?phoneNum="+encodeURIComponent(phoneNum),
                    type: "PUT",
                    contentType: "application/json",
                    success(response){
                        alert(response);
                        location.reload();
                    },
                    error: function (xhr, status, error) {
                        alert("An error occurred: " + error);
                    }
                })
            }
        }
    </script>

    <br><br>
    <button class="custom-button"  style="margin-right: 10%" onclick="window.location.href='/logout'">Log Out</button>
    <button class="custom-button" onclick="window.location.href = '/adminToNormal?username=${adminName}&isAdmin=true'">Log In As A Normal User</button>
</body>
</html>