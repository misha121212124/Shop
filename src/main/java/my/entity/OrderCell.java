package my.entity;

import my.myclasses.OrderCellID;

import javax.persistence.*;

@Entity
@Table(name = "t_order_cell")
public class OrderCell{

    @EmbeddedId
    OrderCellID id;

    @ManyToOne
    @MapsId("orderId")
    @JoinColumn(name = "order_id")
    private Order order;

    @ManyToOne
    @MapsId("cargoId")
    @JoinColumn(name = "cargo_id")
    private Cargo cargo;

    private int count;




    public OrderCell() {
    }

    public OrderCell(Order order, Cargo cargo, int count) {
        this.order = order;
        this.cargo = cargo;
        this.count = count;
        this.id = new OrderCellID(order.getId(), cargo.getId());
    }

    public void setCount(int count) {
        this.count = count;
    }

    public OrderCellID getId() {
        return id;
    }

    public Order getOrder() {
        return order;
    }

    public Cargo getCargo() {
        return cargo;
    }

    public int getCount() {
        return count;
    }

    public void setId(OrderCellID id) {
        this.id = id;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public void setCargo(Cargo cargo) {
        this.cargo = cargo;
    }
}

