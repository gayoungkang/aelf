<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AELF</title>
<meta name="viewport"
	content="user-scalable=no, initial-scale=1.0, width=1920-width">
<link rel="shortcut icon" type="image/x-icon" href="fabicon.ico" />

<meta property="og:title" content="AELF">
<meta property="og:image" content="img/og_thumbnail.jpg">
<meta property="og:url" content="http://www.aelfkorea.io">
<meta name="description" content="AELF">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="aelf-css.css">
<!-- 스타일시트 -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/earlyaccess/notosanskr.css">
<!-- 노토산스 웹폰트 -->

</head>
<body>

	<jsp:include page="../main_top.jsp"></jsp:include>

	<section class="team-pg">
		<div class="content">
			<div class="title">
				<h1>aelf Korea</h1>
			</div>
			<ul class="list clearfix">
				<li>
					<div class="img img1">
						<img class="hover" src="./img/team-hover.png" alt="호버이미지" />
					</div>
					<div class="text">
						<div class="title">
							<h2>JB Lee</h2>
							<p>MIT 공학 석사, McKinsey &amp; Company 에서 컨설턴트로 활약. 새로운 프로젝트 또는
								기업체의 구조 구축과 설계, 그리고 Business Development를 포함한 다방면의 운영에 전문화 되어있음.
							</p>
						</div>
					</div>
				</li>
				<li>
					<div class="img img2">
						<img class="hover" src="./img/team-hover.png" alt="호버이미지" />
					</div>
					<div class="text">
						<div class="title">
							<h2>Dasol Lee</h2>
							<p>University of Toronto 화학과 졸업 후 IT 스타트업에서 매니저로 활약. 운영, 경영 및
								Business deveopment 등 스타트업에 특화된 다양한 경험이 풍부함. 엘프코리아 브랜딩 관리 및 마케팅
								담당.</p>
						</div>
					</div>
				</li>
				<li>
					<div class="img img3">
						<img class="hover" src="./img/team-hover.png" alt="호버이미지" />
					</div>
					<div class="text">
						<div class="title">
							<h2>GM Chung</h2>
							<p>국민대학교 졸업. 엘프코리아의 막내. 재학중 블록체인에 관심을 가지게 되었으며, 오랜 기간의 커뮤니티
								활동을 통해 한국 크립토 마켓의 환경과 트렌드에 능숙하고 투자자로써의 입장과 관심 포인트 이해도가 높음.</p>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</section>

	<jsp:include page="../footer.jsp"></jsp:include>

</body>
</html>