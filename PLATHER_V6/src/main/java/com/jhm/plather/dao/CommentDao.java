package com.jhm.plather.dao;

import java.util.List;

import com.jhm.plather.model.CommentDTO;
import com.jhm.plather.model.CommentVO;

public interface CommentDao extends GenericDao<CommentVO, String>{

	public List<CommentDTO> findByCbcode(Long b_code);
	
	//member id로 댓글조회
	public List<CommentDTO> findByMemberId(String c_id);

}