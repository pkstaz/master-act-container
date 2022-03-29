package com.cestay;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;
import javax.ws.rs.Consumes;
import io.quarkus.hibernate.orm.panache.PanacheEntityBase;
import io.quarkus.hibernate.orm.panache.PanacheQuery;
import io.quarkus.panache.common.Page;

@Path("/index")
@Produces("application/json")
@Consumes("application/json")
public class EjemploResource {

    @GET
    public Response index (@QueryParam("filas") Integer limit, @QueryParam("pagina") Integer page) {

        PanacheQuery<PanacheEntityBase> ejemplo;

        if(null != page && null != limit){
            ejemplo = EjemploEntity.findAll().page(Page.of(page, limit));
        }else{
            ejemplo = EjemploEntity.findAll();
        }

        System.out.println("Carlos Estay - Actividad Semana 2 Master DevOps & Cloud Computing");
        return Response.ok(ejemplo.list()).status(200).build();
    }
}