<%@page import="model.UserInfoModel"%>
<%@page import="util.CryptoSlate"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="model.PetitionInfoModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	PetitionInfoModel pi = (PetitionInfoModel) request.getAttribute("pi");
	List<PetitionInfoModel> listPI = (List<PetitionInfoModel>) request.getAttribute("listPI");
	List<PetitionInfoModel> listBest = (List<PetitionInfoModel>) request.getAttribute("listBest");
	
	int totalCount = (Integer) request.getAttribute("totalCount");
	String pageNum = (String) request.getAttribute("pageNum");
	String pageNavigator = (String) request.getAttribute("pageNavigator");
	String searchText = (String) request.getAttribute("searchText");
	String gubun = (String) request.getAttribute("gubun");
	
	UserInfoModel userInfo = (UserInfoModel) session.getAttribute("userInfo");
	
	NumberFormat nf = NumberFormat.getInstance();
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

<meta name="Title" content="엘프 코리아 청원게시판">
<meta name="Keyword" content="엘프관리자 엘프정보 엘프커뮤니티 엘프연락 엘프포럼 엘프캔디 엘프밋업 엘프지원 엘프문의 aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain">
<meta name="Description" content="엘프 청원, 지원 및 의견 제안하기. 엘프 관리 팀과 소통하고 무엇이든 물어보세요. 엘프코리아가 개선할 수 있도록 많은 참여 바랍니다.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아">
<meta itemprop="description" content="엘프 청원, 지원 및 의견 제안하기. 엘프 관리 팀과 소통하고 무엇이든 물어보세요. 엘프코리아가 개선할 수 있도록 많은 참여 바랍니다.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">

<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 청원게시판">
<meta property="og:description" content="엘프 청원, 지원 및 의견 제안하기. 엘프 관리 팀과 소통하고 무엇이든 물어보세요. 엘프코리아가 개선할 수 있도록 많은 참여 바랍니다.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/petition.lf?menu=petition">

<meta name="apple-mobile-web-app-title" content="엘프 코리아 청원게시판">
<meta name="application-name" content="엘프 코리아">


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->

<script type="text/javascript">

function writePetition() {
	<%if(userInfo == null) {%>
		alert('로그인 후 사용할 수 있습니다.');
	<%} else { %>
		location.href = 'petition.lf?menu=petition&mode=write&gubun=<%=gubun %>';
	<%} %>
}

/// 상단 베스트 인덱스 선택
var curIdx = 0;
function viewBest(idx) {
	for(var i=0; i<<%=listBest.size() %>; i++) {
		document.getElementById('div_best_'+i).style.display = 'none';
	}
	
	$("#div_best_"+idx).stop().animate({opacity: '0'},0);
	document.getElementById('div_best_'+idx).style.display = '';
	$("#div_best_"+idx).stop().animate({opacity: '1'},300);
}

function leftTop() {
	var maxSize = <%=listBest.size() %>;
	
	if(curIdx==0)	curIdx = maxSize-1;
	else			curIdx = curIdx-1;
	
	for(var i=0; i<<%=listBest.size() %>; i++) {
		document.getElementById('div_top_'+i).style.display = 'none';
	}
	
	$("#div_top_"+curIdx).stop().animate({opacity: '0'},0);
	document.getElementById('div_top_'+curIdx).style.display = '';
	$("#div_top_"+curIdx).stop().animate({opacity: '1'},500);
}

function rightTop() {
	var maxSize = <%=listBest.size() %>;
	
	if(curIdx==maxSize-1)	curIdx = 0;
	else					curIdx = curIdx+1;
	
	for(var i=0; i<<%=listBest.size() %>; i++) {
		document.getElementById('div_top_'+i).style.display = 'none';
	}
	
	$("#div_top_"+curIdx).stop().animate({opacity: '0'},0);
	document.getElementById('div_top_'+curIdx).style.display = '';
	$("#div_top_"+curIdx).stop().animate({opacity: '1'},500);
}

</script>

</head>
<body style="background-color:#f7f7f7;">

	<jsp:include page="../main_top.jsp"></jsp:include>
	
		<div class="tab_wrap">
			 <ul>
		   		<li><a href="petition.lf?menu=petition&mode=list&gubun=recent" <%if("recent".equals(gubun)) {%> class="on" <%} %> >최신순</a></li>
		   		<li><a href="petition.lf?menu=petition&mode=list&gubun=recommend" <%if("recommend".equals(gubun)) {%> class="on" <%} %> >추천순</a></li>
				<li><a href="petition.lf?menu=petition&mode=list&gubun=complete" <%if("complete".equals(gubun)) {%> class="on" <%} %> >답변 된 청원</a></li>
		   	</ul>	
		</div>
	
<%if("complete".equals(gubun)) {	////////////// 답변 된 청원 %>
	<div class="notice-wrap petition-wrap" style="padding-bottom:350px;">
        <div class="notice" style="padding-top:30px;">
            <div class="notice-main-wrap">
            <h4>답변 완료 청원</h4>
            <%
            for(int i=0; i<listPI.size(); i++) {
            	PetitionInfoModel list = listPI.get(i);
            %>
                <table class="notice-main" width="1030" cellpadding="0" cellspacing="0" >
                    <tr height="30">
                        <td colspan="3"></td>
                    </tr>
                    <tr>
                        <td class="one_tit" colspan="3" style="font-size:24px; font-weight: 500; letter-spacing: -1.5px;"><%=list.getPiTitle() %></td>
                    </tr>
                    <tr>
                    <tr height="27">
                        <td colspan="3"></td>
                    </tr>
                        <td colspan="3" style="letter-spacing: -1.2px;"><div class="txt_h60"><%=CryptoSlate.getRemoveHtmlText(list.getPiContent()) %></div></td>
                    </tr>
                    <tr height="55">
                        <td colspan="3"></td>
                    </tr>
                    <tr height="14">
                        <td style="font-weight: 400; border-right: 2px solid #d2d2d2" width="58">날짜</td>
                        <td style="padding-left: 26px"><%=list.getPiDate().substring(2, 4) %>.<%=list.getPiDate().substring(5, 7) %>.<%=list.getPiDate().substring(8, 10) %></td>
                        <td></td>
                    </tr>
                    <tr height="7">
                        <td colspan="3"></td>
                    </tr>
                    <tr height="14">
                        <td style="font-weight: 400; border-right: 2px solid #d2d2d2;">조회수</td>
                        <td style="color:#35b1ff; padding-left:26px "><%=nf.format(list.getPiView()) %>명</td>
                        <td style="position:relative;">
                            <div class="notice-viwe notice-btn">
                                <input type="button" value="내용 자세히 보기" onclick="javascript:location.href='petition.lf?menu=petition&mode=view&gubun=<%=gubun %>&pi_no=<%=list.getPiNo() %>'" />
                            </div>
                        </td>
                    </tr>
                    <tr class="notice-dot">
                        <td colspan="3">
                        </td>
                    </tr>
                    <tr height="15">
                        <td colspan="3"></td>
                    </tr>
                </table>
			<%} %>                
                <table class="notice-list" width="1030" cellpadding="0" cellspacing="0" style="border: none;" >
                	<tr>
                		<td><%=pageNavigator %></td>
                	</tr>
                </table>
			</div>
        </div>
    </div>
<%} else { %>
        <div class="notice-wrap petition-wrap">
        <div class="notice" style="padding-top:30px;">
        
		<%if(listBest.size()>0) { %>
            <div class="notice-main-wrap">
				<h4>최다 추천 청원</h4>
				<%
				for(int i=0; i<listBest.size(); i++) {
					PetitionInfoModel bestPI = listBest.get(i);
				%>
	                <table class="notice-main" width="1030" cellpadding="0" cellspacing="0" id="div_best_<%=i %>" <%if(i>0) { %>style="display: none;"<%} %> >
	                    <tr height="30">
	                        <td colspan="3"></td>
	                    </tr>
	                    <tr>
	                        <td class="one_tit" colspan="3" style="font-size:24px; font-weight: 500; letter-spacing: -1.5px;"><%=bestPI.getPiTitle() %></td>
	                    </tr>
	                    <tr>
	                    <tr height="27">
	                        <td colspan="3"></td>
	                    </tr>
	                        <td colspan="3" style="letter-spacing: -1.2px;"><div class="txt_h60"><%=CryptoSlate.getRemoveHtmlText(bestPI.getPiContent()) %></div></td>
	                    </tr>
	                    <tr height="55">
	                        <td colspan="3"></td>
	                    </tr>
	                    <tr height="14">
	                        <td style="font-weight: 400; border-right: 2px solid #d2d2d2" width="58">날짜</td>
	                        <td style="padding-left: 26px"><%=bestPI.getPiDate().substring(2, 4) %>.<%=bestPI.getPiDate().substring(5, 7) %>.<%=bestPI.getPiDate().substring(8, 10) %></td>
	                        <td></td>
	                    </tr>
	                    <tr height="7">
	                        <td colspan="3"></td>
	                    </tr>
	                    <tr height="14">
	                        <td style="font-weight: 400; border-right: 2px solid #d2d2d2;">조회수</td>
	                        <td style="color:#35b1ff; padding-left:26px "><%=nf.format(bestPI.getPiView()) %>명</td>
	                        <td style="position:relative;">
	                            <div class="notice-viwe notice-btn">
	                                <input type="button" value="내용 자세히 보기" onclick="javascript:location.href='petition.lf?menu=petition&mode=view&gubun=<%=gubun %>&pi_no=<%=bestPI.getPiNo() %>'" />
	                            </div>
	                        </td>
	                    </tr>
	                    <tr class="notice-dot">
	                        <td colspan="3">
	                            <div class="aelf-slider-wrap">
                                    <ul class="aelf-slider">
                                        <%for(int j=0; j<listBest.size(); j++) { %>
			                            	<%if(i==j) { %>
			                                <li class="active"></li>
			                                <%}else { %>
			                                <li onclick="javascript:viewBest(<%=j %>)"></li>
			                                <%} %>
			                            <%} %>
                                    </ul>
                                </div>
	                        </td>
	                    </tr>
	                    <tr height="15">
	                        <td colspan="3"></td>
	                    </tr>
	                </table>
				<%} %>
				<%if(listBest.size()>1) { %>
				<div class="list-bth-wrap">
					<span class="list-btn"><img src="img/page_on.png" onMouseOver="this.src='img/page_hover.png'" onMouseOut="this.src='img/page_on.png'" onclick="javascript:leftTop()" /></span>
					<span class="list-btn list-btn-x"><img src="img/page_on.png" onMouseOver="this.src='img/page_hover.png'" onMouseOut="this.src='img/page_on.png'" onclick="javascript:rightTop()" /></span>
				</div>
				<%} %>
			</div>
		<%} %>
            
            
            <div class="notice-list-wrap">
                <h4>유저 청원</h4>
                <table class="notice-list" width="1030;" cellpadding="0" cellspacing="0">
                    <tr style="font-weight: 500;" class="notice-list-bl">
                        <td width="80">번호</td>
                        <td width="120">분류</td>
                        <td width="650" class="notice-list-title">제목</td>
                        <td width="90">날짜</td>
                        <td width="90">참여인원</td>
                    </tr>
                    <%
                    for(int i=0; i<listPI.size(); i++) {
                    	PetitionInfoModel list = listPI.get(i);
                    	
                    	String dateStr[] = list.getPiDate().split(" ");
                    %>
                    <tr class="notice-list-bl notice-list-bl-content" onclick="javascript:location.href='petition.lf?menu=petition&mode=view&gubun=<%=gubun %>&pi_no=<%=list.getPiNo() %>'">
                        <td><%=totalCount - i - (Integer.parseInt(pi.getPageNum()) - 1) * pi.getListCount() %></td>
                        <td>청원</td>
                        <td style="font-weight: 400; text-align: left;" class="notice-list-title"><%=list.getPiTitle() %></td>
                        <td><%=dateStr[0].substring(2, 4) %>.<%=dateStr[0].substring(5, 7) %>.<%=dateStr[0].substring(8, 10) %></td>
                        <td style="color:#35b1ff"><%=nf.format(list.getLikeCnt()+list.getReplyCnt()) %>명</td>
                    </tr>
                    <%} %>
                    <tr height="50">
                        <td colspan="5" style="text-align: right;">
                        	<input type="button" value="신청" style="width: 70px; height: 32px; background-color: #001c33; color:#fff; cursor: pointer; vertical-align: bottom" onclick="javascript:writePetition()" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5">
                            <form action="petition.lf" method="get">
                        		<input type="hidden" name="menu" value="petition" />
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
<%} %>
    
    <jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>