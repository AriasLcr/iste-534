-- PE 02b
-- Gabriel Arias
-- September 7th, 2026
-- ISTE 534 - Data Warehousing

CREATE SCHEMA IF NOT EXISTS dw;
USE dw;

-- ==================================================
-- DIMENSION: Date
-- ==================================================

CREATE TABLE dim_date (
	date_sk			INT			NOT NULL,
    full_date		DATE 		NOT NULL,
    day_of_month	TINYINT		NOT NULL,
    day_of_week		TINYINT		NOT NULL,
    day_name		VARCHAR(10)	NOT NULL,
    month_number	TINYINT		NOT NULL,
    `quarter` 		TINYINT		NOT NULL,
    `year`			SMALLINT	NOT NULL,
    year_quarter	CHAR(7)		NOT NULL,
    `year_month`    CHAR(7)     NOT NULL,
    PRIMARY KEY (date_sk)
);

-- ============================================
-- DIMENSION: customer  (customer type denormalized in)
-- ============================================
CREATE TABLE dim_customer (
    customer_sk         INT          NOT NULL AUTO_INCREMENT,
    customer_id         VARCHAR(10)  NOT NULL,
    customer_name       VARCHAR(45),
    address             VARCHAR(45),
    city                VARCHAR(45),
    state               CHAR(2),
    customer_type_desc  VARCHAR(45),
    PRIMARY KEY (customer_sk)
);

-- ============================================
-- DIMENSION: product  (category denormalized in)
-- ============================================
CREATE TABLE dim_product (
    product_sk      INT          NOT NULL AUTO_INCREMENT,
    product_id      VARCHAR(10)  NOT NULL,   -- business key from OLTP
    product_name    VARCHAR(45),
    unit_price      DECIMAL(10,2),
    category_desc   VARCHAR(45),
    PRIMARY KEY (product_sk)
);

-- ============================================
-- FACT: sales
-- Grain: one row per customer, per product, per day
-- ============================================
CREATE TABLE fact_sales (
    date_sk             INT           NOT NULL,
    customer_sk         INT           NOT NULL,
    product_sk          INT           NOT NULL,
    quantity            INT           NOT NULL,
    PRIMARY KEY (date_sk, customer_sk, product_sk),
    FOREIGN KEY (date_sk)     REFERENCES dim_date(date_sk),
    FOREIGN KEY (customer_sk) REFERENCES dim_customer(customer_sk),
    FOREIGN KEY (product_sk)  REFERENCES dim_product(product_sk)
);

SHOW TABLES;
