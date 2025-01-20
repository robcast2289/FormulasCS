DECLARE @diasSuspencion INT
DECLARE @codSuspencion VARCHAR(10) = 'SUSP. IGSS'

DECLARE @salarioOrdinario REAL = CONVERT(REAL,'%27')
DECLARE @diasNomina INT

DECLARE @tipoSusp INT

DECLARE @FechaInicio DATE = CONVERT(DATE,'%8',103)
DECLARE @FechaFin DATE = CONVERT(DATE,'%9',103)
DECLARE @FechaFinMesAnterior DATE = DATEADD(DAY,-1,@FechaInicio)
DECLARE @FechaInicioMesAnterior DATE = DATEADD(DAY, 1, EOMONTH(@FechaInicio, -2))
DECLARE @VAR1 INT = 0
DECLARE @VAR2 INT = 0
DECLARE @VAR3 INT = 0
DECLARE @VAR4 INT = 0
DECLARE @SalarioPrimerDia REAL
DECLARE @SalarioSegundaParte REAL

SET @diasNomina = DATEDIFF(DAY, @FechaInicio, @FechaFin) + 1
DECLARE @SalarioDiario REAL = @SalarioOrdinario / @diasNomina

SET @diasSuspencion = (SELECT COUNT(*) FROM PAYROLLABSENCETRANS T1
    INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
    WHERE T1.TRANSDATE BETWEEN @FechaInicio AND @FechaFin
    AND T2.EMPLID = '%12' AND T1.PAYROLLABSENCECODEID = @codSuspencion AND T1.HOURS > 0)



IF @diasSuspencion > 0 BEGIN
    SET @VAR1= (SELECT COUNT(*) 
    FROM PAYROLLABSENCETRANS T1
    INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
    WHERE T1.TRANSDATE = @FechaInicio
    AND T2.EMPLID = '%12'
    AND T1.PAYROLLABSENCECODEID = @codSuspencion)

    IF @VAR1 = 0
    BEGIN
        SET @SalarioPrimerDia = @SalarioDiario
    END
    ELSE
    BEGIN
        SET @VAR2= (SELECT COUNT(*) 
        FROM PAYROLLABSENCETRANS T1
        INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
        WHERE T1.TRANSDATE = @FechaFinMesAnterior
        AND T2.EMPLID = '%12'
        AND T1.PAYROLLABSENCECODEID = @codSuspencion)
        IF @VAR2 = 0
        BEGIN
            SET @SalarioPrimerDia = @SalarioDiario
        END
        ELSE
        BEGIN
            SET @SalarioPrimerDia = 0
        END
    END



    IF @SalarioPrimerDia = 0 BEGIN
        SET @VAR1= (SELECT COUNT(*) 
        FROM PAYROLLABSENCETRANS T1
        INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
        WHERE T1.TRANSDATE BETWEEN @FechaInicioMesAnterior AND @FechaFinMesAnterior
        AND T2.EMPLID = '%12'
        AND ( T1.PAYROLLABSENCECODEID = @codSuspencion )) 

        SET @VAR2 = 
        CASE
            WHEN (14 - @VAR1) > @diasSuspencion THEN @diasSuspencion
            WHEN (14 - @VAR1) <= @diasSuspencion THEN (14 - @VAR1)
        END
                
        SET @SalarioSegundaParte = (@VAR2 * @SalarioDiario) / 3
    END
    ELSE BEGIN
        SET @VAR2 = 
        CASE
            WHEN (14) > (@diasSuspencion - 1) THEN (@diasSuspencion - 1)
            WHEN (14) <= (@diasSuspencion - 1) THEN (14)
        END

        SET @SalarioSegundaParte = (@VAR2 * @SalarioDiario) / 3
    END
END

SELECT @SalarioPrimerDia + @SalarioSegundaParte
