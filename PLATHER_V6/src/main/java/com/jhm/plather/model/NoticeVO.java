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
public class NoticeVO {

	private String n_code;
	private String n_title;
	private String n_content;
	private String n_date;
	private String n_time;
	private String n_mcode;
	private int n_hit;

}
