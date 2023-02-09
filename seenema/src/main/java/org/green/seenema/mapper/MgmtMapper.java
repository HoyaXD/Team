package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.MemberVO;

@Mapper
public interface MgmtMapper {
	
	//관리자가 회원목록보기
	public List<MemberVO> memberView();
	
	//관리자가 회원목록삭제
	public void memberDel(String id);
	
	//관리자가 수정을 위한 한명의 회원목록 출력
	public List<MemberVO> oneMemList(@Param("userid") String id);
	
	//관리자가 회원목록 수정하기
	public void editInfo(MemberVO v);
}
