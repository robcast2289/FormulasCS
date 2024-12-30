-- ## VARIABLES

declare @Dias real;
declare @bono14 real;



-- ## ASIGNACIONES

set @Dias = {DiasLiq_AguinaldoBono14,B};
set @bono14 = ({Promedio_AguinaldoBono14,B,PMESES,G_BONO14_L,MC,11});
set @bono14 = si_tern(@bono14=0,{SalarioMensual},@bono14);



-- ## FORMULA

if(@Dias > 0) then
    (@bono14/ {Funcion,DiasAnioXBono} )*@Dias
else
    0
end