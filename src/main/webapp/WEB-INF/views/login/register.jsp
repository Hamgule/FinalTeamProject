<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link rel="stylesheet" href="${path}/resources/css/register.css">
<link rel="stylesheet" href="${path}/resources/css/button.css">

</head>
<body>
	<section class="register-form">
		<div class="back-button" onclick="location.href='${path}/'">
			<span class="back-1"></span>
			<span class="back-2"></span>
		</div>
		<h1>Register</h1>
		<form action="registerok" method="post">
			<div class="input-area">
				<input type="text" name="username" id="id" autocomplete="off" placeholder="Username" required>
				<label for="id">USER NAME</label>
			</div>
			<div class="input-area">
				<input type="password" name="password" id="pw" autocomplete="off" placeholder="Password" required>
				<label for="pw">PASSWORD</label>
			</div>
			<div class="button-area">
				<input type="submit" id="submit"/>
				<label for="submit"><div>Register</div><span></span></label>
			</div>
		</form>
	</section>
</body>
</html>