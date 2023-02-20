package org.green.seenema.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.ReservationVO;

import java.util.List;

@Mapper
public interface ReservationMapper {
    public List<ReservationVO> searchReservation(String id);

    public int regReservation(ReservationVO reservation);

    public List<ReservationVO> loadSeats(ReservationVO reservation);
}
