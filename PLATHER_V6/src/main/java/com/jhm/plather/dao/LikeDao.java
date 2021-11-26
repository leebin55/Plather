package com.jhm.plather.dao;

import java.util.List;

import com.jhm.plather.model.LikeVO;

public interface LikeDao {

	
	// 멤버 아이디로 조회해서 찜을 누른 게시물 코드를 리턴
	public List<Long> myLikeBoard(String m_id);
	// 멤버 아이디로 조회해서 찜을 누를 게시물 수 리턴
	public int myLikeBoardCNT(String m_id);
	
	// 찜 +1
	public int clickLike(LikeVO vo);
	
	// 찜 취소
	public int cancelLike(LikeVO vo);
	
	// insert 
	public int insert(LikeVO vo);
	
	//멤버아이디와 글코드로 likecheck(눌럿는지 안눌럿는지) 값 확인
	//return l_likecheck
	public int findByIdAndBCode(LikeVO vo);
	
	// 특정회원이 특정 게시물을 이전에 눌렀는지 확인할때
	// 게시물 수 리턴
	public int findByIdAndBCodeCount(LikeVO vo);
}
