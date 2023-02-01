USE targeted_marketing;
DELIMITER //
CREATE PROCEDURE `sm_total_sales` ()
BEGIN
  SELECT sm_seller.seller, SUM(sm_transaction.price_paid) AS total_sales
  FROM sm_seller
  JOIN sm_item_by_seller ON sm_seller.id = sm_item_by_seller.id
  JOIN sm_transaction ON sm_item_by_seller.sm_transaction_id = sm_transaction.id
  GROUP BY sm_seller.seller;
END
DELIMITER ;