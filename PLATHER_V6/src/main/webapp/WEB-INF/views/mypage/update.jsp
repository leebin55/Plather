<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />

<link href="${rootPath}/static/css/update.css?ver=2021-07-19-027" rel="stylesheet" />
<%@include file="/WEB-INF/views/include/include_header.jspf"%>
<form class="update" method="POST">
	<fieldset>
		<legend>필수 회원정보</legend>
		<div>
			<label>이름</label> <input name="m_name" id="m_name"
				value="${MB_DETAIL.m_name}" />
		</div>
		<div>
			<label>ID</label> <input name="m_id" id="m_id" type="email"
				value="${MB_DETAIL.m_id}" readonly="readonly" />
		</div>
		<div id="nick_box">
			<label>닉네임</label> <input name="m_nickname" id="m_nickname"
				value="${MB_DETAIL.m_nickname}" />  
				<div class="nick error"></div>
		</div>
		<div id="pw_box">
			<label>비밀번호</label> <input name="m_pw" id="m_pw"
				value="${MB_DETAIL.m_pw}" type="password" />
				<div class="pw error"></div>
		</div>
		<div id="re_pw_box">
			<label>비밀번호 확인</label> <input type="password" id="re_pw" />
			<div class="re_pw error"></div>
		</div>


		<input name="m_birth" value="${MB_DETAIL.m_birth}" type="hidden" /> <input
			name="m_gender" value="${MB_DETAIL.m_gender}" type="hidden" /> <input
			name="m_profile" value="${MB_DETAIL.m_profile}" type="hidden" />

	</fieldset>
	<div class="btn_box">
		<button type="button" class="btn_update">🖉수정하기</button>
	</div>

</form>
<%@include file="/WEB-INF/views/include/include_footer.jspf"%>

<script>
	/* 사용할 변수 선언 */
	let form = document.querySelector("form.update")
	let btn_update = document.querySelector("button.btn_update")
	
	let input_nick = document.querySelector("input#m_nickname")
	let input_pw = document.querySelector("input#m_pw")
	let input_re_pw = document.querySelector("input#re_pw")
	
	/* 회원정보 수정시 오류 사항을 보여줄 빈 box */
	let msg_nick_error = document.querySelector("div.nick.error")
	let msg_pw_error = document.querySelector("div.pw.error")
	let msg_re_pw_error = document.querySelector("div.re_pw.error")
	
	/* 함수 선언 */
	// 닉네임
	let nick_f = ()=>{
		
		let user_nick = input_nick.value
		
		if(user_nick === "") {
			
			msg_nick_error.classList.remove("view_answer")
			
			msg_nick_error.innerText = "* 닉네임은 반드시 입력해야 합니다 *"
			msg_nick_error.classList.add("view")
			input_nick.focus()
			return false
		} else {
			
			fetch("${rootPath}/member/nick_check?m_nickname=" + user_nick)
		 	.then(response=>response.text())
		 	.then(result=>{
		 		
		 		msg_nick_error.classList.remove("view")
		 		msg_nick_error.classList.remove("view_answer")
		 		
		 	if(result === "USE_NICK") {
		 		
		 		msg_nick_error.innerText = " * 중복된 닉네임 입니다 * "
				msg_nick_error.classList.add("view")
				input_nick.focus()
				return false
		 		
		 	} else if(result === "NOT_USE_NICK") {
		 		
		 		msg_nick_error.innerText = " * 사용가능한 닉네임 입니다 * "
				msg_nick_error.classList.add("view_answer")
					return false
		 		
		 	}
		 		
		 	})// result end
			
		} // else end 

	}
	
	// 비밀번호
	let pw_f = () => {
		
		let user_pw = input_pw.value
		
		if(user_pw === "") {
			
			msg_pw_error.innerText = "* 비밀번호는 반드시 입력해야 합니다 *"
			msg_pw_error.classList.add("view")
			input_pw.focus()
			return false
			
		} else if(user_pw.length < 4 || user_pw.length > 10) {
			
			msg_pw_error.innerText = " * 비밀번호는 4이상 10이하만 가능 합니다 * "
			msg_pw_error.classList.add("view")
			
			input_pw.focus()
			return false
			
		} else {
			
			msg_pw_error.classList.remove("view")
			msg_pw_error.innerText = ""
			return false
			
		} // else end
	}	

	// 재 확인 비밀번호
	let re_pw_f = () => {
		
		let user_pw = input_pw.value
		let user_re_pw = input_re_pw.value
		
		if(user_re_pw ==="") {
			
			msg_re_pw_error.classList.remove("view")
			
			msg_re_pw_error.innerText = " * 비밀번호 재확인을 입력해주세요 * "
			msg_re_pw_error.classList.add("view")
			input_re_pw.focus()
			return false
			
		} else if(user_re_pw !== user_pw) {
		
		msg_re_pw_error.classList.remove("view_answer")
		
		msg_re_pw_error.innerText = " * 비밀번호가 불일치합니다 다시 확인해주세요 * "
		msg_re_pw_error.classList.add("view")
		input_re_pw.focus()
		return false
		
	} else {
		
		msg_re_pw_error.classList.remove("view")
		
		msg_re_pw_error.innerText = " * 비밀번호가 일치합니다 * "
		msg_re_pw_error.classList.add("view_answer")
		return false
		}
		
	}
	
	// 닉네임
	if(input_nick) {
		input_nick.addEventListener("keydown",nick_f)
	}
	
	// 비밀번호
	if(input_pw) {
		
		input_pw.addEventListener("keydown", pw_f)
			
	}
	
	// 재확인 비밀번호
	if(input_re_pw) {
		
		input_re_pw.addEventListener("keydown",re_pw_f)
	}
	
	
	
	// button 클릭시
	if(btn_update) {
		btn_update.addEventListener("click",()=>{
			
			let user_nick = input_nick.value
			let user_pw = input_pw.value
			let user_re_pw = input_re_pw.value
			
			if(user_nick === "") {
				nick_f();
				return false
				
			} else 	if(user_pw === "") {
				pw_f();
				return false
				
			} else if(user_re_pw === "") {
				re_pw_f();
				return false
			} 
			
			form.submit();
		})
	}
	
</script>
