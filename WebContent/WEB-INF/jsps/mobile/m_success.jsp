<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");
String name = request.getParameter("name");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>
<meta name="description" content="AELF">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/jquery-ui.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-m-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->
<link rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/nanummyeongjo.css"><!-- 나눔명조 웹폰트 -->

<script type="text/javascript">


</script>

</head>
<body>

	<jsp:include page="./m_top.jsp"></jsp:include>
    
    <div class="notice-wrap login-clear-wrap">
        <div class="login-clear">
            <img src="m-img/login-clear.png" alt="" />
            <p>가입이 완료 되었습니다.</p>
            <span>엘프의 소식을 받아보시고 커뮤니티 활동을 통해<br>궁금증을 해소하세요!</span>
            <button onclick="javascript:goLogin()">시작하기</button>
        </div>
    </div>
    
    <jsp:include page="./m_footer.jsp"></jsp:include>
    
    
<script type="text/javascript">

function goLogin() {
	var id = '<%=id %>';
	var name = '<%=name %>';
	
	id = encodeURIComponent(id);
	name = encodeURIComponent(name);
	
	location.href = 'login.lf?menu=success_login&id='+id+"&name="+name;
}
</script>
    
</body>
</html>