package org.green.seenema.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.OrderVO;

@Mapper
public interface OrderMapper {
	public int buy(@Param("order") OrderVO order);
}
