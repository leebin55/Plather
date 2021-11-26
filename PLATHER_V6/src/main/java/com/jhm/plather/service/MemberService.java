package com.jhm.plather.service;

import org.springframework.ui.Model;

import com.jhm.plather.model.MemberAndBoardDTO;
import com.jhm.plather.model.MemberVO;

public interface MemberService {

	// 회원가입
	public MemberVO join(MemberVO mbVO);

	// ID로 값 조회
	public MemberVO findById(String m_id);

	// 로그인
	public MemberVO login(MemberVO mbVO, Model model);

	// 프로필 랜덤값 자동생성
	public int makeRndNum();

	// 닉네임 값 조회
	public MemberVO findByNick(String m_nickname);

	public MemberVO update(MemberVO mbVO);
	
	// 게시물 조회
	public MemberAndBoardDTO findByIdBaord(String m_id);
		

}