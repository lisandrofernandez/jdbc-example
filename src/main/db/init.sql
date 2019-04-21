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


CREATE TABLE product (
    id IDENTITY PRIMARY KEY,
    sku VARCHAR(256),
    name VARCHAR(256),
    price DECIMAL(20, 2),
    UNIQUE KEY UNIQUE_PRODUCT_SKU (sku)
);

CREATE TABLE customer (
    id IDENTITY PRIMARY KEY,
    name VARCHAR(256),
    birthdate DATE
);

CREATE TABLE address (
    id INT8 PRIMARY KEY,
    street VARCHAR(128),
    postal_code VARCHAR(16),
    FOREIGN KEY(id) REFERENCES customer(id) ON DELETE CASCADE
);

CREATE TABLE email_address (
    id IDENTITY PRIMARY KEY,
    customer_id INT8,
    address VARCHAR(128),
    FOREIGN KEY(customer_id) REFERENCES customer(id) ON DELETE CASCADE
);

CREATE TABLE purchase_order (
    id IDENTITY PRIMARY KEY,
    customer_id INT8,
    order_date DATE,
    FOREIGN KEY(customer_id) REFERENCES customer(id)
);

CREATE TABLE item (
    id IDENTITY PRIMARY KEY,
    order_id INT8,
    product_id INT8,
    quantity INT,
    total DECIMAL(20, 2),
    FOREIGN KEY(order_id) REFERENCES purchase_order(id),
    FOREIGN KEY(product_id) REFERENCES product(id)
);

INSERT INTO product (id, sku, name, price) VALUES (1, 'keyboard', 'Keyboard', 7.99);
INSERT INTO product (id, sku, name, price) VALUES (2, 'tv', 'Television', 351.96);
INSERT INTO product (id, sku, name, price) VALUES (3, 'shirt', 'Shirt', 3.57);
INSERT INTO product (id, sku, name, price) VALUES (4, 'bed', 'Bed', 131.00);
INSERT INTO product (id, sku, name, price) VALUES (5, 'cell-phone', 'Cell Phone', 1000.00);
INSERT INTO product (id, sku, name, price) VALUES (6, 'spoon', 'Spoon', 1.00);

INSERT INTO customer (id, name, birthdate) VALUES (1, 'John Doe', '1960-10-30');
INSERT INTO customer (id, name, birthdate) VALUES (2, 'Pepito Pérez', '1954-07-15');
INSERT INTO customer (id, name, birthdate) VALUES (3, 'Cosme Fulanito', '1956-05-12');

INSERT INTO address (id, street, postal_code) VALUES (1, 'La Habana 4310', '1000');
INSERT INTO address (id, street, postal_code) VALUES (2, '10 rue Henri Poincaré', '13014');
INSERT INTO address (id, street, postal_code) VALUES (3, 'Calle Falsa 123', '01102');

INSERT INTO email_address (id, customer_id, address) VALUES (1, 1, 'john.doe@gmail.com');
INSERT INTO email_address (id, customer_id, address) VALUES (2, 1, 'john.doe@hotmail.com');
INSERT INTO email_address (id, customer_id, address) VALUES (3, 2, 'pepito@perez.com');
INSERT INTO email_address (id, customer_id, address) VALUES (4, 3, 'cosme@fulanito.com');

INSERT INTO purchase_order (id, customer_id, order_date) VALUES (1, 2, '2018-01-04');
INSERT INTO purchase_order (id, customer_id, order_date) VALUES (2, 1, '2018-02-13');
INSERT INTO purchase_order (id, customer_id, order_date) VALUES (3, 2, '2018-02-25');

INSERT INTO item (id, order_id, product_id, quantity, total) VALUES (1, 1, 1, 10, 79.90);
INSERT INTO item (id, order_id, product_id, quantity, total) VALUES (2, 1, 2, 2, 703.92);
INSERT INTO item (id, order_id, product_id, quantity, total) VALUES (3, 1, 3, 7, 24.99);
INSERT INTO item (id, order_id, product_id, quantity, total) VALUES (4, 2, 4, 2, 262.00);
INSERT INTO item (id, order_id, product_id, quantity, total) VALUES (5, 2, 5, 15, 15000.00);
INSERT INTO item (id, order_id, product_id, quantity, total) VALUES (6, 3, 1, 7, 55.93);
INSERT INTO item (id, order_id, product_id, quantity, total) VALUES (7, 3, 6, 18, 18.00);
