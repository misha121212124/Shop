package my.service;

import my.entity.Cargo;
import my.entity.Order;
import my.entity.OrderCell;
import my.entity.User;
import my.myclasses.OrderCellID;
import my.repository.CargoRepository;
import my.repository.OrderCellRepository;
import my.repository.OrderRepository;
import my.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Service
public class OrderCellService {
    @PersistenceContext
    private EntityManager em;
    @Autowired
    OrderRepository orderRepository;
    @Autowired
    CargoRepository cargoRepository;
    @Autowired
    OrderCellRepository orderCellRepository;


    public boolean addOrderCell( OrderCell orderCell ){
        Order order = orderRepository.findById( orderCell.getOrder().getId() ).get();
        Cargo cargo = cargoRepository.findById( orderCell.getCargo().getId() ).get();


        if(cargo == null || order == null ){
            return false;
        }

        orderCellRepository.save(orderCell);
        System.out.println("OrderCell added successfully");
        return true;
    }
    public boolean deleteOrderCell(OrderCellID orderId) {
        System.out.println(orderId.getCargoId()+"   "+orderId.getOrderId());
        if ( orderCellRepository.findById(orderId).isPresent() ) {
            System.out.println("Yessss");
            orderCellRepository.deleteById(orderId);
            return true;
        }
        return false;
    }

    public boolean updateOrderCell( OrderCell orderCell ){
        OrderCell updated = orderCellRepository.getOne(orderCell.getId());
        if ( updated != null){
            updated.setCount(orderCell.getCount());
            orderCellRepository.save(updated);
            return true;
        }
        return  false;
    }

}
