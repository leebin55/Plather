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
public class LikeVO {

	private Long l_seq; //pk
	private String l_id ;//member id
	private Long l_bcode; //board code
	private int l_likecheck; //1 : 좋아요누를때 0: 안눌렀을때 
}
