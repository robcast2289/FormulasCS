-- ## VARIABLES

declare @Dias real;
declare @Promedio real;
declare @A real;
declare @MinimoLey real;
declare @SalarioActual real;

declare @param_1 nvarchar(60);
declare @param_2 nvarchar(60);
declare @param_3 int;
declare @param_4 int;
declare @param_5 int;


-- ## ASIGNACIONES

set @param_1 = 'OTRO';
set @param_2 = 'G_VACACIONES';
set @param_3 = 12;
set @param_4 = 1;
set @param_5 = 0;
set @Promedio = {Funcion,Monto_Acumulado_Cofal,[@param_1,@param_2,@param_3,@param_4,@param_5]};  

set @MinimoLey = {Salario_Minimo_Zona_Empl};
set @SalarioActual = {SalarioMensual};
set @Promedio = si_tern(@Promedio < @MinimoLey, @SalarioActual, @Promedio);
set @Promedio = si_tern(@Promedio < @MinimoLey, @MinimoLey, @Promedio);

/*set @Promedio = {Monto_Acumulado_Mes,SC,PMeses,G_VACACIONES,11};*/
set @A = {CantidadTransaccion};
set @Dias = {Funcion,DiasVacaciones,@A}; 
set @Promedio = @Promedio / 30;


-- ## FORMULA

if ({funcion,DiasLiquidacion} > 0) then
    /*{Total_Acumulado_Anio,MC,D,G_VACACIONES_L,1,pmeses} / 30 * {Funcion,DiasVacaciones,@A}*/
   @Promedio * @Dias 
else
    0
end