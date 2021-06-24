package my.controller;

import my.entity.*;
import my.myclasses.Cargo_count;
import my.myclasses.PDFExporter;
import my.service.FeedBackService;
import my.service.OrderCellService;
import my.service.OrderService;
import my.service.UserService;
import org.dom4j.DocumentException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class ManagerController {
    @Autowired
    private UserService userService;
    @Autowired
    private FeedBackService feedBackService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderCellService orderCellService;

    @GetMapping("/")
    public String getUser(Model model){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if(!authentication.getPrincipal().equals("anonymousUser")) {
            System.out.println(authentication.getPrincipal());
            model.addAttribute("user", (User) authentication.getPrincipal());
            System.out.println(((User)authentication.getPrincipal()).getName());

        }
        return "redirect:/cargo_search";
    }

    @GetMapping("/manager")
    public String userList(Model model) {
        model.addAttribute("allUsers", userService.allUsers());
        return "manager";
    }

    @GetMapping("/feedBacks")
    public String getFeedBacks(Model model){
        model.addAttribute("feedbacks", feedBackService.noAgreedFeedBacks());

        return "feedBacks";
    }

    @GetMapping("/orders/export/pdf")
    public void exportToPDF(HttpServletResponse response) throws DocumentException, IOException {
        response.setContentType("application/pdf");
        DateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss");
        String currentDateTime = dateFormatter.format(new Date());

        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=sales_" + currentDateTime + ".pdf";
        response.setHeader(headerKey, headerValue);

//        List<User> listUsers = service.listAll();


        List<Cargo_count> cargo_countList = new ArrayList<>();
        List<Order> orderList = orderService.getAll();
        for (Order order:orderList) {
            if (order.getStatus().equals("completed")){
                for (OrderCell orderCell:order.getCargos()) {
                    Long id = orderCell.getCargo().getId();
                    boolean flag = false;
                    for (Cargo_count cargoCount:cargo_countList) {
                        if(cargoCount.cargo.getId().equals(id)){
                            cargoCount.add(orderCell.getCount());
                            flag=true;
                            break;
                        }
                    }
                    if(!flag)
                        cargo_countList.add(new Cargo_count(orderCell.getCargo(),orderCell.getCount()));
                }
            }
        }

        for (Cargo_count cargoCount: cargo_countList) {
            System.out.println(cargoCount.cargo.getName()+ " " + cargoCount.count);
        }

//        UserPDFExporter exporter = new UserPDFExporter(listUsers);
//        exporter.export(response);
        PDFExporter exporter = new PDFExporter(cargo_countList);
        exporter.export(response);

    }

    @GetMapping("/manager_basket")
    public String newOrders(Model model) {

//        model.addAttribute("allOrders", orderService.getAllNewOrder());
        model.addAttribute("allOrders", orderService.getAllNotFinished());

        return "manager_basket";
    }

    @PostMapping("/manager")
    public String  processingUser(@RequestParam(required = true, defaultValue = "" ) Long userId,
                              @RequestParam(required = true, defaultValue = "" ) String action,
                              Model model) {
        if (action.equals("delete")){
            userService.deleteUser(userId);
            return "redirect:/manager";
        }else{
            if (action.equals("show")){
                User user = userService.findUserById(userId);
                model.addAttribute(user);///////////////////////////////////////////////
                List<Order> allOrders = orderService.getAllByUser(user);
                if(allOrders.size()==0) allOrders=null;
                model.addAttribute("allOrders",allOrders);

                return "user_details";
            }
        }
        return "redirect:/manager";
    }

    @PostMapping("/feedBacks")
    public String  feedBackDecision(@RequestParam(required = true, defaultValue = "" ) Long feedBackId,
                                  @RequestParam(required = true, defaultValue = "" ) String action,
                                  Model model) {
        System.out.println(feedBackId);
        if (action.equals("deleteFeedBack")){
            FeedBack feedBack = feedBackService.findFeedBackById(feedBackId);
            feedBack.getCargo().removeFeedBack(feedBack);
            feedBack.getUser().removeFeedBack(feedBack);
            feedBackService.deleteFeedBack(feedBackId);
            //userService.deleteUser(userId);
            //return "redirect:/feedBacks";
        }
        if (action.equals("submitFeedBack")){
            feedBackService.updateById(feedBackId);
            //model.addAttribute(userService.findUserById(userId));
            //return "redirect:/feedBacks";
        }

        return "redirect:/feedBacks";
    }

    @PostMapping("/manager_basket")
    public String  orderDecision(@RequestParam(required = true, defaultValue = "" ) Long orderId,
                                    @RequestParam(required = true, defaultValue = "" ) String action,
                                    @RequestParam(required = false) String newStatus,
                                    Model model) {
        if (action.equals("deleteOrder")){
            Order order = orderService.getOrderById(orderId);
            if(order.getCargos()!=null && order.getCargos().size()>0){
                List<OrderCell> toRemove = new ArrayList<>();
                for (OrderCell temp: order.getCargos()) {
                    toRemove.add(temp);
                }
                for (OrderCell temp: toRemove) {
                    temp.getCargo().removeOrder(temp);
                    order.removeCargo(temp);
                    orderCellService.deleteOrderCell(temp.getId());
                }
            }
            orderService.deleteOrder(orderId);
        }
        if (action.equals("submitOrder")){
//            System.out.println(newStatus);
            orderService.updateById(orderId, newStatus);
        }

        return "redirect:/manager_basket";
    }
}
