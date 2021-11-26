package com.jhm.plather.dao;

import java.util.List;

import com.jhm.plather.model.BoardAndSongDTO;
import com.jhm.plather.model.BoardVO;

public interface BoardDao extends GenericDao<BoardVO, Long> {
	// 조회순으로 
	public List<BoardVO> selectAllDescHit();
	// 찜 순으로 
	public List<BoardVO> selectAllDescLike();
	// 게시글 제목으로 찾기(게시글만)
	public List<BoardVO> findByTitle(String b_title);

	// userid로 찾기
	public List<BoardVO> findByUserId(String b_id);
	
	public int findByUserIdCNT(String b_id);

	// 게시글 코드로 게시글 찾기
	public BoardAndSongDTO findByIdResultMap(Long b_code);

	// 조회수
	public int updateHit(Long b_code);
	// like수 ++
	public int likeCountUp(Long b_code);
	// like수 --
	public int likeCountDown(Long b_code);

	// 찜수 조회
	public int showLikeCnt(Long b_code);
}