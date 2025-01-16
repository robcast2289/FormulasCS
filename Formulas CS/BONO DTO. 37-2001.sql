-- ## VARIABLES

declare @Plan real;
declare  @diasnomi real;
declare @nom real;
declare @diasvac real;
declare @diasauig real;


-- ## ASIGNACIONES

set @Plan = {MontoPlanMensual};
set @diasnomi = {Dias_Lab_Calendario_Exact};
set @diasvac = {Dias_Tipo_Ausencia,VACACIONES};
set @diasauig = {Dias_Tipo_Ausencia,SUSP. IGSS};


-- ## FORMULA

/*if ({Dias_Lab_Calendario_Exact} + @diasvac = 0) then*/
/*{MontoPlanMensual}*/
/*else*/
/*end*/

( {MontoPlanMensual} /{Dias_Calendario_Nomina}) * (( {Dias_Lab_Calendario_Exact} ) + @diasvac + @diasauig + {Dias_Tipo_Ausencia,AUSENCIA PRUEB})