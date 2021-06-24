package my.repository;

import my.entity.FeedBack;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FeedBackRepository extends JpaRepository<FeedBack, Long> {
    List<FeedBack> findAllByCargo_id(Long cargoId);
    List<FeedBack> findAllByCargo_idAndEnableTrue(Long cargoId);
    List<FeedBack> findAllByEnableFalse();
    void deleteById(Long id);



}