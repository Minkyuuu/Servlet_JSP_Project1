<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="header.jsp" %>
<%@ page session="true" %>
<%@ page import="omokJava.Board" %>
<%@ page import="omokJava.Omok" %>
<%@ page import="omokJava.Player" %>


    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
    table {
        border-collapse: collapse;
        margin: 20px;
        display: inline-block; /* 인라인 블록으로 설정 */
        vertical-align: top; /* 상단 정렬 */
    }
    form {
        display: inline-block; /* 인라인 블록으로 설정 */
        vertical-align: top; /* 상단 정렬 */
    }
    td, th {
        border-right: none;
        border-left: none;
        border-top: none;
        border-bottom: none;
        text-align: center;
        width: 30px;
        height: 30px;
    }
    th {
        background-color: #f4f4f4;
    }
</style>

<body>
<form name="game" method="get" action="game">
<!-- 오목판 -->
<%
int BOARDSIZE = 19;
int COUNT = 1;
String[][] map = new String[BOARDSIZE][BOARDSIZE];
for (int row = 0; row < BOARDSIZE; row++) {
    for (int col = 0; col < BOARDSIZE; col++) {
        map[row][col] = "·";
    }
}
char chr = 'A';
%>

<table border=1 align=center id="omok">
<% for (int row = 0; row < BOARDSIZE; row++) { %>
	<tr align=center>
		<td bgcolor="#FFFF66"><%=row %></td>
		<% for (int col = 0; col < BOARDSIZE; col++) { %>
			<td id = <%= row %>_<%= col %> onclick="makeMove(<%= row %>, <%= col %>)"><%=map[row][col] %></td>
		<% } %>
	</tr>
<%}%>
    <tr>
    	<td bgcolor=#FFFF66> </td>
    	<% for (int row = 0; row < BOARDSIZE; row++) { %>
    		<td bgcolor=#FFFF66><%=(char)(chr+row) %></td>
    	<% } %>	
    </tr>
</table>
</form>

<form>
	<!-- 채팅창 -->
	<input id="textMessage" type="text">
	<input onclick="sendMessage()" value="전송" type="button">
	<input onclick="disconnect()" value="종료" type="button">
	<br />
	<textarea id="messageTextArea" rows="10" cols="50"></textarea>
</form>

<!-- 채팅창 웹소켓 -->
<script>
	var chatWebSocket = new WebSocket("ws://localhost:8080/omok/websocket");
	var messageTextArea = document.getElementById("messageTextArea");
	// chatWebSocket 서버와 접속이 되면 호출되는 함수
	chatWebSocket.onopen = function(message) {
		messageTextArea.value += "Server connect...\n";
	};
	// chatWebSocket 서버와 접속이 끊기면 호출되는 함수
	chatWebSocket.onclose = function(message) {
		messageTextArea.value += "Server Disconnect...\n";
	};
	// chatWebSocket 서버와 통신 중에 에러가 발생하면 요청되는 함수
	chatWebSocket.onerror = function(message) {
		messageTextArea.value += "error...\n";
	};
	// chatWebSocket 서버로 부터 메시지가 오면 호출되는 함수
	chatWebSocket.onmessage = function(message) {
		messageTextArea.value += "Recieve From Server => " + message.data + "\n";
	};
	// Send 버튼을 누르면 호출되는 함수
	function sendMessage() {
		var message = document.getElementById("textMessage");
		messageTextArea.value += "Send to Server => " + message.value + "\n";
		chatWebSocket.send(message.value);
		message.value = "";
	}
	// Disconnect 버튼을 누르면 호출되는 함수
	function disconnect() {
		chatWebSocket.close();
	}
</script>

<!-- 오목 웹소켓 -->
<script>
const BOARDSIZE = <%= BOARDSIZE %>;
let currentStone = "O";
let board = Array.from({ length: BOARDSIZE }, () => Array(BOARDSIZE).fill('·')); // 2D 배열로 초기화

// WebSocket 연결
var omokWebSocket = new WebSocket("ws://localhost:8080/omok/omok");

// WebSocket 서버와 접속이 되면 호출되는 함수
omokWebSocket.onopen = function(message) {
	alert("게임을 시작하겠습니다.")
	alert("'O'와 'X'가 번갈아 진행되고, 'O'먼저 시작합니다.");
};

// WebSocket 서버와 접속이 끊기면 호출되는 함수
omokWebSocket.onclose = function(message) {
	alert('서버와의 연결이 끊어졌습니다.');
};

// WebSocket 서버와 통신 중에 에러가 발생하면 요청되는 함수
omokWebSocket.onerror = function(message) {
	alert('에러가 발생하였습니다.');
};


//돌을 놓는 함수
function placeStone(row, col, player) {
    if (player !== currentStone) {
        alert("다음 차례에 돌을 두십시오.");
        return;
    }
    // 돌 놓기
    board[row][col] = player;
 	// 차례 변경
    currentStone = player === 'O' ? 'X' : 'O';
}

//게임에서 돌을 놓을 때
function makeMove(row, col) {
    var boardCells = document.getElementsByTagName("td");
    var cell = boardCells[row * (BOARDSIZE + 1) + col + 1]; // 클릭한 셀로 row, col 도출
    if (cell.innerHTML === "·") {
        cell.innerHTML = currentStone;
        placeStone(row, col, currentStone);
        // 서버로 돌 위치 전송
        omokWebSocket.send(row + " " + col);
    }
}

// WebSocket 서버로부터 메시지가 오면 보드 상태 업데이트
omokWebSocket.onmessage = function(message) {
    const data = JSON.parse(message.data);
    if (data.type === "update") {
        updateBoard(data.board);
        currentStone = data.turn; // 서버에서 받은 현재 턴
    } else if (data.type === "win") {
        alert(data.winner + "가 승리했습니다!");
        resetBoard();
    }
};

// 보드 상태를 업데이트
function updateBoard(boardState) {
    for (let i = 0; i < BOARDSIZE; i++) {
        for (let j = 0; j < BOARDSIZE; j++) {
            let cell = document.getElementById(i + "_" + j);
            cell.innerHTML = boardState[i][j];
        }
    }
}

// 오목 조건 확인 메서드
function checkWin() {
    const arr = Array.from({ length: BOARDSIZE }, () => Array(BOARDSIZE).fill(0));

    for (let i = 0; i < BOARDSIZE; i++) {
        for (let j = 0; j < BOARDSIZE; j++) {
            if (board[i][j] === currentStone) {
                arr[i][j] = 1;
            }
        }
    }

    // 종료 조건 확인
    for (let i = 0; i < BOARDSIZE; i++) {
        for (let j = 0; j < BOARDSIZE; j++) {
            // 세로, 가로, 대각선 조건
            if (
                (i + 4 < BOARDSIZE && arr[i][j] + arr[i + 1][j] + arr[i + 2][j] + arr[i + 3][j] + arr[i + 4][j] >= 5) ||
                (j + 4 < BOARDSIZE && arr[i][j] + arr[i][j + 1] + arr[i][j + 2] + arr[i][j + 3] + arr[i][j + 4] >= 5) ||
                (i + 4 < BOARDSIZE && j + 4 < BOARDSIZE && arr[i][j] + arr[i + 1][j + 1] + arr[i + 2][j + 2] + arr[i + 3][j + 3] + arr[i + 4][j + 4] >= 5) ||
                (i >= 4 && j + 4 < BOARDSIZE && arr[i][j] + arr[i - 1][j + 1] + arr[i - 2][j + 2] + arr[i - 3][j + 3] + arr[i - 4][j + 4] >= 5)
            ) {
                return true;
            }
        }
    }
    return false;
}

// 보드 초기화
function resetBoard() {
    for (let i = 0; i < BOARDSIZE; i++) {
        for (let j = 0; j < BOARDSIZE; j++) {
            let cell = document.getElementById(i + "_" + j);
            cell.innerHTML = "·";
        }
    }
    board = Array.from({ length: BOARDSIZE }, () => Array(BOARDSIZE).fill('·')); // 보드 초기화
}

//WebSocket 서버로부터 메시지가 오면 보드 상태 업데이트
omokWebSocket.onmessage = function(message) {
    const data = JSON.parse(message.data);
    if (data.type === "update") {
        updateBoard(data.board);
    } else if (data.type === "win") {
        alert(data.winner + "가 승리했습니다!");
        resetBoard();
    }
};
</script>
</body>
</html>