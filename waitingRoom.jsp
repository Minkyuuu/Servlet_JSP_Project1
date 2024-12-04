<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="omok.MemberDAO" %>
<%@ page import="omok.MemberVO" %>
<%@ include file="header.jsp" %>
<%@ page session="true" %>
<%@ page import="omok.LoginMember" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>오목 : 게임 대기실</title>
</head>
<style>
body{
	align:center;
}
</style>
<body>
<%
request.setCharacterEncoding("utf-8");
MemberVO memberVO = new MemberVO();
MemberDAO dao = new MemberDAO();

boolean user_isLogon = (boolean)session.getAttribute("isLogon");
String user_id = (String)session.getAttribute("login.id");
String user_nickname = (String)session.getAttribute("login.nickname");
%>

<!-- 대기실 -->
<form name="waitingRoom" method="get" action="waitingRoom"></form>
	<div id="onlineUsers">
		<h2>접속 중인 유저</h2>
	</div>
	<button id="requestGame" disabled>게임 요청</button>
	
	
<!-- 대기실 웹소켓 -->
<script>
	var chatWebSocket = new WebSocket("ws://localhost:8080/omok/waitingSocket");
	
	// 접속한 유저의 ID
	const currentUserId = "<%= user_id %>";
	let selectedUser = null;
	
	// 접속시 웹소켓으로 데이터 넘김
	chatWebSocket.onopen = function() {
	    chatWebSocket.send(JSON.stringify({
	        type: "login",
	        userId: currentUserId,
	        nickname: "<%= user_nickname %>"
	    }));
	};

	// 서버로부터 메시지를 받을 때 호출
	chatWebSocket.onmessage = function(event) {
		console.log("Recieved Data :", event.data);
	    const data = JSON.parse(event.data);
	    if (data.type === "updateUsers") {
	        updateOnlineUsers(data.users);
	    } else if (data.type === "gameRequest") {
	        alert(data.fromNickname + "님이 게임을 요청했습니다!");

	        sendRequest(selectedUser);
	    }
	};

	// 유저 목록 업데이트
	function updateOnlineUsers(users) {
		console.log("Updating users:", users); // 디버깅 로그
	    const onlineUsersDiv = document.getElementById("onlineUsers");
	    onlineUsersDiv.innerHTML = "<h2>접속 중인 유저</h2>";
	    selectedUser = null;
	    users.forEach(user => {
	        if (user.id !== currentUserId) {
	            const radio = document.createElement("input");
	            radio.type = "radio";
	            radio.name = "user";
	            radio.value = user.id;
	            radio.onclick = () => {
	                selectedUser = user.id;
	                document.getElementById("requestGame").disabled = false;
	            };

	            const label = document.createElement("label");
	            label.textContent = user.nickname;

	            onlineUsersDiv.appendChild(radio);
	            onlineUsersDiv.appendChild(label);
	            onlineUsersDiv.appendChild(document.createElement("br"));
	        }
	    });
	    if (selectedUser === null) {
	        document.getElementById("requestGame").disabled = true;
	    }
	}

	// 게임 요청 전송
	document.getElementById("requestGame").onclick = function() {
	    if (selectedUser) {
	        chatWebSocket.send(JSON.stringify({
	            type: "gameRequest",
	            fromId: currentUserId,
	            toId: selectedUser
	        }));
	        alert("게임 요청을 전송했습니다.");
	    }
	};

	// 요청받은 유저가 응답 여부 선택
	function sendRequest(opponentId) {
	    if (confirm("게임을 시작하시겠습니까?")) {
	        fetch(`/acceptGameRequest?opponentId=${opponentId}`, { method: 'POST' })
	            .then(res => res.json())
	            .then(data => {
	                if (data.success) {
	                    location.href = "game.jsp";
	                } else {
	                    alert("게임 요청을 처리하는 데 실패했습니다.");
	                }
	            });
	    } else {
	        alert("게임 요청을 거절했습니다.");
	    }
	}
	
	// 서버 연결 종료 시 알람
	chatWebSocket.onclose = function() {
	    alert("서버와 연결이 끊어졌습니다.");
	};
</script>
</body>
</html>