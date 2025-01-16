-- ## VARIABLES

declare @dias real;
declare @Plan real;
declare @Salario real;
declare @DiasAusencia real;
declare @diario real;
declare @MinimoLey real;
declare @Ingresos real;


-- ## ASIGNACIONES

set @dias = {Dias_Lab_Calendario_Exact};
set @Plan = {SalarioMensual};
set @diario =  (@Plan / @dias);
set @Ingresos = {Total_Ingresos_Trans,G_AJUSTEALMINIMO}
set @MinimoLey = {Salario_Minimo_Zona_Empl}


-- ## FORMULA

IF (@Ingresos < (@MinimoLey/{Dias_Calendario_Nomina}) * (@dias - ({Dias_Tipo_Ausencia,AUSENCIA PRUEB} + {Dias_Tipo_Ausencia,SUSP. IGSS}))) THEN
    (((@MinimoLey/{Dias_Calendario_Nomina}) * @dias) - @Ingresos)
ELSE
    0
END