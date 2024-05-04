<%@page import="tn.enis.entity.Compte"%>
<%@page import="tn.enis.entity.Client"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Accounts</title>

<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.css">
<style>
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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
</head>
<body>



	<div class="container">
		<div class="header-title">
			<h1>List of Comptes</h1>
		</div>
			<form id="searchForm" class="form-inline mb-3"
			action="CompteController" method="GET">
			<input type="hidden" name="action" value="search" /> <input
				type="text" class="form-control search-bar" name="search"
				placeholder="Search clients...">
			<button type="submit" class="btn btn-secondary">Search</button>
		</form>
		<table class="table table-striped">
			<thead>
				<tr>
					<th>RIB</th>
					<th>NAME AND SURNAME</th>
					<th>SOLDE</th>
					<th>Edit</th>
					<th>Delete</th>
				</tr>
			</thead>
			<tbody>
				<%
				List<Compte> comptes = (List<Compte>) request.getAttribute("comptes");
				if (comptes != null && !comptes.isEmpty()) {
					for (Compte compte : comptes) {
				%>
				<tr>
					<td><%=compte.getRib()%></td>
					<td>
						<%
						Client client = compte.getClient();
						if (client != null) {
							out.print(client.getNom() + " " + client.getPrenom());
						} else {
							out.print("N/A");
						}
						%>
					</td>
					<td><%=compte.getSolde()%></td>
					<td>
						<form action="CompteController" method="GET">
							<input type="hidden" name="rib" value="<%=compte.getRib()%>">
							<button type="submit" class="edit-icon" name="action"
								value="edit">
								<i class="fas fa-pencil-alt"></i>

							</button>
						</form>
					</td>
					<td>
						<button class="delete-icon delete-btn"
							data-rib="<%=compte.getRib()%>">
							<i class="fas fa-trash-alt"></i>

						</button>
					</td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="5">No comptes found.</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<a href="addCompte.jsp" class="btn btn-primary btn-add">Add Compte</a>
		<hr />
	</div>
	<script>
    $(document).ready(function() {
        $('#addCompteLink').click(function(event) {
            event.preventDefault(); 
            window.location.href = 'addCompte.jsp'; 
        });

        $('.delete-btn').click(function() {
            var rib = $(this).data('rib');
            swal({
                title: "Are you sure?",
                text: "Once deleted, you will not be able to recover this compte!",
                icon: "warning",
                buttons: true,
                dangerMode: true,
            })
            .then((willDelete) => {
                if (willDelete) {
                    $.ajax({
                        url: 'CompteController',
                        type: 'GET',
                        data: { action: "Delete", rib: rib },
                        success: function(response) {
                            swal("Compte has been deleted!", {
                                icon: "success",
                            }).then((value) => {
                                location.reload();
                            });
                        },
                        error: function() {
                            swal("Error deleting client!", {
                                icon: "error",
                            });
                        }
                    });
                }
            });
        });
    });
    </script>
</body>
</html>
