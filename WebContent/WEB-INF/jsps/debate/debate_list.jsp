<%@page import="java.text.NumberFormat"%>
<%@page import="model.UserInfoModel"%>
<%@page import="java.util.List"%>
<%@page import="model.DebateInfoModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	DebateInfoModel di = (DebateInfoModel) request.getAttribute("di");
	List<DebateInfoModel> listDI = (List<DebateInfoModel>) request.getAttribute("listDI");
	
	int totalCount = (Integer) request.getAttribute("totalCount");
	String pageNum = (String) request.getAttribute("pageNum");
	String pageNavigator = (String) request.getAttribute("pageNavigator");
	String searchText = (String) request.getAttribute("searchText");
	
	UserInfoModel userInfo = (UserInfoModel) session.getAttribute("userInfo");
	
	List<DebateInfoModel> listTop = (List<DebateInfoModel>) request.getAttribute("listTop");
	List<DebateInfoModel> listBest = (List<DebateInfoModel>) request.getAttribute("listBest");
	
	NumberFormat nf = NumberFormat.getInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-124162297-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-124162297-1');
</script>
<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
<script type="text/javascript">
if(!wcs_add) var wcs_add = {};
wcs_add["wa"] = "10e055c33a4b84";
wcs_do();
</script>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, width=1920-width">
<link rel="shortcut icon" type="image/x-icon" href="fabicon.ico" />

<meta name="Title" content="엘프 코리아 토론">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain 엘프관리자 엘프정보 엘프커뮤니티 엘프연락 엘프포럼 엘프캔디 엘프밋업 엘프문의">
<meta name="Description" content="엘프커뮤니티 – 핫이슈, 트렌드와 토론. 엘프에 대한 모든 대화, 소통, 문의, 의견을 올려주세요.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아 토론">
<meta itemprop="description" content="엘프커뮤니티 – 핫이슈, 트렌드와 토론. 엘프에 대한 모든 대화, 소통, 문의, 의견을 올려주세요.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">
<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 토론">
<meta property="og:description" content="엘프커뮤니티 – 핫이슈, 트렌드와 토론. 엘프에 대한 모든 대화, 소통, 문의, 의견을 올려주세요.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/debate.lf?menu=debate&mode=list">
<meta name="apple-mobile-web-app-title" content="엘프 코리아">
<meta name="application-name" content="엘프 코리아">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->

<script type="text/javascript">

function writeDebate() {
<%if(userInfo == null) {%>
	alert('로그인 후 사용할 수 있습니다.');
<%} else { %>
	location.href = 'debate.lf?menu=debate&mode=write';
<%} %>
}


/// 상단 베스트 인덱스 선택
function viewBest(idx) {
	for(var i=0; i<<%=listBest.size() %>; i++) {
		document.getElementById('div_best_'+i).style.display = 'none';
	}
	
	$("#div_best_"+idx).stop().animate({opacity: '0'},0);
	document.getElementById('div_best_'+idx).style.display = '';
	$("#div_best_"+idx).stop().animate({opacity: '1'},300);
}


/// 상단 관리자 지정 인덱스 선택
function viewTop(idx) {
	for(var i=0; i<<%=listTop.size() %>; i++) {
		document.getElementById('div_top_'+i).style.display = 'none';
	}
	
	$("#div_top_"+idx).stop().animate({opacity: '0'},0);
	document.getElementById('div_top_'+idx).style.display = '';
	$("#div_top_"+idx).stop().animate({opacity: '1'},300);
}

</script>

</head>
<body style="background-color:#f7f7f7;">

	<jsp:include page="../main_top.jsp"></jsp:include>

        <div class="notice-wrap">
        <div class="notice">
        
        	<%if(listBest.size()+listTop.size() > 0) { %>
            <div class="notice-main-wrap">
                
                <div class="notice-top-wrap">
                    <div class="notice-top">
                        
                        <div class="notice-top-left-wrap">
                            <h4>베스트 토론</h4>
                            <%
                            for(int i=0; i<listBest.size(); i++) {
                            	DebateInfoModel bestDI = listBest.get(i);
                            	
                            	int likeWidth = 50, dislikeWidth = 50;
                            	if(bestDI.getLikeCnt()+bestDI.getDislikeCnt() > 0) {                            		
                            		likeWidth = (int)(((float)bestDI.getLikeCnt() / (bestDI.getLikeCnt()+bestDI.getDislikeCnt())) * 100);
                            		dislikeWidth = 100 - likeWidth;
                            	}
                            %>
                            <div class="notice-top-left" id="div_best_<%=i %>" <%if(i>0) { %>style="display: none;"<%} %> >
                                <div class="notice-top-title" style="cursor: pointer;" onclick="javascript:location.href='debate.lf?menu=debate&mode=view&di_no=<%=bestDI.getDiNo() %>'">
                                	<p><%=bestDI.getDiTitle() %></p>
                                </div>
                                <div class="debate-like-wrap">
                                    <div class="debete-like">

                                        <div class="debete-like-top"><!-- 온클릭 -->
                                            <div class="debete-like-top-up">
                                                <img src="img/debate-up.png" alt="" width="28" />
                                                <span>찬성</span>
                                            </div>
                                            <div class="debete-like-top-down"><!-- 온클릭 -->
                                                <span>반대</span>
                                                <img src="img/debate-down.png" alt="" width="28" />
                                            </div>
                                        </div>

                                        <div class="debete-like-bottom">
                                            <div class="debete-graph">
                                            	<div class="graph-left" style="width: <%=likeWidth%>%;"><span><%=nf.format(bestDI.getLikeCnt()) %>명</span></div>
                                            	<div class="graph-right" style="width: <%=dislikeWidth%>%;"><span><%=nf.format(bestDI.getDislikeCnt()) %>명</span></div>
                                            </div>
                                        </div>

                                        <div class="debete-like-info">
                                            <span><%=bestDI.getDiDate().substring(0, 4) %>.<%=bestDI.getDiDate().substring(5, 7) %>.<%=bestDI.getDiDate().substring(8, 10) %></span>
                                            <span class="debate-re"><img src="img/debate-re.png" alt="" /><%=nf.format(bestDI.getReplyCnt()) %>건</span><!-- 온클릭 -->
                                        </div>

                                    </div>

                                </div>
                                <div class="aelf-slider-wrap">
                                    <ul class="aelf-slider">
                                        <%for(int j=0; j<listBest.size(); j++) { %>
			                            	<%if(i==j) { %>
			                                <li class="active"><a href="#"></a></li>
			                                <%}else { %>
			                                <li onclick="javascript:viewBest(<%=j %>)"></li>
			                                <%} %>
			                            <%} %>
                                    </ul>
                                </div>
                            </div>
                            <%} %>
                        </div>
                        
                        <div class="notice-top-right-wrap">
                            <h4>AELF TOPIC</h4>
                            <%
                            for(int i=0; i<listTop.size(); i++) {
                            	DebateInfoModel topDI = listTop.get(i);
                            	
                            	int likeWidth = 50, dislikeWidth = 50;
                            	if(topDI.getLikeCnt()+topDI.getDislikeCnt() > 0) {                            		
                            		likeWidth = (int)(((float)topDI.getLikeCnt() / (topDI.getLikeCnt()+topDI.getDislikeCnt())) * 100);
                            		dislikeWidth = 100 - likeWidth;
                            	}
                            %>
                            
                            <div class="notice-top-left" id="div_top_<%=i %>" <%if(i>0) { %>style="display: none;"<%} %> >
                            	<div class="notice-top-title" style="cursor: pointer;" onclick="javascript:location.href='debate.lf?menu=debate&mode=view&di_no=<%=topDI.getDiNo() %>'">
                                	<p><%=topDI.getDiTitle() %></p>
                                </div>
                                <div class="debate-like-wrap">
                                    <div class="debete-like">

                                        <div class="debete-like-top">
                                            <div class="debete-like-top-up">
                                                <img src="img/debate-up.png" alt="" width="28" />
                                                <span>찬성</span>
                                            </div>
                                            <div class="debete-like-top-down">
                                                <span>반대</span>
                                                <img src="img/debate-down.png" alt="" width="28" />
                                            </div>
                                        </div>

                                        <div class="debete-like-bottom">
                                            <div class="debete-graph">
                                            	<div class="graph-left" style="width: <%=likeWidth%>%;"><span><%=nf.format(topDI.getLikeCnt()) %>명</span></div>
                                            	<div class="graph-right" style="width: <%=dislikeWidth%>%;"><span><%=nf.format(topDI.getDislikeCnt()) %>명</span></div>
                                            </div>
                                        </div>

                                        <div class="debete-like-info">
                                            <span><%=topDI.getDiDate().substring(0, 4) %>.<%=topDI.getDiDate().substring(5, 7) %>.<%=topDI.getDiDate().substring(8, 10) %></span>
                                            <span class="debate-re"><img src="img/debate-re.png" alt="" /><%=nf.format(topDI.getReplyCnt()) %>건</span>
                                        </div>

                                    </div>

                                </div>
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
                            </div>
                            <%} %>
                            
                        </div>
                        
                    </div>
                </div>

            </div>
            <%} %>
            
            
            <div class="notice-list-wrap">
                <h4>토론</h4>
                <table class="notice-list" width="1030;" cellpadding="0" cellspacing="0">
                    <tr style="font-weight: 500;" class="notice-list-bl">
                        <td width="80">번호</td>
                        <td width="120">분류</td>
                        <td>제목</td>
                        <td width="90">찬성</td>
                        <td width="90">반대</td>
                        <td width="90">날짜</td>
                    </tr>
                    <%
                    for(int i=0; i<listDI.size(); i++) {
                    	DebateInfoModel list = listDI.get(i);
                    	
                    	String dateStr[] = list.getDiDate().split(" ");
                    %>
                    <tr class="notice-list-bl notice-list-bl-content" onclick="javascript:location.href='debate.lf?menu=debate&mode=view&di_no=<%=list.getDiNo() %>'">
                        <td><%=totalCount - i - (Integer.parseInt(di.getPageNum()) - 1) * di.getListCount() %></td>
                        <td>토론</td>
                        <td style="font-weight: 400; text-align: left;"><%=list.getDiTitle() %></td>
                        <td style="color:#00457c"><%=nf.format(list.getLikeCnt()) %>명</td>
                        <td style="color:#ff735c"><%=nf.format(list.getDislikeCnt()) %>명</td>
                        <td><%=dateStr[0].substring(2, 4) %>.<%=dateStr[0].substring(5, 7) %>.<%=dateStr[0].substring(8, 10) %></td>
                    </tr>
                    <%
                    }
                    %>
                    <tr height="50">
                        <td colspan="6" style="text-align: right;">
                        	<input type="button" value="신청" style="width: 70px; height: 32px; background-color: #001c33; color:#fff; cursor: pointer; vertical-align: bottom" onclick="javascript:writeDebate()" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6">
                            <form action="debate.lf" method="get">
                        		<input type="hidden" name="menu" value="debate" />
                        		<input type="hidden" name="mode" value="list" />
	                            <input type="text" name="searchText" value="<%=searchText %>" style="width: 300px; height: 30px; border:1px solid #bfbfbf;"/>
	                            <input type="submit" value="검색" style="width: 70px; height: 32px; background-color: #001c33; color:#fff; cursor: pointer; vertical-align: bottom"/>
                            </form>
                        </td>
                    </tr>
                    <tr height="30">
                        <td colspan="6"></td>
                    </tr>
                    <tr height="30">
                        <td colspan="6"><%=pageNavigator %></td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>