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
            <input type="text" placeholder="Search.." name="search">

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
        <h1 style="margin:0 auto; padding-top: 30px; padding-left: 30px;">Groups</h1>
        <div style="margin: 20px 0 ;">

            <nav style="width: 95%;display:block;margin:0 auto;">
                <ul style="list-style-type: none;padding: 0;margin: 0;font-weight: bold;font-size:20px; ">
                    <c:forEach items="${list}" var="list1">
                        <li style="border: 1px solid #ddd;margin-top: -1px;background-color: rgba(62,62,70,0.7);
                                       padding: 12px 30px;">
                            <c:out value="${list1}"/>

                            <div style="float:right;">
                                <form style="display: inline;" action="ShowStudents">
                                    <input type="hidden" name="name" value="${list1}">
                                    <button type="submit" style="text-align: right;
                                                             background-color: rgba(62,62,70,0);
                                                             color:white;
                                                             font-size: 20px;
                                                             border: none;cursor: pointer;margin: auto;">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </form>
                                <c:if test="${isLogged==true}">
                                    <form style="display:inline;" action="groupEdit">
                                        <input type="hidden" name="name" value="${list1}">
                                        <button type="submit" style="text-align: right;
                                                             background-color: rgba(62,62,70,0);
                                                             color:white;
                                                             font-size: 20px;
                                                             border: none;cursor: pointer;margin: auto;"><i
                                                class="fa fa-pencil"></i>
                                        </button>
                                    </form>
                                    <form style="display:inline;" action="DeleteGroup">
                                        <input type="hidden" name="name" value="${list1}">
                                        <button type="submit" style="text-align: right;
                                                             background-color: rgba(62,62,70,0);
                                                             color:white;
                                                             font-size: 20px;
                                                             border: none;cursor: pointer;margin: auto;"><i
                                                class="fa fa-close"></i>
                                        </button>
                                    </form>
                                </c:if>

                            </div>

                        </li>
                    </c:forEach>

                </ul>
            </nav>

        </div>
        <br>
        <!-- Trigger/Open The Modal -->
        <c:if test="${isLogged==true}">
            <button id="myBtn" onclick="document.getElementById('myModal').style.display='block'">Add Group</button>
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
                        <h2>Add Group</h2>
                    </c:if>
                    <c:if test="${isEditor==true}">
                        <h2>Edit Group</h2>
                    </c:if>
                </div>
                <c:if test="${isEditor==null}">
                    <form method="post" action="tableAdd">
                        <div style="margin-top: 19px;" class="modal-body">
                            <label><b style="color:black;">Group name</b></label>
                            <input type="text" style="width:90%" maxlength="5" class="groups_name" placeholder="Enter group name"
                                   name="gp_name" required>
                        </div>
                        <div class="modal-footer">
                            <button type="sumbit" class="apply_add_group">Apply</button>
                        </div>
                    </form>
                </c:if>
                <c:if test="${isEditor==true}">
                    <form method="post" action="tableEditConfirm">
                        <div style="margin-top: 19px;" class="modal-body">
                            <label><b style="color:black;">Group name</b></label>
                            <input type="hidden" name="name" value="${editingName}">
                            <input type="text" style="width:90%" maxlength="5" class="groups_name" placeholder="Enter group name"
                                   name="gp_name" value="${editingName}" required>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="apply_add_group">Apply</button>
                        </div>
                    </form>
                </c:if>
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
                    window.location.replace("http://localhost:8080/CourseWork_war_exploded/TableShower");
                }
            }

            if (editTool === true) {
                modal.style.display = "block";
            }

        </script>


    </div>
</div>


</body>
</html>