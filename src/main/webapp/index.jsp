<%@ page import="Models.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    <link rel="icon" type="image/vnd.microsoft.icon" href="img/icon.ico">
    <title>Home</title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script>
        function myFunction() {
            document.getElementById("myDropdown").classList.toggle("show");
        }

    </script>

</head>

<body>
<div class="topnav">
    <a class="active" href="index.jsp">Home</a>
    <a href="${pageContext.request.contextPath}/TableShower">Groups</a>
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
        <button onclick="myFunction()" style="color:black; margin-right: 10px;" class="dropbtn"><i
                class="fa fa-filter"></i></button>
    </div>
</div>
<div class="log_in">
    <div id="id01" class="modal_home">
        <form class="modal-home-content animate" action="login" method="post">
            <div class="container_l">
                <c:if test="${error == true}">
                <div style="border: #f44336 1px solid;color:#AD151F;background-color: rgba(255,0,17,0.4);width: auto;padding: 10px">
                    Wrong email or password, please check!
                </div>
                    </c:if>
                <label><b>Email</b></label>
                <input class="logEmail" type="email" placeholder="Enter Email" name="email" required>
                <label><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="psw" required>
                <button type="submit">Login</button>
            </div>

            <div class="container_l" style="background-color:#f1f1f1">
                <c:if test="${error == true}">
                <button type="button" onclick="window.location.replace('http://localhost:8080/CourseWork_war_exploded/index.jsp')" class="cancelbtn">
                    Cancel
                </button>
                </c:if><c:if test="${error == null}">
                <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">
                    Cancel
                </button>
            </c:if>
            </div>
        </form>
    </div>
</div>
<script>
    // Get the modal
    var modal = document.getElementById('id01');

    var error = <c:out value="${error}"/>
        if (error){
            modal.style.display = "block";
        }
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }
</script>


<div class="container">
    <h1 style="margin: 20px;">Home page</h1>
    <br>
    <div class="account_info">
        <c:if test="${isLogged==true}">
            <hr style="width: 97% ;border: 1px solid #f1f1f1;">
            <br>
            <div class="inf">
                <h4>Name: ${fname}</h4>
                <h4>Surname: ${sname}</h4>
                <h4>Email: ${email}</h4>
            </div>
            <div class="imgcontainer" style="text-align: left; margin-left: 60px; margin-top: 40px;">
                <img src="img/account_avatar.png" alt="Avatar"
                     style="background-color: white;width: 20%;border-radius: 50%;border: 10px solid #45A405;">
            </div>
            <br>
            <hr style="width: 97% ;border: 1px solid #f1f1f1;
  margin-bottom: 25px;">
            <br>
        </c:if>
        <div class="default_home" style="width: 90%;display: block;margin: 0 auto">
            <h1 style="font-size:40px;text-align: center;text-shadow:2px 5px rgba(0,0,0,0.4);">Welcome to the
                Deanery</h1>
            <h4 class="text_def">Here you can find out which group you are in, as well as your course, group number and
                Faculty!</h4>
            <h3 class="text_def">If you are one of the members of the Dean's office, then you can personally create /
                edit / delete groups and their students!</h3>
        </div>
    </div>

</div>



</body>

</html>