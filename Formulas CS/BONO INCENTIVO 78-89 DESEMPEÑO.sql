-- ## VARIABLES

declare @dias real;
declare @Plan real;
declare @Salario real;
declare @DiasAusencia real;
declare @diario real;
declare @MinimoCofino real;
declare @Ingresos real;
declare @IngresosDiario real;
declare @diaslab real;

declare @MinimoLey real;
declare @IngresosMinimo real;
declare @montoSusp real;

declare @test real;


-- ## ASIGNACIONES

set @dias = {Dias_Lab_Calendario_Exact};
set @Plan = {SalarioMensual};
set @diario =  (@Plan / @dias);
set @Ingresos = {Total_Ingresos_Trans,G_MINIMOCOFINO};
set @Ingresos = @Ingresos + @Plan;
set @MinimoCofino = 3700.00;
set @MinimoLey = {Salario_Minimo_Zona_Empl}
set @diaslab = {Dias_Calendario_Nomina}

set @IngresosMinimo = {Total_Ingresos_Trans,G_AJUSTEALMINIMO}
set @IngresosMinimo = @IngresosMinimo + @Plan;

set @Ingresos = @Ingresos + (@MinimoLey - @IngresosMinimo)

set @IngresosDiario = (@MinimoCofino - @Ingresos) / @diaslab;
set @montoSusp = {Funcion,SalarioDeSuspencion,@IngresosDiario};

 set @test = {Funcion,test_variable,@IngresosDiario};


-- ## FORMULA

/*IF (@Ingresos < (@MinimoCofino/{Dias_Calendario_Nomina}) * (@dias - ({Dias_Tipo_Ausencia,AUSENCIA PRUEB} + {Dias_Tipo_Ausencia,SUSP. IGSS}))) THEN*/
/*IF (@Ingresos < (@MinimoCofino/{Dias_Calendario_Nomina}) * (@dias)) THEN
    (((@MinimoCofino/{Dias_Calendario_Nomina}) * @dias) - @Ingresos)
ELSE
    0
END*/

IF (@Ingresos < (@MinimoCofino)) THEN
    (((@MinimoCofino - @Ingresos) / @diaslab) * @dias) + @montoSusp
ELSE
    0
END