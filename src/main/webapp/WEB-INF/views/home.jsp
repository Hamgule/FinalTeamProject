<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
<link rel="stylesheet" href="${path}/resources/css/home.css">
</head>

<body>
	<div class="home-container">
		<h1>CoVID Handong</h1>
		<div class="sign-area">
			<div class="button-area">
				<button id="sign-up"></button>
				<label for="sign-up">SIGN UP</label>
				<span></span>
			</div>
			<div class="partition">
				<label>&ensp;|&ensp;</label>
			</div>
			<div class="button-area">
				<button id="sign-in" onclick="location.href='login/login'"></button>
				<label for="sign-in">SIGN IN</label>
				<span></span>
			</div>
		</div>
	</div>
</body>
</html>
