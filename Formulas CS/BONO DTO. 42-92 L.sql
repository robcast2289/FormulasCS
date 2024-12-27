-- ## VARIABLES
declare @Dias real;
declare @bono14 real;
declare @QtyAgui real;
declare @terceraparte real;
declare @treceacum real;
declare @treceunit real;
declare @Acumulado2 real;
declare @unidades2 real;
declare @PromTrece real;
declare @12tercera real;



-- ## ASIGNACIONES

set @Dias = {DiasBono14};
/* set @terceraparte = ({Promomedio_AguinaldoBono14,B,PMESES,realtercerparte,SC,6} * 3); */
set @bono14 = ({Promedio_AguinaldoBono14,B,PMESES,G_BONO14_L,MC,6});
set @QtyAgui= {Promedio_AguinaldoBono14,B,Acumulado,G_AGUINALDO_UNIDADES,MC,6,U,-1};

set @bono14 = si_tern(@bono14=0,{SalarioMensual},@bono14);

/*terceraparte*/
set @Acumulado2 = ({Promedio_AguinaldoBono14,B,Acumulado,G_bono14,MA,6,-1});
/* set @treceacum = ({Monto_Acumulado_Mes,SC,Acumulado,realterceraparte,6})*3; */

set @unidades2 = {Promedio_AguinaldoBono14,B,Acumulado,G_AGUINALDO_UNIDADES,MC,6,U,-1};
set @treceunit = {Monto_Acumulado_Mes,SC,Acumulado,G_TERCERA_UNIDADES,U,6,-1};

set @unidades2 = si_tern(@unidades2=0,1,@unidades2);

set @PromTrece = ((@Acumulado2 + @treceacum) / (@unidades2 + @treceunit) * 30);



-- ## FORMULA

if(@Dias > 0) then
     IF @terceraparte >0 THEN
     (@PromTrece / {Funcion,DiasAnioXnomina} )*@Dias

     else
(@bono14/ {Funcion,DiasAnioXnomina} )*@Dias
end
else
0
end