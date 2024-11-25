<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" type="text/css" href="/css/reset.css">
        <link rel="stylesheet" type="text/css" href="/css/global.css">
        <link rel="stylesheet" type="text/css" href="/css/signin.css">
        <title>스케줄러 - 로그인</title>
    </head>
    <body>
        <div id="signin-wrap">
            <h1>stageus</h1>
            <div id="form-wrap">
                <h2>로그인</h2>
                <form method="post" action="">
                    <input id="id" name="id" type="text" placeholder="아이디"/>
                    <input id="password" name="password" type="password" placeholder="비밀번호"/>
                    <button class="primary" type="submit">로그인</button>
                </form> 
                <div id="option">
                    <a href="/src/findId/findIdPage.jsp">아이디 찾기</a>
                    <a href="">비밀번호 찾기</a>
                    <a href="/src/signup/signupPage.jsp">회원가입</a>
                </div>   
            </div>
        </div>
        <script type="module" src="/js/signin.js"></script>
    </body>
</html>
