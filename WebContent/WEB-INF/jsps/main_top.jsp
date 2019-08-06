<%@page import="dao.AelfDAO"%>
<%@page import="model.AlarmInfoModel"%>
<%@page import="java.util.List"%>
<%@page import="model.UserInfoModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserInfoModel userInfo = (UserInfoModel) session.getAttribute("userInfo");	// 로그인 사용자 정보
	String menu = request.getParameter("menu");
	
	List<AlarmInfoModel> listAlarm = null;
	
	//// 로그인 상태면 알람 목록 불러오기
	if(userInfo != null) {
		AelfDAO aDao = new AelfDAO();
		listAlarm = aDao.selectListAlarmInfo(userInfo.getUiNo());
	}
%>
		<div class="top-wrap main" <%if("".equals(menu)==false && menu!=null) { %> style="background-color: #001c33;" <%} %> >
        <div class="top">
<!--             <table class="top-top">
                <tr>
                    <td width="83"><a href="https://aelf.io" target="_blank"><img src="img/top-1.png" alt="worldwide" /></a></td>
                    <td></td>
                    <td width="62" class="aelf-logo"><a href="main.lf"><img src="img/aelf-logo.png" alt="aelf-logo" /></a></td>
                    <td></td>
                    <td width="24"><a href="https://t.me/aelfkorean" target="_blank"><img src="img/top-2.png" alt="텔레그램"/></a></td>
                    <td width="10"></td>
                    <td width="23"><a href="http://bit.ly/aelfkoreakakao" target="_blank"><img src="img/top-3.png" alt="카카오톡" /></a></td>
                </tr>
            </table> -->
            <div class="logo"><a href="main.lf"><img src="img/ico_logo.png" alt="aelf" /></a></div>
           
		<%if(userInfo == null) { %>
			<div class="top-log top-out">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td><a href="javascript:void(0)" onclick="javascript:goLogin()">로그인</a></td>
                    </tr>
                </table>
            </div>
		<%}else { %>
			<div class="top-log top-out">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                        	<a href="javascript:void(0)" onclick="javascrit:goLogout()">
                        	<%if("".equals(userInfo.getUiProfile())) { %>
                        		<img src="img/top-log-1.png" alt="" style="margin-right: 14px; border-radius: 50%; width: 30px; height: 30px;" /><%=userInfo.getUiName() %>님
                        	<%} else { %>
                        		<img src="upload/profile/<%=userInfo.getUiProfile() %>" alt="" style="margin-right: 14px; border-radius: 50%; width: 30px; height: 30px; vertical-align: middle;" /><%=userInfo.getUiName() %>님
                        	<%} %>
                        	</a>
                        	&nbsp;
                        	<a href="javascript:void(0)" onclick="javascript:toggleUserSub()"><img src="img/top-log-2.png" alt="" style="vertical-align: middle;" /></a>
                        </td>
                    </tr>
                </table>
            </div>
		<%} %>
<%--            	<%if("".equals(menu)==false && menu!=null) { %>
        	<%if(userName != null) { %>
        	<!-- 로그인 -->
            <div class="top-log">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="92">
                        	<a href="javascript:void(0)" onclick="javascrit:goLogout()"><img src="img/top-log-1.png" alt="" style="margin-right: 14px;" /><%=userName %>님</a>
                        </td>
                        <td width="27"></td>
                        <td><a href="javascript:void(0)" onclick="javascript:toggleUserSub()"><img src="img/top-log-2.png" alt="" /></a></td>
                        <td width="32"></td>
                        <td><a href="#"><img src="img/top-log-3.png" alt="" /></a></td>
                    </tr>
                </table>
            </div>
        	<%} else { %>	 --%>
        	<!-- 비로그인 -->
        	<!-- 
            <div class="top-log top-out">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td><a href="javascript:void(0)" onclick="javascript:goLogin()">로그인</a></td>
                        <td width="20"></td>
                        <%--<td><a href="login.lf?menu=login">login</a></td> --%>
                        <td><a href="login.lf?menu=signup">회원가입</a></td>
                    </tr>
                </table>
            </div>
             -->
<%-- 			<%} %>
			<%} %>   --%>
			<div class="sns_wrap" style="margin-right: 30px;">
            	<a href="https://aelf.io" class="ico_world" target="_blank">wrold</a>
            	<a href="https://t.me/aelfkorean" class="ico_fly" target="_blank">Telegram</a>
            	<a href="http://bit.ly/aelfkoreakakao" class="ico_talk" target="_blank">kakaotalk</a>
            </div>                      
            <ul class="top-bottom" style="width: 560px;">
                <li ><a href="notice.lf?menu=notice" <%if("notice".equals(menu)) {%> class="active" <%} %>>공지사항</a></li>
                <li ><a href="news.lf?menu=news&mode=list" <%if("news".equals(menu)) {%> class="active" <%} %>>뉴스</a></li>
                <li ><a href="contents.lf?menu=contents&mode=list" <%if("contents".equals(menu)) {%> class="active" <%} %>>컨텐츠</a></li>
                <li ><a href="debate.lf?menu=debate&mode=list" <%if("debate".equals(menu)) {%> class="active" <%} %>>토론방</a></li>
                <li ><a href="petition.lf?menu=petition" <%if("petition".equals(menu)) {%> class="active" <%} %>>청원</a></li>
                <li ><a href="calendar.lf?menu=calendar" <%if("calendar".equals(menu)) {%> class="active" <%} %>>캘린더</a></li>
                <%-- <li ><a href="team.lf?menu=team" <%if("team".equals(menu)) {%> class="active" <%} %>>팀</a></li> --%>
            </ul>
        </div>
    
    <%if(userInfo != null) {	/// 로그인 상태    %>
    <div class="notice-sub-wrap" style="display: none;" id="user_sub">
    	<span class="sub-bg-wrap">
    		<img src="img/notice-sub-top.png" alt="" class="sub-bg" />
    	</span>	
    	<div class="notice-sub-wrap-2">
	        <table class="notice-sub" cellpadding="0" cellspacing="0">
	        	<%
	        	for(int i=0; i<listAlarm.size(); i++) {
	        		AlarmInfoModel alarm = listAlarm.get(i);
	        		
	        		String profile = "img/top-log-1.png";
	        		if(alarm.getFromUiNo()==-1)
	        			profile = "img/master-profile.jpg";
	        		else {
	        			profile = "upload/profile/"+alarm.getFromUiProfile();
	        		}
	        	%>
	            <tr onclick="javascript:goAlarmLink(<%=alarm.getAiNo() %>, <%=alarm.getBoardNo() %>, '<%=alarm.getBoardType() %>')">
	                <td width="70"><img src="<%=profile %>" style="margin-right: 14px; border-radius: 50%; width: 30px; height: 30px;" alt="" /></td>
	                <td width="210"><%=alarm.getAiContent() %></td>
	            </tr>
	            <%
	        	}
	            %>
	            <%--
	            <tr>
	                <td width="70"><img src="img/top-log-1.png" alt="" /></td>
	                <td width="210"><span style="font-weight: 400;">김성제</span>님이 <span style="font-weight: 400;">회원님의 게시글</span>을<br>좋아합니다.</td>
	            </tr>
	            <tr>
	                <td><img src="img/top-log-1.png" alt="" /></td>
	                <td><span style="font-weight: 400;">김성제</span>님이 <span style="font-weight: 400;">회원님의 게시글</span>을<br>좋아합니다.</td>
	            </tr>
	            <tr>
	                <td><img src="img/top-log-1.png" alt="" /></td>
	                <td><span style="font-weight: 400;">김성제</span>님이 <span style="font-weight: 400;">회원님의 게시글</span>을<br>좋아합니다.</td>
	            </tr>
	            <tr>
	                <td><img src="img/top-log-1.png" alt="" /></td>
	                <td><span style="font-weight: 400;">김성제</span>님이 <span style="font-weight: 400;">회원님의 게시글</span>을<br>좋아합니다.</td>
	            </tr>
	            <tr>
	                <td><img src="img/top-log-1.png" alt="" /></td>
	                <td><span style="font-weight: 400;">김성제</span>님이 <span style="font-weight: 400;">회원님의 게시글</span>을<br>좋아합니다.</td>
	            </tr>
	             --%>
	        </table>
        </div>
      </div>
      <%} %>
      
    </div>
      
      
<script type="text/javascript">
	function goLogin() {
		var url = encodeURIComponent(window.location.href);
		
		location.href = 'login.lf?menu=login&url='+url;
	}
	
	function goLogout() {
		var url = encodeURIComponent(window.location.href);
		
		location.href = 'login.lf?menu=logout&url='+url;
	}
	
	
	/// 쿠키 관련 ////
	function getCookie(name) {
		var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
		return value? value[2] : null;
	}
	
	function setCookie(name, value) {
		document.cookie = name + '=' + value + ';path=/';
	}
	
	function deleteCookie(name) {
		document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
	}
	////////////////
	
	
<%if(userInfo != null) {	/// 로그인 상태    %>	
	var expandUser = getCookie('expand_user');
	//console.log(expandUser);
	
	if(expandUser=='1') {
		document.getElementById('user_sub').style.display = '';
	} else {
		document.getElementById('user_sub').style.display = 'none';
	}
	
	function toggleUserSub() {
		if(expandUser=='1') {
			document.getElementById('user_sub').style.display = 'none';
			setCookie('expand_user', '0');
			expandUser = '0';
		}
		else {
			document.getElementById('user_sub').style.display = '';
			setCookie('expand_user', '1');
			expandUser = '1';
		}
	}
	
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


function ajaxFailed(xmlRequest)	{
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}
</script>
    