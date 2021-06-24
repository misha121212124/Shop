package my.service;

        import my.entity.Cargo;
        import my.repository.CargoRepository;
        import my.repository.OrderRepository;
        import org.springframework.beans.factory.annotation.Autowired;
        import org.springframework.data.domain.Sort;
        import org.springframework.stereotype.Service;
        import javax.persistence.EntityManager;
        import javax.persistence.PersistenceContext;
        import java.util.List;
        import java.util.Optional;

@Service
public class CargoService {
    @PersistenceContext
    private EntityManager em;
    @Autowired
    CargoRepository cargoRepository;

    public Cargo findCargoById(Long cargoId) {
        Optional<Cargo> cargoFromDb = cargoRepository.findById(cargoId);
        return cargoFromDb.orElse(new Cargo());
    }

    public List<Cargo> allCargos() {
        return cargoRepository.findAll(Sort.by("name"));
    }


    public List<Cargo> allCargosIn(String name) {
        System.out.println(name);
        System.out.println(cargoRepository.findAllByNameLike( "%" + name + "%" ));

        return cargoRepository.findAllByNameLike( "%" + name + "%" );
    }

    public boolean saveCargo(Cargo cargo) {
        cargoRepository.save(cargo);
        return true;
    }

    public boolean deleteCargo(Long cargoId) {
        if (cargoRepository.findById(cargoId).isPresent()) {
            cargoRepository.deleteById(cargoId);
            return true;
        }
        return false;
    }
}
