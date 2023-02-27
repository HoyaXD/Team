package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.NoticeVO;

@Mapper
public interface UserNoticeMapper {
	// 공지 목록
	public List<NoticeVO> getNoticeList(int count);
	// 공지 갯수
	public int getNoticeCount();
	// 공지 상세
	public NoticeVO getNoticeInfo(int noticeCode);
	// 공지 이전글 가져오기
	public NoticeVO getPrevContent(int noticeCode);
	// 공지 다음글 가져오기
	public NoticeVO getNextContent(int noticeCode);
	// 공지 조회수 업데이트
	public void plusView(int noticeCode);
}
