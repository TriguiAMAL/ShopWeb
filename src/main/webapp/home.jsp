<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Page d'accueil</title>

<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>

.img-thumbnail {
    max-width: 300px; 
    height: auto; 
}


.v-center {
    display: flex;
    align-items: center;
    min-height: 50vh;
}


body {
padding: 70px;
    background-color: #f2f2f2; 
}


.page-title {
    font-family: 'Arial', sans-serif; 
    font-size: 36px; 
    margin-bottom: 20px; 
}


.image-title {
    font-size: 30px; 
    margin-top: 10px; 
}
</style>
</head>
<body>

<div class="container">
    
    <h1 class="text-center page-title">Welcome to the bank</h1>
    
  
    <div class="row justify-content-center v-center">

        <div class="col-md-6 text-center">
            <figure>
                <a href="clients.jsp">
                    <img src="image/client.png" alt="Image 1" class="img-thumbnail">
                </a>
                <figcaption class="image-title">Client Space</figcaption>
            </figure>
        </div>
      
        <div class="col-md-6 text-center">
            <figure>
                <a href="addCompte.jsp">
                    <img src="image/compte.png" alt="Image 2" class="img-thumbnail">
                </a>
                <figcaption class="image-title">Account Space</figcaption>
            </figure>
        </div>
    </div>
</div>


<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
