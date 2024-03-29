<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="common.jsp" %>

<c:set var="resource" value="${empty resource ? action.resource : resource}"></c:set>
<c:set var="file" value="${empty article ? action.article : article}"></c:set>

<fieldset> 
<legend><b>Tải tệp tin</b></legend>
<table class="" id="uploadFile">
	<tbody>
	<tr>
	<td>
		<div id="file-uploader-demo1"></div>
	</td>
	<td><span id="progress"></span></td>
	</tr>
	<tr>
	<td>Kích thước tối đa: <b>10 MB</b></td>
	</tr>
	<tr>
	<td>Các định dạng cho phép: <b>png, gif, jpg, jpeg, svg.</b></td>
	</tr>
	</tbody>
	<tr>
	<td>
		<ocw:error code="file"></ocw:error>
		<span id="Error-Upload" style="color: red"></span>
	</td>
	</tr>
</table>
</fieldset>


<script src="${templatePath}/js/fileuploader.js" type="text/javascript"></script>
<script>        
    function createUploader(){            
        var uploader = new qq.FileUploader({
            element: document.getElementById('file-uploader-demo1'),
            action: restPath + '/upload/' + resourceId,
            sizeLimit: 10 * 1024 * 1024,   
            // gioi han cac duoi
            allowedExtensions: ['png', 'gif', 'jpg', 'jpeg', 'svg'],
            //'${ocw:restUrl("upload/123")}',
            onProgress: function(id, fileName, loaded, total){
            	$('Error-Upload').innerHTML = '';
                $('progress').innerHTML = loaded;
            },
            onComplete: function(id, fileName, responseJSON){
            },
            onCancel: function(id, fileName){},
         // Thong bao loi
            messages: {
                typeError: "File {file} có phần mở rộng không hợp lệ",
                sizeError: "{file} quá lớn, kích thước file tối đa là {sizeLimit}."        
            },
            showMessage: function(message) {
            	$('Error-Upload').innerHTML = message;
            }
        });           
    }
    
    // in your app create uploader as soon as the DOM is ready
    // don't wait for the window to load  
    //window.onload = createUploader;     
    Event.observe(window,'load',createUploader);
</script>    

<fieldset> 
<legend><b>File description</b></legend> 
<table>
	<tbody>
		<tr>
		<td><label>Tên tệp tin :</label></td>
		<td>
		<input id=name type="text" name="name" size="50" value="${file.name}">
		<div style="font-size: smaller; font-color: red" ><span>Tên của tệp tin sau khi tải lên.</span></div>
		</td>
		</tr>
		
		<tr>
		<td><label>Nguồn gốc tệp tin:</label></td>
		<td>
		<textarea id="fileSource" name="fileSource" cols="60" rows="1">${file.originalSource}</textarea>
		<div style="font-size: smaller;" ><span>Tập tin này từ đâu có?</span></div>
		</td>
		</tr>
		
		<tr>
		<td><label>Tác giả:</label></td>
		<td>
		<textarea id="author" name="author" cols="60" rows="1">${file.author}</textarea>
		<div style="font-size: smaller;" ><span>Ai tạo ra tập tin này? Ngoài ra, nếu nó là một tác phẩm nghệ thuật, ai đã tạo ra nó?</span></div>
		</td>
		</tr>
		
		<tr>
		<td><label>Thông tin thêm:</label></td>
		<td>
		<textarea id="additionalInfo" name="additionalInfo" cols="60" rows="1">${file.additionalInfo}</textarea>
		<div style="font-size: smaller;" ><span>Bạn có chú thích hay thông tin thêm về tệp tin này?</span></div>
		</td>
		</tr>
		
		<tr>
		<td><label>Bản quyền:</label></td>
		<td>
			<select name="license" id="license">
				<option selected="selected" value="UNKNOWN">Chưa chọn</option> 
				<option value="CC3">Giấy phép Creative Commons 3.0</option>  
				<option value="CC_SA3">Giấy phép Creative Commons - Share Alike 3.0</option> 
				<option value="GFPL">Giấy phép GNU Free Documentation License</option> 
				<option value="CC_SA3_GFDL">Kết hợp giấy phép CC-SA 3.0 và GFDL</option> 			 
				<option value="CREATIVE_COMMONS_ZERO_WAIVER">Giấy phép CC0 Waiver</option> 
				<option value="PUBLIC_DOMAIN">Không nắm giữ bản quyền</option>
			</select>
		</td>
		</tr>
	</tbody>
</table> 
</fieldset>

<script type="text/javascript">
<!--
	var file;
	Event.observe(window, 'load', function() {
		WebService.get('/files/' + resourceId,{
		    onSuccess : function(transport) {
				file = transport.responseJSON.result;
		    },
		    onFailure: function(transport){ 
		    	template.onFailure(transport); 
			}
		});
	});	
	EditAction=Class.create();

	EditAction.preview=function(){
	}
	
	EditAction.save = function(successCallback, failureCallback){
		// gửi dữ liệu lên server
		
		file.name = $F('name');
		file.originalSource = tinymce.get('fileSource').getContent();
		file.author = tinymce.get('author').getContent();
		file.additionalInfo = tinymce.get('additionalInfo').getContent();
		file.license = $F('license');
		file.dateOfWork = new Date();

		WebService.post('/files/' + resourceId,
				  {
				    postBody: Object.toJSON({
				          article: file,
				          summary: $F('articleEdit-summary'),
				          minor: $('articleEdit-minor').checked
				      }),
					onSuccess : successCallback,
				    onFailure: function(transport)
	                {
	                    var code = transport.responseJSON.code;
	                    if (code == 'old version') {
	                    	$('articleEdit-error').innerHTML = 'Có người đã sửa file này trước bạn, hãy tải lại trang!';
	                    } else {
		                    if(code == 'not upload yet')
		                    	$('articleEdit-error').innerHTML = 'Bạn phải tải tệp tin lên trước khi lưu!';
		                    else{
	                        	template.onFailure(transport); 
		                    }
	                    }
	                    failureCallback();
					}
				   });
		   return;
	};
//-->
</script>