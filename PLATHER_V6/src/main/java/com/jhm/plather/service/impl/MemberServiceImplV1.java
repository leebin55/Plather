package com.jhm.plather.service.impl;

import java.util.List;
import java.util.Random;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.jhm.plather.dao.MemberDao;
import com.jhm.plather.model.MemberAndBoardDTO;
import com.jhm.plather.model.MemberVO;
import com.jhm.plather.service.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("memberServiceV1")
@RequiredArgsConstructor
public class MemberServiceImplV1 implements MemberService {

	protected final MemberDao mbDao;

	@Override
	public MemberVO login(MemberVO mbVO, Model model) {
		// TODO 로그인
		// mbVO에서 m_id를 가져오고, findByID method를 통해 id 조회
		// 비밀 번호가 일치하는지 조회

		// mdSaveVO에 web에서 id를 입력한 값이 담김? 아이디 조회
		MemberVO mbSaveVO = mbDao.findById(mbVO.getM_id());

		// 만약 mbSaveVO가 null이면
		if (mbSaveVO == null) {

			// LOGIN_FAIL 이라는 변수에 NOT_ID 값을 담음
			model.addAttribute("LOGIN_FAIL", "NOT_ID");

			return null;
		}
		// 비밀번호 일치 조회
		// 아이디 값이 null이 아니면 mbSaveVO에 담긴 값과 mbVO에 담긴 pw 비교
		if (mbSaveVO.getM_pw().equals(mbVO.getM_pw())) {

			// 비밀번호가 일치할 경우
			return mbSaveVO;
		}

		// 일치하지 않을 경우
		// LOGIN_FAIL 이라는 변수에 DIF_PW 값을 담음
		model.addAttribute("LOGIN_FAIL", "NOT_PW");

		// 일치하는 ID는 그대로 있도록함
		model.addAttribute("USERID", mbVO.getM_id());
		return null;
	}

	@Override
	public MemberVO join(MemberVO mbVO) {
		// TODO 회원가입

		// dao에 있는 값을 전체 조회 한 다음 List에 담기
		List<MemberVO> mbList = mbDao.selectAll();

		// List에 값이 담겼는지 확인
		log.debug("mbList에 들어있는 회원 정보 : {}", mbList.toString());

		// mbList에 값이 없으면
		// 아직 member table에 데이터가 하나도 없는 상태
		// 최초로 가입신청이 된 상태임

		// 만약 mbList가 null 이거나 담긴 데이터 size가 1보다 작을 경우
		if (mbList == null || mbList.size() < 1) {
			// 일반 회원은 0으로 level 설정
			mbVO.setM_level(0);
		}

		mbDao.insertOrUpdate(mbVO);

		return mbVO;
	}

	@Override
	public MemberVO findById(String m_id) {
		// TODO Id로 값 조회(아이디 중복 검사, 로그인 시 필요)

		// VO에 dao에서 가져온 m_id 값을 담음(빈칸이 있을수 있으니 trim 사용)
		MemberVO mbVO = mbDao.findById(m_id.trim());

		// vo에 담긴 값이 null이면
		if (mbVO == null) {
			// --> 가입되지 않는 회원임

			// 확인
			log.debug("DB에 없는 회원 ID {}", m_id);

		} else {
			// null이 아니면 이미 가입되어있는 회원임

			// 확인
			log.debug("DB에 있는 회원 ID {}", mbVO.toString());
		}

		return mbVO;
	}

	@Override
	public int makeRndNum() {
		// TODO 프로필 랜덤값 자동생성

		Random rnd = new Random();

		// 0 ~ 6까지의 난수 생성
		int intNum = rnd.nextInt(7);

		log.debug("랜덤 회원값 : {}", intNum);

		return intNum;
	}

	@Override
	public MemberVO findByNick(String m_nickname) {
		// TODO 닉네임 값으로 조회(닉네임 중복검사시 필요)
		MemberVO mbVO = mbDao.findByNick(m_nickname);

		if (mbVO == null) {
			// DB에 없는 닉네임
			// 확인
			log.debug("DB에 없는 회원 nick {}", m_nickname);

		} else {
			// DB에 있는 닉네임
			// 확인
			log.debug("DB에 있는 회원 nick{}", m_nickname);
		}
		return mbVO;
	}

	@Override
	public MemberVO update(MemberVO mbVO) {
		// TODO 회원 정보 수정
		mbDao.insertOrUpdate(mbVO);
		return mbVO;
	}
	@Override
	public MemberAndBoardDTO findByIdBaord(String m_id) {
		//TODO m_id로 작성한 게시물 return
		MemberAndBoardDTO DTO = mbDao.findByIdBoardResultMap(m_id);
		
		return DTO;
	}

}