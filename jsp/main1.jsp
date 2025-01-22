<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오목 게임</title>
</head>
<style>
	body{
		margin 0px;
		padding 0px;
		background: url('img/2.jpg') no-repeat center center fixed;
		background-size: cover;
	}
</style>
<body>
	<main>
		<h2>환영합니다!</h2>
		<button onclick = location.href="login.jsp">로그인</button>
		<button onclick = location.href="signUp.jsp">회원가입</button>
	</main>
</body>
</html>