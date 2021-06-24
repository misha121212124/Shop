package my.myclasses;

import my.entity.Cargo;

public class Cargo_count {
    public Cargo cargo;
    public int count;

    public Cargo_count(Cargo cargo, int count) {
        this.cargo = cargo;
        this.count = count;
    }

    public void add(int count){
        this.count += count;
    }
}
