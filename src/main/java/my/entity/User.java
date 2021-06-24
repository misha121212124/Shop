package my.entity;

import javax.persistence.*;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.validation.constraints.*;
import java.util.Collection;
import java.util.Set;

@Entity
@Table(name = "t_users")
public class User implements UserDetails{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Size(min=5, message = "At least 5 characters")
    private String name;

    @Size(min=3, message = "At least 3 characters")
    private String fname;

    @Size(min=5, message = "At least 5 characters")
    private String sname;

    @Min(value = 15, message = "Age should not be less than 15")
    @Max(value = 150, message = "Age should not be greater than 150")
    private byte age;
    @Pattern(regexp="(^$|[0-9]{3} [0-9]{3} [0-9]{2} [0-9]{2})")
    private  String phone;
    @Email
    private String email;
    private String adress;


    @Size(min=4, message = "At least 5 characters")
    private String password;
    @Transient
    private String passwordConfirm;


    @ManyToMany(fetch = FetchType.EAGER)
    private Set<Role> roles;


    @OneToMany(fetch =FetchType.EAGER, mappedBy = "user", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<FeedBack> feedBacks;

    public User() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return getRoles();
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return name;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPasswordConfirm() {
        return passwordConfirm;
    }

    public void setPasswordConfirm(String passwordConfirm) {
        this.passwordConfirm = passwordConfirm;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }



    public byte getAge() {
        return age;
    }

    public void setAge(byte age) {
        this.age = age;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAdress() {
        return adress;
    }

    public void setAdress(String adress) {
        this.adress = adress;
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

    public void setFeedBacks(List<FeedBack> feedBacks) {
        this.feedBacks = feedBacks;
    }

    @Override
    public String toString() {
        return "entity.User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                "}\n";
    }
}