<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project PLATHER</title>
<link href="${rootPath}/static/css/play_detail.css?ver=2021-06-12-011"
	rel="stylesheet" />
	<script src="https://kit.fontawesome.com/fee19b09ec.js" crossorigin="anonymous"></script>
	<style>
		span#heart:hover{
			cursor:pointer;
		}
	</style>
</head>
<body>
	<%@include file="/WEB-INF/views/include/include_header.jspf"%>
	<div class="content">
		<div class="play">
			<h1>플레이리스트</h1>
			<table class="detail">
				<tr class="data_code" data-code="${BOARD_DETAIL.b_code}">
					<th colspan="3">${BOARD_DETAIL.b_title}</th>
					<th><fmt:formatDate pattern="yyyy-MM-dd"
							value="${BOARD_DETAIL.b_date}" /></th>
				</tr>
				<tr>
					<td colspan="3">조회수 : ${BOARD_DETAIL.b_hit}</td>
					<td>${BOARD_DETAIL.b_nick}</td>
				</tr>
				<tr>
					<td colspan="4">${BOARD_DETAIL.b_content}</td>
				</tr>
				<tr>
				 	
					<td>
					<span id="heart" data-id="${MEMBER.m_id}">
					<c:if test="${LIKE == '0'}"><i class="far fa-heart"></i></c:if>
					<c:if test="${LIKE == '1' }"><i class="fas fa-heart"></i></c:if>
					
					</span><span id="count">${BOARD_DETAIL.b_like}</span>
					</td>
					<!-- table모양 맞추려고 임시로 넣은 코드입니다 수정하셔도 상관없음(7/18 혜미) -->
					<td colspan="3"></td>
				</tr>
			</table>
			<div class="div_button">
				<button class="btn_back" type="button">뒤로가기</button>
				<c:if test="${BOARD_DETAIL.b_id == MEMBER.m_id}">
					<button class="btn_modify" type="button">수정</button>
					<button class="btn_delete" type="button">삭제</button>
				</c:if>
			</div>

		</div>

		<div class="songs">
			<h1>노래 목록</h1>
			<table class="song">
				<c:forEach items="${BOARD_DETAIL.playList}" var="play">
				<tr>
				<th>${play.s_title}</th>
				<th>${play.s_singer}</th>
				</tr>
				</c:forEach>
			</table>
		</div>
		<%@include file="/WEB-INF/views/include/include_comment.jspf"%>
	</div>

	<%@include file="/WEB-INF/views/include/include_footer.jspf"%>
</body>
<script>
//변수
const btn_back = document.querySelector("button.btn_back")
const btn_modify=document.querySelector("button.btn_modify")
const btn_delete=document.querySelector("button.btn_delete")
const b_code = document.querySelector("tr.data_code").dataset.code
const heart = document.querySelector("span#heart")
const count = document.querySelector("span#count")
const m_id = heart.dataset.id

//
btn_back.addEventListener("click",()=>{
	location.href="${rootPath}/board"
})
if(btn_modify && btn_delete){
	btn_modify.addEventListener("click",()=>{
		//alert(b_code)
		location.href="${rootPath}/board/modify?b_code="+b_code
	})
	
	btn_delete.addEventListener("click",()=>{
		location.href="${rootPath}/board/delete?b_code="+b_code
	})
}
//heart부분을 클릭할때 
heart.addEventListener("click",()=>{
	
	fetch("${rootPath}/board/like?l_id="+m_id+"&l_bcode="+b_code)
	.then((response) =>{return response.json()}).then((data)=>{
		console.log(data)
		const likeCnt =data.likeCnt
		if(data.result == 1){
			console.log("likeCnt = " +data.likeCnt)
			heart.innerHTML = "<i class='fas fa-heart'></i>"
			count.innerHTML = likeCnt	
		}else if( data.result == -1){
			heart.innerHTML = "<i class='far fa-heart'></i>"
			count.innerHTML = likeCnt
		}
		else{
			alert("다시 시도해주세요")
		}
	})
	
})
</script>
</html>