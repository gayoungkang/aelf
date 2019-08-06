<%@page import="model.NewsInfoModel"%>
<%@page import="model.ContentInfoModel"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="model.NoticeInfoModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ContentInfoModel ci = (ContentInfoModel) request.getAttribute("ci");

NoticeInfoModel reNi = (NoticeInfoModel) request.getAttribute("reNi");
ContentInfoModel reCi = (ContentInfoModel) request.getAttribute("reCi");
NewsInfoModel reNewsInfo = (NewsInfoModel) request.getAttribute("reNewsInfo");

String dateStr[] = ci.getCiDate().split(" ");
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

<meta name="Title" content="엘프 코리아 컨텐츠">
<meta name="Keyword" content="aelf aelfkorea ELF 엘프한국 엘프한글 코리아 엘프홈페이지 엘프한국홈페이지 엘프 엘프코리아 엘프코인 AELF코인 ELF코인 dpos 디포스 병렬처리 parallel processing 클라우드컴퓨팅 클라우드 플랫폼코인 플랫폼 코인 토큰 3세대 블록체인 blockchain">
<meta name="Description" content="엘프에 다양한 정보, 진행서와 보고서 보기. 인터뷰 동영상 및 엘프코리아 관련 동영상과 기사들을 볼 수 있습니다.">
<meta name="Author" content="Daniel Gong">

<meta itemprop="name" content="엘프 코리아 컨텐츠">
<meta itemprop="description" content="엘프에 다양한 정보, 진행서와 보고서 보기. 인터뷰 동영상 및 엘프코리아 관련 동영상과 기사들을 볼 수 있습니다.">
<meta itemprop="image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">

<meta name="robots" content="All">
<meta name="audience" content="All">
<meta name="ratings" content="General">
<meta property="og:type" content="website">
<meta property="og:site_name" content="AELF KOREA">
<meta property="og:title" content="엘프 코리아 컨텐츠">
<meta property="og:description" content="엘프에 다양한 정보, 진행서와 보고서 보기. 인터뷰 동영상 및 엘프코리아 관련 동영상과 기사들을 볼 수 있습니다.">
<meta property="og:image" content="http://www.aelfkorea.io/img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io/contents.lf?menu=contents&mode=list">
<meta name="apple-mobile-web-app-title" content="엘프 코리아">
<meta name="application-name" content="엘프 코리아">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->
<style type="text/css">

.notice_content img{width: 100% !important;}
</style>
</head>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>

    <div class="board-wrap">
        <div class="board">
            <div class="board-1">
                <table cellpadding="0" cellspacing="0">
                    <tr height="56">
                        <td colspan="5" style="font-size: 16px; font-weight: 500; border-bottom:1px solid #e0e0e0;"><%=ci.getCiTitle() %></td>
                    </tr>
                    <tr height="53">
                        <td style="border-bottom:1px solid #e0e0e0;">날짜</td>
                        <td style="border-bottom:1px solid #e0e0e0;"><span style="padding:0 10px;">｜</span><%=dateStr[0].substring(2, 4) %>.<%=dateStr[0].substring(5, 7) %>.<%=dateStr[0].substring(8, 10) %></td>
                        <td style="border-bottom:1px solid #e0e0e0;">조회수</td>
                        <td style="border-bottom:1px solid #e0e0e0;"><span style="padding:0 10px;">｜</span><%=nf.format(ci.getCiView()) %>명</td>
                        <td width="335" style="border-bottom:1px solid #e0e0e0;"></td>
                    </tr>
                    <tr height="190">
                        <td class="notice_content" colspan="5" style="letter-spacing: -0.8px; vertical-align: top; padding-top:20px; padding-bottom:20px;border-bottom:1px solid #e0e0e0; width: 688px; word-break:break-all;"><%=ci.getCiContent() %></td>
                    </tr>
                    <!-- 
                    <tr height="40">
                        <td colspan="5"  style="border-bottom:1px solid #e0e0e0;">
                            <table cellpadding="0" cellspacing="0" class="board-action-wrap">
                                <tr height="40">
                                    <td width="100" class="board-action"><img src="img/board-icon-1.png" alt="" />좋아요</td>
                                    <td width="100" class="board-action"><img src="img/board-icon-2.png" alt="" />답글달기</td>
                                    <td width="100" class="board-action"><img src="img/board-icon-3.png" alt="" />공유하기</td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                     -->
                </table>
                <!-- 
                <table cellpadding="0" cellspacing="0" style="width: 100%;">
                    <tr height="90">
                        <td style="border-bottom:1px solid #e0e0e0;" width="43"></td>
                        <td style="border-bottom:1px solid #e0e0e0;" width="50"><img src="img/board-icon-4.png" alt="" /></td>
                        <td style="border-bottom:1px solid #e0e0e0;" width="13"></td>
                        <td style="border-bottom:1px solid #e0e0e0;"><input type="text" /></td>
                        <td style="border-bottom:1px solid #e0e0e0;" width="20"></td>
                        <td style="border-bottom:1px solid #e0e0e0;"><button>답글달기</button></td>
                        <td style="border-bottom:1px solid #e0e0e0;" width="55"></td>
                    </tr>
                </table>
                 -->
                  <!-- 
                <div class="board-reply-wrap">
                    <table cellpadding="0" cellspacing="0" class="board-reply">
                        <tr height="22">
                            <td rowspan="3" width="43"></td>
                            <td rowspan="3" width="50"><img src="img/board-icon-4.png" alt="" /></td>
                            <td rowspan="3" width="13"></td>
                            <td style="padding-top:30px; font-size: 16px; font-weight: 500;">Seong Je Kim<span style="margin-left:10px; font-size: 12px; font-weight: 100;">5월 9일 오후 7:00</span></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="padding:10px 0;">안녕하세요, 엘프(aelf)의 한국 오퍼레이션을 담당하고있는 이준범입니다. 4월12일(목) 저희 엘프가 빗썸 거래소에 상장하게 되었습니다! 이에 더욱 많은 분들이 엘프에 관심을 가져주고 계시는데요. 저희는 이번 포스팅을 통해 엘프의 기술을 조금 더 친근하게 한번 설명해보려고 합니다. 많은 분들에게 새로운 프로젝트이기도 할 뿐더러 엘프 백서의 기술적 복잡함을 인지하고 있기에 되도록 쉽게 이해하실 수 있게 풀어봤습니다.</td>
                        </tr>
                        <tr height="22">
                            <td style="padding-bottom:12px;">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="color:#2b5eba; cursor: pointer;">좋아요</td>
                                        <td width="10"></td>
                                        <td style="color:#2b5eba; cursor: pointer;">답글달기</td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="3"></td>
                        </tr>
                    </table>

                    <table cellpadding="0" cellspacing="0" class="board-reply">
                        <tr height="22">
                            <td rowspan="3" width="43"></td>
                            <td rowspan="3" width="50"><img src="img/board-icon-4.png" alt="" /></td>
                            <td rowspan="3" width="13"></td>
                            <td style="padding-top:30px; font-size: 16px; font-weight: 500;">Seong Je Kim<span style="margin-left:10px; font-size: 12px; font-weight: 100;">5월 9일 오후 7:00</span></td>
                        </tr>
                        <tr>
                            <td colspan="4" style="padding:10px 0;">안녕하세요, 엘프(aelf)의 한국 오퍼레이션을 담당하고있는 이준범입니다. 4월12일(목) 저희 엘프가 빗썸 거래소에 상장하게 되었습니다! 이에 더욱 많은 분들이 엘프에 관심을 가져주고 계시는데요. 저희는 이번 포스팅을 통해 엘프의 기술을 조금 더 친근하게 한번 설명해보려고 합니다. 많은 분들에게 새로운 프로젝트이기도 할 뿐더러 엘프 백서의 기술적 복잡함을 인지하고 있기에 되도록 쉽게 이해하실 수 있게 풀어봤습니다.</td>
                        </tr>
                       
                        <tr height="22">
                            <td style="padding-bottom:12px;">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td style="color:#2b5eba; cursor: pointer;">좋아요</td>
                                        <td width="10"></td>
                                        <td style="color:#2b5eba; cursor: pointer;">답글달기</td>
                                    </tr>
                                </table>
                            </td>
                            <td colspan="3"></td>
                        </tr>
                         
                    </table>
                </div>
                -->
                <!-- 
                <table cellpadding="0" cellspacing="0" width="100%" class="board-plus">
                    <tr height="30">
                        <td style="text-align: center;">▼ 답글 더보기</td>
                    </tr>
                </table>
                 -->
                                
            </div>
            <div class="board-2">
            	<%if(reNi.getNiNo() != -1){ %>
	                <table cellpadding="0" cellspacing="0">
	                    <tr>
	                        <td style="font-size: 16px; font-weight: 400;">AELF NOTICE</td>
	                    </tr>
	                    <tr height="13"></tr>
	                    <tr>
	                        <td style="cursor: pointer;" onclick="javascript: location.href='notice.lf?menu=notice&mode=view&ni_no=<%=reNi.getNiNo()%>'"><img src="upload/notice/<%=reNi.getNiNo() %>/<%=reNi.getNiThumbnail() %>" alt="" style="width: 274px;" /></td>
	                    </tr>
	                </table>
                <%} %>
                
                <%if(reNewsInfo.getNewsNo() != -1){ %>
	                <table cellpadding="0" cellspacing="0">
	                    <tr>
	                        <td style="font-size: 16px; font-weight: 400;">AELF NEWS</td>
	                    </tr>
	                    <tr height="13"></tr>
	                    <tr>
	                        <td style="cursor: pointer;" onclick="javascript: location.href='news.lf?menu=news&mode=view&news_no=<%=reNewsInfo.getNewsNo()%>'"><img src="upload/news/<%=reNewsInfo.getNewsNo() %>/<%=reNewsInfo.getNewsThumbnail() %>" alt="" style="width: 274px;" /></td>
	                    </tr>
	                </table>
                <%} %>
                
                <%if(reCi.getCiNo() != -1){
                	if("video".equals(reCi.getCcName())){
                	%>
	                <table cellpadding="0" cellspacing="0">
	                    <tr>
	                        <td style="font-size: 16px; font-weight: 400;">CONTENT</td>
	                    </tr>
	                    <tr height="13"></tr>
	                    <tr>
	                        <td style="cursor: pointer;" onclick="javascript: window.open('<%=reCi.getCiLink()%>')"><img src="upload/content/<%=reCi.getCiNo()%>/<%=reCi.getCiThumbnail() %>" alt="" style="width: 274px;" /></td>
	                    </tr>
	                </table>
	                <%}else{ %>
	                <table cellpadding="0" cellspacing="0">
	                    <tr>
	                        <td style="font-size: 16px; font-weight: 400;">CONTENT</td>
	                    </tr>
	                    <tr height="13"></tr>
	                    <tr>
	                        <td style="cursor: pointer;" onclick="javascript: location.href='contents.lf?menu=contents&mode=view&ci_no=<%=reCi.getCiNo()%>'"><img src="upload/content/<%=reCi.getCiNo()%>/<%=reCi.getCiThumbnail() %>" alt="" style="width: 274px;" /></td>
	                    </tr>
	                </table>
                	<%}
                }%>
                <!-- 
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="font-size: 16px; font-weight: 400;">토론방</td>
                    </tr>
                    <tr>
                        <td>
                            <ul>
                                <li><a href="#" class="one_tit_a">· GMO 완전 표시제 시행 촉구GMO 완전 표시제 시행 촉구GMO 완전 표시제 시행 촉구</a></li>
                                <li><a href="#" class="one_tit_a">· GMO 완전 표시제 시행 촉구</a></li>
                                <li><a href="#" class="one_tit_a">· GMO 완전 표시제 시행 촉구</a></li>
                                <li><a href="#" class="one_tit_a">· GMO 완전 표시제 시행 촉구</a></li>
                                <li><a href="#" class="one_tit_a">· GMO 완전 표시제 시행 촉구</a></li>
                                <li><a href="#" class="one_tit_a">· GMO 완전 표시제 시행 촉구</a></li>
                            </ul>
                        </td>
                    </tr>
                </table>
                 -->
            </div>
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>