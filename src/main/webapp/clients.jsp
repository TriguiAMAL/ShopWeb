<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="tn.enis.entity.Client"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bank</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<link href="css/bootstrap.min.css" rel="stylesheet">
<script src="js/bootstrap.min.js"></script>
<script>
function mas(cin) {
                var lastFourDigits = cin.slice(-4);
                var maskedCIN = "*****" + lastFourDigits;
                return maskedCIN;
            }
</script>

</head>
<body>
    <div class="container">
        <h1>Ajout Client</h1>
        <form action="ClientController" method="GET" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="cin">CIN</label> <input type="text" class="form-control"
                    id="cin" name="cin">
            </div>
            <div class="form-group">
                <label for="nom">Nom</label> <input type="text" class="form-control"
                    id="nom" name="nom">
            </div>
            <div class="form-group">
                <label for="prenom">Prénom</label> <input type="text"
                    class="form-control" id="prenom" name="prenom">
            </div>
            <button type="submit" class="btn btn-primary" name="action"
                value="add">Ajouter</button>
        </form>
        <br>
        <form action="ClientController" method="GET">
            <input type="hidden" name="action" value="list" /> <input
                type="submit" class="btn btn-primary" value="Liste des Clients" />
        </form>

        <div id="clientList" style="display: none;">
            <h1>Liste de clients</h1>
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
                            <td><script>document.write(mas("${client.cin}"));</script></td>
                            <td>${client.nom}</td>
                            <td>${client.prenom}</td>
                            <td>
                                <div class="btn-group" role="group" aria-label="Actions">
                                    <form action="ClientController" method="GET">
                                        <input type="hidden" name="action" value="delete" /> <input
                                            type="hidden" name="cin" value="${client.cin}" />
                                        <button type="button" class="btn btn-danger"
                                            onclick="confirmDelete('${client.cin}')">Supprimer</button>
                                    </form>
                                    <form action="ClientController" method="GET">
                                        <input type="hidden" name="action" value="edit" /> <input
                                            type="hidden" name="cin" value="${client.cin}" />
                                        <button type="submit" class="btn btn-warning ml-2">Modifier</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <script>
            
            $(document).ready(function() {
                <%if ("list".equals(request.getParameter("action"))) {%>
                    $("#clientList").show();
                <%}%>

                <%if (request.getAttribute("error") != null) {%>
                    Swal.fire({
                        title: "Erreur!",
                        text: "<%=request.getAttribute("error")%>",
                        icon: "error",
                        confirmButtonText: "OK"
                    });
                <%}%>

                <%if (request.getAttribute("success") != null) {%>
                    Swal.fire({
                        title: "Succès!",
                        text: "<%=request.getAttribute("success")%>",
                        icon: "success",
                        confirmButtonText: "OK"
                    });
                <%}%>
            });

            function validateForm() {
                var cin = document.getElementById("cin").value;
                var nom = document.getElementById("nom").value;
                var prenom = document.getElementById("prenom").value;

                if (cin.length !== 8 || nom.trim() === "" || prenom.trim() === "") {
                    Swal.fire({
                        title: "Erreur!",
                        text: "Veuillez remplir tous les champs du formulaire.",
                        icon: "error",
                        confirmButtonText: "OK"
                    });
                    return false;
                }
                return true; 
            }

            function confirmDelete(cin) {
                Swal.fire({
                    title: "Êtes-vous sûr(e) de vouloir supprimer ??",
                    text: "Vous ne pourrez pas revenir en arrière !",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "Oui, supprimez-le !"
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
