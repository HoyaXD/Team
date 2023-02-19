package org.green.seenema.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.ReplyVO;

@Mapper
public interface ReplyMapper {
	public int regReply(ReplyVO reply);
	public ArrayList<ReplyVO> getReplyList(int movieCode);
	public ReplyVO getReplyInfo(int replyCode);
	public int updateReply(ReplyVO reply);
	public int deleteReply(int replyCode);
}
