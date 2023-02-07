package org.green.seenema.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class ReplyVO {
	private int replyCode;
	private String id;
	private String movieCode;
	private String comment;
	private int rate;
}
