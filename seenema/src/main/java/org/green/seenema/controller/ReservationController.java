package org.green.seenema.controller;

import lombok.extern.slf4j.Slf4j;
import org.green.seenema.mapper.MovieCRUDMapper;
import org.green.seenema.mapper.MovieMapper;
import org.green.seenema.mapper.ReservationMapper;
import org.green.seenema.mapper.TheaterCRUDMapper;
import org.green.seenema.vo.MovieVO;
import org.green.seenema.vo.ReservationVO;
import org.green.seenema.vo.TheaterVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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

    @Autowired
    MovieCRUDMapper movieCRUDMapper;

    @GetMapping("/reservationMain") //예약 메인으로 가기
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
        model.addAttribute("seats", "");
        model.addAttribute("theater", "");

    }

//    @PostMapping("/reservation.do") // 예매하기
//    public String reservationdo(ReservationVO reservation, Model model){
//        log.info("예약정보 : " + reservation.toString());
//        reservationMapper.cntPlus(reservation.getMovieCode());
//        int result = reservationMapper.regReservation(reservation);
//        model.addAttribute("reservation", reservation);
//        return "user/reservationComplete";
//    }

    @PostMapping("/reservation.do") //예매실행
    @Transactional
    public String reservationdo(ReservationVO reservation, Model model) {
        log.info("예약정보 : " + reservation.toString());
        reservationMapper.cntPlus(reservation.getMovieCode());
        int result = reservationMapper.regReservation(reservation);
        MovieVO movie = movieCRUDMapper.selectOne(reservation.getMovieCode());
        model.addAttribute("reservation", reservation);
        model.addAttribute("movie", movie);
        return "user/reservationComplete";
    }

    @GetMapping("/reservationComplete") //예매 성공페이지로 이동
    public void reservationComplete(){}



}
