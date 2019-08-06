<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
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
                    <td style="font-size:16px; font-weight: 500;">토론 신청이 완료되었습니다.<br><span style="font-weight: 300;">관리자가 승인하면 신청사항이 게시됩니다!</span></td>
                </tr>
                <tr height="28"></tr>
                <tr>
                    <td><button onclick="javascript:location.href='debate.lf?menu=debate&mode=list'">확인</button></td>
                </tr>
            </table>
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>
    

</body>
</html>