<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project PLATHER</title>
<link href="${rootPath}/static/css/notice_list.css?ver=2021-07-20-001"
	rel="stylesheet" />
</head>
<body>
	<%@include file="/WEB-INF/views/include/include_header.jspf"%>
	<div class="content">
		<div class="notice">
			<div class="title">
				<p>"${TEXT}" 검색결과</p>
			</div>
			<table class="list">

				<c:choose>
					<c:when test="${empty SearchResult}">
						<h3 class="no_result">검색 결과 없음</h3>
					</c:when>
					<c:otherwise>
						<tr>
							<th>글번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>등록일</th>
							<th>조회수</th>
						</tr>
						<c:forEach items="${SearchResult}" var="T" varStatus="i">
							<tr id="highlight" data-ncode="${T.n_code}">
								<td>${i.index+1}</td>
								<td>${T.n_title}</td>
								<td>${T.n_nickname}</td>
								<td>${T.n_date}</td>
								<td data-hit="${T.n_hit}">${T.n_hit}</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
			<button class="tolist">뒤로가기</button>
		</div>
	</div>
	<%@include file="/WEB-INF/views/include/include_footer.jspf"%>
</body>
<script>

	document.querySelector("button.tolist").addEventListener("click",(e)=>{
		location.href = "${rootPath}/notice"
	})
	document.querySelector("table.list").addEventListener("click",(e)=>{
		
		let tagName = e.target.tagName
		if(tagName === "TD"){
			let tr = e.target.closest("TR")
			let n_code = tr.dataset.ncode
			location.href="${rootPath}/notice/detail?n_code=" + n_code
		}
	})
	
</script>
</html>