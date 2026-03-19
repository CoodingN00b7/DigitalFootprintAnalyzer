package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Scan;
import util.DBConnection;

public class ScanDAO {

    public static void saveScan(Scan scan) {

        String query = "INSERT INTO scans(target, breaches_found, risk_score, scan_time) VALUES (?, ?, ?, NOW())";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, normalize(scan.getTarget()));
            ps.setInt(2, scan.getBreaches());
            ps.setInt(3, scan.getRisk());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static List<String> getOfflineBreachDetails(String target) {

        List<String> details = new ArrayList<>();

        String normalizedTarget = normalize(target);

        String query = "SELECT breach_source, severity, leak_score FROM local_breaches WHERE LOWER(target) LIKE ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, "%" + normalizedTarget + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                String source = rs.getString("breach_source");
                String severity = rs.getString("severity");
                int score = rs.getInt("leak_score");

                String formatted = source + " (" + severity + " - Score: " + score + ")";

                details.add(formatted);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return details;
    }

    private static String normalize(String input) {

        if (input == null) return "";

        input = input.trim().toLowerCase();

       
        if (input.startsWith("http://")) {
            input = input.substring(7);
        } else if (input.startsWith("https://")) {
            input = input.substring(8);
        }

        return input;
    }
}
