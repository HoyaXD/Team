package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.NoticeVO;

@Mapper
public interface AdminNoticeMapper {
	
	//공지사항출력
	public List<NoticeVO> noticeView();
	
	//공지사항 선택시 출력
	public List<NoticeVO> noticeOneList(int noticeCode);
	
	//공지사항 삭제
	public void noticeDel(int noticeCode);
	
	//공지사항 수정
	public void noticeEdit(NoticeVO v);
	
	//공지사항 등록
	public void noticeRegi(NoticeVO v);

}
