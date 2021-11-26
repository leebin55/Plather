package com.jhm.plather.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.jhm.plather.dao.CommentDao;
import com.jhm.plather.dao.SongDao;
import com.jhm.plather.model.CommentDTO;
import com.jhm.plather.model.CommentVO;
import com.jhm.plather.model.NoticeVO;
import com.jhm.plather.model.SongVO;
import com.jhm.plather.service.CommentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/comment")
public class CommentController {

	protected final CommentService cService;
	protected final CommentDao cDao;
	protected final SongDao sDao;

	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insert(CommentVO cVO) {

		cService.insert(cVO);
		String b_code = cVO.getC_bcode();
		return "redirect:/board/detail?b_code=" + b_code;
	}

	@RequestMapping(value = "/insert/song", method = RequestMethod.POST)
	public String insert(SongVO sVO, String c_bcode) {
		sVO.setS_bcode(Long.valueOf(c_bcode));
		sDao.insert(sVO);
		return "redirect:/board/detail?b_code=" + c_bcode;
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(@RequestParam("c_seq") String c_seq) {
		CommentVO cVO = cDao.findById(c_seq);
		String b_code = cVO.getC_bcode();
		cDao.delete(c_seq);

		return "redirect:/board/detail?b_code=" + b_code;
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(CommentVO cVO) {
		CommentVO cVO2 = cDao.findById(String.valueOf(cVO.getC_seq()));
		String b_code = cVO2.getC_bcode();
		cDao.update(cVO);

		return "redirect:/board/detail?b_code=" + b_code;
	}

}
