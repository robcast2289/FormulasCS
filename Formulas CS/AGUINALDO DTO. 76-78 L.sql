-- ## VARIABLES

declare @Dias real;
declare @Aguinaldo real;
declare @Promedio real;
declare @PromRepHistPrestDet real;
declare @QtyAgui real;
declare @terceraparte real;
declare @treceacum real;
declare @treceunit real;
declare @Acumulado2 real;
declare @unidades2 real;
declare @PromTrece real;
declare @12tercera real;
declare @DiasNomina real;


-- ## ASIGNACIONES

set @Dias = {DiasAguinaldo}; /*{DiasLiq_AguinaldoBono14,A};*/
/*set @Promedio = {Monto_Acumulado_Mes,SC,PDias,G_Aguinaldo_L,D,6};

set @PromRepHistPrestDet =  round(@Promedio * 30 / 365, 2) ;

set @Aguinaldo = @PromRepHistPrestDet * @Dias;*/

set @Aguinaldo = {Promedio_AguinaldoBono14,A,Acumulado,G_Aguinaldo,MA,11};
set @QtyAgui =    {Promedio_AguinaldoBono14,A,Acumulado,G_Aguinaldo_Unidades,MA,11,U,-1};


/*set @Dias = {DiasAguinaldo};
set @terceraparte = ({Promedio_AguinaldoBono14,A,PMESES,realterceraparte,MA,6,-1} * 3);
set @Aguinaldo = ({Promedio_AguinaldoBono14,A,PMESES,G_Aguinaldo,MA,6,-1});
set @Aguinaldo = SI_TERN(@Aguinaldo=0,{SalarioMensual},@Aguinaldo);*/

/*terceraparte*/
/*set @Acumulado2 = {Promedio_AguinaldoBono14,A,Acumulado,G_Aguinaldo,MA,6};
set @treceacum = ({Monto_Acumulado_Mes,MA,Acumulado,realterceraparte,6,-1})* 3;

set @unidades2 = {Promedio_AguinaldoBono14,A,Acumulado,G_Aguinaldo_Unidaes,MA,6,U,-1};
set @treceunit = {Monto_Acumulado_Mes,MA,Acumulado,G_TERCERA_UNIDADES,U,6,-1} ;

set @unidades2 = si_tern(@unidades2=0,1,@unidades2);

set @PromTrece = (@Acumulado2 / @unidades2)*30;
set @12tercera = (@PromTrece/12) * 2;

set @DiasNomina = {Funcion,DiasAnioXnomina};*/


-- ## FORMULA

@Aguinaldo/@QtyAgui * 30 / {Funcion,DiasAnioXnomina} *@Dias


/*If(@Dias>0) then
     If @terceraparte > 0 then
     (@PromTrece / @DiasNomina ) * @Dias
     else
     (@Aguinaldo / @DiasNomina ) * @Dias
     end
else
0
end*/