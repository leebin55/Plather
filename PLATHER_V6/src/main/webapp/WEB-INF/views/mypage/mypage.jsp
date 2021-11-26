<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${rootPath}/static/css/mypage.css?ver=3" rel="stylesheet" />
<title>My Page</title>
<style>
div.hidden {
	display: none;
}

div#table {
	height: 350px;
	overflow-y: scroll;
}

table {
	border-collapse: separate;
	border-spacing: 1px;
	text-align: left;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	margin: 0px auto;
	width: 70%;
}

tbody.tbody tr:hover {
	cursor: pointer;
	font-weight: 900;
	background-color: rgba(145, 199, 136, 0.3);
}

th {
	background-color: #e1e1e1;
	text-align: center;
	width: 150px;
	padding: 10px;
	font-weight: bold;
	border-bottom: 1px solid #ccc;
}

table td {
	text-align: center;
	width: 350px;
	padding: 10px;
	vertical-align: top;
	border-bottom: 1px solid #ccc;
}

div.nickname img#profile {
	border: 1px solid black;
	margin-top: 30px;
}
</style>
</head>
<body>
	<%@include file="/WEB-INF/views/include/include_header.jspf"%>
	<div id="main_container">
		<div class="sub_container">
			<div id="info_container">
				<input name="m_profile" id="m_profile" value="${MB_PROFILE.m_profile}" type="hidden" >
				<div class="nickname">
					<img src="" width="100px" class="profile" >
					<h5>${MEMBER.m_nickname}</h5>
					<div class="line"></div>
				</div>
				<p class="id">${MEMBER.m_id}</p>
				<div class="buttons">
					<button class="modify">정보수정</button>

				</div>
			</div>
			<div id="right_container">
				<ul class="box_container">
					<li class="playlist box">
						<div class="b-title">내가 쓴 글</div>
						<div class="count">${CNT_BOARD} 건</div>
					</li>
					<li class="comment box">
						<div class="b-title">내가 쓴 댓글</div>
						<div class="count">${CNT_COMMENT} 건</div>
					</li>
					<li class="heart box">
						<div class="b-title">찜한 글</div>
						<div class="count">${CNT_LIKE} 건</div>
					</li>
				</ul>
				<div id="table" class="hidden">
					<table>
						<thead>
							<tr>
								<th class="th_1"></th>
								<th class="th_2"></th>
								<th class="th_3"></th>
							</tr>
						</thead>
						<tbody class="tbody">

						</tbody>
					</table>
				</div>

			</div>
		</div>

	</div>
	<%@include file="/WEB-INF/views/include/include_footer.jspf"%>
</body>
<script>
	//변수
	const my_board= document.querySelector("li.playlist.box")
	const my_comment= document.querySelector("li.comment.box")
	const my_like= document.querySelector("li.heart.box")
	const m_id = document.querySelector("p.id").innerText
	const th_1 = document.querySelector("th.th_1")
	const th_2 = document.querySelector("th.th_2")
	const th_3 = document.querySelector("th.th_3")
	const div_table =document.querySelector("#table")
	const tbody = document.querySelector(".tbody")
	let boardList = []; 
	
	
//정보수정버튼을 click 하면 정보수정하는 페이지로 이동

	document.querySelector("button.modify").addEventListener("click",(e)=>{
		location.href="${rootPath}/mypage/update"
	})
	// 날짜변환 function
	const dateFormat=(b_date)=>{
		let date = new Date()
		let year = date.getFullYear();
		let month = (1 + date.getMonth());
		month = month >= 10 ? month : '0' + month;
		let day = date.getDate();
		day = day >= 10 ? day : '0' + day;
		return year + '-' + month + '-' +day;
	}
	//table header 
	const table_header=(th1,th2 ,th3)=>{
		
		th_1.innerText=th1
		th_2.innerText=th2
		th_3.innerText=th3
		
	}
	
	//게시글 테이블 생성 function
	const create_board_table=()=>{
		
		div_table.classList.remove("hidden")
		table_header("글코드","글제목","작성일")
		let html = "";
		for(let i = 0 ; i <boardList.length ; i++){
			date= boardList[i].b_date
			console.log(date)
			html += "<tr data-code="+boardList[i].b_code+ ">"
				html += "<td>"+boardList[i].b_code + "</td>"
				html += "<td>"+boardList[i].b_title + "</td>"
				html += "<td>"+ dateFormat(date) + "</td>"
				html += "</tr>"
		}
		document.querySelector("tbody.tbody").innerHTML = html
	}
	

	// 내가 쓴 글을 찾아서 테이블로 보여주는 function
	const show_my_board=()=>{
		fetch("${rootPath}/mypage/myboard?m_id="+m_id)
		.then((response)=>{
		return response.json()
		}).then((data)=>{
		
			boardList = data.boardList
			console.log(data)
			console.log(boardList)
			// 테이블 생성
			if(boardList.length>0){
			create_board_table()
			}else{
				alert("작성한 글이 없습니다.")
			}
				
		})
	}
	// 내가 쓴 댓글을 찾아서 테이블을 만들어 보여주는 function
	const show_my_comment=()=>{
		fetch("${rootPath}/mypage/mycomment?m_id="+m_id).
		then((response)=>{
			return response.json()
		}).then((data)=>{
			console.log(data)
			if(data.length>0){
				div_table.classList.remove("hidden")
				table_header("게시글코드","댓글내용","작성일")
				let html = "";
				for(let i = 0 ; i < data.length ; i++){
					html += "<tr data-code="+data[i].c_bcode +">"
						html += "<td>"+data[i].c_bcode + "</td>"
						html += "<td>"+data[i].c_comment + "</td>"
						html += "<td>"+ data[i].c_date+ "</td>"
						html += "</tr>"
				}
				document.querySelector("tbody.tbody").innerHTML = html
			}else{
				alert("작성한 댓글이 없습니다.")
			}
			
		})
	}
	// 찜한 글 박스를 클릭할때 function
	const show_my_like=()=>{
		fetch("${rootPath}/mypage/mylike?m_id="+m_id)
		.then(response=>response.json()).then((data)=>{
			console.log(data)
			if(data.length>0){
				div_table.classList.remove("hidden")
				table_header("게시글코드","글제목","찜 수")
				let html = "";
				for(let i = 0 ; i < data.length ; i++){
					html += "<tr data-code="+data[i].b_code +">"
						html += "<td>"+data[i].b_code + "</td>"
						html += "<td>"+data[i].b_title + "</td>"
						html += "<td>"+ data[i].b_like+ "</td>"
						html += "</tr>"
				}
				document.querySelector("tbody.tbody").innerHTML = html
			}
			else{
				alert("찜한 게시물이 없습니다.")
			}
		})
	}
	// "내가 쓴 글"이라는 박스를 클릭할 때 이벤트 
	my_board.addEventListener("click",()=>{
		//alert(m_id)
		show_my_board()
		
	})
	// "내가 쓴 댓글"이라는 박스를 클릭할 때 이벤트
	my_comment.addEventListener("click",()=>{
		show_my_comment()
	})
	//" 찜한 글"라는 박스를 클릭할 때 이벤트 
	my_like.addEventListener("click",()=>{
	show_my_like()
	})
	// 내가 쓴글에서 클릭하면 디테일로 가는 이벤트
	tbody.addEventListener("click",(e)=>{
		if(e.target.tagName ==="TD"){
			const b_code = e.target.closest("TR").dataset.code
			//alert(b_code)
			if(b_code)
			location.href="${rootPath}/board/detail?b_code="+b_code
		}
	})	
	
	
	/* 변수 선언 */
	const input_profile = document.querySelector("input#m_profile")
	const img_profile = document.querySelector("img.profile")
	if(input_profile) {
		
		const profile_num = input_profile.value
			
			img_profile.src = "${rootPath}/static/images/profile_"+ profile_num + ".png"	
			
		/* } else if(user_profile === "1") {
			
			img_profile.src = "${rootPath}/static/images/profile_orange.png"
			
		} else if(user_profile === "2") {
			
			img_profile.src = "${rootPath}/static/images/profile_yellow.png"
			
		} else if(user_profile === "3") {
			
			img_profile.src = "${rootPath}/static/images/profile_green.png"
			
		} else if(user_profile === "4") {
			
			img_profile.src = "${rootPath}/static/images/profile_blue.png"
			
		} else if(user_profile === "5") {
			
			img_profile.src = "${rootPath}/static/images/profile_navy.png"
			
		} else if(user_profile === "6") {
			
			img_profile.src = "${rootPath}/static/images/profile_puple.png"
			
		} */
		
	} // input_profile end
	
</script>
</html>