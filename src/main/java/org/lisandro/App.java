/*
 * Copyright (c) 2018 Lisandro Fernandez
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


package org.lisandro;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author Lisandro Fernandez
 */
public class App {

    private static final String URL = "jdbc:h2:mem:test;INIT=runscript from '/path/to/jdbc-example/src/main/db/init.sql'";
    private static final String USER = "su";
    private static final String PASSWORD = "";
    private static Connection conn;

    public static void main(String[] args) throws SQLException {
        try {
            conn = getConnection();
            printData();
            insertData();
            System.out.println();
            printData();
        } finally {
            if (conn != null) conn.close();
        }
    }

    private static Connection getConnection() throws SQLException {
        conn = DriverManager.getConnection(URL, USER, PASSWORD);
        conn.setAutoCommit(false);
        return conn;
    }

    private static void printData() throws SQLException {
        try (
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM product")
        ) {
            System.out.println("[product]");
            while(rs.next()) {
                long id  = rs.getLong("id");
                String name  = rs.getString("name");
                String sku  = rs.getString("sku");
                BigDecimal price  = rs.getBigDecimal("price");
                System.out.println("id: " + id + " | sku: " + sku + " | name: " + name + " | price: " + price);
            }
        }
    }

    private static void insertData() throws SQLException {
        try (Statement stmt = conn.createStatement()) {
            stmt.executeUpdate("INSERT INTO product (sku, name, price) VALUES ('les-paul', 'Guitar Gibson Les Paul', 2495.39)");
            conn.commit();
        } catch (Exception e) {
            conn.rollback();
            throw e;
        }
    }

}
