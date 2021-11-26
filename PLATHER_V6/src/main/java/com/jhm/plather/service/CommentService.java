package com.jhm.plather.service;

import java.util.List;

import com.jhm.plather.model.CommentDTO;
import com.jhm.plather.model.CommentVO;

public interface CommentService {

	public int insert(CommentVO cVO);
	
	//member id로 댓글 조회
	public List<CommentDTO> findByMemberId(String c_id);
}
