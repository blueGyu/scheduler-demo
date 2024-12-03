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
<%-- 시간 관련 라이브러리 --%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.format.DateTimeParseException"%>

<%
    if (session == null ||
        session.getAttribute("memberId") == null ||
        session.getAttribute("memberName") == null
    ) {
        response.sendRedirect("/src/signin/signinPage.jsp");
    }

    if (request.getParameter("date") == null || "".equals(request.getParameter("date"))) {
        response.sendRedirect("/src/scheduler/schedulerPage.jsp?date=" + LocalDate.now());
    }

    Connection connect = null;
    ResultSet result = null;
    String date_str = null;

    LocalDate date_localDate = null;
    int year = 0;
    int month = 0;

    try {
        date_str = request.getParameter("date") == null || "".equals(request.getParameter("date")) ? LocalDate.now().toString() : request.getParameter("date");
        int isShowAll = "Y".equals(request.getParameter("showAll")) && "1".equals((String) session.getAttribute("rankId")) ? 1 : 0;

        Class.forName("org.mariadb.jdbc.Driver");

        // String에서 LocalDate로 타입변환
        date_localDate = LocalDate.parse(date_str, DateTimeFormatter.ofPattern("yyyy-MM-dd"));

        // 년월 구하기
        year = date_localDate.getYear();
        month = date_localDate.getMonth().getValue();
        int day = date_localDate.getDayOfMonth();

        // date_localDate가 속한 월의 시작 날짜 구하기
        LocalDate startDateOfThisMonth = date_localDate.withDayOfMonth(1);
        
        // 시작 주의 일요일 구하기
        int startDayOfWeek = startDateOfThisMonth.getDayOfWeek().getValue() == 7 ? 0 : startDateOfThisMonth.getDayOfWeek().getValue();
        LocalDate sundayOfWeek = startDateOfThisMonth.minusDays(startDayOfWeek);

        // date_localDate가 속한 월의 끝 날짜 구하기
        LocalDate endDateOfThisMonth = date_localDate.withDayOfMonth(date_localDate.lengthOfMonth());
        
        // 마지막 주의 토요일 구하기
        int endDayOfWeek = endDateOfThisMonth.getDayOfWeek().getValue() == 7 ? 6 : 6 - endDateOfThisMonth.getDayOfWeek().getValue();
        LocalDate saterdayOfWeek = endDateOfThisMonth.plusDays(endDayOfWeek);
        
        connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/scheduler", "bluegyu", "1234");

        String sql = "WITH RECURSIVE calendar AS ( "
                    + "SELECT ? AS calendar_date "
                    + "UNION ALL "
                    + "SELECT calendar_date + INTERVAL 1 DAY AS calendar_date "
                    + "FROM calendar WHERE calendar_date < ? "
                    + ")"
                    + "SELECT calendar_date, COALESCE(s.tot_schedule, 0) AS tot_schedule FROM calendar "
                    + "LEFT JOIN (SELECT DATE_FORMAT(s.start_at, '%Y-%m-%d') AS calendar_date, COUNT(*) AS tot_schedule "
                    + "FROM schedule_tb AS s "
                    + "JOIN member_tb AS m USING (member_id) "
                    + "WHERE s.start_at BETWEEN ? AND ? "
                    + "AND s.is_deleted=0 "
                    + "AND IF (1=?, m.dept_id=?, member_id=?) "
                    + "GROUP BY DATE_FORMAT(s.start_at, '%Y-%m-%d')) AS s USING (calendar_date);";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, sundayOfWeek.toString());
        query.setString(2, saterdayOfWeek.toString());
        query.setString(3, startDateOfThisMonth.toString());
        query.setString(4, endDateOfThisMonth.plusDays(1).toString());
        query.setInt(5, isShowAll);
        query.setString(6, (String) session.getAttribute("deptId"));
        query.setString(7, (String) session.getAttribute("memberId"));

        result = query.executeQuery();

    } catch (SQLException err) {
        out.println("<script>console.log('" + err + "'); </script>");

    } catch (DateTimeParseException err) {
        response.sendRedirect("/src/scheduler/schedulerPage.jsp?date=" + LocalDate.now());

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
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" type="text/css" href="/css/reset.css">
        <link rel="stylesheet" type="text/css" href="/css/global.css">
        <link rel="stylesheet" type="text/css" href="/css/scheduler.css">

        <title>스케줄러</title>
    </head>
    <body>
        <jsp:include page="/src/common/header.jsp" />
        <div id="scheduler-wrap">
            <div id="btn-wrap">
                <% if (session.getAttribute("rankId") != null && "1".equals(session.getAttribute("rankId"))) { %>
                    <% if ("Y".equals(request.getParameter("showAll"))) { %>
                        <p>팀원 일정 포함</p>
                        <a id="include-crew-button" class="on" href="/src/scheduler/schedulerPage.jsp?date=<%=date_str%>&showAll=N">
                            <div id="circle"></div>
                        </a>
                    <% } else { %>
                        <p>팀원 일정 불포함</p>
                        <a id="include-crew-button" class="off" href="/src/scheduler/schedulerPage.jsp?date=<%=date_str%>&showAll=Y">
                            <div id="circle"></div>
                        </a>
                    <% } %>
                <% } %>
            </div>
            <div id="move-year-wrap">
                <a
                    id="last-year"
                    href="/src/scheduler/schedulerPage.jsp?date=<%=date_localDate.minusYears(1)%>&showAll=<%=request.getParameter("showAll")%>"
                ></a>
                <p><%=year%></p>
                <a
                    id="next-year"
                    href="/src/scheduler/schedulerPage.jsp?date=<%=date_localDate.plusYears(1)%>&showAll=<%=request.getParameter("showAll")%>"
                ></a>
            </div>
            <div id="select-month-wrap"></div>
            <div id="calendar-wrap">
                <div class="cell head">일</div>
                <div class="cell head">월</div>
                <div class="cell head">화</div>
                <div class="cell head">수</div>
                <div class="cell head">목</div>
                <div class="cell head">금</div>
                <div class="cell head">토</div>
                <% while(result.next()) { %>
                    <% if (String.format("%02d", month).equals(result.getString("calendar_date").split("-")[1])) { %>
                        <a
                            class="cell active"
                            href="/src/todoList/todoListPage.jsp?date=<%=result.getString("calendar_date")%>&showAll=<%=request.getParameter("showAll")%>"
                            data-date="<%=result.getString("calendar_date")%>"
                        >
                            <p class="cell-day"><%=result.getString("calendar_date").split("-")[2]%></p>
                             <% if (!"0".equals(result.getString("tot_schedule"))) { %>
                                <p class="cell-tot">
                                    <%=result.getString("tot_schedule")%>
                                </p>
                            <% } %>
                        </a>
                    <% } else { %>
                        <a 
                            class="cell not-active"
                            href="/src/todoList/todoListPage.jsp?date=<%=result.getString("calendar_date")%>&showAll=<%=request.getParameter("showAll")%>"
                            data-date="<%=result.getString("calendar_date")%>"
                        >
                            <p class="cell-day"><%=result.getString("calendar_date").split("-")[2]%></p>
                            <% if (!"0".equals(result.getString("tot_schedule"))) { %>
                                <p class="cell-tot">
                                    <%=result.getString("tot_schedule")%>
                                </p>
                            <% } %>
                        </a>  
                    <% } %>
                <% } %>
            </div>
        </div>
        <script type="module" src="/js/scheduler.js"></script>
    </body>
</html>
