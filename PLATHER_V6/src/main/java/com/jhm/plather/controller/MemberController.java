package com.jhm.plather.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhm.plather.model.MemberVO;
import com.jhm.plather.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@RequestMapping(value = "/member")
@Controller
public class MemberController {

	protected final MemberService mbService;


	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model) {
		// 로그인 method

		// 모델에 값을 담아서 보냄
		model.addAttribute("BODY", "LOGIN");

		return "home";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(Model model, MemberVO mbVO, HttpSession hSession) {
		// 로그인 method
		// web에서 로그인 값을 받아서 처리 수행 method

		mbVO = mbService.login(mbVO, model);

		// mbVO로 null 값이 넘어오면(= 값이 없으면)
		if (mbVO == null) {

			model.addAttribute("BODY", "LOGIN");

			// 로그인 실패 : 로그인 화면으로 다시 보냄
			return "home";

		} else {

			// 사용자 ID 정상, 비밀번호 확인 정상
			// HttpSession에 사용자 정보가 담긴 memberVO를
			// 속성으로 세팅한다
			hSession.setAttribute("MEMBER", mbVO);

			// 로그인 성공 : 메인 화면으로 보냄
			return "redirect:/main";
		}
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		// 로그아웃 처리 수행 method

		// 값을 받아서 remove처리
		session.removeAttribute("MEMBER");

		return "redirect:/";
	}

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join(Model model) {
		// 회원가입 method
		// 회원가입 화면 불러오기

		MemberVO mbVO = new MemberVO();
		mbVO.setM_profile(mbService.makeRndNum());

		model.addAttribute("MB", mbVO);

		// BODY 이라는 변수에 JOIN 값을 담음
		model.addAttribute("BODY", "JOIN");

		return "home";
	}

	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(MemberVO mbVO, Model model) {
		// 회원가입 method
		// web(jsp)에서 입력한 회원정보 값을 받아서 처리 수행

		// 확인
		log.debug("회원가입 정보 {}", mbVO.toString());

		mbVO = mbService.join(mbVO);

		// BODY 이라는 변수에 JOIN 값을 담음
		model.addAttribute("BODY", "JOIN");

		return "redirect:/member/login";
	}

	@ResponseBody
	@RequestMapping(value = "/id_check", method = RequestMethod.GET)
	public String id_check(String m_id) {
		// 중복 검사 수행 method

		log.debug("중복 검사를 수행할 ID: {}", m_id);
		MemberVO mbVO = mbService.findById(m_id);

		if (mbVO == null) {
			// mbVO 값이 null이면 아래 문구 return(DB에 없는 회원 ID임)
			return "NOT_USE_ID";

		} else {
			// mbVO 값이 있으면 아래 문구 return(DB에 있는 회원 ID임)
			return "USE_ID";
		}

	}

	@ResponseBody
	@RequestMapping(value = "/nick_check", method = RequestMethod.GET)
	public String nick_check(String m_nickname) {
		// nickname 중복검사 수행 method

		// 확인
		log.debug("중복검사를 수행할 nickname:{}", m_nickname);
		MemberVO mbVO = mbService.findByNick(m_nickname);

		if (mbVO == null) {

			// null이면 DB에 없는 닉네임( = 사용 가능한 닉네임)
			return "NOT_USE_NICK";

		} else {
			// 값이 있으면 DB에 있는 닉네임(= 사용 불가한 닉네임)
			return "USE_NICK";
		}

	} // end nick_check

}