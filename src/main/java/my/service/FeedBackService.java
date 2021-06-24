package my.service;

import my.entity.FeedBack;
import my.entity.Order;
import my.repository.FeedBackRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;
import java.util.Optional;

@Service
public class FeedBackService {
    @PersistenceContext
    private EntityManager em;

    @Autowired
    FeedBackRepository feedBackRepository;

    public FeedBack findFeedBackById(Long feedBackId) {
        Optional<FeedBack> feedBackFromDb = feedBackRepository.findById(feedBackId);
        return feedBackFromDb.orElse(new FeedBack());
    }

    public List<FeedBack> allFeedBack() {
        return feedBackRepository.findAll();
    }

    public List<FeedBack> allFeedBackByCargoAndByEnable(Long cargoId) {
        return feedBackRepository.findAllByCargo_idAndEnableTrue(cargoId);
    }

    public List<FeedBack> noAgreedFeedBacks(){
        return feedBackRepository.findAllByEnableFalse();
    }

    public boolean saveFeedBack(FeedBack feedBack) {
        feedBackRepository.save(feedBack);
        return true;
    }

    public boolean updateById( Long id){
        FeedBack feedBack = feedBackRepository.getOne(id);
        if ( feedBack != null){
            feedBack.setEnable( true );
            feedBackRepository.save(feedBack);
            return true;
        }
        return false;
    }

    public boolean deleteFeedBack(Long feedBackId) {
        if (feedBackRepository.findById(feedBackId).isPresent()) {
            feedBackRepository.deleteById(feedBackId);
            return true;
        }
        return false;
    }

}
