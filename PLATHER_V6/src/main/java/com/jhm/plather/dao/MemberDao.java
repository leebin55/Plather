package com.jhm.plather.dao;

import com.jhm.plather.model.MemberAndBoardDTO;
import com.jhm.plather.model.MemberVO;

public interface MemberDao extends GenericDao<MemberVO, String> {

	// 값이 있으면 update 없으면 insert 수행 method
	public int insertOrUpdate(MemberVO mbVO);

	// DB에 프로필 랜덤값 저장
	public int makeRedNum();

	// 닉네임 값으로 조회
	public MemberVO findByNick(String m_nickname);
	
	// 특정 m_id가 작성한 게시글을 찾기
		public MemberAndBoardDTO findByIdBoardResultMap(String m_id);
}