<%@page import="dao.AelfDAO"%>
<%@page import="model.UserInfoModel"%>
<%@page import="model.AlarmInfoModel"%>
<%@page import="java.util.List"%>
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

   <div class="top-wrap" <%if(menu!=null) {%>style="background-color: #001b31;"<%} %> >
        <div class="top">
            <img src="m-img/main-menu.png" alt="" class="top-menu" onclick="javascript:toggleMenu()" />
            <img src="m-img/top-logo.png" alt="" class="top-logo" onclick="javascript:location.href='main.lf'" />
            <div class="top-alarm">
                <img src="m-img/top-alarm.png" alt="" onclick="javascript:location.href='login.lf?menu=alarm'" />
			<%if(listAlarm!=null && listAlarm.size()>0) { %>
                <span class="active"></span>
			<%} %>
            </div>
        </div>
    </div>
	
	<div id="mask" style="display: none; width: 100%; top: 0; left: 0; height: 100%; z-index: 999999999; background: rgba(0, 0, 0, 0.6); position: absolute;"></div>
	
    <div id="menu" class="menu-wrap">
        <div class="menu">
            
            <div class="menu-top">
                
			<%if(userInfo != null) { %>
                <!-- 로그인 -->
                <div class="menu-top-left">
                    <img src="m-img/menu-logo.png" alt="" />
                    <div class="menu-person">
                        <!-- <img src="m-img/menu-person.png" alt="" onclick="javascrit:goLogout()" /> -->
                        <%if("".equals(userInfo.getUiProfile())) { %>
                        	<img src="m-img/menu-person.png" alt="" style="border-radius: 50%;" onclick="javascrit:goLogout()" />
                       	<%} else { %>
                       		<img src="upload/profile/<%=userInfo.getUiProfile() %>" alt="" style="border-radius: 50%;" />
                       	<%} %>
                        <span><%=userInfo.getUiName() %><!--님--></span>
                    </div>
                </div>
			<%} else { %>
				<!-- 비로그인 -->
                <div class="menu-top-left">
                    <img src="m-img/menu-logo.png" alt="" />
                    <div class="menu-person">
                        <img src="m-img/menu-person.png" alt="" onclick="javascript:goLogin()" />
                        <span>로그인 <!--님--></span>
                    </div>
                </div>
			<%} %>
                
                <div class="menu-top-right">
                    <ul>
                        <li onclick="javascript:location.href='main.lf'">
                            <span <%if(menu==null) {%>class="active"<%} %> >홈</span>
                            <%if(menu==null) {%>
                            	<img src="m-img/menu-home-on.png" alt="" />
                            <%}else { %>
                            	<img src="m-img/menu-home.png" alt="" />
                            <%} %>
                        </li>
                        <li onclick="javascript:location.href='notice.lf?menu=notice'">
                            <span <%if("notice".equals(menu)) {%>class="active"<%} %> >공지사항</span>
                            <%if("notice".equals(menu)) {%>
                            	<img src="m-img/menu-notice-on.png" alt="" />
                            <%}else { %>
                            	<img src="m-img/menu-notice.png" alt="" />
                            <%} %>
                        </li>
                        <li onclick="javascript:location.href='news.lf?menu=news'">
                            <span <%if("news".equals(menu)) {%>class="active"<%} %> >뉴스</span>
                            <%if("news".equals(menu)) {%>
                            	<img src="m-img/menu-notice-on.png" alt="" />
                            <%}else { %>
                            	<img src="m-img/menu-news.png" alt="" />
                            <%} %>
                        </li>
                        <li onclick="javascript:location.href='contents.lf?menu=contents'">
                            <span <%if("contents".equals(menu)) {%>class="active"<%} %> >컨텐츠</span>
                            <%if("contents".equals(menu)) {%>
                            	<img src="m-img/menu-contents-on.png" alt="" />
                            <%}else { %>
                            	<img src="m-img/menu-contents.png" alt="" />
                            <%} %>
                        </li>
                        <li onclick="javascript:location.href='debate.lf?menu=debate'">
                            <span <%if("debate".equals(menu)) {%>class="active"<%} %> >토론방</span>
                            <%if("debate".equals(menu)) {%>
                            	<img src="m-img/menu-debate-on.png" alt="" />
                            <%}else { %>
                            	<img src="m-img/menu-debate.png" alt="" />
                            <%} %>
                        </li>
                        <li onclick="javascript:location.href='petition.lf?menu=petition'">
                            <span <%if("petition".equals(menu)) {%>class="active"<%} %> >청원</span>
                            <%if("petition".equals(menu)) {%>
                            	<img src="m-img/menu-petition-on.png" alt="" />
                            <%}else { %>
                            	<img src="m-img/menu-petition.png" alt="" />
                            <%} %>
                        </li>
                        <li onclick="javascript:location.href='calendar.lf?menu=calendar'">
                            <span <%if("calendar".equals(menu)) {%>class="active"<%} %> >캘린더</span>
                            <%if("calendar".equals(menu)) {%>
                            	<img src="m-img/menu-calendar-on.png" alt="" />
                            <%}else { %>
                            	<img src="m-img/menu-calendar.png" alt="" />
                            <%} %>
                        </li>
                    </ul>
                </div>
            </div>
				<div class="menu-bottom">
	                <div class="menu-bottom-left">
	                    <img src="m-img/menu-telegram.png" onclick="javascript:window.open('https://t.me/aelfkorean')" alt="" />
	                    <img src="m-img/menu-kakao.png" onclick="javascript:window.open('http://bit.ly/aelfkoreakakao')" alt="" />
	                </div>
	                <div class="menu-bottom-right">
	                    <img src="m-img/footer-1.png" onclick="javascript:window.open('https://www.instagram.com/aelfblockchain/?hl=en')" alt="" />
	                    <img src="m-img/footer-2.png" onclick="javascript:window.open('https://twitter.com/aelfblockchain?lang=en')" alt="" />
	                    <img src="m-img/footer-3.png" onclick="javascript:window.open('https://github.com/AElfProject/AElf')" alt="" />
	                </div>
	                
	            </div>
            

            
            <img src="m-img/menu-close.png" alt="" class="close" onclick="javascript:toggleMenu()" />
            
        </div>
    </div>
        
<script type="text/javascript">

var bToggleMenu = 0;
var menuWidth = $('#menu').width() + 36;

$('#menu').css('margin-left', '-'+menuWidth+'px');

function toggleMenu() {
	if(bToggleMenu == 0) {
		//document.getElementById('menu').style.display = '';
		$("#menu").animate({"margin-left":"+=" + menuWidth + "px"},300);
		bToggleMenu = 1;
		document.getElementById('mask').style.display = '';
		$('body').css('overflow', 'hidden');	// body 스크롤 막지
	}
	else {
		//document.getElementById('menu').style.display = 'none';
		$("#menu").animate({"margin-left":"-=" + menuWidth + "px"},300);
		bToggleMenu = 0;
		document.getElementById('mask').style.display = 'none';
		$('body').css('overflow', '');		// body 스크롤 막기 해제
	}
}


function goLogin() {
	var url = encodeURIComponent(window.location.href);
	
	location.href = 'login.lf?menu=login&url='+url;
}

function goLogout() {
	var url = encodeURIComponent(window.location.href);
	
	location.href = 'login.lf?menu=logout&url='+url;
}
</script>

    