package com.jhm.plather.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {

	// table_member
	private String m_id; // VARCHAR(125) primary key,
	private String m_pw; // VARCHAR(50) NOT NULL,
	private String m_nickname; // VARCHAR(20) NOT NULL,
	private String m_birth; // CHAR(10),
	private String m_name; // VARCHAR(125),
	private String m_gender; // CHAR(1),
	private int m_level; // INT DEFAULT 1,
	private int m_profile; // INT

	// 회원가입 페이지에서 비밀번호 확인할때 사용
	private String re_pw;
}