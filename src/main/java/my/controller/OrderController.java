package my.controller;

import my.entity.Cargo;
import my.entity.Order;
import my.entity.OrderCell;
import my.entity.User;
import my.service.CargoService;
import my.service.OrderCellService;
import my.service.OrderService;
import my.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;
import java.util.List;

@Controller
public class OrderController {
    @Autowired
    private UserService userService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private CargoService cargoService;
    @Autowired
    private OrderCellService orderCellService;


    @Transactional
    @GetMapping("/basket")
    public String orders(Model model) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        User user = (User)authentication.getPrincipal();
        Order order = orderService.getLastUserOrder(user);
        if ( order != null ){
            model.addAttribute("order", order.getCargos());
            model.addAttribute("order_id",order.getId());
        }

        //model.addAttribute("order", order.getCargos());


        List<Order> allOrders = orderService.getAllRegisteredByUser(user);
//
//        List<Long> allId = new ArrayList<>();
//        for (Order temp: allOrders) {
//            allId.add(temp.getId());
//        }
//        ArrayList <Cargo> cargos = new ArrayList<>();
//        for (OrderCell temp:order.getCargos()) {
//            cargos.add( temp.getCargo() );
//        }
//
//        Order_Cargo order_cargo = new Order_Cargo(order.getId(),cargos);
//
//        model.addAttribute("order", order_cargo);
        //model.addAttribute(allId);
        if(allOrders.size()==0) allOrders=null;
//            System.out.println(allOrders.size());
            model.addAttribute("allOrders",allOrders);

        return "basket";
    }

//    @Transactional
//    @GetMapping("/basket2")
//    public String orders2(Model model) {
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//        User user = (User)authentication.getPrincipal();
//        Order order = orderService.getLastUserOrder(user);
//        ArrayList <Cargo> cargos = new ArrayList<>();
//        for (OrderCell temp:order.getCargos()) {
//            cargos.add( temp.getCargo() );
//        }
//
//        model.addAttribute("order", cargos);
//
//        return "basket2";
//    }

    @Transactional
    @GetMapping("/basket_order/{name}")
    public String  cargoLikeList(@RequestParam String name, Model model) {
        if(name.equals("")){
            model.addAttribute("allCargos", cargoService.allCargos());
        }else{
            model.addAttribute("allCargos", cargoService.allCargosIn(name));
        }
        return "cargo_search";
    }

    @PostMapping("/basket_remove")///////////////////////////
    public String  removeCargo(@RequestParam(required = true, defaultValue = "" ) Long orderId,
                              @RequestParam(required = true, defaultValue = "" ) Long cargoId,
                              @RequestParam(required = true, defaultValue = "" ) String action,
                              Model model) {
        if (action.equals("deleteCargoFromBasket")){
            System.out.println("009009009909909\n\n90909\n\n");
            Order order = orderService.getOrderById(orderId);
            System.out.println(orderId);
            Cargo cargo = cargoService.findCargoById(cargoId);
            System.out.println(cargo.getId());
            for (OrderCell temp: order.getCargos()) {
                System.out.println("\t11\n");
                if(temp.getCargo().equals(cargo)){
                    System.out.println("\t\t22\n");
                    order.getCargos().remove(temp);
                    cargo.getOrders().remove(temp);
                    orderCellService.deleteOrderCell(temp.getId());
                    break;
                }
            }

            //String result = "";
            //model.addAttribute(cargo);
            //model.addAttribute(result);

        }
        return "redirect:/basket";

    }

    @PostMapping("/submit_order")///////////////////////////
    public String  submitOrder(@RequestParam(required = true, defaultValue = "" ) Long  orderId,
                              Model model) {
        System.out.println(orderId);
        orderService.updateById(orderId, "processing");

        return "redirect:/basket";

    }


}
