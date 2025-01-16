-- ## VARIABLES

declare @Plan real;
declare  @diasnomi real;
declare @nom real;
declare @diasvac real;


-- ## ASIGNACIONES

set @Plan = {MontoPlanMensual};
set @diasnomi = {Dias_Lab_Calendario_Exact};
set @diasvac = {Dias_Tipo_Ausencia,VACACIONES};


-- ## FORMULA

( {MontoPlanMensual} /{Dias_Calendario_Nomina}) * ({Dias_Lab_Calendario_Exact} + @diasvac)