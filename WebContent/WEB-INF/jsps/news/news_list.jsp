<%@page import="util.DateConvert"%>
<%@page import="util.CryptoSlate"%>
<%@page import="model.NewsInfoModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	List<NewsInfoModel> listNI = (List<NewsInfoModel>) request.getAttribute("listNI");
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

<meta name="Title" content="엘프 코리아 뉴스">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain 엘프커뮤니티 엘프관리자 엘프뉴스 엘프커뮤니티 엘프포럼 엘프캔디 엘프밋업">
<meta name="Description" content="엘프에 대한 최신 뉴스 및 속보를 받아보세요. 엘프의 다양한 활동, 성취와 성과를 확인해 보세요.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아">
<meta itemprop="description" content="엘프에 대한 최신 뉴스 및 속보를 받아보세요. 엘프의 다양한 활동, 성취와 성과를 확인해 보세요.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">

<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 뉴스">
<meta property="og:description" content="엘프에 대한 최신 뉴스 및 속보를 받아보세요. 엘프의 다양한 활동, 성취와 성과를 확인해 보세요.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/news.lf?menu=news&mode=list">

<meta name="apple-mobile-web-app-title" content="엘프 코리아 뉴스">
<meta name="application-name" content="엘프 코리아">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->




</head>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>

    <div class="news-wrap">
        <div class="news">
            <div class="news-page" style="padding-top:150px;">
                <%for(int i=0; i<listNI.size(); i++){
                	NewsInfoModel list = listNI.get(i);
                	
                	String dateStr[] = list.getNewsDate().split(" ");
                	
                	if(i%2 == 0){
                	%>
                		<div class="news-tb-wrap news-tb-rivers">
		                    <table cellpadding="0" cellspacing="0">
		                        <tr>
		                            <td rowspan="3" style="position: relative;"><img src="upload/news/<%=list.getNewsNo() %>/<%=list.getNewsThumbnail() %>" alt="" style="width: 534px; height: 307px;" /><span class="news-icon"><img src="img/news-non.png" alt="" /></span></td>
		                            <td width="17"></td>
		                            <td colspan="2" style="font-size:30px; font-weight: 400; line-height: 30px; border-bottom:3px solid #000;" height="103"><p class="two_tit_p w552"><%=list.getNewsTitle() %></p></td>
		                        </tr>
		                        <tr>
		                            <td></td>
		                            <td colspan="2" style="font-size:12px; line-height: 22px; letter-spacing: -0.7px; "><p class="txt_h135"><%=CryptoSlate.getRemoveHtmlText(list.getNewsContent()) %></p></td>
		                        </tr>
		                        <tr class="news-btn-wrap" height="31">
		                            <td></td>
		                            <td class="news-company"><%=list.getNewsAuthor() %>｜<%=DateConvert.month(dateStr[0]) %><%=dateStr[0].substring(8, 10) %>.<%=dateStr[0].substring(0, 4) %></td>
		                            <td>
		                                <div class="notice-viwe news-viwe">
		                                    <input type="button" value="내용 자세히 보기" onclick="javascript:location.href='news.lf?menu=news&mode=view&news_no=<%=list.getNewsNo() %>'" />
		                                </div>
		                            </td>
		                        </tr>
		                    </table>
		                </div>
                	<%}else{ %>
                		<div class="news-tb-origin-wrap">
		                    <div class="news-tb-wrap">
		                        <table cellpadding="0" cellspacing="0">
		                            <tr>
		                                <td colspan="2" style="font-size:30px; font-weight: 400; line-height: 30px; border-bottom:3px solid #000;" height="103"><p class="two_tit_p w552"><%=list.getNewsTitle() %></p></td>
		                                <td width="17"></td>
		                                <td rowspan="3" style="position: relative;"><img src="upload/news/<%=list.getNewsNo() %>/<%=list.getNewsThumbnail() %>" alt="" style="width: 534px; height: 307px;" /><span class="news-icon"><img src="img/news-non.png" alt="" /></span></td>
		                            </tr>
		                            <tr>
		                                <td colspan="2" style="font-size:12px; line-height: 22px; letter-spacing: -0.7px;"><p class="txt_h135"><%=CryptoSlate.getRemoveHtmlText(list.getNewsContent()) %></p></td>
		                                <td></td>
		                            </tr>
		                            <tr class="news-btn-wrap" height="31">
		                                <td class="news-company"><%=list.getNewsAuthor() %>｜<%=DateConvert.month(dateStr[0]) %><%=dateStr[0].substring(8, 10) %>.<%=dateStr[0].substring(0, 4) %></td>
		                                <td>
		                                    <div class="notice-viwe news-viwe">
		                                        <input type="button" value="내용 자세히 보기" onclick="javascript:location.href='news.lf?menu=news&mode=view&news_no=<%=list.getNewsNo() %>'" />
		                                    </div>
		                                </td>
		                                <td></td>
		                            </tr>
		                        </table>
		                    </div>
		                </div>
                	<%}
                }%>
                
            </div>
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>
    
</body>
</html>