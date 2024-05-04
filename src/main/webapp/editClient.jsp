<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Client</title>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
<style>
body {
	padding: 70px;
	background-color: #f2f2f2;
}
</style>

<script>
	function mas(cin) {
		var lastFourDigits = cin.slice(-4);
		var maskedCIN = "*****" + lastFourDigits;
		return maskedCIN;
	}
</script>

</head>
<body>
	<div class="container mt-5">
		<div class="card">
			<div class="card-header bg-dark text-white">
				<h2 class="card-title mb-0">Edit Client</h2>
			</div>

			<div class="card-body">
				<form action="ClientController" method="GET">
					<input type="hidden" name="action" value="update" />
					<div class="form-group row">

						<label for="cin" class="col-sm-3 col-form-label">CIN</label>
						<div class="col-sm-9">

							<input type="text" class="form-control" id="cin" name="cin"
								value="${client.cin}" readonly>
						</div>
					</div>
					<div class="form-group row">
						<label for="nom" class="col-sm-3 col-form-label">Nom</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="nom" name="nom"
								value="${client.nom}">
						</div>
					</div>
					<div class="form-group row">
						<label for="prenom" class="col-sm-3 col-form-label">Prénom</label>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="prenom" name="prenom"
								value="${client.prenom}">
						</div>
					</div>
					<div class="form-group row">
						<div class="col-sm-9 offset-sm-3">
							<button type="submit" class="btn btn-success">Update</button>

						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
