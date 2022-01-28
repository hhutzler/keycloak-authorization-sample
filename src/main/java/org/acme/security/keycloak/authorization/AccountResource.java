package org.acme.security.keycloak.authorization;

import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import io.quarkus.security.identity.SecurityIdentity;

@Path("/accounts")
public class AccountResource {

    @Inject
    SecurityIdentity keycloakSecurityContext;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public String testAgentAction() {
        String userName;
        userName = keycloakSecurityContext.getPrincipal().getName();

        return "User " + userName + ": Can view accounts !\n\n";
    }

    @POST
    @Produces(MediaType.APPLICATION_JSON)
    public String testAdminAction() {
        String userName;
        userName = keycloakSecurityContext.getPrincipal().getName();

        return "User " + userName + ": Can create accounts !\n\n";
    }
}
