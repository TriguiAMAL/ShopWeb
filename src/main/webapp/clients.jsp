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

<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<script>
function mas(cin) {
                var lastFourDigits = cin.slice(-4);
                var maskedCIN = "*****" + lastFourDigits;
                return maskedCIN;
            }
</script>


<style>
.btn-custom {
	background-color: black;
	color: white;
	border-color: black;
}

.btn-custom:hover {
	background-color: #333;
	border-color: #333;
	color: white;
}

body {
	padding: 70px;
	background-color: #f2f2f2;
}

.header-title {
	text-align: center;
	margin-top: 20px;
	margin-bottom: 20px;
}

.form-inline {
	display: flex;
	justify-content: flex-end;
}

.table {
	margin-top: 20px;
	background-color: #f8f9fa;
}

.table th, .table td {
	border: 1px solid #dee2e6;
	padding: 8px;
	text-align: center;
}

.table th {
	background-color: #343a40;
	color: #f8f9fa;
}

.search-bar {
	flex-grow: 1;
	margin-right: 5px;
}

.btn-add {
	background-color: #1e7e34;
	border-color: #1e7e34;
}

.btn-add:hover {
	background-color: #218838;
	border-color: #218838;
}

.edit-icon, .delete-icon {
	color: #1e7e34;
	font-size: 18px;
	cursor: pointer;
	background-color: transparent;
	border: none;
	outline: none;
	padding: 0;
}
</style>
</head>
<body>
	<div class="text-right">
		<a href="home.jsp" class="btn btn-custom">Home</a>
	</div>


	<div class="container">
		<h1>Ajout Client</h1>
		<form action="ClientController" method="GET"
			onsubmit="return validateForm()">
			<div class="form-group">
				<label for="cin">CIN</label> <input type="text" class="form-control"
					id="cin" name="cin">
			</div>
			<div class="form-group">
				<label for="nom">First name</label> <input type="text" class="form-control"
					id="nom" name="nom">
			</div>
			<div class="form-group">
				<label for="prenom">Last name </label> <input type="text"
					class="form-control" id="prenom" name="prenom">
			</div>
			<button type="submit" class="btn btn-success" name="action"
				value="add">Add</button>
		</form>
		<br>
		<form action="ClientController" method="GET">
			<input type="hidden" name="action" value="list" /> <input
				type="submit" class="btn btn-success" value="View all clients" />
		</form>

		<div id="clientList" style="display: none;">
			<h1>Clients</h1>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>CIN</th>
						<th>First name</th>
						<th>Last name</th>
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
										<input type="hidden" name="action" value="edit" /> <input
											type="hidden" name="cin" value="${client.cin}" />
										<button type="submit" class="edit-icon">
											<i class="fas fa-pencil-alt"></i>
										</button>
									
									</form>
									<form action="ClientController" method="GET">
										<input type="hidden" name="action" value="delete" /> <input
											type="hidden" name="cin" value="${client.cin}" />
										<button type="button" class="delete-icon delete-btn"
											onclick="confirmDelete('${client.cin}')">
											<i class="fas fa-trash-alt"></i>
										</button>
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
                        title: "Error!",
                        text: "<%=request.getAttribute("error")%>",
                        icon: "error",
                        confirmButtonText: "OK"
                    });
                <%}%>

                <%if (request.getAttribute("success") != null) {%>
                    Swal.fire({
                        title: "Succes!",
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
                        title: "Error!",
                        text: "Please fill in all the fields of the form.",
                        icon: "error",
                        confirmButtonText: "OK"
                    });
                    return false;
                }
                return true; 
            }

            function confirmDelete(cin) {
                Swal.fire({
                    title: "Are you sure you want to delete ?",
                    text: "You won't be able to revert this action!",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "yes delete it !"
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
