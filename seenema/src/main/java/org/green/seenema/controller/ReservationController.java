package org.green.seenema.controller;

import lombok.extern.slf4j.Slf4j;
import org.green.seenema.mapper.MovieMapper;
import org.green.seenema.mapper.ReservationMapper;
import org.green.seenema.mapper.TheaterCRUDMapper;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.ReservationVO;
import org.green.seenema.vo.TheaterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Date;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/user")
public class ReservationController {
    @Autowired
    ReservationMapper reservationMapper;
    @Autowired
    MovieMapper movieMapper;

    @Autowired
    TheaterCRUDMapper tcMapper;
    @GetMapping("/reservationMain")
    public void reservation(Model model){
        List<TheaterVO> tlist = tcMapper.getListGroupByPlace();
        List<MovieVO> mlist = movieMapper.getMovieList();
        model.addAttribute("tlist",tlist);
        model.addAttribute("mlist",mlist);
    }

    @GetMapping("/getMovieList.do") //영화목록 불러오기
    public @ResponseBody List<MovieVO> getMovieList(){
        return movieMapper.getMovieList();
    }

    @GetMapping("/getTheaterList.do") //영화관 정보 불러오기
    public @ResponseBody List<TheaterVO> TheaterList(String place){
        return tcMapper.getListWherePlace(place);
    }

    @PostMapping("/reservationSeats") //영화관 좌석선택으로 이동하기
    public void reservationSeats(Model model, ReservationVO reservation){
        model.addAttribute("reservation", reservation);
    }

    @PostMapping("/reservation.do") // 예매하기
    public String reservationdo(ReservationVO reservation, Model model){
        log.info("예약정보 : " + reservation.toString());
        int result = reservationMapper.regReservation(reservation);
        model.addAttribute("reservation", reservation);
        return "user/reservationComplete";
    }

    @GetMapping("/reservationComplete")
    public void reservationComplete(){}
}
