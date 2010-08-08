<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/includes/common.jsp" %>

<script>

function validateName() {
	var txtName = $('te_name');
	var msgName = $('msgName');

	if (txtName.value == '') {
		msgName.innerText = 'Bạn cần nhập tên.';
		msgName.style.display = 'block';
		return false;
	}
	
	msgName.style.display = 'none';
	return true;
}

</script>

<form id="form_edit" action="${scriptPath}" method="get">

	<input type="hidden" name="action" value="test.edit"></input>
	<input type="hidden" name="te_id" value="${test.id}"></input>
	
	<p>
	   <label>Tên: <input type="text" name="te_name" 
			value="${(empty param.te_name) ? test.name : param.te_name}"></input></label>
		<span id="msgName" style='${(empty nameErr) ? "none" : "block"}'>${nameErr}</span>
	</p>
	<c:if test="${not empty action.nameError}">
	   <div class="error-validating">${action.nameError}</div>
	</c:if>
	<br></br>
	
	<p>
	   <label>Mô tả: <textarea name="te_description">
	       ${(empty param.te_name) ? test.description : param.te_description}
	   </textarea></label>
	</p>
    <br></br>

    <p><label>Chủ đề:
            <input type="text" id="txtTopicName" name="te_topicname" 
                    value="${empty param.te_topicname ? test.topic.name : param.te_topicname}"></input>
            </label>
            <input type="hidden" id="txtTopicId" name="te_topic" 
                     value="${empty param.te_topic ? test.topic.id : param.te_topic}"></input>
            <span style="color:red">${topicErr}</span>
    </p>
    <c:if test="${not empty action.topicError}">
       <div class="error-validating">${action.topicError}</div>
    </c:if>
    <br></br>

    <p>Kiểu:
        <p><label>
            <input type="radio" name="te_type" value="radio"
                    ${(empty param.te_type && test.type=='radio') || param.te_type=='radio' ? "checked":""}>
            Một câu đúng 
        </label>
        </p>
        <p><label>
            <input type="radio" name="te_type" value="check"
                    ${((empty param.te_type && test.type=='check') || param.te_type=='check') ? "checked":""}>
            Nhiều câu đúng 
        </label>
        </p>
    </p>
    <c:if test="${not empty action.typeError}">
       <div class="error-validating">${action.typeError}</div>
    </c:if>
    <br></br>
    
    <p><label>Thời gian
        <input type="text" id="txtTime" name="te_time" 
                value="${(empty param.te_time)? test.time : param.te_time}"
                maxlength="3"></input>
    </label>
    </p>
    <c:if test="${not empty action.timeError}">
       <div class="error-validating">${action.timeError}</div>
    </c:if>
    <br></br>
	
	<p>
	   <button type="submit" name="te_submit" value="update">Lưu</button>
	   <button type="button" onclick="location.href='${scriptPath}?action=test.view&tv_id=${test.id}'">Thôi</button>
	</p>

</form>

<script type="text/javascript">
<!--
filterNumericKey('txtTime');

new Autocomplete('txtTopicName', {
    serviceUrl : '${scriptPath}?action=testtopic.ajaxsearch',
    minChars : 2,
    maxHeight : 400,
    width : 300,
    deferRequestBy : 100,
    autoSelect: true,
    // callback function:
    onSelect : function(value, data) {
        $('txtTopicId').value = data;
    }
});
//-->
</script>