package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.QnaVO;
import org.springframework.ui.Model;

@Mapper
public interface AdminQnaMapper {
	
	//관리자가 qna목록보기
	public List<QnaVO> qnaListView(); 
	
	//관리자 qna선택한 목록출력
	public QnaVO qnaOneList(int qcode); 
	

}
