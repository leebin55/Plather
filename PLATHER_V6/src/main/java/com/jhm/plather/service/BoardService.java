package com.jhm.plather.service;

import java.util.List;

import org.springframework.ui.Model;

import com.jhm.plather.model.BoardAndSongDTO;
import com.jhm.plather.model.BoardVO;
import com.jhm.plather.model.LikeVO;
import com.jhm.plather.model.SongVO;

public interface BoardService {

	// 게시물 모두 조회 (플레이리스트없이)
	public List<BoardVO> selectAll();
	// 조회순, 추천순 , 날짜순 조회
	public int selectByCategory(String category,Model model,int intPageNum);
		
	// 게시물 코드로 게시물만(플레이리스트 없이)
	public BoardVO findById(Long b_code);

	// 게시물 등록(tbl_board와 tbl_song같이)
	public int register(BoardVO boardVO, List<SongVO> list);
	
	// 멤버가 쓴 게시물과 찜 개수 조회
	public int findByUserIdCNT(String b_id,Model model);
	// 게시물 수정
	public int update(BoardVO vo);

	// 게시물 삭제
	public int delete(Long b_code);

	// 게시물 코드로 플레이리스트와 함께 게시물 리턴
	public BoardAndSongDTO findByIdWithList(Long b_code);

	// 게시물 조회수
	public int updateHit(Long b_code);
	
//////찜//////
	
	// 게시물의 하트를 클릭하면 실행 결과로 1 또는 -1리턴
	public Integer clickHeart(LikeVO vo);
	
	//게시물코드와 아이디로  찜 했나 안했나 조회
	public int checkLike(LikeVO vo);
	
	// 찜한 게시물을 조회
	public List<BoardVO> myLikeBoard(String m_id);
	// 게시물 찜 수
	public int showLikeCnt(Long b_code);
	
}