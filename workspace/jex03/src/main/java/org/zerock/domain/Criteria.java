package org.zerock.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {

	private int pageNum;
	private int amount;
	
	private String keyword;
	private String type;
	
	public Criteria() {
		this(1,10);
	}
	
	public Criteria(int PageNum, int amount) {
		this.pageNum = PageNum;
		this.amount = amount;
	}
	
public String[] getTypeArr() {
		
		return type == null? new String[] {}: type.split("");
	}
}
