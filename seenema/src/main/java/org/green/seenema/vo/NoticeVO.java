package org.green.seenema.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class NoticeVO {
	private int noticeCode;
	private String title;
	private String content;
	private Timestamp regDate;
	private int hit;
}