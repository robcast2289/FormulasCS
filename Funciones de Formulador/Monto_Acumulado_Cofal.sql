/* Parametros: 
PARAM_1: 'AGUINALDO'|'BONO14'|'OTROS'
PARAM_2: GRUPO DE ELEMENTOS
PARAM_3: CANTIDAD DE MESES 
*/
DECLARE @TIPO_PRESTACION NVARCHAR(10) = @PARAM_1
DECLARE @ElementGroupId NVARCHAR(60) = @PARAM_2
DECLARE @CANTIDAD INT = CONVERT(INT,@PARAM_3)
DECLARE @PROMEDIO_COFIÑO INT = CONVERT(INT,@PARAM_4)

DECLARE @FechaInicial DATE
DECLARE @FechaFinal DATE
DECLARE @FechaAguinaldo DATE = NULL
DECLARE @FechaBono DATE = NULL

DECLARE @ElementId NVARCHAR(60)
DECLARE @ElementType INT
DECLARE @SUMAINGRESOS REAL = 0
DECLARE @ACUMULADO REAL = 0
DECLARE @DIAS INT

DECLARE @EsPrimerDia BIT

IF @TIPO_PRESTACION = 'AGUINALDO' OR @TIPO_PRESTACION = 'BONO14'
    SELECT @FechaAguinaldo = t1.LASTAGUINALDO,
        @FechaBono = t1.LASTBONO14
    FROM PAYROLLEMPL t1
    WHERE t1.EMPLID = '%12'

    IF @TIPO_PRESTACION = 'AGUINALDO'
        IF @FechaAguinaldo = NULL
            SET @FechaInicial = CONVERT(DATE,'%19',103)
        ELSE
            SET @FechaInicial = @FechaAguinaldo
    IF @TIPO_PRESTACION = 'BONO14'
        IF @FechaBono = NULL
            SET @FechaInicial = CONVERT(DATE,'%19',103)
        ELSE
            SET @FechaInicial = @FechaBono
ELSE
    SET @FechaInicial = DATEADD(MONTH,(@CANTIDAD*-1),CONVERT(DATE,'%8',103))

    IF @FechaInicial < CONVERT(DATE,'%19',103)
        SET @FechaInicial = CONVERT(DATE,'%19',103)


SET @FechaFinal = DATEADD(DAY,-1,CONVERT(DATE,'%8',103))

IF @PROMEDIO_COFIÑO = 1
    -- Verificar si la fecha inicial es el primer día del mes
    SET @EsPrimerDia = CASE 
        WHEN DAY(@FechaInicial) = 1 THEN 1 
        ELSE 0 
    END

    IF @EsPrimerDia = 0
        SET @FechaInicial = DATEADD(DAY,1,EOMONTH(@FechaInicial))


DECLARE PayRollTransEmplElement_Cursor CURSOR FOR
    select SUM(ROUND(t1.amount,2)) ingresos, SUM(t1.quantity) cantidad
    from PAYROLLTRANSEMPLELEMENT t1
    join PAYROLLTRANS t2 on t1.TRANSID = t2.TRANSID
    where t1.ELEMENTID IN (SELECT ElementId
    FROM PayRollElementPerGroup
    WHERE ElementGroupId = @ElementGroupId)
    AND t1.ELEMENTTYPE = 0
    and t1.EMPLID = '%12'
    AND ((t2.FROMDATE <= @FechaInicial
        AND t2.TODATE >= @FechaInicial)
        OR (t2.FROMDATE >= @FechaInicial
        AND t2.TODATE <= @FechaFinal)
        OR (t2.FROMDATE <= @FechaFinal
        AND t2.TODATE >= @FechaFinal))
    and t2.STATUS >= 6
    group by t2.FROMDATE, t2.TODATE

OPEN PayRollTransEmplElement_Cursor

FETCH NEXT FROM PayRollTransEmplElement_Cursor INTO @SUMAINGRESOS, @DIAS

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @ACUMULADO = @ACUMULADO + ROUND(@SUMAINGRESOS,2)

    FETCH NEXT FROM PayRollTransEmplElement_Cursor INTO @SUMAINGRESOS, @DIAS
END

CLOSE PayRollTransEmplElement_Cursor
DEALLOCATE PayRollTransEmplElement_Cursor

SELECT @ACUMULADO

/*DECLARE ElementGroup_Cursor CURSOR FOR
SELECT ElementId, ElementType
FROM PayRollElementPerGroup
WHERE ElementGroupId = @ElementGroupId

OPEN ElementGroup_Cursor

FETCH NEXT FROM ElementGroup_Cursor INTO @ElementId, @ElementType

WHILE @@FETCH_STATUS = 0
BEGIN


    FETCH NEXT FROM ElementGroup_Cursor INTO @ElementId, @ElementType
END

CLOSE ElementGroup_Cursor
DEALLOCATE ElementGroup_Cursor*/






DECLARE @ElementGroupId NVARCHAR(60) = 'G_VACACIONES'
DECLARE @ElementId NVARCHAR(60)
DECLARE @ElementType INT
DECLARE @SUMAINGRESOS REAL = 0
DECLARE @ACUMULADO REAL = 0
DECLARE @DIAS INT

DECLARE PayRollTransEmplElement_Cursor CURSOR FOR
    select SUM(t1.amount) ingresos, SUM(t1.quantity) cantidad
    from PAYROLLTRANSEMPLELEMENT t1
    join PAYROLLTRANS t2 on t1.TRANSID = t2.TRANSID
    where t1.ELEMENTID IN (SELECT ElementId
    FROM PayRollElementPerGroup
    WHERE ElementGroupId = @ElementGroupId)
    AND t1.ELEMENTTYPE = 0
    and t1.EMPLID = '%12'
    AND t2.FROMDATE >= CONVERT(DATE,'%19',103)
    AND t2.TODATE <= CONVERT(DATE,'%8',103)
    and t2.STATUS >= 6
    group by t2.FROMDATE, t2.TODATE

OPEN PayRollTransEmplElement_Cursor

FETCH NEXT FROM PayRollTransEmplElement_Cursor INTO @SUMAINGRESOS, @DIAS

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @ACUMULADO = @ACUMULADO + @SUMAINGRESOS

    FETCH NEXT FROM PayRollTransEmplElement_Cursor INTO @SUMAINGRESOS, @DIAS
END

CLOSE PayRollTransEmplElement_Cursor
DEALLOCATE PayRollTransEmplElement_Cursor

SELECT @ACUMULADO