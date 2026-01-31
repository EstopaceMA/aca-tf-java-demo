package com.example.demo;

import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.core.Response;
import java.net.URI;

@Path("/")
public class RootResource {

    @GET
    public Response redirectToSwagger() {
        return Response.temporaryRedirect(URI.create("/swagger")).build();
    }
}
