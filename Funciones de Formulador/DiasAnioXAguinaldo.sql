DECLARE @current_date DATE;
DECLARE @start_date DATE;
DECLARE @end_date DATE;
DECLARE @current_year INT;
DECLARE @days INT;

-- Obtener la fecha inicial de la transacción actual
SET @current_date = CONVERT(DATE,'%8',103);;

-- Obtener el año actual
SET @current_year = YEAR(@current_date);

-- Validar si la fecha es mayor al 1 de diciembre del año actual
IF @current_date > DATEFROMPARTS(@current_year, 12, 1)
BEGIN
    -- Período: 1 dic año actual hasta 30 nov año siguiente
    SET @start_date = DATEFROMPARTS(@current_year, 12, 1);
    SET @end_date = DATEFROMPARTS(@current_year + 1, 11, 30);
END
ELSE
BEGIN
    -- Período: 1 dic año anterior hasta 30 nov año actual
    SET @start_date = DATEFROMPARTS(@current_year - 1, 12, 1);
    SET @end_date = DATEFROMPARTS(@current_year, 11, 30);
END

-- Calcular días entre las fechas (incluyendo ambos días)
SET @days = DATEDIFF(DAY, @start_date, @end_date) + 1;

SELECT @days;