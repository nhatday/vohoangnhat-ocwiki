<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/includes/common.jsp" %>

<c:choose>

<c:when test="${u:size(action.textArticles) > 0}">

	<ocw:pagination actionName="${action.descriptor.name}"
		count="${action.count}" currentStart="${action.start}"></ocw:pagination>

	<div class="clear"></div>
	<div class="content-wrapper">
        <ul style="list-style: none;">
		<c:forEach items="${action.textArticles}" var="textArticle" >
			<li>
			     <ocw:articleLink resource="${textArticle}">${textArticle.name}</ocw:articleLink>
			</li>
		</c:forEach>
		</ul>
	</div>
	
</c:when>

<c:otherwise>
    <div class="empty-notif">
        Chưa có dữ liệu
    </div>
</c:otherwise>

</c:choose>