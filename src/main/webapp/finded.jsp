<%@ page import="Models.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    User user = new User();
    String isLogged = "false";
    Cookie[] cookies = request.getCookies();
    for (Cookie cookie : cookies) {
        if ("uid".equals(cookie.getName())) {
            isLogged = "true";
            user.setUserID(cookie.getValue());
            user.getInfById(Integer.parseInt(user.getUserID()));

            request.setAttribute("email", String.valueOf(user.getUserEmail()));
            request.setAttribute("sname", String.valueOf(user.getSecondN()));
            request.setAttribute("fname", String.valueOf(user.getFirstN()));
        }

    }

    request.setAttribute("isLogged", isLogged);
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/x-icon" href="img/icon.ico">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Groups</title>
    <script>

        function myFunction() {
            document.getElementById("myDropdown").classList.toggle("show");
        }

    </script>
</head>

<body>
<div class="topnav">
    <a href="index.jsp">Home</a>
    <a class="active" href="${pageContext.request.contextPath}/TableShower">Groups</a>
    <c:if test="${isLogged==false}">
        <a href="sign_up.jsp">Sign up</a>
        <button class="button_log" onclick="document.getElementById('id01').style.display='block'">Log in</button>
    </c:if>
    <c:if test="${isLogged==true}">
        <form style="display:inline" action="LogOut">
            <button class="button_log" type="submit" action="LogOut">Log Out</button>
        </form>
    </c:if>
    <div class="search-container">
        <form style="display:inline" method="POST" action="finder">
            <input type="text" placeholder="Search.." name="search" required>

            <button type="submit"><i class="fa fa-search"></i></button>

            <div id="myDropdown" style="color: #606060" class="dropdown-content">
                <h3 style="margin-left: 15px;margin-top: 8px;">Filter</h3>
                <div style="margin: 5px 10px;font-weight:500;">
                    <input type="radio" name="filter" value="surname" checked required>By Surname
                </div>
                <div style="margin: 5px 10px 10px 10px;font-weight:500; ">
                    <input type="radio" name="filter" value="group"  required>By Group
                </div>
            </div>
        </form>
        <button onclick="myFunction()" style="color:black; margin-right: 10px;" class="dropbtn"><i class="fa fa-filter"></i></button>
    </div>
</div>

<div class="log_in">
    <div id="id01" class="modal_home">
        <form class="modal-home-content animate" action="login" method="post">
            <div class="container_l">
                <label><b>Email</b></label>
                <input class="logEmail" type="email" placeholder="Enter Email" name="email" required>

                <label><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="psw" required>

                <button type="submit">Login</button>
            </div>
            <div class="container_l" style="background-color:#f1f1f1">
                <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">
                    Cancel
                </button>
            </div>
        </form>
    </div>
</div>
<script>
    // Get the modal
    var modal_home = document.getElementById('id01');

    // When the user clicks anywhere outside of the modal, close it

    window.onclick = function (event1) {
        if (event1.target === modal_home) {
            modal_home.style.display = "none";
        }
    }

</script>
<div class="container">
    <div class="groups">
        <h1 style="margin:0 auto; padding-top: 30px; padding-left: 30px;">Searching results</h1>
        <div style="margin: 20px 0 ;">
            <table class="groups_table">
                <tr class="tr" style="color: white;">
                    <th class="th">Second Name</th>
                    <th class="th">First Name</th>
                    <th class="th">Status</th>
                    <th class="th">Email</th>
                    <th class="th">Group</th>
                    <th></th>
                </tr>
                <jsp:useBean id="listFindStudents" scope="request" type="java.util.List"/>
                <c:forEach items="${listFindStudents}" var="student">
                    <tr class="tr" style="color:white">
                        <c:forEach items="${student}" var="info">
                            <td class="td">${info}</td>
                        </c:forEach>

                            <td class="td">
                                <div style="float:right">
                                    <form style="display:inline;" method="post" action="ShowStudents">
                                        <input type="hidden" name="name" value="${student[4]}">
                                        <button type="submit" style="text-align: right;
                                                             background-color: rgba(62,62,70,0);
                                                             color:white;
                                                             font-size: 20px;
                                                             border: none;cursor: pointer;margin: auto;"><i
                                                class="fa fa-search"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                    </tr>
                </c:forEach>
            </table>

        </div>
    </div>
</div>
</body>
</html>

