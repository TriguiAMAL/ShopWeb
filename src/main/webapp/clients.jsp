<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="tn.enis.entity.Client"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>shop</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <h1>Ajout Client</h1>
    <form action="ClientController" method="GET">
        <div class="form-group">
            <label for="cin">CIN</label>
            <input type="text" class="form-control" id="cin" name="cin">
        </div>
        <div class="form-group">
            <label for="nom">Nom</label>
            <input type="text" class="form-control" id="nom" name="nom">
        </div>
        <div class="form-group">
            <label for="prenom">Prénom</label>
            <input type="text" class="form-control" id="prenom" name="prenom">
        </div>
        <button type="submit" class="btn btn-primary" name="action" value="add">Ajouter</button>
    </form>

    <form action="ClientController" method="GET">
        <input type="hidden" name="action" value="list"/>
        <input type="submit" class="btn btn-primary" value="Liste des Clients"/>
    </form>

    <h1>Liste des Clients</h1>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>CIN</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${clients}" var="client">
                <tr>
                    <td>${client.cin}</td>
                    <td>${client.nom}</td>
                    <td>${client.prenom}</td>
                    <td>
                        <form action="ClientController" method="GET">
                            <input type="hidden" name="action" value="delete"/>
                            <input type="hidden" name="cin" value="${client.cin}"/>
                            <button type="button" class="btn btn-danger" onclick="confirmDelete('${client.cin}')">Supprimer</button>

                        </form>
                        <form action="ClientController" method="GET">
                            <input type="hidden" name="action" value="edit"/>
                            <input type="hidden" name="cin" value="${client.cin}"/>
                            <button type="submit" class="btn btn-warning">Modifier</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    <script>
    function confirmDelete(cin) {
        Swal.fire({
            title: "Are you sure?",
            text: "You won't be able to revert this!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Yes, delete it!"
        }).then((result) => {
            if (result.isConfirmed) {
               
                window.location.href = "ClientController?action=delete&cin=" + cin;
            }
        });
    }
</script>
    
</div>
</body>
</html>
