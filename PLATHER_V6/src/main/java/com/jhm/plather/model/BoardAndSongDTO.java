package com.jhm.plather.model;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor

//board와 song 테이블 조인
public class BoardAndSongDTO {

	private Long b_code;
	private String b_title;
	private String b_content;
	private Date b_date;  
	private Date b_moddate;
	private String b_id; 
	private String b_nick;
	private String b_hit;
	private String b_like;
	private List<SongVO> playList;
}
