package controller;

import util.DBConnection;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int totalScans = 0;
        int critical = 0;
        int high = 0;
        int safe = 0;

        List<Integer> riskTrend = new ArrayList<>();

        try (Connection con = DBConnection.getConnection()) {

            /* 🔹 TOTAL SCANS */
            ResultSet rs1 = con.createStatement().executeQuery("SELECT COUNT(*) FROM scans");
            if (rs1.next()) totalScans = rs1.getInt(1);

            /* 🔹 RISK DISTRIBUTION */
            ResultSet rs2 = con.createStatement().executeQuery("SELECT risk_score FROM scans");

            while (rs2.next()) {
                int risk = rs2.getInt("risk_score");

                if (risk >= 70) critical++;
                else if (risk >= 40) high++;
                else safe++;

                riskTrend.add(risk);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

       
        request.setAttribute("totalScans", totalScans);
        request.setAttribute("critical", critical);
        request.setAttribute("high", high);
        request.setAttribute("safe", safe);
        request.setAttribute("riskTrend", riskTrend);

        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
    }
}
