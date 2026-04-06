import java.sql.*;
import java.util.Scanner;

public class ProgramA {
    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter Customer ID: ");
        int custId = scanner.nextInt();

        try {
            Class.forName("org.mariadb.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("Driver failed to load!");
            e.printStackTrace();
            return;
        }

        String url = "jdbc:mariadb://localhost:3306/HW11";
        String user = "root";
        String pass = "Eleda5609%";

        try (Connection conn = DriverManager.getConnection(url, user, pass)) {

            CallableStatement stmt =
                    conn.prepareCall("{CALL GetCustomerOrderSummary(?)}");

            stmt.setInt(1, custId);

            ResultSet rs = stmt.executeQuery();

            System.out.println("\n===== Customer Order Summary =====");

            while (rs.next()) {
                System.out.println("Customer ID: " + rs.getInt("cust_id"));
                System.out.println("Customer Name: " + rs.getString("customer_name"));
                System.out.println("Total Orders: " + rs.getInt("total_orders"));
                System.out.println("Total Revenue: $" + rs.getDouble("total_revenue"));
                System.out.println("Most Recent Order: " + rs.getString("most_recent_order"));
            }

            System.out.println("==================================");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
