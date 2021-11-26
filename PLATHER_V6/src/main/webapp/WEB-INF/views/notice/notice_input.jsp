<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
@charset "UTF-8";

#notice_input {
	padding: 50px;
	padding-top: 130px;
	line-height: 30px;
	width: 80%;
	margin: 0 auto;
	min-height: calc(100vh - 30px);
}

#notice_input div {
	white-space: nowrap;
}

#notice_input h2 {
	margin: 20px;
}

fieldset {
	padding: 10px;
}

label {
	display: inline-block;
	width: 20%;
	text-align: right;
	margin: 5px 30px 5px 0px;
	padding: 10px;
	white-space: nowrap;
}

input {
	width: 70%;
	padding: 8px;
	outline: 0;
}

button {
	background-color: #91c788;
	border: 0px;
	border-radius: 5px;
}

span.nickname {
	font-weight: 800;
}

textarea {
	width: 70%;
	margin-left: 4px;
	resize: none;
	overflow-y: scroll;
}

.list_buttons {
	text-align: right;
	padding: 20px;
	margin-right: 7%;
}

div.list_buttons button {
	padding: 5px 10px;
	margin-top: 10px;
	cursor: pointer;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/include/include_header.jspf"%>

	<form id="notice_input" method="POST">
		<fieldset>
			<h2>공지사항 등록하기</h2>

			<div>
				<label>공지제목</label> <input id="n_title" name="n_title"
					value="${NT.n_title}" />
			</div>
			<div>
				<label>작성자</label><span class="nickname">${MEMBER.m_nickname}</span>
			</div>
			<div>
				<label></label>
				<textarea id="n_content" name="n_content" cols="50" rows="10"
					placeholder="내용을 입력하세요">${NT.n_content}</textarea>
			</div>
			<div class="list_buttons">
				<button id="save" type="button">💾 저장</button>
				<button id="reset" type="reset">↺ 다시작성</button>
			</div>
		</fieldset>
	</form>

	<%@include file="/WEB-INF/views/include/include_footer.jspf"%>
</body>
<script>
document.querySelector("form#notice_input").addEventListener("keydown",(e)=>{
	
	if (e.keyCode === 13) {
		e.preventDefault()
	}
})
	document.querySelector("form#notice_input button#save").addEventListener("click",(e)=>{
		let n_title = document.querySelector("#n_title")
		let n_content = document.querySelector("#n_content")
		if(n_title.value === ""){
			alert("제목을 입력하세요")
			n_title.focus()
			return false;
		}
		if(n_content.value === ""){
			alert("내용을 입력하세요")
			n_content.focus()
			return false;
		}
		document.querySelector("form#notice_input").submit()

})
	
</script>
</html>