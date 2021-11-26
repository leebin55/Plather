<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Project PLATHER</title>
<link href="${rootPath}/static/css/notice_detail.css?ver=2021-06-12-015"
	rel="stylesheet" />
</head>
<body>
	<%@include file="/WEB-INF/views/include/include_header.jspf"%>
	<div class="content">
		<div class="notice">
			<h1>공지사항</h1>
			<table class="detail" data-ncode="${NT.n_code}">
				<tr>
					<th colspan="3">${NT.n_title}</th>
					<th>${NT.n_date}</th>
				</tr>
				<tr>
					<td colspan="3">${NT.n_hit}</td>
					<td>${NT.n_nickname}</td>
				</tr>
				<tr>
					<td colspan="4"><p>${NT.n_content}</td>
				</tr>
				<tr id="btn_box">
					<td></td>
					<td><c:if test="${MEMBER.m_level == '1'}"><button class="update">수정</button></c:if></td>
					<td><c:if test="${MEMBER.m_level == '1'}"><button class="delete">삭제</button></c:if></td>
					<td><button class="tolist">뒤로가기</button></td>
				</tr>
			</table>
		</div>
	</div>
	<%@include file="/WEB-INF/views/include/include_footer.jspf"%>
</body>
<script>


	document.querySelector("tr#btn_box").addEventListener("click",(e)=>{
		
		let target = e.target
		let n_code = target.closest("TABLE").dataset.ncode
		if(target.tagName === "BUTTON"){
			if(target.className.includes("update")){
				location.href = "${rootPath}/notice/update?n_code=" + n_code
			}
			if(target.className.includes("tolist")){
				location.href = document.referrer; 
			}
			if(target.className.includes("delete")){
				if(confirm("삭제하시겠습니까?")){
					location.replace(
						"${rootPath}/notice/delete?n_code=" + n_code
					);
				}	
			}
		}
	})
</script>
</html>