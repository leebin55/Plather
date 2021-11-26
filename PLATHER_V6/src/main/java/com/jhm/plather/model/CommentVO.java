package com.jhm.plather.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CommentVO {
	private int c_seq;
	private String c_bcode;
	private String c_id;
	private String c_comment;
	private String c_date;
	private String c_title;
	private String c_singer;
}
