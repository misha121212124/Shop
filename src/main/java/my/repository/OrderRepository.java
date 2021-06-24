package my.repository;

import my.entity.FeedBack;
import my.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
//    Order find

    //@Query(value = "select u from t_order u where u.user_id = ?1 ORDER BY t_order.id DESC LIMIT 1", nativeQuery = true)
Order findFirstByUser_idOrderByIdDesc(Long userId);
Optional<Order> findById(Long id);

List<Order> findAllByUser_id(Long userId);

List<Order> findAllByStatus(String status);

}
