<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session.getAttribute("changePasswordMemberId") == null) {
        response.sendRedirect("/src/signin/signinPage.jsp");
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" type="text/css" href="/css/reset.css">
        <link rel="stylesheet" type="text/css" href="/css/global.css">
        <link rel="stylesheet" type="text/css" href="/css/changePassword.css">
        <title>스케줄러 - 비밀번호 변경</title>
    </head>
    <body>
        <div id="change-password-wrap">
            <h1>stageus</h1>
            <div id="form-wrap">
                <h2>비밀번호 변경</h2>
                <form method="post" action="changePasswordAction.jsp">
                    <input id="password" name="password" type="password" placeholder="비밀번호" />
                    <ul>
                        <li>
                            <span id="length-condition" class="err"><b>✕</b>최소길이 8자이상 최대길이 32자이하</span>
                        </li>
                        <li>
                            <span id="capital-condition" class="err"><b>✕</b>영대문자 1자이상 포함</span>
                        </li>
                        <li>
                            <span id="special-condition" class="err"><b>✕</b>특수문자 2자이상 포함</span>
                        </li>
                    </ul>
                    <input id="confirm" name="confirm" type="password" placeholder="비밀번호 확인" />
                    <button class="primary">비밀번호 변경</button>
                </form>
            </div>
        </div>
        <script type="module" src="/js/changePassword.js"></script>
    </body>
</html>
