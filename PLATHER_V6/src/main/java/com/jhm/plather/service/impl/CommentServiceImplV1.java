package com.jhm.plather.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;

import com.jhm.plather.dao.CommentDao;
import com.jhm.plather.model.CommentDTO;
import com.jhm.plather.model.CommentVO;
import com.jhm.plather.service.CommentService;

import lombok.RequiredArgsConstructor;

@Service("commentServiceV1")
@RequiredArgsConstructor
public class CommentServiceImplV1 implements CommentService{

	protected final CommentDao cDao;
	
	@Override
	public int insert(CommentVO cVO) {
		// TODO Auto-generated method stub
		
		cDao.insert(cVO);
		return 0;
	}
	@Override
	public List<CommentDTO> findByMemberId(String c_id) {
		// Member Id로 comment 조회
		
		List<CommentDTO> cDTO =cDao.findByMemberId(c_id);
		return cDTO;
	}
}
