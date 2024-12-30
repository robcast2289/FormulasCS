DECLARE @current_date DATE;
DECLARE @start_date DATE;
DECLARE @end_date DATE;
DECLARE @current_year INT;
DECLARE @days INT;

-- Obtener la fecha inicial de la transaccion actual
SET @current_date = CONVERT(DATE,'%8',103);;

-- Obtener el año actual
SET @current_year = YEAR(@current_date);

-- Validar si la fecha es mayor al 1 de julio del año actual
IF @current_date > DATEFROMPARTS(@current_year, 7, 1)
BEGIN
    -- Período: 1 jul año actual hasta 30 jun año siguiente
    SET @start_date = DATEFROMPARTS(@current_year, 7, 1);
    SET @end_date = DATEFROMPARTS(@current_year + 1, 6, 30);
END
ELSE
BEGIN
    -- Período: 1 jul año anterior hasta 30 jun año actual
    SET @start_date = DATEFROMPARTS(@current_year - 1, 7, 1);
    SET @end_date = DATEFROMPARTS(@current_year, 6, 30);
END

-- Calcular días entre las fechas (incluyendo ambos días)
SET @days = DATEDIFF(DAY, @start_date, @end_date) + 1;

SELECT @days;