<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>오목 게임</title>
</head>
<style>
.container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin: 0;
    padding: 10px 20px;
    font-size : 50;
    font-family: Arial, sans-serif;
}
a:link, a:visited, a:hover, a:active {
    color: black;
    text-decoration: none;
}
</style>
<body>
    <header>
        <div class="container">
            <h1 class="logo">
            	<c:choose>
                    <c:when test="${sessionScope.isLogon == true}">
                        <a href="main2.jsp">오목 게임</a>
                    </c:when>
                    <c:otherwise>
                        <a href="main1.jsp">오목 게임</a>
                    </c:otherwise>
                </c:choose>
            </h1>
        </div>
    </header>
</body>
</html>
