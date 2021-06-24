package my.repository;

        import my.entity.Cargo;
        import org.springframework.data.jpa.repository.JpaRepository;

        import java.util.List;

public interface CargoRepository extends JpaRepository<Cargo, Long> {
    List<Cargo> findAllByNameLike(String name);
}

