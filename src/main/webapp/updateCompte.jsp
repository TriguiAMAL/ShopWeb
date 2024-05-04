<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Compte</title>

<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">

<style>
.container {
	margin-top: 50px;
	max-width: 400px;
	margin-left: auto;
	margin-right: auto;
	padding: 20px;
	background-color: #f8f9fa; 
	border-radius: 10px; 
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); 
}

.form-group {
	margin-bottom: 20px;
}

.form-control[readonly] {
	background-color: #e9ecef;
}

.btn-primary {
	background-color: #1e7e34; 
	border-color: #1e7e34;
}

.btn-primary:hover {
	background-color: #218838; 
	border-color: #218838;
}

h2 {
	text-align: center;
	margin-bottom: 30px;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>
	<div class="container">
		<h2>Edit Compte</h2>

		<form id="updateForm" action="CompteController" method="GET">
			<input type="hidden" name="action" value="update"> <input
				type="hidden" name="rib" value="${compte.rib}">

			<div class="form-group">
				<label for="cin">CIN:</label> <input type="text"
					class="form-control" id="cin" name="cin" value="${client.cin}"
					readonly>
			</div>

			<div class="form-group">
				<label for="nom">Nom:</label> <input type="text"
					class="form-control" id="nom" name="nom" value="${client.nom}"
					readonly>
			</div>

			<div class="form-group">
				<label for="prenom">Prenom:</label> <input type="text"
					class="form-control" id="prenom" name="prenom"
					value="${client.prenom}" readonly>
			</div>

			<div class="form-group">
				<label for="solde">Solde:</label> <input type="text"
					class="form-control" id="solde" name="solde"
					value="${compte.solde}">
			</div>

			<button type="button" class="btn btn-primary btn-block"
				onclick="showSuccessNotification()">Update</button>
		</form>
	</div>

	<script>
    function showSuccessNotification() {
        Swal.fire({
            title: "Success!",
            text: "Update successful!",
            icon: "success",
            confirmButtonText: "OK"
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('updateForm').submit();
            }
        });
    }
</script>

</body>
</html>
