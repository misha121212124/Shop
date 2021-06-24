package my.entity;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "t_order")
public class Order{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String address;
    private String status;

    @ManyToOne(fetch = FetchType.EAGER)
    private User user;

//    @Transient
//    @ManyToMany(mappedBy = "order_cell")
//    private List<Cargo> cargos;

    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    //@OneToMany()
    private List<OrderCell> cargos;


    public Order() {
        cargos =  new ArrayList<>();
    }

    public Order(String address, String status, User user) {
        this.address = address;
        this.status = status;
        this.user = user;
    }

    public Long getId() {
        return id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<OrderCell> getCargos() {
        return cargos;
    }

    public void setCargos(List<OrderCell> cargos) {
        this.cargos = cargos;
    }

    public void addCargo(OrderCell cargo){
        if (cargos == null) cargos = new ArrayList<>();
        cargos.add(cargo);
    }

    public void removeCargo(OrderCell cargo){
        cargos.remove(cargo);
    }


    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "entity.Order{" +
                "id=" + id +
                ", address: " + address +
                ", status: " + status +
                ", user=" + user +
                "}\n";
    }
}
