-- ## VARIABLES

declare @dias real;
declare @Plan real;
declare @Salario real;
declare @DiasAusencia real;
declare @diario real;


-- ## ASIGNACIONES

set @dias = {Dias_Lab_Calendario_Exact};
/*set @DiasAusencia = {CantidadTransaccion};*/
set @Plan = {SalarioMensual};
set @diario =  (@Plan / @dias);


-- ## FORMULA

(@Plan/{Dias_Calendario_Nomina}) * (@dias - ({Dias_Tipo_Ausencia,AUSENCIA PRUEB} + {Dias_Tipo_Ausencia,SUSP. IGSS}))