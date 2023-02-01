DELIMITER $$

CREATE PROCEDURE GetProductInformation(IN productId INT)
BEGIN
  DECLARE productName VARCHAR(100);
  DECLARE productPrice DECIMAL(10,2);
  DECLARE categoryName VARCHAR(100);
  DECLARE manufacturerName VARCHAR(100);

  SELECT 
    name, 
    price,
    (SELECT name FROM category WHERE category.id = product.category_id) AS categoryName,
    (SELECT name FROM manufacturer WHERE manufacturer.id = product.manufacturer_id) AS manufacturerName
  INTO 
    productName, 
    productPrice, 
    categoryName, 
    manufacturerName
  FROM product
  WHERE product.id = productId;

  SELECT productName, productPrice, categoryName, manufacturerName;
END $$

DELIMITER ;