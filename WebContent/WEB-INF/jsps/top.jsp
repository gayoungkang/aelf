<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userName = (String) session.getAttribute("user_name");	// 로그인 사용자명
	String menu = request.getParameter("menu");
%>

		<div class="top-wrap" <%if("".equals(menu)==false && menu!=null) { %> style="background-color: #001c33;" <%} %> >
        <div class="top">
            <table class="top-top">
                <tr>
                    <td width="83"><a href="https://aelf.io" target="_blank"><img src="img/top-1.png" alt="worldwide" /></a></td>
                    <td></td>
                    <td width="62" class="aelf-logo"><a href="main.lf"><img src="img/aelf-logo.png" alt="aelf-logo" /></a></td>
                    <td></td>
                    <td width="24"><a href="https://t.me/aelfkorean" target="_blank"><img src="img/top-2.png" alt="텔레그램"/></a></td>
                    <td width="10"></td>
                    <td width="23"><a href="http://bit.ly/aelfkoreakakao" target="_blank"><img src="img/top-3.png" alt="카카오톡" /></a></td>
                </tr>
            </table>
            <ul class="top-bottom">
                <li <%if("notice".equals(menu)) {%> class="active" <%} %>><a href="notice.lf?menu=notice">공지사항</a></li>
                <li <%if("news".equals(menu)) {%> class="active" <%} %>><a href="news.lf?menu=news">뉴스</a></li>
                <li <%if("contents".equals(menu)) {%> class="active" <%} %>><a href="contents.lf?menu=contents">컨텐츠</a></li>
                <li <%if("debate".equals(menu)) {%> class="active" <%} %>><a href="debate.lf?menu=debate">토론방</a></li>
                <li <%if("calendar".equals(menu)) {%> class="active" <%} %>><a href="calendar.lf?menu=calendar">캘린더</a></li>
            </ul>
	<%if("".equals(menu)==false && menu!=null) { %>
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
        <%} else { %>	
        	<!-- 비로그인 -->
            <div class="top-log top-out">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td><a href="login.lf?menu=signup">Sign up</a></td>
                        <td width="32"></td>
                        <%--<td><a href="login.lf?menu=login">login</a></td> --%>
                        <td><a href="javascript:void(0)" onclick="javascript:goLogin()">login</a></td>
                    </tr>
                </table>
            </div>
		<%} %>
	<%} %>
        </div>
    </div>
    
    <%if(userName != null) {	/// 로그인 상태    %>
    <div class="notice-sub-wrap" style="display: none;" id="user_sub">
          <table class="notice-sub" cellpadding="0" cellspacing="0">
              <tr class="sub-bg-wrap">
                  <td colspan="2"><img src="img/notice-sub-top.png" alt="" class="sub-bg" /></td>
              </tr>
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
          </table>
      </div>
      <%} %>
      
      
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
	
	
<%if(userName != null) {	/// 로그인 상태    %>	
	var expandUser = getCookie('expand_user');
	console.log(expandUser);
	
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
<%} %>
</script>
    