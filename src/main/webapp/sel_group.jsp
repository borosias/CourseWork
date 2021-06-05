<%@ page contentType="text/html;charset=UTF-8" %>

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
            <input type="text" placeholder="Search.." name="search" pattern="^[a-zA-Z0-9-]+$" required>

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



<div class="container">
    <div class="groups">
        <h1 style="margin:0 auto; padding-top: 30px; padding-left: 30px;">Groups</h1>
        <h2 style="margin:0 auto; padding-top: 30px; padding-left: 30px;">${gname}</h2>

        <div style="margin: 20px 0 ;">
            <table class="groups_table">
                <tr class="tr" style="color: white;">
                    <th class="th">First Name</th>
                    <th class="th">Second Name</th>
                    <th class="th">Status</th>
                    <th class="th">Email</th>
                    <th class="th"></th>
                </tr>
                <jsp:useBean id="listStudents" scope="request" type="java.util.List"/>
                <c:forEach items="${listStudents}" var="student">
                    <tr class="tr" style="color:white">
                        <c:forEach items="${student}" var="info">
                            <td class="td">${info}</td>
                        </c:forEach>
                        <c:if test="${isLogged==true}">
                            <td class="td">
                                <div style="float:right">
                                    <form style="display:inline;" method="post" action="studentEdit">
                                        <input type="hidden" name="student" value="${student}">
                                        <input type="hidden" name="name" value="${gname}">
                                        <button type="submit" style="text-align: right;
                                                             background-color: rgba(62,62,70,0);
                                                             color:white;
                                                             font-size: 20px;
                                                             border: none;cursor: pointer;margin: auto;"><i
                                                class="fa fa-pencil"></i>
                                        </button>
                                    </form>

                                    <form style="display:inline;" method="post" action="studentDelete">
                                        <input type="hidden" name="student" value="${student}">
                                        <input type="hidden" name="name" value="${gname}">
                                        <button type="submit" style="text-align: right;
                                                             background-color: rgba(62,62,70,0);
                                                             color:white;
                                                             font-size: 20px;
                                                             border: none;cursor: pointer;margin: auto;"><i
                                                class="fa fa-close"></i>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </c:if>
                        <c:if test="${isLogged==false}">
                            <td class="td"></td>
                        </c:if>
                    </tr>
                </c:forEach>
            </table>

        </div>
        <br>
        <!-- Trigger/Open The Modal -->
        <c:if test="${isLogged==true}">
            <button id="myBtn" onclick="document.getElementById('myModal').style.display='block'">Add Student</button>
        </c:if>
        <br>

        <!-- The Modal -->
        <div id="myModal" class="modal">

            <!-- Modal content -->
            <div class="modal-content">
                <div class="modal-header">
                    <span onclick="document.getElementById('myModal').style.display='none'"
                          class="close_adder">&times;</span>
                    <c:if test="${isEditor==null}">
                        <h2>Add Student</h2>
                    </c:if>
                    <c:if test="${isEditor==true}">
                        <h2>Edit Student</h2>
                    </c:if>
                </div>
                <c:if test="${isEditor==null}">
                    <form method="post" style="display:inline" action="studentAdd">
                        <div style="margin-top: 19px;" class="modal-body">
                            <table class="groups_table">
                                <tr class="tr1">
                                    <th class="th" style="color: black">First Name</th>
                                    <th class="th" style="color: black">Second Name</th>
                                    <th class="th" style="color: black">Status</th>
                                    <th class="th" style="color: black">Email</th>
                                </tr>
                                <tr class="tr1">

                                    <td class="td1">
                                        <input type="text"
                                               placeholder="Enter student first name" name="st_f_name" pattern="^[a-zA-Z]+$" required>
                                    </td>
                                    <td class="td1"><input type="text"
                                                           placeholder="Enter student second name" name="st_s_name"
                                                           pattern="^[a-zA-Z]+$" required></td>
                                    <td class="td1" style="width:20%;font-size:14px;font-weight:500; color: #757575">
                                        <input type="radio" name="st_status" value="Budget" required>Budget
                                        <input type="radio" name="st_status" value="Contract" required>Contract
                                    </td>
                                    <td class="td1"><input type="email" class="sEmail" placeholder="Enter student's email"
                                                           name="st_email" style="padding: 16px;
	width: 88.38%;
	display: inline-block;
	border: none;
	cursor: text;
	background-color: rgba(256,256,256,0); " required></td>

                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" name="name" value="${gname}">
                            <button class="apply_add_group" type="submit">Apply</button>
                        </div>
                    </form>
                </c:if>
                <c:if test="${isEditor==true}">
                    <form method="post" style="display:inline" action="studentEditConfirm">
                        <div style="margin-top: 19px;" class="modal-body">
                            <table class="groups_table">
                                <tr class="tr1">
                                    <th class="th" style="color: black">First Name</th>
                                    <th class="th" style="color: black">Second Name</th>
                                    <th class="th" style="color: black">Status</th>
                                    <th class="th" style="color: black">Email</th>
                                </tr>
                                <tr class="tr1">
                                    <td class="td1"><input type="text"
                                                           placeholder="Enter student first name" pattern="^[a-zA-Z]+$" name="st_f_name"
                                                           value="${editName}">
                                    </td>
                                    <td class="td1"><input type="text"
                                                           placeholder="Enter student second name" pattern="^[a-zA-Z]+$" name="st_s_name"
                                                           value="${editSurname}" required></td>
                                    <td class="td1" style="width:20%;font-size:14px;font-weight:500; color: #757575">
                                        <c:if test="${editStatus == 'BUDGET'}">
                                            <input type="radio" name="st_status" value="Budget" checked>Budget
                                            <input type="radio" name="st_status" value="Contract">Contract
                                        </c:if>
                                        <c:if test="${editStatus == 'CONTRACT'}">
                                            <input type="radio" name="st_status" value="Budget">Budget
                                            <input type="radio" name="st_status" value="Contract" checked>Contract
                                        </c:if>
                                    </td>
                                    <td class="td1"><input type="email" placeholder="Enter student's email"
                                                           name="st_email" style="padding: 16px;
	width: 88.38%;
	display: inline-block;
	border: none;
	cursor: text;
	background-color: rgba(256,256,256,0); " value="${editEmail}" required></td>
                                    <input type="hidden" name="old_email" value="${editEmail}">
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <input type="hidden" name="name" value="${gname}">
                            <button class="apply_add_group" type="submit">Apply</button>
                        </div>
                    </form>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    // Get the modal
    var editTool = <c:out value="${isEditor}"/>;

    var modal = document.getElementById("myModal");

    // Get the <span> element that closes the modal
    var span = document.getElementsByClassName("close_adder")[0];

    // When the user clicks on <span> (x), close the modal
    span.onclick = function () {
        if (editTool === true) {
            window.location.replace("http://localhost:8080/CourseWork_war_exploded/ShowStudents?name=${gname}");
        }
    }

    if (editTool === true) {
        modal.style.display = "block";
    }

</script>

</body>
</html>