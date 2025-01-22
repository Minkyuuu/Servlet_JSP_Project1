<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오목 : 회원가입창</title>
</head>
<body>
	<!-- 에러메시지 처리 -->
	<c:if test="${not empty errorMessage }">
		<p style="color:red;">${errorMessage }</p>
    </c:if>
	<form name="frmsignUp" method="post" action="signUp">
	<main>
		<h2>회원 가입</h2>
		아이디 : <input type="text" name="user_id" placeholder="아이디를 입력하세요." autofocus required><br><br>
        비밀번호 : <input type="password" name="user_pwd" placeholder="비밀번호를 입력하세요." required><br><br>
        닉네임 : <input type="text" name="user_nickname" placeholder="닉네임을 입력하세요." required><br><br>
        <input type="submit" value="회원가입">
	</main>
	</form>
</body>
</html>