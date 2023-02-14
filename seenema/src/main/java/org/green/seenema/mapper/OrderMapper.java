package org.green.seenema.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.green.seenema.vo.OrderVO;

@Mapper
public interface OrderMapper {
	public int buy(@Param("order") OrderVO order);
	public List<OrderVO> getOrderList(String id);
}
