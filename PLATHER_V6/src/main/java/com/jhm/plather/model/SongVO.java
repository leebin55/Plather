package com.jhm.plather.model;

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
public class SongVO {
	private Long s_seq; // PK
	private Long s_bcode; 
	private String s_title;
	private String s_singer;
}