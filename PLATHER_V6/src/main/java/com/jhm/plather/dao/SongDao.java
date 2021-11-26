package com.jhm.plather.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jhm.plather.model.SongVO;

public interface SongDao extends GenericDao<SongVO, Long>{

	public List<SongVO> findByBoardCode(Long b_code);
	public List<SongVO> findByTitle(String s_title);
	public List<SongVO> findBySinger(String s_singer);
	public int insertWithList(
		@Param("b_code") Long b_code,
		@Param("playList") List<SongVO> playList);
}
