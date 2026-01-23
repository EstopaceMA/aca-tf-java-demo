package com.example.demo;

import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.DELETE;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.NotFoundException;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.PUT;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;
import jakarta.ws.rs.Produces;
import static jakarta.ws.rs.core.MediaType.APPLICATION_JSON;
import jakarta.ws.rs.core.Response;
import jakarta.ws.rs.core.UriBuilder;
import jakarta.ws.rs.core.UriInfo;
import org.jboss.logging.Logger;

import java.util.List;

@Path("/api/todos")
@Consumes(APPLICATION_JSON)
@Produces(APPLICATION_JSON)
public class TodoResource {

    @Inject
    Logger logger;

    @Inject
    UriInfo uriInfo;

    @POST
    @Transactional
    public Response createTodo(Todo todo) {
        logger.info("Creating todo: " + todo);
        Todo.persist(todo);
        UriBuilder uriBuilder = uriInfo.getAbsolutePathBuilder().path(todo.id.toString());
        return Response.created(uriBuilder.build()).entity(todo).build();
    }

    @GET
    public List<Todo> getTodos() {
        logger.info("Getting all todos");
        return Todo.listAll();
    }

    @GET
    @Path("/{id}")
    public Todo getTodo(@PathParam("id") Long id) {
        logger.info("Getting todo: " + id);
        Todo todo = Todo.findById(id);
        if (todo == null) {
            throw new NotFoundException("Todo with id " + id + " not found");
        }
        return todo;
    }

    @PUT
    @Path("/{id}")
    @Transactional
    public Todo updateTodo(@PathParam("id") Long id, Todo updatedTodo) {
        logger.info("Updating todo: " + id);
        Todo todo = Todo.findById(id);
        if (todo == null) {
            throw new NotFoundException("Todo with id " + id + " not found");
        }
        todo.description = updatedTodo.description;
        todo.details = updatedTodo.details;
        todo.done = updatedTodo.done;
        return todo;
    }

    @DELETE
    @Path("/{id}")
    @Transactional
    public Response deleteTodo(@PathParam("id") Long id) {
        logger.info("Deleting todo: " + id);
        boolean deleted = Todo.deleteById(id);
        if (!deleted) {
            throw new NotFoundException("Todo with id " + id + " not found");
        }
        return Response.noContent().build();
    }
}
