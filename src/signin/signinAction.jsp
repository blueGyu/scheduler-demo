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
<%-- 단방향 암호화 bcrypt 라이브러리 --%>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>

<%

    Connection connect = null;
    ResultSet result = null;

    try {

        request.setCharacterEncoding("utf-8");

        String id = request.getParameter("id");
        String password = request.getParameter("password"); 

        if (id == null || id.equals("")) {
            throw new Exception("아이디를 확인해주세요.");
        }

        if (password == null || password.equals("")) {
            throw new Exception("비밀번호를 확인해주세요.");
        }

        Class.forName("org.mariadb.jdbc.Driver");

        connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/scheduler", "bluegyu", "1234");

        String sql = "SELECT member_id, name FROM member_tb WHERE id=? AND password=? LIMIT 1;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, id);
        query.setString(2, password);

        result = query.executeQuery();

        // 로그인 페이지로 이동
        if (!result.next()) {
            out.println("<script>alert('가입된 이력이 없습니다.'); location.href='/src/signup/signupPage.jsp'</script>");
        } else {
            // 세션 추가하기;
            session.setAttribute("memberId", result.getString("member_id"));
            session.setAttribute("memberName", result.getString("name"));

            // 메인화면으로 이동
            out.println("<script>alert('로그인에 성공했습니다.'); location.href='/src/scheduler/schedulerPage.jsp'</script>");
        }
    } catch (SQLException err) {
        out.println("<script>console.log(" + err + ");</script>");

    } catch (Exception err) {
        out.println("<script>console.log('" + err + "'); </script>");

    } finally {
        try {
            if (result != null) connect.close();
            if (connect != null && !connect.isClosed()) {
                connect.close();
            }
        } catch (SQLException err) {
             out.println("<script>console.log('" + err + "'); </script>");
        }
    }
%>
