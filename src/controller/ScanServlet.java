package controller;

import dao.ScanDAO;
import model.Scan;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.regex.*;

@WebServlet("/scan")
public class ScanServlet extends HttpServlet {

    private static final String API_KEY = "your API key here";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String target = request.getParameter("target");
        String scanType = request.getParameter("scanType");

        int breaches = 0;
        int risk = 0;
        List<String> breachDetails = new ArrayList<>();

        if (target == null || target.trim().isEmpty()) {
            response.sendRedirect("index.jsp");
            return;
        }

        target = target.trim();

        
        String type = detectType(target);

        try {
            if ("offline".equals(scanType)) {

                breachDetails = ScanDAO.getOfflineBreachDetails(target);
                breaches = breachDetails.size();

            } else {

               
                String encoded = URLEncoder.encode(target, StandardCharsets.UTF_8.toString());

                URL url = new URL("https://leakcheck.io/api/public?key=" + API_KEY + "&check=" + encoded);
                HttpURLConnection conn = (HttpURLConnection) url.openConnection();

                conn.setRequestMethod("GET");
                conn.setConnectTimeout(5000);
                conn.setReadTimeout(5000);

                if (conn.getResponseCode() == 200) {

                    BufferedReader reader = new BufferedReader(
                            new InputStreamReader(conn.getInputStream())
                    );

                    StringBuilder result = new StringBuilder();
                    String line;

                    while ((line = reader.readLine()) != null) {
                        result.append(line);
                    }

                    reader.close();

                    String json = result.toString();

                   
                    breaches = countOccurrences(json, "\"source\"");

                    if (breaches > 0) {
                        breachDetails.add("LeakCheck Database");
                    }
                }
            }

        } catch (Exception e) {
            System.out.println("Scan Error: " + e.getMessage());
        }

        
        risk = calculateRisk(breaches, type);

      
        Scan scan = new Scan(target, breaches, risk, breachDetails);
        ScanDAO.saveScan(scan);

       
        request.setAttribute("target", target);
        request.setAttribute("breaches", breaches);
        request.setAttribute("risk", risk);
        request.setAttribute("breachDetails", breachDetails);

        request.getRequestDispatcher("result.jsp").forward(request, response);
    }

    
    private String detectType(String input) {

        if (input.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$"))
            return "email";

        if (input.matches("^((25[0-5]|2[0-4]\\d|1\\d\\d|\\d\\d?)\\.){3}(25[0-5]|2[0-4]\\d|1\\d\\d|\\d\\d?)$"))
            return "ip";

        if (input.startsWith("http://") || input.startsWith("https://"))
            return "url";

        return "unknown";
    }

   
    private int countOccurrences(String text, String word) {
        return text.split(word, -1).length - 1;
    }

  
    private int calculateRisk(int breaches, String type) {

        int base = breaches * 20;

        switch (type) {
            case "email": base += 20; break;
            case "url": base += 30; break;
            case "ip": base += 25; break;
        }

        if (base > 100) base = 100;
        return base;
    }
}
