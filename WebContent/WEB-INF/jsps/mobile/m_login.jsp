<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String url = request.getParameter("url");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>
<meta name="description" content="AELF">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="js/jquery-ui.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-m-css.css"><!-- 스타일시트 -->
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/earlyaccess/notosanskr.css"><!-- 노토산스 웹폰트 -->
<link rel="stylesheet" href="//fonts.googleapis.com/earlyaccess/nanummyeongjo.css"><!-- 나눔명조 웹폰트 -->

<script type="text/javascript">


</script>

</head>
<body>

	<jsp:include page="./m_top.jsp"></jsp:include>
    
    <div class="notice-wrap sns-wrap" style="padding-bottom: 0;">
        
            <div class="sns-login-wrap">

                <div class="sns-login" onclick="javascript:facebookLogin()">
                    <img src="m-img/sns-fb.png" alt="" />
                    <p><span>페이스북</span> 계정으로 로그인</p>
                </div>
                <div class="sns-login" onclick="javascript:kakaoLogin()">
                    <img src="m-img/sns-kt.png" alt="" />
                    <p><span>카카오톡</span> 계정으로 로그인</p>
                </div>
                <!-- <div class="sns-login">
                    <img src="m-img/sns-tw.png" alt="" />
                    <p><span>트위터</span> 계정으로 로그인</p>
                </div> -->
                <div class="sns-login">
                    <img src="m-img/sns-nv.png" alt="" />
                    <p><span>네이버</span> 계정으로 로그인</p>
                </div>
                <div class="sns-login" id="googleLogin">
                    <img src="m-img/sns-gg.png" alt="" />
                    <p><span>구글</span> 계정으로 로그인</p>
                </div>

            </div>
            
    </div>
    
    <jsp:include page="./m_footer.jsp"></jsp:include>
    
    
<script type="text/javascript">

function loginCheck(email, name, gubun){

	var param = "mode=login&id="+encodeURIComponent(email)+"&name="+encodeURIComponent(name);
	
	$.ajax({
		type: "POST",
		url: 'login.lf',
		data: param,
		error: ajaxFailed,
		success: function(ret){
			
			if(ret == "[true]"){
				alert(gubun+" 아이디로 로그인 되었습니다.");
				location.href="main.lf";
			}
			else{
				location.href="login.lf?menu=signup&id="+encodeURIComponent(email)+"&name="+encodeURIComponent(name);	
			}
		}
	});	
} 

function ajaxFailed(xmlRequest){
	alert(xmlRequest.status+"\n\r"+xmlRequest.statusText+"\n\r"+xmlRequest.responseText);
}
</script>


<!-- 페이스북 -->
<script>
   window.fbAsyncInit = function() {
  FB.init({
    appId      : '403774836770239',  // 앱 ID
    status     : true,    // 로그인 상태를 확인
   // cookie     : false,    // 쿠키허용
    xfbml      : true     // parse XFBML
  });           
   };
 
   // Load the SDK Asynchronously
   (function(d){
   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
   if (d.getElementById(id)) {return;}
   js = d.createElement('script'); js.id = id; js.async = true;
   js.src = "//connect.facebook.net/ko_KR/all.js";
   ref.parentNode.insertBefore(js, ref);
    }(document));
   
   function facebookLogin() {
    FB.login(function(response) {
   FB.getLoginStatus(function(response) {   
    statusChangeCallback(response);
   });
    }, {scope: 'public_profile,email'});
   }

   function statusChangeCallback(response) {
   if (response.status === 'connected') {                 
    FB.api('/me?fields=id,name,email', function(user) {
     if (user) {
      //console.log(JSON.stringify(user));
      /*var image = document.getElementById('image');
      image.src = 'http://graph.facebook.com/' + user.id + '/picture';
      var name = document.getElementById('name');
      name.innerHTML = user.name
      var id = document.getElementById('id');
      id.innerHTML = user.id 
      var email = document.getElementById('email');
      email.innerHTML = user.email        
      //console.log(response.authResponse.accessToken);
      */
      loginCheck(user.email,user.name,"페이스북");
     }
    });      
   } else if (response.status === 'not_authorized') {     
   } else { }
   }
</script>


<!--카카오-->
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<script>  
 Kakao.init("1c778626456954737e6f06041ec1ee4b");
 
 function kakaoLogin(){
  Kakao.Auth.login({      
   success: function(authObj) {
    Kakao.API.request({
     url: '/v1/user/me',
     success: function(res) {
    	 
    	 console.log(res.id);
      
      if(res.kaccount_email=="" || res.kaccount_email==undefined){
    	  alert("이메일 정보제공을 동의해주세요.");
    	  return false;
      }
      
      loginCheck(res.kaccount_email, res.properties.nickname, "카카오톡");
     },
     fail: function(error) {
      console.log(error);
     }
    });
   },
   fail: function(err) {
    console.log(err);
   }
  });      
 }
</script>


<!-- 구글 -->
<script src="https://apis.google.com/js/api:client.js"></script>
<script>
  var googleUser = {};
  var startApp = function() {
    gapi.load('auth2', function(){
      // Retrieve the singleton for the GoogleAuth library and set up the client.
      auth2 = gapi.auth2.init({
        client_id: '810084313443-bebnhpsr4tjsapfq690nsa5scd9imnll.apps.googleusercontent.com',
        cookiepolicy: 'single_host_origin',
        // Request scopes in addition to 'profile' and 'email'
        scope: 'profile email'
      });
      attachSignin(document.getElementById('googleLogin'));
    });
  };

  function attachSignin(element) {   
    auth2.attachClickHandler(element, {},
  function(googleUser) {
   var profile = googleUser.getBasicProfile();
   
   console.log(profile);
   
   loginCheck(profile.getEmail(), profile.getName(), "구글");
  }, function(error) {
    //alert(JSON.stringify(error, undefined, 2));
  });
  }
</script>
<script>startApp();</script>
    
</body>
</html>