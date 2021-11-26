package com.jhm.plather.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Builder
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class PageDTO {

	//nav를 위한 변수
	private int startPage;
	private int endPage;
	private int totalPages;
	
	// 리스트에서 필요한 데이터를 추출하기 위한 변수
	private int offset;
	private int limit;
}