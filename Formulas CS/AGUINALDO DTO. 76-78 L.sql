-- ## VARIABLES

declare @Dias real;
declare @Aguinaldo real;
declare @SalarioActual real;
declare @Salrio_mas_promedio real;

declare @Promedio real;
declare @param_1 nvarchar(60);
declare @param_2 nvarchar(60);
declare @param_3 int;
declare @param_4 int;
declare @param_5 int;


-- ## ASIGNACIONES

set @param_1 = 'AGUINALDO';
set @param_2 = 'G_AGUINALDO_L_COM';
set @param_3 = 11;
set @param_4 = 1;
set @param_5 = 0;
set @Aguinaldo = {Funcion,Monto_Acumulado_Cofal,[@param_1,@param_2,@param_3,@param_4,@param_5]};

/*set @Aguinaldo = {Promedio_AguinaldoBono14,A,PMESES,G_AGUINALDO_L_COM,MC,11};*/
set @Dias = {DiasLiq_AguinaldoBono14,A};
set @SalarioActual = {SalarioMensual};
set @Salrio_mas_promedio = @SalarioActual + @Aguinaldo;



-- ## FORMULA

If(@Dias>0) then
    @Salrio_mas_promedio / {Funcion,DiasAnioXAguinaldo} * @Dias
else
    0
end