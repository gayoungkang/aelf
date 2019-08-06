<%@page import="dao.AelfDAO"%>
<%@page import="model.AlarmInfoModel"%>
<%@page import="model.UserInfoModel"%>
<%@page import="util.CryptoSlate"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="util.DateConvert"%>
<%@page import="model.NewsInfoModel"%>
<%@page import="model.ContentInfoModel"%>
<%@page import="model.NoticeInfoModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
UserInfoModel userInfo = (UserInfoModel) session.getAttribute("userInfo");	// 로그인 사용자 정보

List<AlarmInfoModel> listAlarm = null;

//// 로그인 상태면 알람 목록 불러오기
if(userInfo != null) {
	AelfDAO aDao = new AelfDAO();
	listAlarm = aDao.selectListAlarmInfo(userInfo.getUiNo());
}
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

function topBtn(){
   $("html, body").stop().animate({scrollTop:0}, 500, 'swing', function(){});
}

$(window).scroll(function(event){
	var scroll = $(window).scrollTop();
	if(scroll >= 100) {
		document.getElementById('up_btn').style.display = '';
   } else {
		document.getElementById('up_btn').style.display = 'none';
   }
});


<%if(userInfo != null) {	/// 로그인 상태    %>		
	function goAlarmLink(aiNo, boardNo, boardType) {
		
		var uiNo = <%=userInfo.getUiNo() %>;
		
		var param = "mode=alarm_read&ai_no="+aiNo+"&ui_no="+uiNo;
		$.ajax({
			type: "POST",
			url: 'main.lf',
			data: param,
			error: ajaxFailed,
			success: function(ret) {
				if(boardType=='notice_info') {
					location.href = 'notice.lf?menu=notice&mode=view&ni_no='+boardNo;
				}
				else if(boardType=='news_info') {
					location.href = 'news.lf?menu=news&mode=view&news_no='+boardNo;
				}
				else if(boardType=='debate_info') {
					location.href = 'debate.lf?menu=debate&mode=view&di_no='+boardNo;
				}
				else if(boardType=='petition_info') {
					location.href = 'petition.lf?menu=petition&mode=view&pi_no='+boardNo;
				}
			}
		});
	}
<%} %>

</script>

</head>
<body>

	<jsp:include page="./m_top.jsp"></jsp:include>
	
	<div class="page-up" id="up_btn" style="display: none;">
        <img src="m-img/page-up.png" alt="" onclick="javascript:topBtn()" />
    </div>
    
    <div class="notice-wrap sns-wrap" style="padding-bottom: 0;">
        
        <div class="alarm-wrap">
            <div class="alarm">
            <%if(listAlarm != null) { %>
                <ul>
            	<%
            	for(int i=0; i<listAlarm.size(); i++) {
					AlarmInfoModel alarm = listAlarm.get(i);
	        		
	        		String profile = "m-img/johnDoe-profile.png";
	        		if(alarm.getFromUiNo()==-1)
	        			profile = "m-img/aelf-profile.png";
	        		else {
	        			profile = "upload/profile/"+alarm.getFromUiProfile();
	        		}
            	%>
                    <li onclick="javascript:goAlarmLink(<%=alarm.getAiNo() %>, <%=alarm.getBoardNo() %>, '<%=alarm.getBoardType() %>')">
                        <img src="<%=profile %>" alt="" style="border-radius: 50%;" alt="" width="40px" height="40px" />
                        <p><%=alarm.getAiContent() %></p>
                        <span class="time"><%=alarm.getAiDate() %></span>
                    </li>
				<%} %>
                </ul>
			<%} else { %>
				<br/>
				<p align="center">알람이 없습니다.</p>
				<br/>
			<%} %>
            </div>
        </div>
        
    </div>
    
    <jsp:include page="./m_footer.jsp"></jsp:include>
    
</body>
</html>