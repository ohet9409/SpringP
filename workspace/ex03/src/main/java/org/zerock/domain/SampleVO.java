package org.zerock.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// setter, 생성자, toString()등을 자동 생성
@Data
// 모든속성의 생성자를 만들기 위한
@AllArgsConstructor
// 비어있는 생성자를 만들기 위한
@NoArgsConstructor
public class SampleVO {

	private Integer mno;
	private String firstName;
	private String lastName;
}
