DECLARE @diasSuspencion INT
DECLARE @codSuspencion VARCHAR(10) = 'SUSP. IGSS'
DECLARE @diasAccidente INT
DECLARE @codAccidente VARCHAR(10) = 'SUSP. IGSS'
DECLARE @diasEnfermedad INT
DECLARE @codEnfermedad VARCHAR(10) = 'SUSP. IGSS'
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

SET @diasAccidente = (SELECT COUNT(*) FROM PAYROLLABSENCETRANS T1
    INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
    WHERE T1.TRANSDATE BETWEEN @FechaInicio AND @FechaFin
    AND T2.EMPLID = '%12' AND T1.PAYROLLABSENCECODEID = @codAccidente AND T1.HOURS > 0)

SET @codEnfermedad = (SELECT COUNT(*) FROM PAYROLLABSENCETRANS T1
    INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
    WHERE T1.TRANSDATE BETWEEN @FechaInicio AND @FechaFin
    AND T2.EMPLID = '%12' AND T1.PAYROLLABSENCECODEID = @codEnfermedad AND T1.HOURS > 0)

SET @tipoSusp =
CASE
    WHEN @diasSuspencion > 0 THEN 1
    WHEN @diasAccidente > 0 OR @diasEnfermedad > 0 THEN 2
    ELSE 0
END

IF @tipoSusp = 1 OR @tipoSusp = 2 BEGIN
    SET @VAR1= (SELECT COUNT(*) 
    FROM PAYROLLABSENCETRANS T1
    INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
    WHERE T1.TRANSDATE = @FechaInicio
    AND T2.EMPLID = '%12'
    AND ( T1.PAYROLLABSENCECODEID = @codSuspencion
        OR T1.PAYROLLABSENCECODEID = @codAccidente
        OR T1.PAYROLLABSENCECODEID = @codEnfermedad        
        ))

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
        AND ( T1.PAYROLLABSENCECODEID = @codSuspencion
            OR T1.PAYROLLABSENCECODEID = @codAccidente
            OR T1.PAYROLLABSENCECODEID = @codEnfermedad        
            ))
        IF @VAR2 = 0
        BEGIN
            SET @SalarioPrimerDia = @SalarioDiario
        END
        ELSE
        BEGIN
            SET @SalarioPrimerDia = 0
        END
    END
END

IF @tipoSusp = 1 BEGIN
    IF @SalarioPrimerDia = 0 BEGIN
        SET @SalarioSegundaParte = (@diasSuspencion * @SalarioDiario) / 3
    END
    ELSE BEGIN
        SET @SalarioSegundaParte = ((@diasSuspencion - 1) * @SalarioDiario) / 3
    END
END

IF @tipoSusp = 2 BEGIN
    IF @SalarioPrimerDia = 0 BEGIN
        SET @VAR1= (SELECT COUNT(*) 
        FROM PAYROLLABSENCETRANS T1
        INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
        WHERE T1.TRANSDATE BETWEEN @FechaInicioMesAnterior AND @FechaFinMesAnterior
        AND T2.EMPLID = '%12'
        AND ( T1.PAYROLLABSENCECODEID = @codSuspencion )) - 1

        IF @diasAccidente > 0 BEGIN
            SET @VAR2 = 
            CASE
                WHEN (14 - @VAR1) > @diasAccidente THEN @diasAccidente
                WHEN (14 - @VAR1) <= @diasAccidente THEN (14 - @VAR1)
            END
        END
        ELSE BEGIN
            SET @VAR2 = 
            CASE
                WHEN (14 - @VAR1) > @diasEnfermedad THEN @diasAccidente
                WHEN (14 - @VAR1) <= @diasEnfermedad THEN (14 - @VAR1)
            END
        END
                
        SET @SalarioSegundaParte = (@VAR2 * @SalarioDiario) / 3
    END
    ELSE BEGIN
        IF @diasAccidente > 0 BEGIN
            SET @VAR2 = 
            CASE
                WHEN (14) > (@diasAccidente - 1) THEN (@diasAccidente - 1)
                WHEN (14) <= (@diasAccidente - 1) THEN (14)
            END
        END
        ELSE BEGIN
            SET @VAR2 = 
            CASE
                WHEN (14) > (@diasAccidente - 1) THEN (@diasAccidente - 1)
                WHEN (14) <= (@diasAccidente - 1) THEN (14)
            END
        END

        SET @SalarioSegundaParte = (@VAR2 * @SalarioDiario) / 3
    END
END

SELECT @SalarioPrimerDia + @SalarioSegundaParte
/*SELECT @SalarioDiario*/