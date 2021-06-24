package my.service;

import my.entity.Cargo;
import my.entity.Order;
import my.entity.User;
import my.repository.CargoRepository;
import my.repository.OrderRepository;
import my.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class OrderService {
    @PersistenceContext
    private EntityManager em;
    @Autowired
    OrderRepository orderRepository;
    @Autowired
    UserRepository userRepository;
    @Autowired
    CargoRepository cargoRepository;

    public Order getOrderById(Long id){
        Optional<Order> order = orderRepository.findById( id );
        if( !order.isPresent() )return null;
        else return order.get();
    }

    public Order getLastUserOrder(User user){
        Order order = orderRepository.findFirstByUser_idOrderByIdDesc(user.getId());
        if( order==null || !order.getStatus().equals("new order") )return null;
        return order;
    }

    public List<Order> getAllRegisteredByUser(User user){
        List<Order> orders = orderRepository.findAllByUser_id(user.getId());
        List<Order> to_remove = new ArrayList<>();
        System.out.println("count of user = "+user.getName()+"'s orders:"+orders.size());
        for (Order temp: orders) {
            if(temp.getStatus().equals("new order"))to_remove.add(temp);
        }
        for (Order temp: to_remove) {
            orders.remove(temp);
        }
        return orders;
    }

    public List<Order> getAllByUser(User user){
        return orderRepository.findAllByUser_id(user.getId());
    }

    public List<Order> getAll(){
        return orderRepository.findAll();
    }

    public List<Order> getAllNewOrder(){
        return orderRepository.findAllByStatus("processing");
    }

    public List<Order> getAllNotFinished(){
        List<Order> list = orderRepository.findAllByStatus("processing");
        list.addAll(orderRepository.findAllByStatus("submited"));
        list.addAll(orderRepository.findAllByStatus("sent"));
        list.addAll(orderRepository.findAllByStatus("delivered"));
        return list;
    }

    public boolean addOrder(Order order){
        User user = userRepository.findById(order.getUser().getId()).get();
//        Cargo cargo = cargoRepository.findById( ( order.getCargos().size()>0 )?
//                order.getCargos().get(0).getId():null ).get();

        //Cargo cargo = cargoRepository.findById(( order.getCargos().size()>0 )?
                //order.getCargos().get(0).getCargo().getId():null).get();
        if( user == null ){//|| cargo == null ){
            return false;
        }

        orderRepository.save(order);
        System.out.println("added successfully");
        return true;
    }
    public boolean deleteOrder(Long orderId) {
        if (orderRepository.findById(orderId).isPresent()) {
            orderRepository.deleteById(orderId);
            return true;
        }
        return false;
    }

    public boolean updateById( Long id, String status ){
        Order order = orderRepository.getOne(id);
        if ( order != null){
            order.setStatus( status );
            orderRepository.save(order);
            return true;
        }
        return false;
    }

}
