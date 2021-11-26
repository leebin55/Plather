package com.jhm.plather.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhm.plather.dao.CommentDao;
import com.jhm.plather.model.BoardAndSongDTO;
import com.jhm.plather.model.BoardVO;
import com.jhm.plather.model.CommentDTO;
import com.jhm.plather.model.LikeVO;
import com.jhm.plather.model.MemberVO;
import com.jhm.plather.model.SongVO;
import com.jhm.plather.service.BoardService;
import com.jhm.plather.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping(value = "/board")
public class BoardController {

	protected final BoardService bSer;
	protected final MemberService mSer;
	protected final CommentDao cDao;

	@RequestMapping(value = {"/",""}, method = RequestMethod.GET)
	public String list(@RequestParam(value="category",required = false, defaultValue = "cat_date")String category
	,@RequestParam(value = "pageNum", required = false, defaultValue = "1") String pageNum,
	Model model) {
		
		int intPageNum = Integer.valueOf(pageNum);
		if(intPageNum > 0) {
			model.addAttribute("PAGE_NUM", intPageNum);
		}
		bSer.selectByCategory(category, model,intPageNum);
		
		return "playlist/play_list";
	}


	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String boarInsert(Model model) {
		
		return "playlist/play_insert";
	}

	@ResponseBody
	//////////////////////// 게시물 등록 //////////////////////////////
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String boardInsert(@RequestBody Map<String, Object> bsMaps) {

		log.debug("bsMaps: {}", bsMaps.toString());

		BoardVO boardVO = new BoardVO();
		boardVO.setB_title((String) bsMaps.get("b_title"));
		boardVO.setB_content((String) bsMaps.get("b_content"));
		boardVO.setB_id((String) bsMaps.get("b_id"));
		boardVO.setB_nick((String) bsMaps.get("b_nick"));
		log.debug("00>>:{}", boardVO.toString());

		List<SongVO> songList = (List<SongVO>) bsMaps.get("playList");
		log.debug("Song List {}", songList.toString());

		// 게시물과 노래 리스트를 같이 등록 하였을 때 결과
		int ret = bSer.register(boardVO, songList);
		if (ret > 0) {
			// tbl_board와 tbl_song 모두 insert성공

			return "OK";
		} else {
			return "FAIL";
		}

	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(Long b_code, HttpSession session, Model model) {
		// 게시물 코드를 받아와 게시글 불러오기

		bSer.updateHit(b_code);
		BoardAndSongDTO bsDTO = bSer.findByIdWithList(b_code);
		log.debug(">>>>>>>>>>>>>>>>> {}", bsDTO);
		LikeVO likeVO = new LikeVO();
		MemberVO memberVO = (MemberVO) session.getAttribute("MEMBER");
		likeVO.setL_bcode(bsDTO.getB_code());
		likeVO.setL_id(memberVO.getM_id());
		int checkLike = bSer.checkLike(likeVO);

		model.addAttribute("LIKE", checkLike);
		model.addAttribute("BOARD_DETAIL", bsDTO);
		
		// 댓글리스트(07/18 혜미)
		List<CommentDTO> clist = cDao.findByCbcode(b_code);
		model.addAttribute("COMS", clist);
		
		return "playlist/play_detail";

	}

	/////////////////// 게시물 수정/////////
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String boardModify(Long b_code, Model model) {

		BoardAndSongDTO bsDTO = bSer.findByIdWithList(b_code);
		model.addAttribute("BOARD_DETAIL", bsDTO);

		return "playlist/play_modify";
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String boardModifyPost(BoardVO vo) {

		bSer.update(vo);
		return "redirect:/board";
	}

	/////////////////// 게시물 삭제////////////////////
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String boardDelete(Long b_code) {

		bSer.delete(b_code);
		return "redirect:/board";
	}
	@ResponseBody
	@RequestMapping(value = "/like", method = RequestMethod.GET, produces = "application/json;char=UTF8")
	public Map<String, Integer> clickHeart(@RequestParam("l_id") String l_id, @RequestParam("l_bcode") Long l_bcode) {
		
		Map<String, Integer>checkMap = new HashMap<>();
		LikeVO likeVO = new LikeVO();
		likeVO.setL_bcode(l_bcode);
		likeVO.setL_id(l_id);
		log.debug(" like : likeVO : {}", likeVO);
		Integer result = bSer.clickHeart(likeVO);
		log.debug("return 값 : " + result);
		if (result != null) {
			checkMap.put("result", result);
			Integer likeCnt = bSer.showLikeCnt(l_bcode);
			checkMap.put("likeCnt", likeCnt);

		} else {
			checkMap.put("result", 0);

		}
		return checkMap;
	}
}