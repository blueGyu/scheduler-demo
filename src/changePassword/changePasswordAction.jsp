<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 정규식 일치 확인 라이브러리 --%>
<%@ page import="java.util.regex.Pattern" %>
<%-- 데이터베이스 탐색 라이브러리 --%>
<%@ page import="java.sql.DriverManager" %>
<%-- 데이터베이스 연결 라이브러리 --%>
<%@ page import="java.sql.Connection" %>
<%-- SQL 준비 및 전송 라이브러리 --%>
<%@ page import="java.sql.PreparedStatement" %>
<%-- 데이터베이스로부터 인서트 값 받아오기 라이브러리 --%>
<%@ page import="java.sql.Statement" %>
<%-- 데이터베이스 오류 예외처리 라이브러리 --%>
<%@ page import="java.sql.SQLException"%>

<%

    Connection connect = null;
    int result = 0;

    try {

        request.setCharacterEncoding("utf-8");

        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");

        if (password == null ||
        password.equals("") ||
        password.length() < 8 ||
        password.length() > 32 ||
        !Pattern.compile("[A-Z]").matcher(password).find() ||
        !Pattern.compile("^(.*[!@#$%^&*(),.?\":{}|<>]){2,}.*$").matcher(password).find()
        ) {
            throw new Exception("비밀번호를 확인해주세요.");
        }

        if (confirm == null || confirm.equals("") || !confirm.equals(password)) {
            throw new Exception("비밀번호 확인을 확인해주세요.");
        }

        Class.forName("org.mariadb.jdbc.Driver");

        connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/scheduler", "bluegyu", "1234");

        String sql = "UPDATE member_tb SET password=? WHERE member_id=?;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, password);
        query.setString(2, (String) session.getAttribute("changePasswordMemberId"));

        result = query.executeUpdate();

        // 로그인 페이지로 이동
        if (result == 1) {
            session.removeAttribute("changePasswordMemberId");
            out.println("<script>alert('비밀번호 변경이 완료되었습니다.'); location.href='/src/signin/signinPage.jsp'</script>");
        } else {
            out.println("<script>alert('비밀번호 변경에 실패했습니다.'); location.href='/src/signin/signinPage.jsp'</script>");
        }
    } catch (SQLException err) {
        out.println("<script>console.log(" + err + ");</script>");

    } catch (Exception err) {
        out.println("<script>console.log('" + err + "'); </script>");

    } finally {
        try {
            if (result != 0) connect.close();
            if (connect != null && !connect.isClosed()) {
                connect.close();
            }
        } catch (SQLException err) {
             out.println("<script>console.log('" + err + "'); </script>");
        }
    }
%>
