package tn.enis.controller;

import java.io.IOException;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import tn.enis.entity.Client;
import tn.enis.service.ClientService;

/**
 * Servlet implementation class ClientController
 */
@WebServlet("/ClientController")
public class ClientController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private ClientService clientService;

	public ClientController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if ("add".equals(request.getParameter("action"))) {
			String cin = request.getParameter("cin");

			if (clientService.exists(cin)) {

				request.setAttribute("error", "Le CIN existe déjà dans la base de données.");
			} else {

				String nom = request.getParameter("nom");
				String prenom = request.getParameter("prenom");
				Client client = new Client(cin, nom, prenom);
				clientService.save(client);
				request.setAttribute("success", "Le client est ajouté avec succès");
			}
		} else if ("list".equals(request.getParameter("action"))) {
			List<Client> clients = clientService.findAll();
			request.setAttribute("clients", clients);
			request.getRequestDispatcher("clients.jsp").forward(request, response);

		} else if ("delete".equals(request.getParameter("action"))) {
			String cin = request.getParameter("cin");
			
			clientService.delete(cin);
			response.sendRedirect("ClientController?action=list");

		} else if ("edit".equals(request.getParameter("action"))) {
			String cin = request.getParameter("cin");
			Client client = clientService.findById(cin);
			request.setAttribute("client", client);
			request.getRequestDispatcher("editClient.jsp").forward(request, response);
		} else if ("update".equals(request.getParameter("action"))) {
			String cin = request.getParameter("cin");
			String nom = request.getParameter("nom");
			String prenom = request.getParameter("prenom");
			Client client = new Client(cin, nom, prenom);
			clientService.update(client);
			response.sendRedirect("ClientController?action=list");
		}

		request.setAttribute("clients", clientService.findAll());
		request.getRequestDispatcher("clients.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}
}