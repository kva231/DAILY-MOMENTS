<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta content="width=device-width, initial-scale=1.0" name="viewport">
		
		<title>FaceGram</title>
		<meta content="" name="description">
		<meta content="" name="keywords">
		
		<!-- Favicons -->
		<link href="<%=request.getContextPath()%>/resources/assets/img/favicon.png" rel="icon">
		<link href="<%=request.getContextPath()%>/resources/assets/img/apple-touch-icon.png" rel="apple-touch-icon">
		
		<!-- Google Fonts -->
		<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
		
		<!-- Vendor CSS Files -->
		<link href="<%=request.getContextPath()%>/resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="<%=request.getContextPath()%>/resources/assets/vendor/icofont/icofont.min.css" rel="stylesheet">
		<link href="<%=request.getContextPath()%>/resources/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
		<link href="<%=request.getContextPath()%>/resources/assets/vendor/owl.carousel/assets/owl.carousel.min.css" rel="stylesheet">
		<link href="<%=request.getContextPath()%>/resources/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
		<link href="<%=request.getContextPath()%>/resources/assets/vendor/venobox/venobox.css" rel="stylesheet">
		
		<!-- Template Main CSS File -->
		<link href="<%=request.getContextPath()%>/resources/assets/css/style.css" rel="stylesheet">
		
		<!-- Ajax -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		
		<!-- Search button -->
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		
		<!-- SweetAlert2 -->
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
		
		<!-- isop -->
		<script src="<%=request.getContextPath()%>/resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
	</head>

	<body>
		<header id="header" class="header-tops">
			<div class="container">
				<h1>
					<a href="">FaceGram</a>
				</h1>
				<h2>
					I'm a passionate <span>graphic designer</span> from New York
				</h2>
	
				<nav class="nav-menu d-none d-lg-block">
					<ul>
						<c:if test="${mid != null}">
							<form class="form-inline">
								<input class="form-control form-control-sm ml-3 w-75" type="text" id="searchedContent" name="searchedContent" placeholder="Search" onkeyup="printSearchedContent()">
							    <button type="button" style="background: #ddd; font-size: 18px; border-radius: 2px;" onclick="search()"><i class="fa fa-search"></i></button>
							</form>
							
							<script>
								function printSearchedContent() {
									var searchedContent = document
											.querySelector('#searchedContent').value;
									console.log(searchedContent);
								}
	
								var mid = '${mid}';
								
								function search() {
									var searchedContent = document
											.querySelector('#searchedContent').value;
									
									if (searchedContent.charAt(0) === '@') {
										searchedId = searchedContent.substr(1);
										
										if (searchedId == mid) {
											profile();
										} else {
											$.ajax({
												url : "searchId",
												post : "GET",
												data : {
													searchedId : searchedId
												},
												success : function(data) {
													if (data.result == "success")
														atSign(searchedId);
													else if (data.result == "fail") {
														Swal.fire({
															icon: 'info',
															title: 'Oops...',
															text: 'Can\'t find Member',
															footer: 'You should search for the Member that exists.'
														})
													}
												}
											});
										}
									} else if (searchedContent.charAt(0) === '#') {
										searchedTag = searchedContent.substr(1);
	
										$.ajax({
											url : "searchTag",
											post : "GET",
											data : {
												searchedTag : searchedTag
											},
											success : function(data) {
												if (data.result == "success")
													tag(searchedTag);
												else if (data.result == "fail") {
													Swal.fire({
														icon: 'info',
														title: 'Oops...',
														text: 'Can\'t find Tag',
														footer: 'You should search for the Tag that exists.'
													})
												}
											}
										});
									} else {
										Swal.fire({
											icon: 'info',
											title: 'Oops...',
											text: 'member search: @, tag search: #',
											footer: 'You should write @ or # in front of searched keyword.'
										})
									}
								}
	
								function atSign(searchedId) {
									$.ajax({
										url : "atSign",
										method : "GET",
										data : {searchedId : searchedId},
										success : function(data) {
											$("#atSign").html(data);
											$("#li-atSign").click();
										}
									});
								}
	
								function tag(searchedTag) {
									$.ajax({
										url : "tag",
										method : "GET",
										data : {searchedTag : searchedTag},
										success : function(data) {
											$("#tag").html(data);
											$("#li-tag").click();
										}
									});
								}
							</script>
						</c:if>
						
						<li class="active"><a href="#header">Home</a></li>
						
						<c:if test="${mid == null}">
							<li><a id="li-loginForm" href="javascript:loginForm()">Login</a>
								<script type="text/javascript">
									function loginForm() {
										$.ajax({
											url : "loginForm",
											method : "GET",
											success : function(data) {
												$("#loginForm").html(data);
												$("#li-loginForm").attr("href", "#loginForm");
												$("#li-loginForm").click();
												$("#li-loginForm").attr("href", "javascript:loginForm()");
											}
										});
									}
								</script>
							</li>
							
							<li><a id="li-join" href="javascript:join()">Join</a>
								<script type="text/javascript">
									function join() {
										$.ajax({
											url : "join",
											method : "GET",
											success : function(data) {
												$("#join").html(data);
												$("#li-join").attr("href", "#join");
												$("#li-join").click();
												$("#li-join").attr("href", "javascript:join()");
											}
										});
									}
								</script>
							</li>
						</c:if>
	
						<c:if test="${mid != null}">
							<li style="display: none"><a id="li-atSign" href="#atSign">At-Sign</a>
							
							<li style="display: none"><a id="li-tag" href="#tag">Tag</a>
							
							<li><a id="li-feed" href="javascript:feed()">Feed</a>
								<script type="text/javascript">
									function feed() {
										$.ajax({
											url : "feed",
											method : "GET",
											success : function(data) {
												$("#feed").html(data);
												$("#li-feed").attr("href", "#feed");
												$("#li-feed").click();
												$("#li-feed").attr("href", "javascript:feed()");
											}
										});
									}
								</script>
							</li>
							
							<li><a id="li-writeForm" href="javascript:writeForm()">Write</a>
								<script type="text/javascript">
									function writeForm() {
										$.ajax({
											url : "writeForm",
											method : "GET",
											success : function(data) {
												$("#writeForm").html(data);
												$("#li-writeForm").attr("href", "#writeForm");
												$("#li-writeForm").click();
												$("#li-writeForm").attr("href", "javascript:writeForm()");
											}
										});
									}
								</script>
							</li>
							
							<li><a id="li-notification" href="javascript:notification()">Notification</a>
								<script type="text/javascript">
									function notification(){
										$.ajax({
											url : "notification",
											method : "GET",
											success : function(data){
												$("#notification").html(data);
												$("#li-notification").attr("href","#notification");
												$("#li-notification").click();
												$("#li-notification").attr("href", "javascript:notification()");
											}
										})
									}
								</script>
							</li>
							
							<li class="dropdown" id="test"><a class="dropdown-toggle" href="#" data-toggle="dropdown">My Page</a>
								<div class="dropdown-menu" style="opacity: 0.5;">
		
									<a id="li-profile" class="dropdown-item" style="color: #0000ff;" href="javascript:profile()">Profile</a>
									<script type="text/javascript">
										function profile() {
											$.ajax({
												url : "profile",
												method : "GET",
												success : function(data) {
													$("#profile").html(data);
													$("#li-profile").attr("href", "#profile");
													$("#li-profile").click();
													$("#li-profile").attr("href", "javascript:profile()");
												}
											});
										}
									</script>
		
									<a id="li-setting" class="dropdown-item" style="color: #0000ff;" href="javascript:setting()">Setting</a>
									<script type="text/javascript">
										function setting() {
											$.ajax({
												url : "setting",
												method : "GET",
												success : function(data) {
													$("#setting").html(data);
													$("#li-setting").attr("href", "#setting");
													$("#li-setting").click();
													$("#li-setting").attr("href", "javascript:setting()");
												}
											});
										}
									</script>
									
									<a id="li-qna" class="dropdown-item" style="color: #0000ff;" href="javascript:qna()">Q&A</a>
									<script type="text/javascript">
										function qna() {
											$.ajax({
												url : "qna",
												method : "GET",
												success : function(data) {
													$("#qna").html(data);
													$("#li-qna").attr("href", "#qna");
													$("#li-qna").click();
													$("#li-qna").attr("href", "javascript:qna()");
												}
											});
										}
									</script>
		
									<a class="dropdown-item" style="color: #0000ff;" href="logout">Logout</a>
								</div>
							</li>
						</c:if>
					</ul>
				</nav>
				
			</div>
		</header>
	
		<section id="loginForm"></section>
		<section id="join"></section>
		<section id="atSign"></section>
		<section id="feed"></section>
		<section id="tag"></section>
		<section id="writeForm"></section>
		<section id="notification"></section>
		<section id="profile"></section>
		<section id="setting"></section>
		<section id="qna"></section>
	
		<!-- Vendor JS Files -->
		<script src="<%=request.getContextPath()%>/resources/assets/vendor/jquery/jquery.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/assets/vendor/jquery.easing/jquery.easing.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/assets/vendor/php-email-form/validate.js"></script>
		<script src="<%=request.getContextPath()%>/resources/assets/vendor/waypoints/jquery.waypoints.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/assets/vendor/counterup/counterup.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/assets/vendor/owl.carousel/owl.carousel.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
		<script src="<%=request.getContextPath()%>/resources/assets/vendor/venobox/venobox.min.js"></script>
	
		<!-- Template Main JS File -->
		<script src="<%=request.getContextPath()%>/resources/assets/js/main.js"></script>
	</body>

</html>