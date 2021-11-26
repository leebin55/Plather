<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>plater</title>
<style type="text/css">
* {
	/* 초기화 */
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

@font-face {
	/*기본 폰트 설정*/
	font-family: 'GmarketSansLight';
	src:
		url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/GmarketSansLight.woff')
		format('woff');
	font-weight: normal;
	font-style: normal;
}
</style>
</head>
<body>
	<c:choose>
		<c:when test="${BODY eq 'LOGIN'}">
			<%@ include file="/WEB-INF/views/member/login.jsp"%>
		</c:when>

		<c:when test="${BODY eq 'MAIN'}">
			<%@ include file="/WEB-INF/views/main.jsp"%>
		</c:when>

		<c:when test="${BODY eq 'JOIN'}">
			<%@ include file="/WEB-INF/views/member/join.jsp"%>
		</c:when>

		<c:otherwise>
			<%@ include file="/WEB-INF/views/dummy.jsp"%>
		</c:otherwise>
	</c:choose>
</body>
</html>