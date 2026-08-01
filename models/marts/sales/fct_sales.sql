/*
- This sql file inner joins the salesorderheader table (created by stg_salesorderheader) with the salesorderdetail table (created by stg_salesorderdetail)
- It is an inner join on the orderID column.
- The purpose of this is to combine both the header and details of each order to give one unified view of sales transactions and their
corresponding details.
- This saves compute and memory for analyst teams who no longer need to locally perform memory and compute-intensive joins.
*/

--- CTEs selecting the salesorderheader and salesorderdetail tables
WITH header AS (
    SELECT * FROM {{ ref('stg_salesorderheader') }}
),
detail AS (
    SELECT * FROM {{ ref('stg_salesorderdetail') }}
)

/*
This SELECT statement selects the columns which will appear in the newly formed table.
The OrderDate column has been given the alias 'date_key' to link to a Date Table. This allows date based calculations and reporting.
*/
SELECT
    -- These columns are all the sales, customer and product identifiers
    h.OrderDate AS date_key,
    d.SalesOrderDetailID,
    h.SalesOrderID,
    h.CustomerID,
    h.ShipToAddressID,
    h.BillToAddressID,
    d.ProductID,
    
    -- These columns are information related to product sales
    d.OrderQty,
    d.UnitPrice,
    d.UnitPriceDiscount,
    d.LineTotal,
    h.SubTotal,
    h.TaxAmt,
    h.Freight,
    h.TotalDue,
    
    -- Thse columns are for adminstrative puposes and highlight if the order was made online
    h.Status,
    h.OnlineOrderFlag

-- Selects the left most table header (salesorderheader)
FROM header h

-- Performs an inner join with the details table (salesorderdetail) so all 
INNER JOIN detail d ON h.SalesOrderID = d.SalesOrderID