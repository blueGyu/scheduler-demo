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
    if (session == null ||
        session.getAttribute("memberId") == null ||
        session.getAttribute("memberName") == null
    ) {
        response.sendRedirect("/src/signin/signinPage.jsp");
    }

    Connection connect = null;
    int result = 0;

    try {

        request.setCharacterEncoding("utf-8");

        String id = request.getParameter("schedule_id");
        String showAll = "Y".equals(request.getParameter("showAll")) || request.getParameter("showAll") != null ? "Y" : "N";
        String date = request.getParameter("date");
        String hour = request.getParameter("hour"); 
        String minute = request.getParameter("minute");
        String content = request.getParameter("content");

        if (id == null || id.equals("")) {
            throw new Exception("일정번호를 선택해주세요.");
        }

        if (date == null || date.equals("")) {
            throw new Exception("날짜를 선택해주세요.");
        }

        if (hour == null || hour.equals("")) {
            throw new Exception("시간을 선택해주세요.");
        }

        if (minute == null || minute.equals("")) {
            throw new Exception("분을 확인해주세요.");
        }

        if (content == null || content.equals("")) {
            throw new Exception("일정을 확인해주세요.");
        }

        String startAt = date + " " + hour + ":" + minute + ":" + "00";

        Class.forName("org.mariadb.jdbc.Driver");

        connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/scheduler", "bluegyu", "1234");

        String sql = "UPDATE schedule_tb SET start_at=?, content=? WHERE schedule_id=? AND member_id=?;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, startAt);
        query.setString(2, content);
        query.setString(3, id);
        query.setString(4, (String) session.getAttribute("memberId"));

        result = query.executeUpdate();

        // 로그인 페이지로 이동
        if (result == 1) {
            out.println("<script>alert('일정이 수정되었습니다.'); location.href='/src/todoList/todoListPage.jsp?date=" + date + "&showAll=" + showAll + "'</script>");
        } else {
            out.println("<script>alert('일정 수정에 실패했습니다.'); location.href='/src/todoList/todoListPage.jsp?date=" + date + "&showAll=" + showAll + "'</script>");
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
