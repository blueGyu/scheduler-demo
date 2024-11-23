<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  // 세션이 없는 경우 로그인 페이지 이동, 있는 경우 스케줄러 페이지 이동
  response.sendRedirect("/src/signin/signinPage.jsp");
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>스케줄러</title>
  </head>
  <body></body>
</html>
