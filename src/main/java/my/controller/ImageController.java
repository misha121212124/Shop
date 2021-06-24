package my.controller;

import my.entity.Cargo;
import my.service.CargoService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping("/myImage")
public class ImageController {

    @Resource(name = "cargoService")
    private CargoService cargoService;


    @RequestMapping(value = "/imageDisplay", method = RequestMethod.GET)
    public void showImage(@RequestParam("id") Long itemId, HttpServletResponse response, HttpServletRequest request)
            throws ServletException, IOException {


        Cargo cargo = cargoService.findCargoById((long) itemId);
        response.setContentType("image/jpeg, image/jpg, image/png, image/gif");
        response.getOutputStream().write(cargo.getImages());


        response.getOutputStream().close();
    }
}