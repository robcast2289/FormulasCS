-- ## VARIABLES

declare @A real;
declare @dias real;



-- ## ASIGNACIONES

set @A = {CantidadTransaccion};



-- ## FORMULA

if ({funcion,DiasLiquidacion} > 0) then
    {Total_Acumulado_Anio,MC,D,G_VACACIONES_L,1,pmeses} / 30 * {Funcion,DiasVacaciones,@A}
else
    0
end