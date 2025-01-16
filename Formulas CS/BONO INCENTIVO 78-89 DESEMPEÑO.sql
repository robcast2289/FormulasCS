-- ## VARIABLES

declare @dias real;
declare @Plan real;
declare @Salario real;
declare @DiasAusencia real;
declare @diario real;
declare @MinimoCofino real;
declare @Ingresos real;
declare @diaslab real;


-- ## ASIGNACIONES

set @dias = {Dias_Lab_Calendario_Exact};
set @Plan = {SalarioMensual};
set @diario =  (@Plan / @dias);
set @Ingresos = {Total_Ingresos_Trans,G_MINIMOCOFINO};
set @Ingresos = @Ingresos + @Plan;
set @MinimoCofino = 3700.00;
set @diaslab = {Dias_Calendario_Nomina} + {Dias_Tipo_Ausencia,VACACIONES}


-- ## FORMULA

/*IF (@Ingresos < (@MinimoCofino/{Dias_Calendario_Nomina}) * (@dias - ({Dias_Tipo_Ausencia,AUSENCIA PRUEB} + {Dias_Tipo_Ausencia,SUSP. IGSS}))) THEN*/
/*IF (@Ingresos < (@MinimoCofino/{Dias_Calendario_Nomina}) * (@dias)) THEN
    (((@MinimoCofino/{Dias_Calendario_Nomina}) * @dias) - @Ingresos)
ELSE
    0
END*/

IF (@Ingresos < (@MinimoCofino)) THEN
    ((@MinimoCofino - @Ingresos) / @diaslab) * @dias
ELSE
    0
END