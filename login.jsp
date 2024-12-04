<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오목 : 로그인</title>
</head>
<body>
	<form name="frmLogin" method="post" action="login">
	<h2>로그인</h2>
	아이디 : <input type="text" name="user_id" placeholder="아이디를 입력하세요." autofocus required><br>
    비밀번호 : <input type="password" name="user_pwd" placeholder="비밀번호를 입력하세요." required><br><br>
    <input type="submit" value="로그인"> <input type="reset" value="초기화">
</body>
</html>