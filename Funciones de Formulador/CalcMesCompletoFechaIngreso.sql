DECLARE @FechaInicial DATE = CONVERT(DATE,'%19',103)
DECLARE @MesesLimite INT = @PARAM_1
DECLARE @MesesCalculados INT
    DECLARE @EsPrimerDia BIT
    DECLARE @FechaActual DATE = CONVERT(DATE,'%8',103)
    
    -- Calcular la cantidad de meses entre las fechas
    SET @MesesCalculados = DATEDIFF(MONTH, @FechaInicial, @FechaActual)
    
    -- Verificar si la fecha inicial es el primer día del mes
    SET @EsPrimerDia = CASE 
        WHEN DAY(@FechaInicial) = 1 THEN 1 
        ELSE 0 
    END
    
    -- Aplicar las reglas de negocio
    SET @MesesCalculados = 
        CASE
            -- Si es mayor a @MesesLimite meses, retornar @MesesLimite
            WHEN @MesesCalculados > @MesesLimite THEN @MesesLimite
            -- Si no es el primer día del mes, restar 1 al cálculo
            WHEN @EsPrimerDia = 0 THEN @MesesCalculados - 1
            -- Si es el primer día, mantener el cálculo original
            ELSE @MesesCalculados
        END
    
    -- Asegurar que no retorne valores negativos
     SET @MesesCalculados = 
        CASE 
            WHEN @MesesCalculados < 0 THEN 0 
            ELSE @MesesCalculados 
        END

    SELECT @MesesCalculados;