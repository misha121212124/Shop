
package my.controller;

import my.entity.*;

import my.service.CargoService;
//import my.service.ImageGalleryService;
import my.service.FeedBackService;
import my.service.OrderCellService;
import my.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Controller
public class CargoController {


    @Autowired
    private CargoService cargoService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderCellService orderCellService;

    @Autowired
    private FeedBackService feedBackService;

    @GetMapping("/cargo_search")
    public String cargoList(Model model) {
        model.addAttribute("allCargos", cargoService.allCargos());
        return "cargo_search";
    }

    @GetMapping("/addCargo")
    public String addCargo(Model model) {
        return "addCargo";
    }

    @Transactional
    @GetMapping("/cargo_search/{name}")
    public String  cargoLikeList(@RequestParam String name, Model model) {
        if(name.equals("")){
            model.addAttribute("allCargos", cargoService.allCargos());
        }else{
            model.addAttribute("allCargos", cargoService.allCargosIn(name));
        }
        return "cargo_search";
    }

    @PostMapping("/cargo_search")
    public String  cargo_info(@RequestParam(required = true, defaultValue = "" ) Long cargoId,
                                @RequestParam(required = true, defaultValue = "" ) String action,
                                Model model) {
        if (action.equals("showCargo")){
            Cargo cargo = cargoService.findCargoById(cargoId);
//            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//            User user = (User)authentication.getPrincipal();

//
            String result = "";
            model.addAttribute(cargo);
            model.addAttribute(result);
            List<FeedBack> feedBacks = feedBackService.allFeedBackByCargoAndByEnable(cargo.getId());
            if (feedBacks.size()==0)feedBacks=null;
            model.addAttribute("feedbacks", feedBacks);

            return "cargo_info";
        }else {
            cargoService.deleteCargo(cargoId);
            return "redirect:/cargo_search";
        }
    }

    @PostMapping("/cargo_info")
    public String  orderCargo(@RequestParam(required = true, defaultValue = "" ) Long cargoId,
                                @RequestParam(required = true, defaultValue = "" ) String action,
                                @RequestParam(required = true, defaultValue = "1") int count,
                                @RequestParam(defaultValue = "") String address,
                                Model model) {
        String result = null;
        if (action.equals("order")){
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            User user;
            if (authentication.isAuthenticated()){
                user = (User)authentication.getPrincipal();
            }else {
                return  "redirect:/login";
            }

            Cargo cargo = cargoService.findCargoById(cargoId);
            Order order = orderService.getLastUserOrder(user);
            if(address.length()<1)address = user.getAdress();
            if(address.length()<1){
                result = "Вкажіть адресу!";
                model.addAttribute(cargo);
                List<FeedBack> feedBacks = feedBackService.allFeedBackByCargoAndByEnable(cargo.getId());
                model.addAttribute("feedbacks", feedBacks);
                model.addAttribute(result);
                return "cargo_info";/// redirect?
            }
            boolean isPresent = false;
            if(order == null) {
                System.out.println("There is no orders");
                order = new Order(address, "new order", user);
                orderService.addOrder(order);
            }else{
                System.out.println("УРААААААА!!!!\n\n");
                System.out.println(order.getCargos().size());
                for (OrderCell temp:order.getCargos()) {
                    if( temp.getCargo() != null && temp.getCargo().getId().equals(cargo.getId()) ){
                        isPresent = true;
                        temp.setCount(temp.getCount()+count);
                        orderCellService.updateOrderCell(temp);
                        break;
                    }
                }
            }
            if ( !isPresent ){
                OrderCell orderCell = new OrderCell(order, cargo, count);
                if(orderCellService.addOrderCell(orderCell)) {
                    result = "Товар додано до корзини";
                    order.addCargo(orderCell);
                    cargo.addOrder(orderCell);
                }
                else result = "Помилка! Перезавантажте сторінку та спробуйте знову";
            }else result = "Збільшено кількість одиниць товару";


            model.addAttribute(cargo);
            List<FeedBack> feedBacks = feedBackService.allFeedBackByCargoAndByEnable(cargo.getId());
            model.addAttribute("feedbacks", feedBacks);
            model.addAttribute(result);

            return "cargo_info";
        }
            //cargoService.deleteCargo(cargoId);
            return "redirect:/cargo_search";

    }

    @PostMapping("/cargo_info/addFeedBack")///////////////////////////
    public String  addFeedBackToCargo(@RequestParam(required = true, defaultValue = "" ) Long cargoId,
                              @RequestParam(required = true, defaultValue = "" ) String action,
                              @RequestParam(defaultValue = "") String text,
                              Model model) {
        String result = null;

        if(action.equals("addFeedBack")){
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            User user;
            if (authentication.isAuthenticated()){
                user = (User)authentication.getPrincipal();
            }else {
                return  "redirect:/login";
            }
            Cargo cargo = cargoService.findCargoById(cargoId);
            FeedBack feedBack = new FeedBack(text, user, cargo);
            feedBackService.saveFeedBack(feedBack);
            model.addAttribute(cargo);
            List<FeedBack> feedBacks = feedBackService.allFeedBackByCargoAndByEnable(cargo.getId());
            model.addAttribute("feedbacks", feedBacks);

        }

        //cargoService.deleteCargo(cargoId);
        return "cargo_info";

    }

    @PostMapping("/addCargo")
    public @ResponseBody
    ResponseEntity<?> createProduct(@RequestParam("name") String name,
                                    @RequestParam("characteristics") String characteristics,
                                    @RequestParam("description") String description,
                                    @RequestParam("price") String price,
                                    Model model, HttpServletRequest request,
                                    final @RequestParam("image") MultipartFile file) {
        try {
            String fileName = file.getOriginalFilename();
            if (fileName == null || fileName.contains("..")) {
                System.out.println("68767");/////////////////////
                model.addAttribute("invalid", "Invalid path sequence \" + fileName");
                return new ResponseEntity<>("Ivalid path sequence " + fileName, HttpStatus.BAD_REQUEST);
            }

            Cargo cargo = new Cargo();
            cargo.setName(name);
            //cargo.setImages(new ArrayList<ImageGalery>());

            cargo.setDescription(description);
            cargo.setCharacteristics(characteristics);
            cargo.setPrice(Integer.parseInt(price));

            byte[] imageData = file.getBytes();
            cargo.setImages(imageData);
            //ImageGalery imageGalery = new ImageGalery();
            //imageGalery.setImage(imageData);
            //imageGalery.setCargo(cargo);
            if (!cargoService.saveCargo(cargo)){
                System.out.println("78777878");///////
                return new ResponseEntity<>("Помилка. Перезавантажте сторінку та спробуйте ще раз.",HttpStatus.BAD_REQUEST);
            }
            //imageGalleryService.saveImage(imageGalery);
            return new ResponseEntity<>("Product Saved With File - " + fileName, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }



}
