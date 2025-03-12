DECLARE @diasSuspencion INT
DECLARE @codSuspencion VARCHAR(10) = 'SUSP. IGSS'

DECLARE @salarioOrdinario REAL = CONVERT(REAL,'%27')
DECLARE @diasNomina INT
DECLARE @diasMaxTercera INT = 13

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
DECLARE @SalarioRetorno REAL
DECLARE @SalarioDiario REAL
SET @diasNomina = DATEDIFF(DAY, @FechaInicio, @FechaFin) + 1
/*DECLARE @SalarioDiario REAL = @SalarioOrdinario / @diasNomina*/
SET @SalarioDiario = @PARAM_1

/* Valida los dias de suspension en el mes */
SET @diasSuspencion = (SELECT COUNT(*) FROM PAYROLLABSENCETRANS T1
    INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
    WHERE T1.TRANSDATE BETWEEN @FechaInicio AND @FechaFin
    AND T2.EMPLID = '%12' AND T1.PAYROLLABSENCECODEID = @codSuspencion AND T1.HOURS <> 0)

/* Si tiene dias de suspension en el mes, este bloque valida el sueldo del primer dia*/
IF @diasSuspencion > 0 BEGIN
    /* Busca si en el primer dia del mes tiene suspension */
    SET @VAR1= (SELECT COUNT(*) 
    FROM PAYROLLABSENCETRANS T1
    INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
    WHERE T1.TRANSDATE = @FechaInicio
    AND T2.EMPLID = '%12'
    AND T1.PAYROLLABSENCECODEID = @codSuspencion)

    /* Si el primer dia no tiene suspension, se suma un dia de sueldo como primer dia de susp. */
    IF @VAR1 = 0
    BEGIN
        SET @SalarioPrimerDia = @SalarioDiario
    END
    ELSE
    BEGIN
        /* Si el primer dia tiene suspension, se busca si el ultimo dia del mes anterior
        tiene suspension */
        SET @VAR2= (SELECT COUNT(*) 
        FROM PAYROLLABSENCETRANS T1
        INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
        WHERE T1.TRANSDATE = @FechaFinMesAnterior
        AND T2.EMPLID = '%12'
        AND T1.PAYROLLABSENCECODEID = @codSuspencion)
        /* Si no tiene se suma el primer dia, sino no se suma */
        IF @VAR2 = 0
        BEGIN
            SET @SalarioPrimerDia = @SalarioDiario
        END
        ELSE
        BEGIN
            SET @SalarioPrimerDia = 0
        END
    END


    /* Si no se calculo sueldo de primer dia, es porque la suspension
    inicio desde el mes anterior y se calcula los dias */
    IF @SalarioPrimerDia = 0 BEGIN
        /* Se busca los dias de suspension del mes anterior */
        SET @VAR1= (SELECT COUNT(*) 
        FROM PAYROLLABSENCETRANS T1
        INNER JOIN PAYROLLABSENCETABLE T2 ON T1.PAYROLLABSENCETABLEID = T2.PAYROLLABSENCETABLEID 
        WHERE T1.TRANSDATE BETWEEN @FechaInicioMesAnterior AND @FechaFinMesAnterior
        AND T2.EMPLID = '%12'
        AND ( T1.PAYROLLABSENCECODEID = @codSuspencion )) 

        SET @VAR2 = 
        CASE
            WHEN (@diasMaxTercera - @VAR1) > @diasSuspencion THEN @diasSuspencion
            WHEN (@diasMaxTercera - @VAR1) <= @diasSuspencion THEN (@diasMaxTercera - @VAR1)
        END
                
        SET @SalarioSegundaParte = (@VAR2 * @SalarioDiario) / 3
    END
    ELSE BEGIN
        SET @VAR2 = 
        CASE
            WHEN (@diasMaxTercera) > (@diasSuspencion - 1) THEN (@diasSuspencion - 1)
            WHEN (@diasMaxTercera) <= (@diasSuspencion - 1) THEN (@diasMaxTercera)
        END

        SET @SalarioSegundaParte = (@VAR2 * @SalarioDiario) / 3
    END
END

SET @SalarioRetorno = @SalarioPrimerDia + @SalarioSegundaParte

IF @SalarioRetorno < 0 BEGIN
    SET @SalarioRetorno = 0
END

SELECT @SalarioRetorno