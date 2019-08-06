<%@page import="model.UserInfoModel"%>
<%@page import="java.util.List"%>
<%@page import="model.DebateInfoModel"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	UserInfoModel userInfo = (UserInfoModel) session.getAttribute("userInfo");
	int uiNo = -1;
	String diAuthor = "";
	if(userInfo!=null) {
		uiNo = userInfo.getUiNo();
		diAuthor = userInfo.getUiName();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>
<meta name="viewport" content="user-scalable=no, initial-scale=1.0, width=1920-width">
<link rel="shortcut icon" type="image/x-icon" href="fabicon.ico" />

 <meta property="og:title" content="AELF">
 <meta property="og:image" content="img/og_thumbnail.jpg">
 <meta property="og:url" content="http://www.aelfkorea.io">
<meta name="description" content="AELF">

<script type="text/javascript" src="js/HuskyEZCreator.js" charset="utf-8"></script> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->
<link rel="stylesheet" href="admin.css">

<script type="text/javascript">

function onSubmit(){
	oEditors.getById["ir1"].exec("UPDATE_CONTENTS_FIELD", []);
	
	var title = document.getElementById('di_title').value;
	var content = document.getElementById('ir1').value;
	
	if(title == ""){
		alert("제목을 입력하세요.");
		return false;
	}
	
	if(content == ""){
		alert("내용을 입력하세요.");
		return false;
	}
	
	if(confirm("이대로 신청하시겠습니까?")==false)
		return false;
	
}

</script>

</head>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>

        <div class="notice-wrap">
        <div class="notice">           
            
            <div class="notice-list-wrap" style="background-color: #ffffff;">
            <div style="width: 100%; height: auto; clear: both; padding-top: 20px;">
                <h4 style="padding-left: 20px;">토론 신청</h4>
                <form action="debate.lf" method="post" onsubmit="javascript:return onSubmit()">
                	<input type="hidden" name="mode" value="add_debate" />
                	<input type="hidden" name="ui_no" value="<%=uiNo %>" />
                	
	                <table style="width: 950px; table-layout: fixed; margin: 0 auto;">
						<tr style="border-bottom: 1px solid lightgray;">
							<td style="width: 150px;">작성자</td>
							<td style="width: 800px;"><input type="text" readonly="readonly" class="input-style" value="<%=diAuthor %>" id="di_author" name="di_author" /></td>
						</tr>
						<tr style="border-bottom: 1px solid lightgray;">
							<td style="width: 150px;">제목</td>
							<td style="width: 800px;"><input type="text" class="input-style" id="di_title" name="di_title"  /></td>
						</tr>
						<tr style="border-bottom: 1px solid lightgray;">
							<td style="width: 150px;">내용</td>
							<td style="width: 800px;"><textarea rows="10" cols="30" id="ir1" name="content" style="width:100%; height:412px; "></textarea></td>
						</tr>
						<tr height="50px;">
							<td colspan="2">
								<button type="submit" class="btn-default" style="width: 50px; height: 30px;">등록</button>&nbsp;&nbsp;
								<button type="button" class="btn-default" style="width: 50px; height: 30px;" onclick="javascript:location.href='debate.lf?menu=debate&mode=list'">취소</button>
							</td>
						</tr>
					</table>
				</form>
				</div>
            </div>
        </div>
    </div>
    
    <jsp:include page="../footer.jsp"></jsp:include>
    
<script type="text/javascript"> 
var oEditors = []; 
$(function(){ 
	nhn.husky.EZCreator.createInIFrame({ 
		oAppRef: oEditors, 
		elPlaceHolder: "ir1", //SmartEditor2Skin.html 파일이 존재하는 경로 
		sSkinURI: "SmartEditor2Skin.html",	
		htParams : { 
			// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseToolbar : true,	
			// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseVerticalResizer : true,	
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
			bUseModeChanger : true,	
			fOnBeforeUnload : function(){ 
				
			} 
		}, 
		fOnAppLoad : function(){ 
			//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용 
			oEditors.getById["ir1"].exec("PASTE_HTML", [""]); 
		}, 
		fCreator: "createSEditor2" 
	}); 
}); 
</script>

</body>
</html>