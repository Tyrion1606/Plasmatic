clc;
clear all;
close all;




horasmedia = 12*24;
Dose = 100;
Meia_Vida_h  = 2*24;
TempoDeTeste_h = (120)*24;

x = linspace(1 , TempoDeTeste_h , TempoDeTeste_h);
x2 = linspace(1 , 10 , 10);

Taxa_IntervaloMeiavida = zeros(1,100);
Taxa_DoseConcentracaoFinal = zeros(1,100);

Concentracao = zeros(1,TempoDeTeste_h);
MediaMovel = zeros(1,TempoDeTeste_h);

for k = 1:10
    
    Intervalo_Adm_h = k*12;
    
    i = 0;
    for Hora = 1:(TempoDeTeste_h-1)
        Concentracao(Hora+1) = Concentracao(Hora) - ((Concentracao(Hora)/Meia_Vida_h)/2);
        
        i++;
        if i == Intervalo_Adm_h
            i = 0;
            Concentracao(Hora+1) += +Dose;
        endif
    endfor


    
    for j = 1+(horasmedia/2):(TempoDeTeste_h-horasmedia)
        MediaMovel(j) = (sum(Concentracao(j-(horasmedia/2):j+(horasmedia/2))))/(horasmedia+1);
    endfor


##    figure(1);
##    plot(x,Concentracao(x),MediaMovel(x));
##    grid on;
##    xlabel('x');
##    ylabel('F(x)');

    Taxa_IntervaloMeiavida(k) = Intervalo_Adm_h/Meia_Vida_h;
    Taxa_DoseConcentracaoFinal(k)= (MediaMovel(length(Concentracao)-horasmedia)/Dose);
    
endfor

figure(1);
plot(Taxa_IntervaloMeiavida(x2),Taxa_DoseConcentracaoFinal(x2),'-o');
grid on;

disp(Taxa_IntervaloMeiavida(x2));
disp(Taxa_DoseConcentracaoFinal(x2));
