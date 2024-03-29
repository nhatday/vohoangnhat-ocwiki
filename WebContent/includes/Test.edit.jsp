<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/includes/common.jsp" %>

<c:set var="resource" value="${empty resource ? action.resource : resource}" scope="request"></c:set>
<c:set var="test" value="${empty article ? action.article : article}" scope="request"></c:set>

<h3>Sửa ${test.namespace.name}:<jsp:include page="/includes/article.edit.name.jsp"></jsp:include></h3>

<c:set var="i" value="1"></c:set>

<div id="Test-Time">
	Thời gian làm bài:
	<input type="text" id="Test-Time-Edit" value="${test.time}">
	(phút)
</div>

<div id = "Test-Content">
	<textarea rows="5" cols="60" style="width: 100%" id="Test-content-${test.id}">${empty test.content.text ? 'Không có nội dung' : test.content}</textarea>
	<script type="text/javascript">
		Editor.preview('Test-Content');
	</script>	
</div>

<div>
	<c:set var="indexsection" value="0"></c:set>
	<input type="hidden" id="id-question-add" name="taq_question" 
					value="${param.taq_question}">
	<c:forEach items="${test.sections}" var="section">
		<div id = "section-${indexsection}" >
			<div class = "section-wrapper mouse-out"
					onmouseover="this.removeClassName('mouse-out'); this.addClassName('mouse-in');" 
			                onmouseout="this.removeClassName('mouse-in'); this.addClassName('mouse-out');">
				<div class="buttons">
			     	<img alt="" src="${templatePath}/images/wrong.png" onclick="del_section(${indexsection})">
			    </div>
			    <div id ="section-edit-name-${indexsection}">
					<textarea rows="5" cols="80" style="width: 100%" class="mceNoEditor" 
					       id = "section-content-${indexsection}">${section.content.text}</textarea>
					<script type="text/javascript">
						Editor.preview('section-edit-name-${indexsection}');
					</script>
				</div>			
				<br>
		    </div>
			<p></p>
			<c:set var="indexquestion" value="0"></c:set>
			<c:forEach items="${section.questions}" var="question">
				<div id="Delete-question-id${i}" class="question-wrapper mouse-out"
		                onmouseover="this.removeClassName('mouse-out'); this.addClassName('mouse-in');" 
			                onmouseout="this.removeClassName('mouse-in'); this.addClassName('mouse-out');">
					<div class="question">			    
				        <div class="question-number-wrapper">
							<div id = "${question.id}" style="margin-right: 10px">
								<b><ocw:articleLink resource="${question.baseContainer}" id ="Qnum-${question.id}">Câu ${i}</ocw:articleLink></b>
								<input type="text" class="markInput" id ="Mark-${question.id}" value = "${question.mark}" onblur="SpanOnclick(${indexsection}, ${indexquestion},${question.id})">
								<script type="text/javascript">
									Editor.previewTextField('${question.id}');
								</script>
				            </div>
				        </div>
				        <div class="buttons">
					     	<img alt="" src="${templatePath}/images/wrong.png" onclick="del(${indexsection},${indexquestion},${i})">
					     </div>
				        <div class="question-content-wrapper">${question.content}</div>
						<div>
				             <c:set var="j" value="0" />
				             <div class="choice-list-wrapper">
				             <c:forEach items="${question.choices}" var="choice">
				                <div class="choice-wrapper">
				                     <div class="number-wrapper">
				                        <b>${u:alpha(j)}</b>.
				                     </div>
				                     <div>${choice.content}</div>
				                     <c:set var="j" value="${j+1}" />
				                 </div>
				             </c:forEach>
				             </div>
				        </div>
					</div>			 
				</div>
				<c:set var="i" value="${i+1}"></c:set>
				<c:set var="indexquestion" value="${indexquestion+1}"></c:set>
			</c:forEach>
			<div id ="add-section-${indexsection}"></div>
			<form>
				<button type="submit" onclick="Add_question(${indexsection}); return false;">Thêm</button>
				<input type="text" id="id-question-add-${indexsection}"></input>
				<span id = "Message-${indexsection}"></span>
			</form>
			<c:set var="indexsection" value="${indexsection+1}"></c:set>
			<p>
		</div>
	</c:forEach>
	<div id="Add_Section_edit">
	</div>
	<button type="button" onclick = "AddSection()">Thêm Section</button>
	<textarea rows="" cols="80" id = "test_edit_sectioncontent"></textarea>
	<%@ include file="article.edit.topic.jsp" %>
</div>

<ocw:setJs templateVar="QuestionTempl">
	<div id="Delete-question-id\#{lastQuestionTest}" class="question-wrapper mouse-out"
               onmouseover="this.removeClassName('mouse-out'); this.addClassName('mouse-in');" 
                onmouseout="this.removeClassName('mouse-in'); this.addClassName('mouse-out');">
		<div class="question-number-wrapper">
            <div id = "\#{question.id}" style="margin-right: 10px">
				<b><a href="\#{link}" id = "Qnum-\#{question.id}">Câu \#{lastQuestion}</a></b>
	            <input type="text" id ="Mark-\#{question.id}" value = "\#{question.mark}" onblur="SpanOnclick(\#{indexsection}, \#{indexquestion},\#{question.id})">
				<script type="text/javascript">
					Editor.previewTextField('\#{question.id}');
				</script>
            </div>
        </div>
        <div class="buttons">
	     	<img alt="" src="\#{templatePath}/images/wrong.png" onclick="del(\#{indexsection},\#{indexquestion},\#{lastQuestionTest})">
	    </div>
        <div class="question-content-wrapper">\#{question.baseResource.article.content.text}</div>
		<div>
             <c:set var="j" value="0" />
             <div class="choice-list-wrapper" id="add-\#{lasQuestionTest}">
             	\#{choices}
             </div>
         </div>
	</div>
</ocw:setJs>

<ocw:setJs templateVar="DelTemplate">
    <div id="question\#{index}-deleted" style="text-align: center;">
        Câu hỏi đã bị xoá.
        <a href="#" onclick="undeleteQuestion(\#{indexsection},\#{indexquestion},\#{index}); return false;">Phục hồi</a>
    </div>
</ocw:setJs>

<ocw:setJs templateVar="AnswerTempl">
	<div class="choice-wrapper">
        <div class="number-wrapper">
           <b>\#{oder_ans}</b>.
        </div>
        <div>\#{content}</div>
    </div>
</ocw:setJs>

<ocw:setJs templateVar="SectionTempl">
	<div id="section-\#{indexsection}">
		<div  class = "section-wrapper mouse-out"
				onmouseover="this.removeClassName('mouse-out'); this.addClassName('mouse-in');" 
		                onmouseout="this.removeClassName('mouse-in'); this.addClassName('mouse-out');">
			<div class="buttons">
		     	<img alt="" src="\#{templatePath}/images/wrong.png" onclick="del_section(\#{indexsection})">
		    </div>
		    <div id ="section-edit-name-\#{indexsection}">
				<textarea rows="" cols="" id = "section-content-\#{indexsection}">\#{section_content}</textarea>
				<script type="text/javascript">
					Editor.preview('section-edit-name-\#{indexsection}');
				</script>
			</div>
		</div>
		<div id ="add-section-\#{indexsection}"></div>
		<form>
			<button type="submit" onclick="Add_question(\#{indexsection}); return false;">Thêm</button>
			<input type="text" id="id-question-add-\#{indexsection}"></input>
			<span id = "Message-\#{indexsection}"></span>
		</form>
	</div>
</ocw:setJs>

<ocw:setJs templateVar="DelSection">
	<div id="section-\#{indexsection}-deleted" style="text-align: center;">
        Section đã bị xoá.
        <a href="#" onclick="undeleteSection(\#{indexsection}); return false;">Phục hồi</a>
    </div>
</ocw:setJs>

<script type="text/javascript"><!--
	var test = resource.article;
	var lastQuestion = ${i};
	var indexsection = ${indexsection};
	var st_char='ABCDEFGHIJKLMNOPQRSTUVWXYZ';

	Event.observe(window, 'load', function() {
        for(i = 0;i<test.sections.length;i++){
            new Autocomplete('id-question-add-' + i, {
                serviceUrl : apiPath + '/question.search?format=qcount',
                minChars : 2,
                maxHeight : 400,
                width : 300,
                deferRequestBy : 100,
                // callback function:
                onSelect : function(value, data,id) {
                    $('id-question-add').value = data;
                }
            });
        }
	});
	
	function Show(){
		alert($F('section'));
	}
	
	//Del question Order
	function del(indexsection,indexquestion,index){
		var data={"indexsection":indexsection,"indexquestion":indexquestion,"index": index}; 
		var element=$('Delete-question-id' + index);
		var question_id = test.sections[indexsection].questions[indexquestion].id;
		element.insert({after: DelTemplate.evaluate(data)});
		element.hide();
		test.sections[indexsection].questions[indexquestion].deleted=true;
		Khoiphuc(question_id);
	}
	
	//Xoa bo lua chon del
	function undeleteQuestion(indexsection,indexquestion,index){
		var element=$('question'+index+'-deleted');
		var deleted=$('Delete-question-id' + index);
		deleted.show();
		element.remove();
		test.sections[indexsection].questions[indexquestion].deleted=false;
		var question_id = test.sections[indexsection].questions[indexquestion].id;
		Khoiphuc(question_id);
	}
	
	function search_question(){
		
	}
	
	function Add_question(Nosection){
		var sec_length = test.sections.length;
		var ques_length;
		if (test.sections[Nosection].questions != null) ques_length = test.sections[Nosection].questions.length + 1;
		else {
			ques_length = 1;
			test.sections[Nosection].questions = new Array();
		}
		var id_question_add = 'id-question-add-' + Nosection;
		var questionId = $F('id-question-add');
		var mark = parseFloat('1.0');
		if (checkId(questionId)){
			$('Message-' + Nosection).innerHTML = 'Câu hỏi đã tồn tại trong bài kiểm tra!';
			return;
		}
		else{
			$('Message-' + Nosection).innerHTML = '';
		}
		WebService.get('/questions/' + $F('id-question-add'),{
		  onSuccess : function(transport) {
			  question = transport.responseJSON.result;
			  var question_of_section = {"id":questionId,"baseResource":{"article":question,"id": questionId},"mark":mark};
		      var choice = question.choices;
		      var section = test.sections[Nosection];
		      var add_question='add-section-'+Nosection;
		      var choices='';
		      var lienket = 'http://localhost:8080/tracnghiem/article/' + questionId;
		      for(index=0;index<choice.length;index++){
			      var content = choice[index].content.text;
			      var u_index = st_char.charAt(index);
			      var dt = {"content":content,"oder_ans":u_index};
				  choices+=AnswerTempl.evaluate(dt);
			      //$(id_add).insert({after: AnswerTempl.evaluate(dt)});
		      }
		      var data={"question":question_of_section,"lastQuestion":ques_length,
				      "indexsection":Nosection,"templatePath":templatePath,"choices":choices,"indexquestion": ques_length - 1,
				      "lastQuestionTest":lastQuestion,"link":lienket};
		      $(add_question).insert({before: QuestionTempl.evaluate(data)});
		      lastQuestion++;
		      test.sections[Nosection].questions[ques_length - 1] = question_of_section;
		      test.sections[Nosection].questions[ques_length - 1].deleted = false;
		      Khoiphuc(questionId);
		  },
		  onFailure: function(){ 
			  template.onFailure(transport);
		  } 
		});
	}

	// Save Test
	EditAction = Class.create();
	
	EditAction.preview = function(){
	}
	
	EditAction.save = function(successCallback, failureCallback){
		// Lay cac cau hoi cua test
		var i,j;
		var newtest;
		var newsection,section, IdSection;
		var length_sec = test.sections.length;
		var question_length;
		var newquestion;
		var content, name;
		var indexquestion = 0;
		var indexsection = 0;
		newsection =  new Array();
		for (i = length_sec - 1; i>=0 ; i--){
			var question_length = test.sections[i].questions.length;
			if (test.sections[i].deleted == true){
				test.sections.splice(i,1);
				continue;
			}

			for (j = question_length - 1; j >= 0 ; j--) {
				if (test.sections[i].questions[j].deleted == true){
					test.sections[i].questions.splice(j,1);
					test.sections[i].id = 0;
				} else {
					var q = test.sections[i].questions[j];
					test.sections[i].questions[j] = { id: q.id };
				}
			}

			question_length = test.sections[i].questions.length;
            if (question_length <= 0) {
                test.sections.splice(i,1);
                continue;
            }
			
            currentContent = getEditorContent('section-content-' + i);
			if (currentContent != test.sections[i].content.text) {
				test.sections[i].id = 0;
				test.sections[i].content = { "id": 0, "text": currentContent };				
			}
		}
		//test.sections = newsection;
		if (test.sections.length <= 0) delete test.sections;
		// Lay thong tin bai kiem tra
		content = tinymce.get('Test-content-' + test.id).getContent();
		if (test.content == null){
			test.content = {"text": content};
		}
		else test.content.text = content;

		// Sua ten bai kiem tra
		name = $('articleEdit-nameInput').value;
		test.name = name;

		// Luu thoi gian
		if (!isNumber($('Test-Time-Edit').value) || (parseInt($('Test-Time-Edit').value) <= 0)){
			$('articleEdit-error').innerHTML = 'Thời gian làm bài không hợp lệ';
			failureCallback();
			return;
		}
		test.time = parseInt($('Test-Time-Edit').value);
			
		// Sua cac chu de cua bai kiem tra
		if (test.topics == null) test.topics = new Array();
		for (i = 0; i < test.topics.length; i++){
			if (test.topics[i].deleted) test.topics.splice(i,1);
		}
		if (test.topics.length <= 0) delete test.topics;
		
		WebService.post('/tests/' + resourceId,
			    {
			      postBody: Object.toJSON({
			          article: test,
			          summary: $F('articleEdit-summary'),
			          minor: $('articleEdit-minor').checked
			      }),
			      onSuccess: successCallback,
			      onFailure: function(transport) {
			    	  var code = transport.responseJSON.code;
			          if (code == 'old version') {
			        	  $('articleEdit-error').innerHTML = 'Trùng phiên bản';
			          } 
				      if (code == 'test content is blank'){
			        	  $('articleEdit-error').innerHTML = 'Nội dung bài kiểm tra rỗng';
			          }
				      if (code == 'too little sections'){
					  	  $('articleEdit-error').innerHTML = 'Không có phần nào trong bài kiểm tra';
					  }
				      if (code == 'too little questions'){
					  	  $('articleEdit-error').innerHTML = 'Câu hỏi trong phần không có câu hỏi';
					  }
				      if (code == 'section content is blank'){
					  	  $('articleEdit-error').innerHTML = 'Có một phần trong bài kiểm tra không có nội dung';
					  }
				      if (code == 'question is empty'){
					  	  $('articleEdit-error').innerHTML = 'Câu hỏi rỗng';
					  }
				      if (code == 'mark must be positive'){
					  	  $('articleEdit-error').innerHTML = 'Điểm phải là số dương';
					  }
				      failureCallback();
			      }
			    });
	}

	function AddSection(){
		var section_content = tinymce.get('test_edit_sectioncontent').getContent();
		if (section_content == "") return;
		//var index = indexsection;
		var section_length;
		if (test.sections == null){
			section_length = 0;
			test.sections = new Array();	
		}
		else section_length = test.sections.length;
		var data = {"section_content": section_content,"indexsection":section_length, "templatePath":templatePath};
		var question_array = new Array();
		var newsection = {"content":section_content,"questions":question_array};
		test.sections[section_length] = newsection;
		//var st = SectionTempl.evaluate(data);
		//var is = '<h2>Hello</h2>';
		$('Add_Section_edit').insert({before: SectionTempl.evaluate(data)});//SectionTempl.evaluate(data)	
		new Autocomplete('id-question-add-' + section_length, {
	        serviceUrl : apiPath + '/question.search?format=qcount',
	        minChars : 2,
	        maxHeight : 400,
	        width : 300,
	        deferRequestBy : 100,
	        // callback function:
	        onSelect : function(value, data,id) {
				$('id-question-add').value = data;
	        }
	    });	
	}
	
	function SpanOnclick(indexsection, indexquestion, questionId){
		var id = 'Mark-' + questionId;
		//var DivId = id.substring(0,id.length - 2);
		if (!isNumber($(id).value)){
			//$(id).focus();
			return;
		}
		var mark = parseInt($(id).value);
		test.sections[indexsection].questions[indexquestion].mark = mark;
		//Editor.previewTextField('' + questionId);
	}
	
	function checkId(id){
		var i,j;
		for (i = 0; i<test.sections.length; i++)
			for (j = 0; j<test.sections[i].questions.length; j++){
				if (test.sections[i].questions[j].id == id ) return true;
			}
		return false;
	}
	
	function isNumber(num){
		var exp = /^[0-9]+(\.[0-9]+)?$/;
		if (exp.test(num)) return true;
		else return false;
	}
	
	function Khoiphuc(id){
		var i, j;
		var dem = 1;
		var ok = false;
		var id_ques;
		for (i = 0; i<test.sections.length; i++){
			if (test.sections[i].deleted) continue;
			for (j = 0; j< test.sections[i].questions.length; j++){
				if (test.sections[i].questions[j].id == id){
					ok = true;
				}
				if (!test.sections[i].questions[j].deleted){
					id_ques = 'Qnum-' + test.sections[i].questions[j].id;
					if (test.sections[i].questions[j].id != id){
						if (ok){
							$(id_ques).innerHTML = 'Câu ' + dem + ' ';
						}
					}
					else{
						$(id_ques).innerHTML = 'Câu ' + dem + ' ';
					}
					dem++;
				} 
			}
		}
	}
	
	function del_section(index){
		var data={"indexsection":index}; 
		var element=$('section-' + index);
		var sectionId = test.sections[index].id;
		element.insert({after: DelSection.evaluate(data)});
		element.hide();
		test.sections[index].deleted = true;
		KhoiphucSection(sectionId);
	}
	
	function undeleteSection(index){
		var element=$('section-'+index+'-deleted');
		var deleted=$('section-' + index);
		deleted.show();
		element.remove();
		test.sections[index].deleted=false;
		var section_id = test.sections[index].id;
		KhoiphucSection(section_id);
		
	}
	function KhoiphucSection(sectionId){
		var i, j;
		var dem = 1;
		var ok = false;
		var id_ques;
		for (i = 0; i<test.sections.length; i++){
			if (test.sections[i].id == sectionId) ok = true;
			if (test.sections[i].deleted) continue;
			for (j = 0; j< test.sections[i].questions.length; j++){
				if (!test.sections[i].questions[j].deleted){
					id_ques = 'Qnum-' + test.sections[i].questions[j].id;
					if (ok){
						$(id_ques).innerHTML = 'Câu ' + dem + ' ';
					}
					dem++;
				} 
			}
		}
	}
</script>