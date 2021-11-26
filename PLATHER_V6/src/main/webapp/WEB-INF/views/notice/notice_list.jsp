<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project PLATHER</title>
<link href="${rootPath}/static/css/notice_list.css?ver=2021-07-21-001"
	rel="stylesheet" />
</head>
<body>
	<%@include file="/WEB-INF/views/include/include_header.jspf"%>
	<div class="content">
		<div class="notice">
			<div class="title">
				<p>공지사항</p>
				<c:if test="${MEMBER.m_level == '1'}">
					<button class="btn_input">등록</button>
				</c:if>
			</div>
			<table class="list">
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>조회수</th>
				</tr>
				<c:choose>
					<c:when test="${empty NOTICES}">
						<tr>
							<td colspan="5">데이터 없음</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${NOTICES}" var="NT" varStatus="i">
							<tr id="highlight" data-ncode="${NT.n_code}">
								<td>${i.index+1}</td>
								<td>${NT.n_title}</td>
								<td>${NT.n_nickname}</td>
								<td>${NT.n_date}</td>
								<td data-hit="${NT.n_hit}">${NT.n_hit}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
			<%@include file="/WEB-INF/views/include/include_pagination.jspf"%>
			<%@include file="/WEB-INF/views/include/include_search.jspf"%>
		</div>
	</div>
	<%@include file="/WEB-INF/views/include/include_footer.jspf"%>
</body>
<script>
	document.querySelector("table.list").addEventListener("click",(e)=>{
		
		let tagName = e.target.tagName
		if(tagName === "TD"){
			let tr = e.target.closest("TR")
			let n_code = tr.dataset.ncode
			location.href="${rootPath}/notice/detail?n_code=" + n_code
		}
	})
	const btn_input = document.querySelector("button.btn_input");
	if(btn_input){
		btn_input.addEventListener("click",(e)=>{
			location.href="${rootPath}/notice/input"
		})
	}
	
</script>
</html>