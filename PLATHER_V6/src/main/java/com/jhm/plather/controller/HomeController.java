package com.jhm.plather.controller;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.jhm.plather.dao.BoardDao;
import com.jhm.plather.model.BoardVO;
import com.jhm.plather.model.MemberVO;
import com.jhm.plather.model.NoticeDTO;
import com.jhm.plather.model.NoticeVO;
import com.jhm.plather.service.MemberService;
import com.jhm.plather.service.NoticeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class HomeController {

	protected final NoticeService nService;
	protected final MemberService mbService;
	protected final BoardDao bDao;


	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		return "redirect:/member/login";
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainPage(NoticeDTO noticeDTO, Model model) {

		List<NoticeVO> ntList = nService.selectAll();
		model.addAttribute("NTLIST", ntList);
		
		List<BoardVO> bdList = bDao.selectAll();
		model.addAttribute("BDLIST", bdList);
		return "main";
	}

}