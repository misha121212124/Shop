package my.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "t_feedback")
public class FeedBack{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String text;
    @ManyToOne(fetch = FetchType.EAGER)
    User user;
    @ManyToOne(fetch = FetchType.EAGER)
    Cargo cargo;

    private Boolean enable = false;

    public FeedBack(){}

    public FeedBack(String text, User user, Cargo cargo){
            //Hotel hotel, Integer room, Date date, User user) throws Exception {
        this.text = text;
        this.user = user;
        this.cargo = cargo;
        user.addFeedBack(this);
        cargo.addFeedBack(this);
//        hotel.addBooking(this);
//        user.addBooking(this);
//        System.err.println("Booking of the room " + room + " is possible.");
    }

    public Long getId() {
        return id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Cargo getCargo() {
        return cargo;
    }

    public void setCargo(Cargo cargo) {
        this.cargo = cargo;
    }

    public boolean isEnable() {
        return enable;
    }

    public void setEnable(boolean enable) {
        this.enable = enable;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "entity.FeedBack{" +
                "id=" + id +
                ", text: " + text +
                ", enable: " + enable +
                ", user:" + user +
                ", cargo:" + cargo +
                "}\n";
    }
}
