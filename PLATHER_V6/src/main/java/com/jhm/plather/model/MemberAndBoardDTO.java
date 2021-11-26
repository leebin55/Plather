package com.jhm.plather.model;


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
public class MemberAndBoardDTO {
	
	private String m_id; //VARCHAR(125) primary key, 
	private String m_nickname; //VARCHAR(20) NOT NULL, 
	private String m_birth; //CHAR(10), 
	private String m_name; //VARCHAR(125),
	private String m_gender; //CHAR(1), 
	private int m_level; //INT DEFAULT 1, 
    private int m_profile; //INT
	
    //tbl_baord와 조인할때 사용
    private List<BoardVO> boardList;
	
}
