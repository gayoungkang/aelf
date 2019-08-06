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
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, width=1920-width">
<link rel="shortcut icon" type="image/x-icon" href="fabicon.ico" />

 <meta property="og:title" content="AELF">
 <meta property="og:image" content="img/og_thumbnail.jpg">
 <meta property="og:url" content="http://www.aelfkorea.io">
<meta name="description" content="AELF">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->

</head>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>

	
    <div class="success-wrap">
        <div class="success">
            <table cellpadding="0" cellspacing="0" class="success-tb">
                <tr>
                    <td><img src="img/aelf-seccess-logo.png" alt="" /></td>
                </tr>
                <tr height="23"></tr>
                <tr>
                    <td style="font-size:16px; font-weight: 500;">가입이 완료되었습니다.<br><span style="font-weight: 300;">엘프의 소식을 받아보시고 포럼 참여를 통해 궁금증을 해소하세요!</span></td>
                </tr>
                <tr height="28"></tr>
                <tr>
                    <td><button onclick="javascript:goLogin()">로그인 후 시작하기</button></td>
                </tr>
            </table>
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>
    
    
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