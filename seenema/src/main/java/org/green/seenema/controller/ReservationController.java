package org.green.seenema.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
@RequestMapping("/user")
public class ReservationController {
    @GetMapping("/reservation")
    public void reservation(){
        log.info("예약페이지...");
    }
}
