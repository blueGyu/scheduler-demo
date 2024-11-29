<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 데이터베이스 탐색 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>
<%-- 데이터베이스 연결 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- SQL 준비 및 전송 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %>
<%-- 데이터베이스로부터 값 받아오기 라이브러리 --%>
<%@ page import="java.sql.ResultSet" %>
<%-- 데이터베이스 오류 예외처리 라이브러리 --%>
<%@ page import="java.sql.SQLException"%>
<%

    Connection connect = null;
    ResultSet deptResult = null;
    ResultSet rankResult = null;

    try {
        Class.forName("org.mariadb.jdbc.Driver");

        connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/scheduler", "bluegyu", "1234");

        // 부서정보 가져오기
        String deptSql = "SELECT dept_id, name FROM dept_tb";
        PreparedStatement deptQuery = connect.prepareStatement(deptSql);

        deptResult = deptQuery.executeQuery();

        // 직급정보 가져오기
        String rankSql = "SELECT rank_id, name FROM rank_tb";
        PreparedStatement rankQuery = connect.prepareStatement(rankSql);

        rankResult = rankQuery.executeQuery();

    } catch (SQLException err) {
        out.println("<script>console.log('" + err + "'); </script>");

    } catch (Exception err) {
        out.println("<script>console.log('" + err + "'); </script>");

    } finally {
        try {
            if (deptResult != null) connect.close();
            if (rankResult != null) connect.close();
            if (connect != null && !connect.isClosed()) {
                connect.close();
            }
        } catch (SQLException err) {
             out.println("<script>console.log('" + err + "'); </script>");
        }
    }

%>
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
                <form method="post" action="./signupAction.jsp">
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
                            <li class="selected" data-department="0">부서를 선택해주세요.</li>
                            <% while(deptResult.next()) { %>
                                <li data-department="<%=deptResult.getString("dept_id")%>">
                                    <%=deptResult.getString("name")%>
                                </li>
                            <% } %>
                        </ul>
                        <div id="department-arrow" class="arrow">⏏︎</div>
                        <input id="department" class="hidden" name="department" value="0"/>
                    </div>
                    <div id="select-rank" class="select-box">
                        <p>직급을 선택해주세요.</p>
                        <ul id="rank-dropdown" class="dropdown-menu hidden">
                            <li class="selected" data-rank="0">직급을 선택해주세요.</li>
                            <% while(rankResult.next()) { %>
                                <li data-rank="<%=rankResult.getString("rank_id")%>">
                                    <%=rankResult.getString("name")%>
                                </li>
                            <% } %>
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
