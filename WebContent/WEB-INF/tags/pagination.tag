<%@ tag pageEncoding="UTF-8" %>
<%@ attribute name="actionName"
    description="Tên của hành động"
    rtexprvalue="true" type="java.lang.String"%>
<%@ attribute name="count"
    description="Tổng số lượng đối tượng cần hiển thị" required="false" 
    rtexprvalue="true" type="java.lang.Long"%>
<%@ attribute name="currentStart"
    description="Trang hiện tại" required="false" 
    rtexprvalue="true" type="java.lang.Long"%>    
<%@ attribute name="pageSize"
    description="Số đối tượng hiển thị trong 1 trang" required="false" 
    rtexprvalue="true" type="java.lang.Integer"%>
<%@ attribute name="additionalParams"
    description="Tham số bổ sung cho liên kết, đã được mã hoá URL" required="false" 
    rtexprvalue="true" type="java.lang.String"%>
<%@ include file="/includes/common.jsp"%>

<c:if test="${empty actionName}">
    <c:set var="actionName" value="${action.descriptor.name}"></c:set>
</c:if>

<c:if test="${empty count}">
    <c:set var="count" value="${action.count}"></c:set>
</c:if>

<c:if test="${empty currentStart}">
    <c:catch var="startEx">
        <c:set var="currentStart" value="${action.start}"></c:set>
    </c:catch>
    <c:if test="${not empty startEx}">
        <c:set var="currentStart" value="0"></c:set>
    </c:if>
</c:if>

<div class="pagination">
<c:if test="${empty pageSize}">
    <c:set var="pageSize" value="20"></c:set>
</c:if>
<c:set var="pageCount" value="${u:floor(count%pageSize==0 ? count/pageSize : ((count-(count%pageSize))/pageSize)+1)}"></c:set>
<c:choose>
	<c:when test="${count > pageSize}">
	   <ul>
			<c:if test="${(currentStart > 0)}">
				<li><ocw:actionLink name="${actionName}" encodedParams="${additionalParams}">
					<ocw:param name="start" value="0"/>
					Đầu
				</ocw:actionLink></li>
			</c:if>
			<c:if test="${(currentStart > 0)}">
				<li><ocw:actionLink name="${actionName}" encodedParams="${additionalParams}">
					<ocw:param name="start" value="${currentStart-pageSize}"/>
					Trước
				</ocw:actionLink></li>
			</c:if>
			<c:choose>
				<c:when test="${pageCount < 6}">
					<c:forEach begin="1" end="${pageCount}" var="i">
				   		<c:choose>
				   			<c:when test="${currentStart == ((i-1)*pageSize)}">
	                            <li class="currentPage"><ocw:actionLink name="${actionName}" encodedParams="${additionalParams}">
	                                <ocw:param name="start" value="${(i-1)*pageSize}"/>
	                                ${i}                
	                            </ocw:actionLink></li>
							</c:when>
							<c:otherwise>
								<li><ocw:actionLink name="${actionName}" encodedParams="${additionalParams}">
									<ocw:param name="start" value="${(i-1)*pageSize}"/>
									${i}				
								</ocw:actionLink></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<c:forEach begin="${((currentStart/pageSize+1-2)>0)?(currentStart/pageSize+1-2):1}" 
								end="${((currentStart/pageSize+1+2)<pageCount)?(currentStart/pageSize+1+2):pageCount}" var="i">
					    <span>
					   		<c:choose>
					   			<c:when test="${currentStart == ((i-1)*pageSize)}">
	                                <li class="currentPage"><ocw:actionLink name="${actionName}" encodedParams="${additionalParams}">
	                                    <ocw:param name="start" value="${(i-1)*pageSize}"/>
	                                    ${i}                
	                                </ocw:actionLink></li>
								</c:when>
								<c:otherwise>
									<li><ocw:actionLink name="${actionName}" encodedParams="${additionalParams}">
										<ocw:param name="start" value="${(i-1)*pageSize}"/>
										${i}				
									</ocw:actionLink></li>
								</c:otherwise>
							</c:choose>
					    </span>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<c:if test="${currentStart < ((pageCount-1)*pageSize)}">
				<li><ocw:actionLink name="${actionName}" encodedParams="${additionalParams}">
					<ocw:param name="start" value="${currentStart+pageSize}"/>
					Sau
				</ocw:actionLink></li>
			</c:if>	
			<c:if test="${currentStart < ((pageCount-1)*pageSize)}">
				<li><ocw:actionLink name="${actionName}" encodedParams="${additionalParams}">
					<ocw:param name="start" value="${((pageCount-1)*pageSize)}"/>
					Cuối				
				</ocw:actionLink></li>
			</c:if>	
		</ul>
		<div class="clear"></div>
	</c:when>
</c:choose>
</div>