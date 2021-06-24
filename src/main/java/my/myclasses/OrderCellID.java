package my.myclasses;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class OrderCellID implements Serializable {

    @Column(name = "order_id")
    Long orderId;

    @Column(name = "cargo_id")
    Long cargoId;

    public OrderCellID(){}

    public OrderCellID(Long orderId, Long cargoId) {
        this.orderId = orderId;
        this.cargoId = cargoId;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null || getClass() != obj.getClass())
            return false;
        OrderCellID oci = (OrderCellID) obj;
        return Objects.equals(oci.cargoId,cargoId) && Objects.equals(oci.orderId,orderId);
    }

    public Long getOrderId() {
        return orderId;
    }

    public Long getCargoId() {
        return cargoId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public void setCargoId(Long cargoId) {
        this.cargoId = cargoId;
    }
}
