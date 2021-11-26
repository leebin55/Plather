<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${rootPath}/static/css/play_list.css?ver=2021-06-15-003"
	rel="stylesheet" />

</head>
<body>
	<%@include file="/WEB-INF/views/include/include_header.jspf"%>
	<div class="content">
		<div class="play">
			<div class="title"><p>플레이리스트</p><button class="btn_add">&#43; 등록</button></div>
			<div class="select">
				<select name="category">
					<option value="cat_date" 
					<c:if test="${CAT == 'cat_date'}">selected="selected"</c:if>>날짜순</option>
					<option value="cat_hit"
					<c:if test="${CAT == 'cat_hit'}">selected="selected"</c:if>>조회순</option>
					<option value="cat_like" 
					<c:if test="${CAT == 'cat_like'}">selected="selected"</c:if>>추천순</option>
					
				</select>
			</div>
			<table class="list">
				<thead>
					<tr>
						<th>No.</th>
						<th>제목</th>
						<th>작성자</th>
						<th>찜</th>
						<th>등록일</th>
					</tr>
				</thead>
				<c:choose>
					<c:when test="${empty BOARDLIST}">
						<tr>
							<td colspan="5">데이터 없음</td>
						</tr>
					</c:when>
					<c:otherwise>
				<c:forEach items="${BOARDLIST}" var="B" varStatus="i">
				<tbody>
				<tr data-code="${B.b_code}">
					<td><c:if test="${PAGE_NUM >1 }">${(PAGE_NUM-1)*10 + (i.index+1)}</c:if>
					<c:if test="${PAGE_NUM ==1 }">${i.index+1}</c:if></td>
					<td>${B.b_title}</td>
					<td>${B.b_nick}</td>
					<td>${B.b_like}</td>
				<td><fmt:formatDate pattern="yyyy-MM-dd" 
                                value="${B.b_date}"/></td>
				</tr>
				</tbody>
				</c:forEach>
				</c:otherwise>
				</c:choose>
			</table>
				<%@include file="/WEB-INF/views/include/include_pagination_board.jspf" %>
		</div>
		<div class="search">
		<form>
			<input/>
			<button>검색</button>
			</form>
		</div>
	</div>
	<%@include file="/WEB-INF/views/include/include_footer.jspf"%>
</body>
<script>
	const select_cat = document.querySelector("select[name='category']")
	
	select_cat.addEventListener("change",()=>{
		const category = select_cat.value
		//alert(category)
		location.href="${rootPath}/board?category="+category
	})
	
	//등록 버튼을 누를 때
	document.querySelector("button.btn_add").addEventListener("click",(e)=>{
		location.href="${rootPath}/board/insert"
	})
	
	// 테이블 데이터를 클릭할때 
	document.querySelector("table.list").addEventListener("click",(e)=>{
		let target =e.target;
		let tagName = target.tagName;
		if(tagName ==="TD"){
			let b_code = e.target.closest("TR").dataset.code
			//alert(b_code)
			if(b_code){
			location.href="${rootPath}/board/detail?b_code="+b_code
			}
		}
	})
	
	//pagination(includ_pagination_board)
	const page_nav = document.querySelector("ul.page_nav")
	if(page_nav) {
		page_nav.addEventListener("click",(e)=>{
			const li = e.target
			if(li.tagName === "LI"){
				const pageNum = li.dataset.num
				const category = select_cat.value
				const totalP= document.querySelector("#totalPages").dataset.num
				//alert(totalP)
				if(pageNum>0 && pageNum<totalP+1){
				location.href = "${rootPath}/board?pageNum=" + pageNum + "&category="+category
				}
			}
		})
	}
	
</script>
</html>