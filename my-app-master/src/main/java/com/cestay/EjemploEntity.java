package com.cestay;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

@Entity
@Table(name="ejemplo_master")
public class EjemploEntity extends PanacheEntity{
    @Column(name="codigo")
    public Integer codigo;

    @Column(name="descripcion")
    public String descripcion;

    public EjemploEntity(){
    }

    public EjemploEntity(Integer codigo, String descripcion){
        this.codigo = codigo;
        this.descripcion = descripcion;
    }
}
