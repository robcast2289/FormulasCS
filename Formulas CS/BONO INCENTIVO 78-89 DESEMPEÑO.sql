-- ## VARIABLES

declare @dias real;
declare @Plan real;
declare @Salario real;
declare @DiasAusencia real;
declare @diario real;
declare @MinimoCofino real;
declare @Ingresos real;


-- ## ASIGNACIONES

set @dias = {Dias_Lab_Calendario_Exact};
set @Plan = {SalarioMensual};
set @diario =  (@Plan / @dias);
set @Ingresos = {Total_Ingresos_Trans,G_MINIMOCOFINO};
set @MinimoCofino = 3700.00;


-- ## FORMULA

IF (@Ingresos < (@MinimoCofino/{Dias_Calendario_Nomina}) * (@dias - ({Dias_Tipo_Ausencia,AUSENCIA PRUEB} + {Dias_Tipo_Ausencia,SUSP. IGSS}))) THEN
    (((@MinimoCofino/{Dias_Calendario_Nomina}) * @dias) - @Ingresos)
ELSE
    0
END