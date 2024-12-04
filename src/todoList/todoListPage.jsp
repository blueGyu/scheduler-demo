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
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="java.time.format.DateTimeFormatter"%>

<%
    if (session == null ||
        session.getAttribute("memberId") == null ||
        session.getAttribute("memberName") == null
    ) {
        response.sendRedirect("/src/signin/signinPage.jsp");
    }

    if (request.getParameter("date") == null || "".equals(request.getParameter("date"))) {
        response.sendRedirect("/src/todoList/todoListPage.jsp?date=" + LocalDate.now());
    }

    Connection connect = null;
    ResultSet result = null;
    String date = null;
    String showAll = null;

    try {
        date = request.getParameter("date") != null ? request.getParameter("date") : LocalDate.now().toString();
        showAll = request.getParameter("showAll");
        int isShowAll = "Y".equals(showAll) && "1".equals((String) session.getAttribute("rankId")) ? 1 : 0;

        Class.forName("org.mariadb.jdbc.Driver");

        connect = DriverManager.getConnection("jdbc:mariadb://localhost:3306/scheduler", "bluegyu", "1234");

        String sql = "SELECT member_id, s.schedule_id, s.content, s.start_at, m.name "
                    + "FROM schedule_tb AS s "
                    + "JOIN member_tb AS m USING (member_id) "
                    + "WHERE DATE_FORMAT(s.start_at, '%Y-%m-%d')=? "
                    + "AND s.is_deleted=0 "
                    + "AND IF (1=?, m.dept_id=?, member_id=?) "
                    + "ORDER BY s.start_at asc;";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, date);
        query.setInt(2, isShowAll);
        query.setString(3, (String) session.getAttribute("deptId"));
        query.setString(4, (String) session.getAttribute("memberId"));

        result = query.executeQuery();

    } catch (SQLException err) {
        out.println("<script>console.log('" + err + "'); </script>");

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
        <link rel="stylesheet" type="text/css" href="/css/todoList.css">
        <title>일정관리</title>
    </head>
    <body>
        <jsp:include page="/src/common/header.jsp" />
        <div id="todo-list-wrap">
            <main>
                <div id="btn-wrap">
                    <div id="arrow-btn-wrap">
                        <a href="/src/scheduler/schedulerPage.jsp?date=<%=date%>&showAll=<%=showAll%>"><div id="arrow-btn"></div></a>
                    </div>
                    <% if (session.getAttribute("rankId") != null && "1".equals((String) session.getAttribute("rankId"))) { %>
                        <% if ("Y".equals(showAll)) { %>
                            <p>팀원 일정 포함</p>
                            <a id="include-crew-button" class="on" href="/src/todoList/todoListPage.jsp?date=<%=date%>&showAll=N">
                                <div id="circle"></div>
                            </a>
                        <% } else { %>
                            <p>팀원 일정 불포함</p>
                            <a id="include-crew-button" class="off" href="/src/todoList/todoListPage.jsp?date=<%=date%>&showAll=Y">
                                <div id="circle"></div>
                            </a>
                        <% } %>
                    <% } %>
                </div>
                <%-- 일정 --%>
                <div id="schedule-list-wrap">
                    <p id="year"><%=date.split("-")[0]%></p>
                    <p id="date"><%=date.split("-")[1]%>월 <%=date.split("-")[2]%>일</p>
                    <ul id="schedule-list">    
                        <% if (result != null && result.isBeforeFirst()) { %>
                            <% while(result.next()) { %>
                                <li class="schedule" data-id="<%=result.getString("schedule_id")%>">
                                    <div>
                                        <p><%=(new SimpleDateFormat("HH:mm")).format(result.getTimestamp("start_at"))%></p>
                                        <p><%=result.getString("content")%></p>
                                    </div>
                                    <% if (result.getString("member_id").equals((String) session.getAttribute("memberId"))) {%>
                                        <div>
                                            <button
                                                class="edit"
                                                data-id="<%=result.getString("schedule_id")%>"
                                                data-start="<%=result.getString("start_at")%>"
                                                data-content="<%=result.getString("content")%>"
                                                data-showall="<%=showAll%>"
                                            >수정</button>
                                            <a href="/src/todoList/todoListDeleteAction.jsp?date=<%=date%>&id=<%=result.getString("schedule_id")%>">삭제</a>
                                        </div>
                                    <% } else {%>
                                        <p><%=result.getString("name")%></p>
                                    <% }%>
                                </li>
                            <% } %>
                        <% } else { %>
                            <li>일정이 없습니다.</li>
                        <% } %>
                    </ul>
                </div>
                <%-- 일정 추가 --%>
                <form id="add-form" method="get" action="todoListAddAction.jsp">
                    <div class="time-seletor">
                        <div class="select-box-wrap">
                            <div id="add-select-hour" class="select-box">
                                <p>00</p>
                                <ul class="dropdown-menu hidden"></ul>
                                <div id="hour-arrow" class="arrow">⏏︎</div>
                            </div>
                            :
                            <div id="add-select-minute" class="select-box">
                                <p>00</p>
                                <ul class="dropdown-menu hidden"></ul>
                                <div id="minute-arrow" class="arrow">⏏︎</div>
                            </div>
                        </div>
                        <button type="submit" class="primary">추가</button>
                    </div>
                    <textarea name="content" placeholder="일정을 입력해주세요."></textarea>
                    <input name="date" type="text" class="hidden" value="<%=date%>"/>
                    <input name="showAll" type="text" class="hidden" value="<%=showAll%>"/>
                    <input id="hour" class="hidden" name="hour" type="text" value="00"/>
                    <input id="minute" class="hidden" name="minute" type="text" value="00" />
                </form>
            </main>
        </div>
        <script type="module" src="/js/todoList.js"></script>
    </body>
</html>
