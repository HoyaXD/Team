package org.green.seenema.vo;

import lombok.Data;

@Data
public class OrderVO {
	private String orderNum;
	private	int productCode;
	private int price;
	private int count;
	private String id;
	private String orderDate;
}
