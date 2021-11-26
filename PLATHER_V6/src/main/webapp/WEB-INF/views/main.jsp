<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PLATHER MAIN</title>
<link href="${rootPath}/static/css/main_home.css?ver=2021-07-18-001"
	rel="stylesheet" />
<style>
article#bn1 {
	background: url("${rootPath}/static/images/summer_event.png") no-repeat;
}

article#bn2 {
	background: url("${rootPath}/static/images/bn_white.png") no-repeat;
}

article#bn3 {
	background: url("${rootPath}/static/images/신곡.png") no-repeat;
}
</style>

<body>
	<%@ include file ="/WEB-INF/views/include/include_main_header.jspf" %>
	<section id="banners">
		<article id="bn1"></article>
		<article id="bn2">
			<div id = "ntable">
				<h2>공지사항</h2>
				<table>
					<tr>
						<th>제목</th>
						<th>작성일</th>
					</tr>
					<c:choose>
						<c:when test="${empty NTLIST}">
							<tr>
								<td colspan="2">데이터 없음</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="i" begin="0" end="4">
								<tr id="highlight" data-ncode="${NTLIST[i].n_code}">
									<td>${NTLIST[i].n_title}</td>
									<td>${NTLIST[i].n_date}</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
			<div id="btable">
				<h2>최근 플래더</h2>
				<table>
					<tr>
						<th>제목</th>
						<th>작성일</th>
					</tr>
					<c:choose>
						<c:when test="${empty BDLIST}">
							<tr>
								<td colspan="2">데이터 없음</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach var="i" begin="0" end="4">
								<tr id="highlight" data-bcode="${BDLIST[i].b_code}">
									<td>${BDLIST[i].b_title}</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd" 
                                value="${BDLIST[i].b_date}"/></td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
			</div>
		</article>
		<article id="bn3"></article>
	</section>
	<%@include file="/WEB-INF/views/include/include_footer.jspf"%>
</body>
<script>
document.querySelector("div#ntable").addEventListener("click",(e)=>{
	let tagName = e.target.tagName
	if(tagName === "TD"){
		let tr = e.target.closest("TR")
		let n_code = tr.dataset.ncode
		location.href="${rootPath}/notice/detail?n_code=" + n_code
	}
})
document.querySelector("div#btable").addEventListener("click",(e)=>{
	let tagName = e.target.tagName
	if(tagName === "TD"){
		let tr = e.target.closest("TR")
		let b_code = tr.dataset.bcode
		location.href="${rootPath}/board/detail?b_code=" + b_code
	}
})
</script>
</html>