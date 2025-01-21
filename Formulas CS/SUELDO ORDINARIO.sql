-- ## VARIABLES

declare @dias real;
declare @diasnomi real;
declare @Plan real;
declare @Salario real;
declare @DiasAusencia real;
declare @diario real;

declare @montoSusp real;


-- ## ASIGNACIONES

set @dias = {Dias_Lab_Calendario_Exact};
set @diasnomi = {Dias_Calendario_Nomina};
/*set @DiasAusencia = {CantidadTransaccion};*/
set @Plan = {SalarioMensual};
set @diario =  (@Plan / @diasnomi);

set @montoSusp = {Funcion,SalarioDeSuspencion,@diario};


-- ## FORMULA

((@Plan/@diasnomi) * (@dias)) + (@montoSusp)