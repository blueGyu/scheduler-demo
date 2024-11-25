<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" type="text/css" href="/css/reset.css">
        <link rel="stylesheet" type="text/css" href="/css/global.css">
        <link rel="stylesheet" type="text/css" href="/css/findId.css">
        <title>스케줄러 - 아이디 찾기</title>
    </head>
    <body>
        <div id="find-id-wrap">
            <h1>stageus</h1>
            <div id="form-wrap">
                <h2>아이디 찾기</h2>
                <form method="post" action="">
                    <input id="email" name="email" type="text" placeholder="이메일"/>
                    <input id="name" name="name" type="text" placeholder="이름"/>
                    <input id="phone" name="phone" type="tel" placeholder="전화번호"/>
                    <button class="primary" type="submit">아이디 찾기</button>
                </form>
            </div>
        </div>
        <script type="module" src="/js/findId.js"></script>
    </body>
</html>
