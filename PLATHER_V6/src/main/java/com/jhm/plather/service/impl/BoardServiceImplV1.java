package com.jhm.plather.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.jhm.plather.dao.BoardDao;
import com.jhm.plather.dao.LikeDao;
import com.jhm.plather.dao.SongDao;
import com.jhm.plather.model.BoardAndSongDTO;
import com.jhm.plather.model.BoardVO;
import com.jhm.plather.model.LikeVO;
import com.jhm.plather.model.PageDTO;
import com.jhm.plather.model.SongVO;
import com.jhm.plather.service.BoardService;
import com.jhm.plather.service.PageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Slf4j
@Service
public class BoardServiceImplV1 implements BoardService {

	protected final BoardDao boardDao;
	protected final SongDao songDao;
	protected final LikeDao lDao;
	protected final PageService pSer;

	@Override
	public List<BoardVO> selectAll() {
		List<BoardVO> bList = boardDao.selectAll();
		return bList;
	}

//////////////////////게시물 등록///////////////////////////////////
	@Override
	public int register(BoardVO boardVO, List<SongVO> songList) {
		int b_result = boardDao.insert(boardVO);

		// 게시물 등록이 성공하였을때 진행
		if (b_result > 0) {
			// tbl_like insert
			Long b_code = boardVO.getB_code();

			log.debug("songList>> : {}", songList.toString());

			return songDao.insertWithList(b_code, songList);

		}
		log.debug("tbl_board insert실패");
		return 0;

	}

	// 게시물코드로 게시물 리턴(플레이리스트 없이 게시물만)
	@Override
	public BoardVO findById(Long b_code) {

		BoardVO vo = boardDao.findById(b_code);
		return vo;
	}

	@Override
	public int update(BoardVO vo) {
		int ret = boardDao.update(vo);
		return ret;
	}

	@Override
	public int delete(Long b_code) {
		int ret = boardDao.delete(b_code);
		return ret;
	}

	@Override
	public BoardAndSongDTO findByIdWithList(Long b_code) {

		BoardAndSongDTO bsDTO = boardDao.findByIdResultMap(b_code);
		return bsDTO;
	}

	@Override
	public int updateHit(Long b_code) {

		int ret = boardDao.updateHit(b_code);
		return ret;
	}

	// 하트를 눌럿을때 실행되는 메소드
	@Override
	public Integer clickHeart(LikeVO vo) {

		Integer result = null;
		int count_tbl = lDao.findByIdAndBCodeCount(vo);
		Long b_code = vo.getL_bcode();

		// 해당 게시물에 하트 한번도 누르지 않은 상태
		if (count_tbl == 0) {
			vo.setL_likecheck(1);
			int ret = lDao.insert(vo);
			// insert완료 했을때
			if (ret > 0) {
				if (boardDao.likeCountUp(b_code) > 0) {
					result = 1;
				}

			}
		}
		// 이전에 하트를 누른 적 있는 상태
		else {
			int l_likecheck = lDao.findByIdAndBCode(vo);
			if (l_likecheck == 1) {
				int ret = lDao.cancelLike(vo);
				if (ret > 0) { // update성공하였을 때
					if (boardDao.likeCountDown(b_code) > 0) {
						result = -1;
					}
				}

			} else {
				int ret = lDao.clickLike(vo);
				if (ret > 0) {
					if (boardDao.likeCountUp(b_code) > 0) {
						result = 1;
					}
				} // if end
			} // else end
		} // 하트 누른적 있을때 end

		return result;
	}

	@Override
	public int checkLike(LikeVO vo) {

		int l_checkLike = 0;
		// 게시물 코드와 아이디를 받아 테이블이 존재하는지 검사
		int like_cnt = lDao.findByIdAndBCodeCount(vo);
		log.debug("like_count : {}", like_cnt);
		if (like_cnt > 0) {
			// 이전에 찜을 눌러 테이블이 존재하는 상태
			// return l_likecheck
			l_checkLike = lDao.findByIdAndBCode(vo);
		}
		// 이전에 찜을 누르지 않아 테이블이 없으면 그냥 초기값인 0을 리턴
		return l_checkLike;
	}

	@Override
	public List<BoardVO> myLikeBoard(String m_id) {

		List<BoardVO> boardList = new ArrayList<BoardVO>();

		List<Long> bCodeList = lDao.myLikeBoard(m_id);
		log.debug("myLike bcode : {}", bCodeList.toString());
		for (Long bCode : bCodeList) {
			BoardVO vo = new BoardVO();
			vo = boardDao.findById(bCode);
			boardList.add(vo);
		}
		log.debug("myLike: {}", boardList.toString());
		return boardList;
	}

	public int showLikeCnt(Long b_code) {
		return boardDao.showLikeCnt(b_code);

	}


	@Override
	public int selectByCategory(String category, Model model,int pageNum) {
		List<BoardVO> totalBoard = boardDao.selectAll();
		int totalSize= totalBoard.size();
		
		PageDTO pageDTO = pSer.makePagination(totalSize, pageNum);
		if(pageDTO == null) {
			return 0;
		}
		//조회순 추천순 날짜순별로 리스트 추출
		List<BoardVO> boardList= new ArrayList<BoardVO>();
		
		if(category.equals("cat_hit")) {
			boardList= boardDao.selectAllDescHit();
		}else if(category.equals("cat_like")) {
			boardList = boardDao.selectAllDescLike();
		}else if(category.equals("cat_date")) {
			boardList= totalBoard;
		}
		
		// 위의 리스트를 페이지 별로 데이터 컷팅
		List<BoardVO> pageList= new ArrayList<BoardVO>();
		
		for(int i = pageDTO.getOffset();i<pageDTO.getLimit(); i++) {
			pageList.add(boardList.get(i));
		}
		
		model.addAttribute("PAGE_NAV", pageDTO);
		model.addAttribute("BOARDLIST", pageList);
		model.addAttribute("CAT", category);
		return 1;
	}

	@Override
	public int findByUserIdCNT(String b_id,Model model) {
		int cnt_board =boardDao.findByUserIdCNT(b_id);
		int cnt_like = lDao.myLikeBoardCNT(b_id);
		model.addAttribute("CNT_BOARD", cnt_board);
		model.addAttribute("CNT_LIKE", cnt_like);
		return 0;
	}
}
