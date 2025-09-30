package com.waterresources.api;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.json.Json;
import javax.json.JsonObject;

@Path("/health")
public class HealthService {
    
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response health() {
        JsonObject status = Json.createObjectBuilder()
            .add("status", "UP")
            .add("service", "Water Infrastructure API")
            .add("timestamp", System.currentTimeMillis())
            .build();
        
        return Response.ok(status).build();
    }
}