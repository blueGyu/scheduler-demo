<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/css/header.css">
<header>
    <h1>stageus</h1>
    <div id="account">
        <p><strong><%=(String) session.getAttribute("memberName")%></strong>님</p>
        <% if (session.getAttribute("memberId") != null) { %>
            <a id="signout" href="/src/signout/signoutAction.jsp">로그아웃</a>
        <% } %>
    </div>
</header>