-- ## VARIABLES

declare @A real;
declare @dias real;
declare @CalcInvVac real;
declare @Promedio real;
declare @Asignacion1 real;
declare @MesesCalcular real;

declare @param_1 nvarchar(60);
declare @param_2 nvarchar(60);
declare @param_3 int;
declare @param_4 int;
declare @param_5 int;




-- ## ASIGNACIONES

set @A = {CantidadTransaccion};
set @Asignacion1 = 11;
set @CalcInvVac = {Monto_Anio_VacHistoricas,G_VACACIONES,Acumulado};
set @Dias = {Tabla_AguinaldoVacaciones,V,hoy,s};
set @Dias = {Funcion,DiasVacaciones,@A}; 
set @MesesCalcular =  {Funcion,CalcMesCompletoFechaIngreso,@Asignacion1};
set @Promedio = {Monto_Acumulado_Mes,SC,PMeses,G_VACACIONES,11};
  
set @param_1 = 'OTRO';
set @param_2 = 'G_VACACIONES';
set @param_3 = 12;
set @param_4 = 1;
set @param_5 = 3;
set @Promedio = {Funcion,Monto_Acumulado_Cofal,[@param_1,@param_2,@param_3,@param_4,@param_5]};  
set @Promedio = @Promedio / 30;



-- ## FORMULA

if ({funcion,DiasLiquidacion} > 0) then
    /*{Total_Acumulado_Anio,MC,D,G_VACACIONES_L,1,pmeses} / 30 * {Funcion,DiasVacaciones,@A}*/
   @Promedio * @Dias 
else
    0
end




--------------------------------------


declare @A real;
declare @dias real;
declare @CalcInvVac real;
declare @Promedio real;
declare @MesesCalcular int;
declare @Asignacion1 int;
declare @MiVar real = 11;
declare @var1 int;
declare @var2 int;
declare @var4 int;
declare @var3 real;

declare @param_1 nvarchar(60);
declare @param_2 nvarchar(60);
declare @param_3 int;
declare @param_4 int;


-- #########


set @A = {CantidadTransaccion};
set @Asignacion1 = 11;
set @CalcInvVac = {Monto_Anio_VacHistoricas,G_VACACIONES,Acumulado};
set @Dias = {Tabla_AguinaldoVacaciones,V,hoy,s};
set @Dias = {Funcion,DiasVacaciones,@A}; 
set @MesesCalcular =  {Funcion,CalcMesCompletoFechaIngreso,@Asignacion1};
/*set @Promedio = {Monto_Acumulado_Mes,SC,PMeses,G_VACACIONES,12};*/

set @Promedio = {Monto_Acumulado_Mes,MC,G_VACACIONES,12,Acumulado,D};

set @Promedio = @Promedio / 8;
     
set @param_1 = 'AGUINALDO';
set @param_2 = 'G_VACACIONES';
set @param_3 = 12;
set @param_4 = 1;
set @Promedio = {Funcion,Monto_Acumulado_Cofal,[@param_1,@param_2,@param_3,@param_4]};  

/*
set @var1 = 10;
set @var2 = 40;
set @var4 = 50;
set @var3 = {Funcion,test_funcion,[@var1,@var2,@var4]}
*/



---#######


if ({funcion,DiasLiquidacion} > 0) then
    /*{Total_Acumulado_Anio,MC,D,G_VACACIONES_L,1,pmeses} / 30 * {Funcion,DiasVacaciones,@A}*/
   @Promedio / 30 * @Dias


else
    0
end