<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/includes/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>${pageTitle}</title>

    <link rel="stylesheet" href="${templatePath}/css/autocomplete.css" type="text/css" />
    <link rel="stylesheet" href="${templatePath}/css/calendarview.css" type="text/css" />
    <link rel="stylesheet" href="${templatePath}/css/main.css" type="text/css" />
    <link rel="stylesheet" href="${templatePath}/css/ddmenu.css" type="text/css" />
    <link rel="stylesheet" href="${templatePath}/js/windowjs/themes/default.css" type="text/css" />
    <link rel="stylesheet" href="${templatePath}/js/windowjs/themes/alphacube.css" type="text/css" />

	<script type="text/javascript" src="${templatePath}/js/prototype.js"></script>
	<!-- TODO dùng link này để tận dụng CDN của Google
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/prototype/1.6.1.0/prototype.js"></script>
	 -->
	<script type="text/javascript" src="${templatePath}/js/calendarview.js"></script>
	<script type="text/javascript" src="${templatePath}/js/autocomplete.js"></script>
	<script type="text/javascript" src="${templatePath}/js/tiny_mce/tiny_mce.js"></script>
	<script type="text/javascript" src="${templatePath}/js/scriptaculous.js"></script>
	<script type="text/javascript" src="${templatePath}/js/ddmenu.js"></script>
	<script type="text/javascript" src="${templatePath}/js/windowjs/javascripts/window.js"></script>
	<script type="text/javascript">
		tinyMCE.init({
		    mode : "textareas",
		    theme : "simple"
		});
	</script>
	
	<script type="text/javascript" src="${homeDir}/includes/common.js"></script>
	<script type="text/javascript" src="${templatePath}/js/main.js"></script>
	<script type="text/javascript">
	<!-- // initialize global variables
	   articlePath = '${config.articlePath}';
	   actionPath = '${config.actionPath}';
	   apiPath = '${config.apiPath}';
	   uploadPath = '${config.uploadPath}';
	   restPath = '${config.restPath}';
	   templatePath = '${templatePath}';
	   //login = false;
	   //login = ${sessionScope.login};
	//-->
	</script>
</head>
<body>
<div id="content">
<div class="headNav">
    &nbsp;
	<c:forEach items="${modules['top_right']}" var="module">
	<div class="top_right">
        <jsp:include page="modules/${module.page}"></jsp:include>
	</div>
	</c:forEach>
</div>
<!-- content begins -->
<div class="clear"></div>
<div id="main">
	<div id="right">
        <div id="logo">         
            <img src="${templatePath}/images/banner.jpg" alt="first" width="700"/>
            <!-- Computer Science Team -->
        </div>
    	<div id="menu">
			<ul>
				<li id="button1"><a href="${scriptPath}">Trang chủ</a></li>
				<li id="button2"><a href="${scriptPath}?action=test.list" title="">Đề thi</a></li>
				<li id="button3"><a href="${scriptPath}?action=teststruct.list" title="">Cấu trúc đề</a></li>
				<li id="button4"><a href="${scriptPath}?action=question.list" title="">Câu hỏi</a></li>
				<li id="button4"><a href="${scriptPath}?action=topic.list" title="">Chủ đề</a></li>
				<li id="button5"><a href="${scriptPath}?action=user.list" title="Danh sách thành viên" target="_self">Thành viên</a></li>
				<li id="button6"><a href="http://code.google.com/p/ocwiki/" target="_blank" title="">Giới thiệu</a></li>
			</ul>
		</div>
    	<div id="righttop">
    	</div>
    	<div class="clear"></div>
		<div class="rightbg">
            <c:if test="${not empty sessionScope.user.warningMessage}">
                <div class="notification">Bạn bị cảnh cáo với lí do: 
                     ${sessionScope.user.warningMessage}  
                </div>
            </c:if>

			<!-- ########################################## -->
			<!--  nội dung action được đặt ở đây -->
			<!-- ########################################## -->
			<c:catch var="ex">
				<jsp:include page="actions/${action.descriptor.name}.jsp" />
			</c:catch>
			<c:choose>
                <c:when test="${empty ex}">
	                <c:forEach items="${modules['action-bottom']}" var="item">
	                   <c:set var="module" scope="request" value="${item}"></c:set>
	                    <h3>${module.title}</h3>
	                    <div class="article-bottom">
	                        <jsp:include page="modules/${module.page}"></jsp:include>
	                    </div>
	                </c:forEach>
                </c:when>
                <c:otherwise>
					<h3 style="color:red">${ex}</h3>
                </c:otherwise>			
			</c:choose>
		</div>			
				
	</div>
	<div id="left">		
		<div id="header"></div>
		<div id="lefttop"></div>
 
	    <c:forEach items="${modules['left']}" var="item">
	       <c:set var="module" scope="request" value="${item}"></c:set>
	        <h3>${module.title}</h3>
            <div class="leftbg">
                <jsp:include page="modules/${module.page}"></jsp:include>
            </div>
			<div class="leftcenter"></div>
	    </c:forEach>
		
		</div>
    	<div id="mainbot"></div>
		<!--content ends -->
	<!--footer begins -->
	</div>

	<div id="footer">
		<p><a href="https://code.google.com/p/tracnghiem-csforce/">ocwiki v0.1</a>. 
		Copyright © 2010. Powered by CS Force</p>
	</div>
</div>
<!-- footer ends -->

<c:if test="${not empty action.descriptor.javaScript}">
<script type="text/javascript">
<!--
<jsp:include page="actions/${action.descriptor.javaScript}"></jsp:include>
//-->
</script>
</c:if>

</body>
</html>