<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link rel="stylesheet" href="${path}/resources/css/login.css">
<link rel="stylesheet" href="${path}/resources/css/button.css">

</head>
<body>
	<section class="login-form">
		<div class="back-button" onclick="location.href='${path}/'">
			<span class="back-1"></span>
			<span class="back-2"></span>
		</div>
		<h1>CoVID Handong</h1>
		<form action="loginok" method="post">
			<div class="input-area">
				<input type="text" name="username" id="id" autocomplete="off" placeholder="Type your username" required>
				<label for="id">USER NAME</label>
			</div>
			<div class="input-area">
				<input type="password" name="password" id="pw" autocomplete="off" placeholder="Type your password" required>
				<label for="pw">PASSWORD</label>
			</div>
			<div class="button-area">
				<input type="submit" id="submit"/>
				<label for="submit"><div>LOGIN</div><span></span></label>
			</div>
		</form>
		<!-- 
		<div class="caption">
			<a href="">Forgot Password?</a>
		</div>
		 -->
	</section>
</body>
</html>