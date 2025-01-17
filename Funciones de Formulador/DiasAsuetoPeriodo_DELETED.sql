DECLARE @Mes INT = MONTH(CONVERT(DATE,'%8',103))
DECLARE @DiasAsueto INT
DECLARE @DiasAsuetoAnual INT
DECLARE @DiasAsuetoEspecifico INT
DECLARE @FechaInicio DATE = CONVERT(DATE,'%8',103)
DECLARE @FechaFin DATE = CONVERT(DATE,'%9',103)

SET @DiasAsuetoAnual = (select COUNT(*) from PAYROLLHOLIDAYS
where DATAAREAID = '%1'
and DATETYPE = 1
and MONTHOFYEAR = @Mes)

SET @DiasAsuetoEspecifico = (select COUNT(*) from PAYROLLHOLIDAYS
where DATETYPE = 0
and DATE BETWEEN @FechaInicio and @FechaFin)

SET @DiasAsueto = @DiasAsuetoAnual + @DiasAsuetoEspecifico

SELECT @DiasAsuetoAnual 
