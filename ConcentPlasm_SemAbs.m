clc;
clear all;
close all;

Dose = 250;
Intervalo_Adm_h = 2*24;
Meia_Vida_h  = 7*24;

TempoDeTeste_h = (150)*24;

x = linspace(1 , TempoDeTeste_h , TempoDeTeste_h);

Concentracao = zeros(1,TempoDeTeste_h);
cont = 0;
for Hora = 1:(TempoDeTeste_h-1)
    Concentracao(Hora+1) = Concentracao(Hora) - ((Concentracao(Hora)/Meia_Vida_h)/2);
    
    cont++;
    if cont == Intervalo_Adm_h
        cont = 0;
        Concentracao(Hora+1) += Dose;
    endif
endfor


horasmedia = 12*24;
MediaMovel = zeros(1,TempoDeTeste_h);
for j = 1+(horasmedia/2):(TempoDeTeste_h-horasmedia)
    MediaMovel(j) = (sum(Concentracao(j-(horasmedia/2):j+(horasmedia/2))))/(horasmedia+1);
endfor


figure(1);
plot(x,Concentracao(x),MediaMovel(x));
grid on;
xlabel('x');
ylabel('F(x)');

Taxa_IntervaloMeiavida = Intervalo_Adm_h/Meia_Vida_h;
Taxa_DoseConcentracaoFinal = MediaMovel(length(Concentracao)-horasmedia)/Dose;

disp(Taxa_IntervaloMeiavida);
disp(Taxa_DoseConcentracaoFinal);



