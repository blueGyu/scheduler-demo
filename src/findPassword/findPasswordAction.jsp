<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- 정규식 일치 확인 라이브러리 --%>
<%@ page import="java.util.regex.Pattern" %>
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
    ResultSet result = null;

    try {

        request.setCharacterEncoding("utf-8");

        String id = request.getParameter("id");
        String email = request.getParameter("email");
        String name = request.getParameter("name"); 
        String phone = request.getParameter("phone");

        if (id == null ||
            id.equals("") ||
            id.length() > 20 ||
            !Pattern.compile("^[ㄱ-힣a-zA-Z0-9]+$").matcher(id).find()
        ) {
            throw new Exception("아이디를 확인해주세요.");
        }

        if (email == null ||
            email.equals("") ||
            email.length() > 100 ||
            !Pattern.compile("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$").matcher(email).find()
        ) {
            throw new Exception("이메일을 확인해주세요.");
        }

        if (name == null ||
            name.equals("") ||
            name.length() > 10 ||
            !Pattern.compile("^[a-zA-Z0-9ㄱ-힣]+$").matcher(name).find()
        ) {
            throw new Exception("이름을 확인해주세요.");
        }

        if (phone == null ||
            phone.equals("") ||
            phone.length() > 11 ||
            !Pattern.compile("^(010|011|017)\\d{4}\\d{4}$").matcher(phone).find()
        ) {
            throw new Exception("전화번호를 확인해주세요.");
        }

        Class.forName("org.mariadb.jdbc.Driver");

        connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/scheduler", "bluegyu", "1234");

        String sql = "SELECT member_id FROM member_tb WHERE id=? AND email=? AND name=? AND phone=? LIMIT 1;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, id);
        query.setString(2, email);
        query.setString(3, name);
        query.setString(4, phone);

        result = query.executeQuery();

        if (!result.next()) {
            out.println("<script>alert('가입된 이력이 없습니다.'); location.href='/src/signin/signinPage.jsp'</script>");
        } else {
            // 세션 생성 - 회원번호
            session.setAttribute("changePasswordMemberId", result.getString("member_id"));
            out.println("<script>alert('회원정보가 확인되었습니다.'); location.href='/src/changePassword/changePasswordPage.jsp'</script>");
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
