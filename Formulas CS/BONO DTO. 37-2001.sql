-- ## VARIABLES

declare @Plan real;
declare  @diasnomi real;
declare @diaslab real;
declare @nom real;
declare @diasvac real;
declare @diasauig real;
declare @diasmat real;
declare @diasAsueto real;
declare @alta real;
declare @tipotrans real;
declare @montoCalc real;


-- ## ASIGNACIONES

set @Plan = {MontoPlanMensual};
/*set @diasAsueto = {funcion,DiasAsuetoPeriodo}*/
set @diasnomi = {Dias_Calendario_Nomina};
set @diaslab = {Dias_Lab_Calendario_Exact};
set @diasvac = {Dias_Tipo_Ausencia,VACACIONES};

/* Dias de suspensiones IGSS */
set @diasauig = {Dias_Tipo_Ausencia,SUSP. IGSS};

/* Dias de maternidad */
set @diasmat = {Dias_Tipo_Ausencia,SUSP. MATERN};

set @alta = {AltaEnPeriodo};
set @tipotrans = {TipoTransaccion};

set @montoCalc = case
when @alta = 1 or @tipotrans = 1 then (({MontoPlanMensual} / @diasnomi)  * (@diaslab + @diasvac))
when @alta = 0 then ({MontoPlanMensual})
end;



-- ## FORMULA

/*if ({Dias_Lab_Calendario_Exact} + @diasvac = 0) then*/
/*{MontoPlanMensual}*/
/*else*/
/*end*/

/*( {MontoPlanMensual} /{Dias_Calendario_Nomina}) * (( {Dias_Lab_Calendario_Exact} ) + @diasvac + @diasauig + {Dias_Tipo_Ausencia,AUSENCIA PRUEB})*/

/* Si los dias de suspension abarca todo el periodo de nomina, retorna 0 */
if (@diaslab + @diasvac = 0) then
    0
else
/* De lo contraria calcula lo proporcional a los dias laborados + vacaciones + suspenciones igss */
    /*( {MontoPlanMensual} / @diasnomi ) * (( @diaslab ) + @diasvac + @diasauig )*/
@montoCalc

end