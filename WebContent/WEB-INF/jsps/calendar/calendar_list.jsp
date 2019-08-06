<%@page import="java.util.Calendar"%>
<%@page import="model.CalendarInfoModel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	List<CalendarInfoModel> listCIM = (List<CalendarInfoModel>)request.getAttribute("listCIM");

 	int year = (Integer) request.getAttribute("year");
	int month = (Integer) request.getAttribute("month");
	
	Calendar cal = Calendar.getInstance();
	int curYear = cal.get(Calendar.YEAR);
	int curMonth = cal.get(Calendar.MONTH)+1;
	int curDay = cal.get(Calendar.DAY_OF_MONTH);
	
	// 표시할 달력 세팅
	cal.set(year, month-1, 1);
	int startDay = 1;
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	int week = cal.get(Calendar.DAY_OF_WEEK);
	
	String[] text = {"","","","","","","","","","","","","","","","","","","","","","","","","","","","","","","",""};
	
	if(listCIM.size()>0){
		for(int i = 0; i < listCIM.size(); i++){
			CalendarInfoModel cim = listCIM.get(i);
			if(text[Integer.parseInt(cim.getCalStartDate().substring(8, 10))].equals("")){
				text[Integer.parseInt(cim.getCalStartDate().substring(8, 10))] = "<font class=\"event\">" + cim.getCalStartDate().substring(8, 10)  + "</font><br><a target=\"_blank\" href =\"" + cim.getCalContent() + "\"><br><span class=\"event-text\">" + cim.getCalTitle() + "</span></a>";	
			}else{
				text[Integer.parseInt(cim.getCalStartDate().substring(8, 10))] += "<br><a target=\"_blank\" href =\"" + cim.getCalContent() + "\"><br><span class=\"event-text\">" + cim.getCalTitle() + "</span></a>";
			}
		}
	}
	
	String arrWeek[] = {"Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"};
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, width=1920-width">
<link rel="shortcut icon" type="image/x-icon" href="fabicon.ico" />



<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css">
<!-- 스타일시트 -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<!-- 노토산스 웹폰트 -->

<style type="text/css">
.opacity_bg_layer {
	display: none;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: #000;
	opacity: .5;
	filter: alpha(opacity = 50);
	z-index: 100000;
}

.layer_pop_center {
	position: absolute;
	background: #FFF;
	padding: 5px;
	z-index: 100001;
	overflow: hidden;
	overflow-y: auto;
}

.div_modal img {
	max-width: 100% !important;
	height: auto;
}
</style>

<script type="text/javascript">

function left(){
	location.href="calendar.lf?menu=calendar&year="+<%= year %>+"&month="+<%= month -1 %>;
}
function right(){
	location.href="calendar.lf?menu=calendar&year="+<%= year %>+"&month="+<%= month +1 %>;
}
</script>

</head>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>


	<section class="calendar">
		<div class="content">
			<div class="month">
				<% if((month+"").length() == 1){ %>
				<h1><%= year %>.<%= "0"+month %></h1>
				<% }else{ %>
				<h1><%= year %>.<%= month %></h1>
				<% } %>
				<div class="btn-box">
					<button onclick="javascript:left()" class="left-btn">
						<img src="./img/calendar_left_btn.png" alt="왼쪽 버튼" />
					</button>
					<button onclick="javascript:right()" class="right-btn">
						<img src="./img/calendar_right_btn.png" alt="오른쪽 버튼" />
					</button>
				</div>
			</div>
			<div class="date">
				<div class="title">
					<span>월별 스케쥴</span>
				</div>
				<table>
					<tr class="weekend">
						<th class="red">S</th>
						<th>M</th>
						<th>T</th>
						<th>W</th>
						<th>T</th>
						<th>F</th>
						<th class="blue">S</th>
					</tr>
					
					<% int lineCursor = 0; %>
					<tr class="week first-week">
					<% for(int i = 0; i < week-1; i++){ %>
						<td></td>
					<% lineCursor++; } %>
					<% for(int i=startDay; i<=endDay; i++){
						String fontColor = (lineCursor==0) ? "red" : (lineCursor==6) ? "blue" : "black";
						String bgcolor = "white";
						if(curYear==year && curMonth==month && curDay==i)
							bgcolor = "#F6F6F6"; %>
							<td class="<%= fontColor %>">
							<% if(text[i].equals("")){ %>
								<%= i %>
							<% }else{ %>
								<%= text[i] %>
							<% } %>
							</td>
					<% lineCursor++; %>
						<% if(lineCursor==7 && i!=endDay){ %>
							</tr>
							<tr class="week second-week">
						<% lineCursor = 0; }  %>
					<% } %>
					<% while( lineCursor>0 && lineCursor<7){ %>				
						<td></td>
					<% lineCursor++; } %>
					</tr>
					
				</table>
			</div>

			<div class="daily-schedule clearfix">
				<div class="title">
					<span>일별 스케쥴</span>
				</div>
				<ul class="schedule first">
					<% 
					Calendar cimCal = Calendar.getInstance();
					%>
					<% for(int i = 0; i < listCIM.size(); i++){ 
						if(i % 2 == 0 || i == 0){
							cimCal.set(year, month-1, Integer.parseInt(listCIM.get(i).getCalStartDate().substring(8, 10)));
					%>
					<li>
						<div class="list clearfix">
							<div class="date">
								<p class="week"><%= listCIM.get(i).getCalStartDate().substring(8, 10) %></p>
								<p><%= arrWeek[cimCal.get(Calendar.DAY_OF_WEEK)-1] %> -</p>
							</div>
							<div class="title">
								<a target="_blank" href="<%= listCIM.get(i).getCalContent() %>"><span><%= listCIM.get(i).getCalTitle() %></span></a>
								<p>시간 : <%= listCIM.get(i).getCalTime() %> 장소 : <%= listCIM.get(i).getCalPlace() %></p>
							</div>
							<div class="d-day">
								<% if(listCIM.get(i).getCalDday().equals("D+0")){
									listCIM.get(i).setCalDday("D-DAY");
								} %>
								<span><%= listCIM.get(i).getCalDday() %></span>
							</div>
						</div>
					</li>
					<%
						}
					} %>
				</ul>
				<ul class="schedule">
					<% for(int i = 0; i < listCIM.size(); i++){ 
						if(i % 2 == 1 && i != 0){
							cimCal.set(year, month-1, Integer.parseInt(listCIM.get(i).getCalStartDate().substring(8, 10)));
					%>
					<li>
						<div class="list clearfix">
							<div class="date">
								<p class="week"><%= listCIM.get(i).getCalStartDate().substring(8, 10) %></p>
								<p><%= arrWeek[cimCal.get(Calendar.DAY_OF_WEEK)-1] %> -</p>
							</div>
							<div class="title">
								<a target="_blank" href="<%= listCIM.get(i).getCalContent() %>"><span><%= listCIM.get(i).getCalTitle() %></span></a>
								<p>시간 : <%= listCIM.get(i).getCalTime() %> 장소 : <%= listCIM.get(i).getCalPlace() %></p>
							</div>
							<div class="d-day">
								<% if(listCIM.get(i).getCalDday().equals("D+0")){
									listCIM.get(i).setCalDday("D-DAY");
								} %>
								<span><%= listCIM.get(i).getCalDday() %></span>
							</div>
						</div>
					</li>
					<%
						}
					} %>
				</ul>
				
			</div>
		</div>

	</section>

	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>