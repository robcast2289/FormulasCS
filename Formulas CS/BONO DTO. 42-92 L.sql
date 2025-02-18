-- ## VARIABLES

declare @Dias real;
declare @bono14 real;
      
declare @Promedio real;
declare @param_1 nvarchar(60);
declare @param_2 nvarchar(60);
declare @param_3 int;
declare @param_4 int;
declare @param_5 int;


-- ## ASIGNACIONES

set @param_1 = 'BONO14';
set @param_2 = 'G_BONO14_L';
set @param_3 = 12;
set @param_4 = 1;
set @param_5 = 0;
set @bono14 = {Funcion,Monto_Acumulado_Cofal,[@param_1,@param_2,@param_3,@param_4,@param_5]};

/*set @bono14 = ({Promedio_AguinaldoBono14,B,PMESES,G_BONO14_L,MC,11});*/
set @Dias = {DiasLiq_AguinaldoBono14,B};
set @bono14 = si_tern(@bono14=0,{SalarioMensual},@bono14);


-- ## FORMULA

if(@Dias > 0) then
    (@bono14/ {Funcion,DiasAnioXBono} )*@Dias
else
    0
end