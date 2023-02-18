package org.green.seenema.user.main.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.green.seenema.vo.MovieVO;

@Mapper
public interface UserMainMapper {
	public List<MovieVO> getMainMovieList();
	public MovieVO getMovieDetail(String movieCode);
}
