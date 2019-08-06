<%@page import="util.CryptoSlate"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.List"%>
<%@page import="model.NoticeInfoModel"%>
<%@page import="model.NewsInfoModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	NoticeInfoModel ni = (NoticeInfoModel) request.getAttribute("ni");
	List<NoticeInfoModel> listNI = (List<NoticeInfoModel>) request.getAttribute("listNI");
	List<NoticeInfoModel> listTop = (List<NoticeInfoModel>) request.getAttribute("listTop");
	//NoticeInfoModel topNi = (NoticeInfoModel) request.getAttribute("topNi");
	
	int totalCount = (Integer) request.getAttribute("totalCount");
	String pageNum = (String) request.getAttribute("pageNum");
	String pageNavigator = (String) request.getAttribute("pageNavigator");
	String searchText = (String) request.getAttribute("searchText");
	
	NumberFormat nf = NumberFormat.getInstance();
	
	//String topStr[] = {};
	//if(topNi.getNiNo()!= -1){
	//	topStr = topNi.getNiDate().split(" ");
	//}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>

<!-- Naver Analytics -->	
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "10e055c33a4b84";
wcs_do();
</script>

<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-124162297-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-124162297-1');
</script>

<meta name="viewport" content="user-scalable=no, initial-scale=1.0, width=1920-width">
<link rel="shortcut icon" type="image/x-icon" href="fabicon.ico" />

<meta name="Title" content="엘프 코리아 공지사항">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain 엘프이벤트  엘프퀴즈 엘프QR 엘프QR코드 엘프QR코드찾기 엘프상품 엘프커뮤니티 엘프오픈채팅 엘프밋업 엘프카카오톡 엘프카톡 엘프텔레그램 엘프텔레 엘프관리자 엘프포럼 엘프캔디">
<meta name="Description" content="매주 엘프코리아에서 제공하는 다양한 이벤트와 피드를 받아보세요.  홈페이지 속 숨겨진 QR코드 찾기, 깜짝 퀴즈 등 엘프와 다양한 활동에 참여하고 상품 받기.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아">
<meta itemprop="description" content="매주 엘프코리아에서 제공하는 다양한 이벤트와 피드를 받아보세요.  홈페이지 속 숨겨진 QR코드 찾기, 깜짝 퀴즈 등 엘프와 다양한 활동에 참여하고 상품 받기.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">

<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 공지사항">
<meta property="og:description" content="매주 엘프코리아에서 제공하는 다양한 이벤트와 피드를 받아보세요.  홈페이지 속 숨겨진 QR코드 찾기, 깜짝 퀴즈 등 엘프와 다양한 활동에 참여하고 상품 받기.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/notice.lf?menu=notice">

<meta name="apple-mobile-web-app-title" content="엘프 코리아 공지사항">
<meta name="application-name" content="엘프 코리아">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->

<script type="text/javascript">

/// 메인 공지사항 인덱스 선택
var curIdx = 0;
function viewTop(idx) {
	curIdx = idx;
	
	for(var i=0; i<<%=listTop.size() %>; i++) {
		document.getElementById('div_top_'+i).style.display = 'none';
	}
	
	$("#div_top_"+idx).stop().animate({opacity: '0'},0);
	document.getElementById('div_top_'+idx).style.display = '';
	$("#div_top_"+idx).stop().animate({opacity: '1'},500);
}

function leftTop() {
	var maxSize = <%=listTop.size() %>;
	
	if(curIdx==0)	curIdx = maxSize-1;
	else			curIdx = curIdx-1;
	
	for(var i=0; i<<%=listTop.size() %>; i++) {
		document.getElementById('div_top_'+i).style.display = 'none';
	}
	
	$("#div_top_"+curIdx).stop().animate({opacity: '0'},0);
	document.getElementById('div_top_'+curIdx).style.display = '';
	$("#div_top_"+curIdx).stop().animate({opacity: '1'},500);
}

function rightTop() {
	var maxSize = <%=listTop.size() %>;
	
	if(curIdx==maxSize-1)	curIdx = 0;
	else					curIdx = curIdx+1;
	
	for(var i=0; i<<%=listTop.size() %>; i++) {
		document.getElementById('div_top_'+i).style.display = 'none';
	}
	
	$("#div_top_"+curIdx).stop().animate({opacity: '0'},0);
	document.getElementById('div_top_'+curIdx).style.display = '';
	$("#div_top_"+curIdx).stop().animate({opacity: '1'},500);
}
</script>

</head>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>

	<div class="notice-wrap">
		<div class="notice">
		
			<%if(listTop.size()>0) { %>
			<div class="notice-main-wrap">
				<h4>메인 공지사항</h4>
	            <%
				for(int i=0; i<listTop.size(); i++) {
					NoticeInfoModel topNi = listTop.get(i);
				%>
	                <table class="notice-main" width="1030" cellpadding="0" cellspacing="0" id="div_top_<%=i %>" <%if(i>0) { %>style="display: none;"<%} %> >
	                    <tr height="30">
	                        <td colspan="3"></td>
	                    </tr>
	                    <tr>
	                        <td class="one_tit" colspan="3" style="font-size:24px; font-weight: 500; letter-spacing: -1.5px;"><%=topNi.getNiTitle() %></td>
	                    </tr>
	                    <tr>
	                    <tr height="27">
	                        <td colspan="3"></td>
	                    </tr>
	                        <td colspan="3" style="letter-spacing: -1.2px;"><div class="txt_h60"><%=CryptoSlate.getRemoveHtmlText(topNi.getNiContent()) %></div></td>
	                    </tr>
	                    <tr height="55">
	                        <td colspan="3"></td>
	                    </tr>
	                    <tr height="14">
	                        <td style="font-weight: 400; border-right: 2px solid #d2d2d2" width="58">날짜</td>
	                        <td style="padding-left: 26px"><%=topNi.getNiDate().substring(2, 4) %>.<%=topNi.getNiDate().substring(5, 7) %>.<%=topNi.getNiDate().substring(8, 10) %></td>
	                        <td></td>
	                    </tr>
	                    <tr height="7">
	                        <td colspan="3"></td>
	                    </tr>
	                    <tr height="14">
	                        <td style="font-weight: 400; border-right: 2px solid #d2d2d2;">조회수</td>
	                        <td style="color:#35b1ff; padding-left:26px "><%=nf.format(topNi.getNiView()) %>명</td>
	                        <td style="position:relative;">
	                            <div class="notice-viwe notice-btn">
	                                <input type="button" value="내용 자세히 보기" onclick="javascript:location.href='notice.lf?menu=notice&mode=view&ni_no=<%=topNi.getNiNo() %>'" />
	                            </div>
	                        </td>
	                    </tr>
	                    <tr class="notice-dot">
	                        <td colspan="3">
	                        	<div class="aelf-slider-wrap">
                                    <ul class="aelf-slider">
                                        <%for(int j=0; j<listTop.size(); j++) { %>
			                            	<%if(i==j) { %>
			                                <li class="active"><a href="#"></a></li>
			                                <%}else { %>
			                                <li onclick="javascript:viewTop(<%=j %>)"></li>
			                                <%} %>
			                            <%} %>
                                    </ul>
                                </div>
	                        <%--
	                            <ul>
	                            <%for(int j=0; j<listTop.size(); j++) { %>
	                            	<%if(i==j) { %>
	                                <li class="active"><a href="#"></a></li>
	                                <%}else { %>
	                                <li><a href="javascript:void(0)" onclick="javascript:viewTop(<%=j %>)"></a></li>
	                                <%} %>
	                            <%} %>
	                         --%>
	                            </ul>
	                        </td>
	                    </tr>
	                    <tr height="15">
	                        <td colspan="3"></td>
	                    </tr>
	                </table>
				<%} %>
				<%if(listTop.size()>1) { %>
				<div class="list-bth-wrap">
					<span class="list-btn"><img src="img/page_on.png" onMouseOver="this.src='img/page_hover.png'" onMouseOut="this.src='img/page_on.png'" onclick="javascript:leftTop()" /></span>
					<span class="list-btn list-btn-x"><img src="img/page_on.png" onMouseOver="this.src='img/page_hover.png'" onMouseOut="this.src='img/page_on.png'" onclick="javascript:rightTop()" /></span>
				</div>
				<%} %>
			</div>
			<%} %>
            
            <div class="notice-list-wrap">
                <h4>공지사항</h4>
                <table class="notice-list" width="1030;" cellpadding="0" cellspacing="0">
                    <tr style="font-weight: 500;" class="notice-list-bl">
                        <td width="80">번호</td>
                        <td width="120">분류</td>
                        <td>제목</td>
                        <td width="90">날짜</td>
                        <td width="90">조회수</td>
                    </tr>
                    <%for(int i=0; i<listNI.size(); i++){
                    	NoticeInfoModel list = listNI.get(i);
                    	
                    	String dateStr[] = list.getNiDate().split(" ");
                    	%>
                    	<tr class="notice-list-bl notice-list-bl-content" onclick="javascript:location.href='notice.lf?menu=notice&mode=view&ni_no=<%=list.getNiNo() %>'">
	                        <td><%=totalCount - i - (Integer.parseInt(ni.getPageNum()) - 1) * ni.getListCount() %></td>
	                        <td>공지</td>
	                        <td class="one_tit" style="font-weight: 400; text-align: left;"><%=list.getNiTitle() %></td>
	                        <td><%=dateStr[0].substring(2, 4) %>.<%=dateStr[0].substring(5, 7) %>.<%=dateStr[0].substring(8, 10) %></td>
	                        <td><%=nf.format(list.getNiView()) %>명</td>
	                    </tr>
                    <%} %>
                    <tr height="30px"></tr>                   	
                    <tr>
                        <td colspan="5">
                        	<form action="notice.lf" method="get">
                        		<input type="hidden" name="menu" value="notice" />
                        		<input type="hidden" name="mode" value="list" />
	                            <input type="text" name="searchText" value="<%=searchText %>" style="width: 300px; height: 30px; border:1px solid #bfbfbf;"/>
	                            <input type="submit" value="검색" style="width: 70px; height: 32px; background-color: #001c33; color:#fff; cursor: pointer; vertical-align: bottom"/>
                            </form>
                        </td>
                    </tr>
                    <tr height="30">
                        <td colspan="5"></td>
                    </tr>
                    <tr height="30">
                        <td colspan="5"><%=pageNavigator %></td>
                    </tr>
                    
                </table>
            </div>
        </div>
        
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>