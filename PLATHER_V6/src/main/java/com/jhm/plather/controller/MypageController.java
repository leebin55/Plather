package com.jhm.plather.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhm.plather.model.BoardVO;
import com.jhm.plather.model.CommentDTO;
import com.jhm.plather.model.MemberAndBoardDTO;
import com.jhm.plather.model.MemberVO;
import com.jhm.plather.service.BoardService;
import com.jhm.plather.service.CommentService;
import com.jhm.plather.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/mypage")
public class MypageController {

	protected final MemberService mbService;
	protected final CommentService cService;
	protected final BoardService bService;

	@RequestMapping(value = { "/", "" }, method = RequestMethod.GET)
	public String list(Model model, HttpSession hSession) {
		// 마이 페이지
		// 프로필 값 가져와서 랜덤 프로필색 지정
		MemberVO mbVO = (MemberVO) hSession.getAttribute("MEMBER");
		// 내가 쓴 글
		String m_id = mbVO.getM_id();
		
		bService.findByUserIdCNT(m_id,model);
		// 내가 쓴 댓글 
		List<CommentDTO> cList = cService.findByMemberId(m_id);
		
		model.addAttribute("CNT_COMMENT", cList.size());
		model.addAttribute("MB_PROFILE",mbVO);
		
		return "mypage/mypage";

	}

	@RequestMapping(value = { "/", "" }, method = RequestMethod.POST)
	public String mypageAfterUpdate() {

		return "mypage/mypage";
	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update(Model model, HttpSession hSession) {
		// 마이 페이지 수정 method

		// 로그인 세션값을 불러옴
		MemberVO mbVO = (MemberVO) hSession.getAttribute("MEMBER");

		// "MB_DETAIL"이라는 변수에 담아서 다시 보냄
		model.addAttribute("MB_DETAIL", mbVO);

		return "mypage/update";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(Model model, MemberVO mbVO) {
		// 마이 페이지 수정 method

		mbVO = mbService.update(mbVO);

		model.addAttribute("MDETAIL", mbVO);

		return "redirect:/main";
	}
	@ResponseBody
	@RequestMapping(value = "/myboard", method = RequestMethod.GET, produces = "application/json;char=UTF8")
	public MemberAndBoardDTO myBoard(String m_id) {
		//mypage에서 내가 쓴글을 누를 때 게시글보여줌 
		MemberAndBoardDTO mbDTO = mbService.findByIdBaord(m_id);
		log.debug("mbDTO: {}", mbDTO);
		return mbDTO;

	}
	@ResponseBody
	@RequestMapping(value = "/mycomment", method = RequestMethod.GET, produces = "application/json;char=UTF8")
	public List<CommentDTO> myComment(String m_id) {
		//mypage에서 내가 쓴 댓글을 누를 때 댓글보여줌 
		List<CommentDTO> cList = cService.findByMemberId(m_id);
		log.debug("cDTO: {}", cList);
		return cList;

	}
	@ResponseBody
	@RequestMapping(value = "/mylike", method = RequestMethod.GET, produces = "application/json;char=UTF8")
	public List<BoardVO> myLike(String m_id) {
		
		List<BoardVO> boardList = bService.myLikeBoard(m_id);
		log.debug("mylike boardlist : {} ", boardList.toString());
		return boardList;

	}
}

