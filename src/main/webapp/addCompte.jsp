<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Compte</title>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
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

.container {
	margin-top: 20px;
}

.table {
	width: auto;
	margin: auto;
	background-color: #f8f9fa;
}

.form-control {
	border-radius: 0;
	border-color: #ced4da;
}

.form-control:focus {
	border-color: #6c757d;
	box-shadow: none;
}

.form-label {
	font-weight: bold;
}

.btn-add {
	background-color: #1e7e34;
	border-color: #1e7e34;
}

.btn-add:hover {
	background-color: #218838;
	border-color: #218838;
}

.title-container {
	text-align: center;
}
</style>
</head>
<body>

	<div class="container">
		<a href="home.jsp" class="btn btn-custom float-end"
			style="margin-right: 5px;">Home</a>
	</div>



	<div class="container">
		<a href="#" id="addCompteLink"></a>
	</div>



	<div class="container" id="addCompteFormContainer"
		style="display: none;">
		<div class="row">
			<div class="col">
				<div class="title-container">
					<h1>Add Compte</h1>
				</div>
			</div>
		</div>
		<form id="addCompteForm" action="CompteController" method="GET">
			<input type="hidden" name="action" value="Add" />
			<table class="table">
				<tr>
					<td><label for="cin">CIN</label></td>
					<td><input type="text" id="cin" name="cin"
						class="form-control" oninput="fetchClients(this.value)"
						autocomplete="on" />
						<div id="clientNames"
							style="position: absolute; background-color: white; z-index: 1000;"></div>
					</td>
				</tr>
				<tr>
					<td><label class="form-label" for="nom">SOLDE</label></td>
					<td><input type="text" id="nom" name="solde"
						class="form-control" /></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="submit" value="Add"
						class="btn btn-primary btn-add" /></td>

				</tr>

			</table>
			<a href="CompteController?action=Fetch"
				class="btn btn-custom float-end">View All Accounts</a>
		</form>
	</div>





	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
        document
                .getElementById('addCompteLink')
                .addEventListener(
                        'click',
                        function(event) {
                            event.preventDefault();
                            document.getElementById('addCompteFormContainer').style.display = 'block';
                        });
    </script>
	<script>
        document.addEventListener('DOMContentLoaded', function() {

            var addCompteLink = document.getElementById('addCompteLink');

            addCompteLink.click();
        });
    </script>

	<script>
        function fetchClients(cin) {
            if (cin.length === 0) {
                return;
            }
            var xhr = new XMLHttpRequest();
            xhr.open('GET', 'CompteController?action=suggestClients&cin='
                    + encodeURIComponent(cin), true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    var clients = JSON.parse(xhr.responseText);
                    var options = '';
                    clients.forEach(function(client) {
                        options += '<div onclick="selectClient(\'' + client.cin
                                + '\')">' + client.cin + ' - ' + client.nom
                                + ' ' + client.prenom + '</div>';
                    });
                    document.getElementById('clientNames').innerHTML = options;
                }
            };
            xhr.send();
        }

        function selectClient(selectedCin) {
            document.getElementById('cin').value = selectedCin;
            document.getElementById('clientNames').innerHTML = '';
        }
        
        document.getElementById('addCompteForm').addEventListener('submit', function(event) {
            event.preventDefault(); 

            var cin = document.getElementById('cin').value;
            var xhr = new XMLHttpRequest();
            xhr.open('GET', 'CompteController?action=checkClientExistence&cin=' + encodeURIComponent(cin), true);
            xhr.onload = function() {
                if (xhr.status === 200) {
                    var clientExists = JSON.parse(xhr.responseText);
                    if (!clientExists) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Oops...',
                            text: 'The specified ID number does not exist in the database. Please create a client account.',
                            confirmButtonText: 'OK'
                        }).then((result) => {
                            if (result.isConfirmed) {
                                window.location.href = 'clients.jsp';
                            }
                        });
                    } else {
                        document.getElementById('addCompteForm').submit(); 
                    }
                }
            };
            xhr.send();
        });
    </script>
</body>
</html>

