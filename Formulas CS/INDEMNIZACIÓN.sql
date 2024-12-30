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

declare @PctDias real;


-- ## ASIGNACIONES

set @PIndemniza = {Monto_Acumulado_Mes,MC,6,G_INDEMNIZACION_L,D,Pmeses};
set @SalarioActual = {SalarioMensual};

-- Aguinaldo
set @DiasAguinaldo = {DiasLiq_AguinaldoBono14,A};
set @PromAguinaldo = {Promedio_AguinaldoBono14,A,PMESES,G_AGUINALDO_L_COM,MC,11};
set @PromFinAguinaldo = @SalarioActual + @PromAguinaldo;
set @DoceavaAgui = @PromFinAguinaldo / 12;


-- Bono 14
set @DiasBono = {DiasLiq_AguinaldoBono14,A};
set @PromBono = {Promedio_AguinaldoBono14,B,PMESES,G_BONO14_L,MC,11};
set @PromFinBono = @PromBono;
set @DoceavaBono = @PromFinBono / 12;


set @PctDias = {DiasLiquidacion} / 365;
set @PIndemDoceava = @PIndemniza + @DoceavaAgui + @DoceavaBono;



-- ## FORMULA

(@PctDias * @PIndemDoceava) *  {PorcentajeLiquidacion}