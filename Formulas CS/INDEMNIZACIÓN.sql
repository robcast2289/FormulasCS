-- ## VARIABLES

declare @PIndemniza real;
declare @PIndemDoceava real;

declare @DoceavaAgui real;
declare @DiasAguinaldo real;
declare @PromAguinaldo real;
declare @PromFinAguinaldo real;


declare @DoceavaBono real;
declare @DiasBono real;
declare @PromBono real;
declare @PromFinBono real;

declare @SalarioActual real;
declare @MinimoLey real;
declare @PctDias real;

declare @Promedio real;
declare @param_1 nvarchar(60);
declare @param_2 nvarchar(60);
declare @param_3 int;
declare @param_1_1 nvarchar(60);
declare @param_2_1 nvarchar(60);
declare @param_3_1 int;
declare @param_1_2 nvarchar(60);
declare @param_2_2 nvarchar(60);
declare @param_3_2 int;
declare @param_4 int;
declare @param_5 int;


-- ## ASIGNACIONES

set @MinimoLey = {Salario_Minimo_Zona_Empl};
set @SalarioActual = {SalarioMensual};

set @param_1 = 'OTRO';
set @param_2 = 'G_INDEMNIZACION_L';
set @param_3 = 6;
set @param_4 = 1;
set @param_5 = 0;
set @PIndemniza = {Funcion,Monto_Acumulado_Cofal,[@param_1,@param_2,@param_3,@param_4,@param_5]};  
set @PIndemniza = si_tern(@PIndemniza < @MinimoLey, @SalarioActual, @PIndemniza); 
set @PIndemniza = si_tern(@PIndemniza < @MinimoLey, @MinimoLey, @PIndemniza); 

/*set @PIndemniza = {Monto_Acumulado_Mes,MC,6,G_INDEMNIZACION_L,D,Pmeses};*/

-- Aguinaldo
set @param_1_1 = 'AGUINALDO';
set @param_2_1 = 'G_AGUINALDO_L_COM';
set @param_3_1 = 12;
set @DiasAguinaldo = {DiasLiq_AguinaldoBono14,A};
set @PromAguinaldo = {Funcion,Monto_Acumulado_Cofal,[@param_1_1,@param_2_1,@param_3_1,@param_4,@param_5]};
/*set @PromAguinaldo = {Promedio_AguinaldoBono14,A,PMESES,G_AGUINALDO_L_COM,MC,11};*/
set @PromFinAguinaldo = @SalarioActual + @PromAguinaldo;
set @PromFinAguinaldo = si_tern(@PromFinAguinaldo < @MinimoLey, @SalarioActual, @PromFinAguinaldo);
set @PromFinAguinaldo = si_tern(@PromFinAguinaldo < @MinimoLey, @MinimoLey, @PromFinAguinaldo);
set @DoceavaAgui = @PromFinAguinaldo / 12;


-- Bono 14
set @param_1_2 = 'BONO14';
set @param_2_2 = 'G_BONO14_L';
set @param_3_2 = 12;
set @DiasBono = {DiasLiq_AguinaldoBono14,A};
set @PromBono = {Funcion,Monto_Acumulado_Cofal,[@param_1_2,@param_2_2,@param_3_2,@param_4,@param_5]};
/*set @PromBono = {Promedio_AguinaldoBono14,B,PMESES,G_BONO14_L,MC,11};*/
set @PromFinBono = @PromBono;
set @PromFinBono = si_tern(@PromFinBono < @MinimoLey, @SalarioActual, @PromFinBono);
set @PromFinBono = si_tern(@PromFinBono < @MinimoLey, @MinimoLey, @PromFinBono);
set @DoceavaBono = @PromFinBono / 12;


set @PctDias = {DiasLiquidacion} / 365;
set @PIndemDoceava = @PIndemniza + @DoceavaAgui + @DoceavaBono;



-- ## FORMULA

(@PctDias * @PIndemDoceava) *  {PorcentajeLiquidacion}