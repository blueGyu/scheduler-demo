<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" type="text/css" href="/css/reset.css">
        <link rel="stylesheet" type="text/css" href="/css/global.css">
        <link rel="stylesheet" type="text/css" href="/css/signup.css">
        <title>스케줄러 - 회원가입</title>
    </head>
    <body>
        <div id="signup-wrap">
            <h1>stageus</h1>
            <div id="form-wrap">
                <h2>회원가입</h2>
                <form method="post" action="">
                    <input id="id" name="id" type="text" placeholder="아이디" />
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
                    <input id="email" name="email" type="text" placeholder="이메일" />
                    <div id="select-department" class="select-box">
                        <p>부서를 선택해주세요.</p>
                        <ul id="department-dropdown" class="dropdown-menu hidden">
                            <%-- TODO: 데이터베이스에서 불러와야함 --%>
                            <li class="selected" data-department="0">부서를 선택해주세요.</li>
                            <li id="management" data-department="1">경영팀</li>
                            <li id="design" data-department="2">디자인팀</li>
                        </ul>
                        <div id="department-arrow" class="arrow">⏏︎</div>
                        <input id="department" class="hidden" name="department" value="0"/>
                    </div>
                    <div id="select-rank" class="select-box">
                        <p>직급을 선택해주세요.</p>
                        <ul id="rank-dropdown" class="dropdown-menu hidden">
                            <%-- TODO: 데이터베이스에서 불러와야함 --%>
                            <li class="selected" data-rank="0">직급을 선택해주세요.</li>
                            <li id="leader" data-rank="1">팀장</li>
                            <li id="crew" data-rank="2">팀원</li>
                        </ul>
                        <div id="rank-arrow" class="arrow">⏏︎</div>
                        <input id="rank" class="hidden" name="rank" value="0">
                    </div>
                    <input id="name" name="name" type="text" placeholder="이름" />
                    <input id="phone" name="phone" type="tel" placeholder="전화번호" />
                    <button class="primary">회원가입</button>
                </form> 
            </div>
        </div>
        <script type="module" src="/js/signup.js"></script>
    </body>
</html>
