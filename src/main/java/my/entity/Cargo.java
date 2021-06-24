package my.entity;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "t_cargo")
public class Cargo{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private Integer price;

    @Lob
    @Type(type = "org.hibernate.type.ImageType")
//    @Column(length = Integer.MAX_VALUE, nullable = true)
    private byte[] image;

    private String description;
    private String characteristics;

    @OneToMany(mappedBy = "cargo", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<FeedBack> feedBacks;

//    @ManyToMany(fetch = FetchType.EAGER)
//    private Set<Order> orders;

    @OneToMany(mappedBy = "cargo", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderCell> orders;

    public Cargo(){}

    public Cargo(String name, String description, String characteristics) {
        this.name = name;
        this.description = description;
        this.characteristics = characteristics;
    }

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public byte[] getImages() {
        return image;
    }

    public void setImages(byte[] image) {
        this.image = image;
    }


    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCharacteristics() {
        return characteristics;
    }

    public void setCharacteristics(String characteristics) {
        this.characteristics = characteristics;
    }

    public List<FeedBack> getFeedBacks() {
        return feedBacks;
    }

    public void addFeedBack(FeedBack feedBack) {
        feedBacks.add(feedBack);
    }

    public void removeFeedBack(FeedBack feedBack) {
        feedBacks.remove(feedBack);
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public void setFeedBacks(List<FeedBack> feedBacks) {
        this.feedBacks = feedBacks;
    }

    public List<OrderCell> getOrders() {
        return orders;
    }

    public void setOrders(List<OrderCell> orders) {
        this.orders = orders;
    }

    public  void addOrder(OrderCell order){
        if (orders == null) orders = new ArrayList<>();
        orders.add(order);
    }

    public void removeOrder(OrderCell orderCell) {
        orders.remove(orderCell);
    }


    public byte[] getImage() {
        return image;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return "entity.Cargo{" +
                "id=" + id +
                ", name: " + name +
                ", description: " + description +
                ", characteristics=" + characteristics +
                "}\n";
    }
}
