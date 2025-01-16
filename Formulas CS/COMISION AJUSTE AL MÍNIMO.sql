-- ## VARIABLES

declare @dias real;
declare @Plan real;
declare @Salario real;
declare @DiasAusencia real;
declare @diario real;
declare @MinimoLey real;
declare @Ingresos real;
declare @diaslab real;


-- ## ASIGNACIONES

set @dias = {Dias_Lab_Calendario_Exact};
set @Plan = {SalarioMensual};
set @diario =  (@Plan / @dias);
set @Ingresos = {Total_Ingresos_Trans,G_AJUSTEALMINIMO}
set @Ingresos = @Ingresos + @Plan;
set @MinimoLey = {Salario_Minimo_Zona_Empl}
set @diaslab = {Dias_Calendario_Nomina} + {Dias_Tipo_Ausencia,VACACIONES}


-- ## FORMULA

/*IF (@Ingresos < (@MinimoLey/{Dias_Calendario_Nomina}) * (@dias - ({Dias_Tipo_Ausencia,AUSENCIA PRUEB} + {Dias_Tipo_Ausencia,SUSP. IGSS}))) THEN*/
/*IF (@Ingresos < (@MinimoLey/{Dias_Calendario_Nomina}) * (@dias)) THEN
    (((@MinimoLey/{Dias_Calendario_Nomina}) * @dias) - @Ingresos)
ELSE
    0
END*/

IF (@Ingresos < (@MinimoLey)) THEN
    ((@MinimoLey - @Ingresos) / @diaslab) * @dias
ELSE
    0
END