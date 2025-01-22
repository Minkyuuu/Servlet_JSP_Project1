<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="omok.MemberDAO" %>
<%@ page import="omok.MemberVO" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정 프로필</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
MemberDAO dao = new MemberDAO();

boolean user_isLogon = (boolean)session.getAttribute("isLogon");
String user_id = (String)session.getAttribute("login.id");
String user_pwd = (String)session.getAttribute("login.pwd");
String user_nickname = (String)session.getAttribute("login.nickname");
int winCnt = (int)dao.getMemberById(user_id).getWinCnt();
int lossCnt = (int)dao.getMemberById(user_id).getLossCnt();
String winningRate = "0";
if(winCnt+lossCnt != 0){
	winningRate = (winCnt*100 / (winCnt+lossCnt)) + "%";	
}
%>
<h2 align=center>프로필 정보</h2>
<table border=1 width=800 align=center>
	<tr align=center>
		<td bgcolor="#FFFF66">아이디</td>
		<td><%=user_id %></td>
	</tr>
	<tr align=center>
		<td bgcolor="#FFFF66">닉네임</td>
		<td><%=user_nickname %></td>
	</tr>
	<tr align=center>
		<td bgcolor="#FFFF66">승률</td>
		<td><%=winningRate %></td>
	</tr>
</table>
</body>
</html>