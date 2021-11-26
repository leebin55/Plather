package com.jhm.plather.dao;

import java.util.List;

import com.jhm.plather.model.NoticeDTO;
import com.jhm.plather.model.NoticeVO;

public interface NoticeDao extends GenericDao<NoticeVO, String> {

	public String findByMaxNcode();

	public int updateHit(String n_code);

	public List<NoticeDTO> findByTitle(String n_title);

	public List<NoticeDTO> findByNick(String n_nickname);

	public List<NoticeDTO> findByContent(String n_content);
	
	public NoticeDTO findByNcode(String n_code);

	public List<NoticeDTO> selectAllView();

}
