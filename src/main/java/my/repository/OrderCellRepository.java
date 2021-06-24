package my.repository;

import my.entity.OrderCell;
import my.myclasses.OrderCellID;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderCellRepository extends JpaRepository<OrderCell, OrderCellID> {
    void deleteById(OrderCellID id);
}
