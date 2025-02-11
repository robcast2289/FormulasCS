-- ## VARIABLES

declare @A real;
declare @dias real;
declare @CalcInvVac real;
declare @Promedio real;
declare @Asignacion1 real;
declare @MesesCalcular real;



-- ## ASIGNACIONES

set @A = {CantidadTransaccion};
set @Asignacion1 = 11;
set @CalcInvVac = {Monto_Anio_VacHistoricas,G_VACACIONES,Acumulado};
set @Dias = {Tabla_AguinaldoVacaciones,V,hoy,s};
set @Dias = {Funcion,DiasVacaciones,@A}; 
set @MesesCalcular =  {Funcion,CalcMesCompletoFechaIngreso,@Asignacion1};
set @Promedio = {Monto_Acumulado_Mes,SC,PMeses,G_VACACIONES,11}




-- ## FORMULA

if ({funcion,DiasLiquidacion} > 0) then
    /*{Total_Acumulado_Anio,MC,D,G_VACACIONES_L,1,pmeses} / 30 * {Funcion,DiasVacaciones,@A}*/
   @Promedio * @A
else
    0
end