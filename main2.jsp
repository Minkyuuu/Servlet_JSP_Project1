<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="omok.MemberDAO" %>
<%@ page import="omok.MemberVO" %>
<%@ page session="true" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// 내장 객체 session을 사용하여 세션 정보 확인
if (session == null || session.getAttribute("isLogon") == null || !(Boolean) session.getAttribute("isLogon")) {
    // 세션이 없거나 로그인 정보가 없는 경우 로그인 페이지로 리다이렉트
    response.sendRedirect("login.jsp");
    return;
}

// 세션 정보 가져오기
String userId = (String) session.getAttribute("login.id");
String userPwd = (String) session.getAttribute("login.pwd");
String userNickname = (String) session.getAttribute("login.nickname");
%>
		<main>
			<h2>반갑습니다, <%=userNickname%>님!!! </h2>
		<form action="logoutServlet" method="get">
		    <button type="submit">로그아웃</button>
		</form><br>
		<form action="/omok/UnregisterServlet" method="POST">
		    <button type="submit">회원탈퇴</button>
		</form><br>
		<button onclick = location.href="profile.jsp">프로필</button><br><br>
		<form action="waitingRoom.jsp" method="POST">
		    <button type="submit">게임 시작</button>
		</form><br>
	</main>
</body>
</html>