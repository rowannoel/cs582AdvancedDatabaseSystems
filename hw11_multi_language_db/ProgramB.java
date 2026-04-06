import java.sql.*;
import java.util.Scanner;

public class ProgramB {
    public static void main(String[] args) {

        Scanner input = new Scanner(System.in);

        System.out.print("Enter product category: ");
        String category = input.nextLine();

        System.out.print("Sort by price (ASC/DESC): ");
        String sortOrder = input.nextLine().trim();

        if (!sortOrder.equalsIgnoreCase("ASC") && !sortOrder.equalsIgnoreCase("DESC")) {
            System.out.println("Invalid sort order. Defaulting to ASC.");
            sortOrder = "ASC";
        }

        String url = "jdbc:mariadb://localhost:3306/HW11";
		String user = "root";
        String pass = "hiding my password";

        String query =
            "SELECT prod_id, name, category, unit_price " +
            "FROM Products " +
            "WHERE category = ? " +
            "ORDER BY unit_price " + sortOrder;

        try (Connection conn = DriverManager.getConnection(url, user, pass);
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, category);

            ResultSet rs = stmt.executeQuery();

            System.out.println("\n===== Product Search Results =====");
            while (rs.next()) {
                System.out.printf(
                    "ID: %d | %-20s | $%.2f\n",
                    rs.getInt("prod_id"),
                    rs.getString("name"),
                    rs.getDouble("unit_price")
                );
            }
            System.out.println("==================================");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
