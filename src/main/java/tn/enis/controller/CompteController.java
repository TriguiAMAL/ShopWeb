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
import tn.enis.entity.Compte;
import tn.enis.service.ClientService;
import tn.enis.service.CompteService;

@WebServlet("/CompteController")
public class CompteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
	private CompteService compteService;

	@EJB
	private ClientService clientService;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		if ("Add".equals(request.getParameter("action"))) {
			float solde = Float.parseFloat(request.getParameter("solde"));
			String cin = request.getParameter("cin");
			Client client = clientService.findById(cin);

			Compte compte = new Compte(solde, client);
			compteService.save(compte);

			response.sendRedirect("CompteController?action=Fetch");
		} else if ("Delete".equals(request.getParameter("action"))) {
			Long rib = Long.parseLong(request.getParameter("rib"));
			compteService.delete(rib);
			response.sendRedirect("CompteController?action=Fetch");
		} else if ("edit".equals(request.getParameter("action"))) {
			Long rib = Long.parseLong(request.getParameter("rib"));
			Compte compte = compteService.findById(rib);
			Client client = compte.getClient();
			request.setAttribute("client", client);
			request.setAttribute("compte", compte);
			request.getRequestDispatcher("updateCompte.jsp").forward(request, response);
		} else if ("update".equals(request.getParameter("action"))) {
			Long rib = Long.parseLong(request.getParameter("rib"));
			float solde = Float.parseFloat(request.getParameter("solde"));
			Compte compte = compteService.findById(rib);
			compte.setSolde(solde);
			compteService.update(compte);
			response.sendRedirect("CompteController?action=Fetch");
		} else if ("Fetch".equals(request.getParameter("action"))) {
			List<Compte> comptes = compteService.findAll();
			request.setAttribute("comptes", comptes);
			request.getRequestDispatcher("comptes.jsp").forward(request, response);
		} else if ("search".equals(request.getParameter("action"))) {
			String search = request.getParameter("search");
			request.setAttribute("comptes", compteService.findByCin(search));
			request.getRequestDispatcher("comptes.jsp").forward(request, response);
			return;
		}

		else if ("Fetch".equals(request.getParameter("action"))) {
			List<Compte> comptes = compteService.findAll();
			request.setAttribute("comptes", comptes);
			request.getRequestDispatcher("comptes.jsp").forward(request, response);
		}

		else if ("suggestClients".equals(request.getParameter("action"))) {
			String cin = request.getParameter("cin");
			List<Client> clients = clientService.findAllByCinStartingWith(cin);

			StringBuilder responseBuilder = new StringBuilder();
			responseBuilder.append("[");
			for (int i = 0; i < clients.size(); i++) {
				Client client = clients.get(i);
				responseBuilder.append("{\"cin\":\"").append(client.getCin()).append("\",\"nom\":\"")
						.append(client.getNom()).append("\",\"prenom\":\"").append(client.getPrenom()).append("\"}");
				if (i < clients.size() - 1) {
					responseBuilder.append(",");
				}
			}
			responseBuilder.append("]");

			response.setContentType("application/json");
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(responseBuilder.toString());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
