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
<%-- 데이터베이스로부터 값 받아오기 라이브러리 --%>
<%@ page import="java.sql.ResultSet" %>
<%-- 데이터베이스 오류 예외처리 라이브러리 --%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.SQLIntegrityConstraintViolationException"%>
<%-- 단방향 암호화 bcrypt 라이브러리 --%>
<%@ page import="org.mindrot.jbcrypt.BCrypt"%>

<%

    Connection connect = null;
    int result = 0;

    try {

        request.setCharacterEncoding("utf-8");

        String dept = request.getParameter("department");
        String rank = request.getParameter("rank"); 
        String id = request.getParameter("id");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");

        if (dept == null || dept.equals("0")) {
            throw new Exception("부서를 선택해주세요.");
        }

        if (rank == null || rank.equals("0")) {
            throw new Exception("직급을 선택해주세요.");
        }

        if (id == null || id.equals("") || id.length() > 20) {
            throw new Exception("아이디를 확인해주세요.");
        }

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

        String sql = "INSERT INTO member_tb(dept_id, rank_id, id, password, email, name, phone) VALUES (?,?,?,?,?,?,?);";
        PreparedStatement query = connect.prepareStatement(sql);
        query.setString(1, dept);
        query.setString(2, rank);
        query.setString(3, id);
        query.setString(4, password);
        query.setString(5, email);
        query.setString(6, name);
        query.setString(7, phone);

        result = query.executeUpdate();

        // 로그인 페이지로 이동
        if (result == 1) {
            out.println("<script>alert('회원가입이 완료되었습니다.'); location.href='/src/signin/signinPage.jsp'</script>");
        } else {
            out.println("<script>alert('회원가입에 실패했습니다.'); location.href='/src/signin/signinPage.jsp'</script>");
        }

    } catch (SQLIntegrityConstraintViolationException err) {
        // 중복값이 아이디, 이메일 여부에 따라 다른 안내 메시지 표시
        if (err.getErrorCode() == 1062) {
            if (err.getMessage().contains("id")) {
                out.println("<script>alert('이미 회원가입된 아이디입니다.'); location.href='/src/signin/signinPage.jsp'</script>");
            } else if (err.getMessage().contains("email")){
                out.println("<script>alert('이미 회원가입된 이메일입니다.'); location.href='/src/signin/signinPage.jsp'; </script>");
            }
        } else {
            out.println("<script>console.log(" + err.getMessage() + ");</script>");
        }

    } catch (SQLException err) {
        out.println("<script>console.log(" + err.getMessage() + ");</script>");

    } catch (Exception err) {
        out.println("<script>console.log('Exception: " + err + "'); </script>");

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
