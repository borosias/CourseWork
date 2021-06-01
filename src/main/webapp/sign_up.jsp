<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/vnd.microsoft.icon" href="img/icon.ico">
	<title>Sign up</title>
	<link rel="stylesheet"  href="css/main.css" >
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<script>

		function myFunction() {
			document.getElementById("myDropdown").classList.toggle("show");
		}

	</script>
</head>

<body>
<div class="topnav">
	<a href="index.jsp">Home</a>
	<a  href="${pageContext.request.contextPath}/TableShower">Groups</a>
	<c:if test="${isLogged==false}">
		<a class="active" href="sign_up.jsp">Sign up</a>
		<button class="button_log" onclick="document.getElementById('id01').style.display='block'">Log in</button>
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
<div class = "log_in">
	<div id="id01" class="modal_home">
		<form class="modal-home-content animate" action="login" method="post">
			<div class="container_l">
				<label ><b>Email</b></label>
				<input class="logEmail" type="email" placeholder="Enter Email" name="email" required>

				<label><b>Password</b></label>
				<input type="password" placeholder="Enter Password" name="psw" required>

				<button type="submit">Login</button>

			</div>

			<div class="container_l" style="background-color:#f1f1f1">
				<button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>

			</div>
		</form>
	</div>
</div>
<script>
	// Get the modal
	var modal = document.getElementById('id01');

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	}
</script>

<div class="container">
	<div class="sign_up">
		<form action="SignUp" method="post">
			<div class="container3">
				<h1>Registration form</h1>
				<p>Please fill out this form to create an account.</p>
				<hr>

				<label><b>First Name</b></label>
				<input type="text" placeholder="Enter your name" name="f_name" required>

				<label><b>Second Name</b></label>
				<input type="text" placeholder="Please enter your last name" name="s_name" required>

				<label><b>Email</b></label>
				<input class="su_email" type="email" placeholder="Enter your email" name="email" required>

				<label><b>Password</b></label>
				<input type="password" class="su_psw" placeholder="Enter password" name="psw" required>

				<div class="clearfix">
					<button type="reset" class="su_cancelbtn">Cancel</button>
					<button type="submit" class="su_signupbtn">Sign Up</button>
				</div>
			</div>
		</form>
	</div>
</div>
</body>
</html>