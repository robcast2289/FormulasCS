-- ## VARIABLES

declare @Dias real;
declare @Aguinaldo real;
declare @SalarioActual real;
declare @Salrio_mas_promedio real;


-- ## ASIGNACIONES

set @Dias = {DiasLiq_AguinaldoBono14,A};
set @Aguinaldo = {Promedio_AguinaldoBono14,A,PMESES,G_AGUINALDO_L_COM,MC,11};
set @SalarioActual = {SalarioMensual};
set @Salrio_mas_promedio = @SalarioActual + @Aguinaldo;



-- ## FORMULA

If(@Dias>0) then
    @Salrio_mas_promedio / {Funcion,DiasAnioXAguinaldo} * @Dias
else
    0
end