clc;
clear all;
close all;

## --- PAR�METROS ---
TempoDeMonitoramento_h = (90)*24;
TempoDeAdm_h = (3)*24;

Dose = 100;	## Unidade arbitr�ria
TaxaDeAbs_porhora = (1/24);
Intervalo_Adm_h = 4*24;
Meia_Vida_h  = 7*24;

## --- INICIALIZA��O DAS VARI�VEIS DE CONTROLE ---
x = linspace(1 , TempoDeMonitoramento_h , TempoDeMonitoramento_h); ## Eixo X com 1 de passo
Concentracao = zeros(1,TempoDeMonitoramento_h);	## Concentra��o plasm�tica inicia-se em zero, pois n�o houve qualquer administra��o
DoseNA = Dose;	## primeira administra��o em t = 0
cont = 0;	## Contador para intervalo entre doses

## --- PROCESSAMENTO DA CONCENTRA��O PLASM�TICA A CADA PASSO DE 1 HORA ---
for Hora = 1:(TempoDeMonitoramento_h-1)
	
    ## Administra��o
    cont++;
    if cont == Intervalo_Adm_h
		DoseNA += Dose;
        cont = 0;
    endif
	
	Concentracao(Hora+1) += Concentracao(Hora);
	
	Concentracao(Hora+1) -= (Concentracao(Hora)/2)/(Meia_Vida_h);	## Metabolismo
	Concentracao(Hora+1) += DoseNA*TaxaDeAbs_porhora;	## Absorcao da droga para o organismo
	DoseNA -= DoseNA*TaxaDeAbs_porhora;
endfor

## --- M�DIA M�VEL DA CONCENTRA��O PLASM�TICA ---

AmostragemMediaMovel_h = 7*24;
MediaMovel = zeros(1,TempoDeMonitoramento_h);
Metade = AmostragemMediaMovel_h/2;

for j = 1:(TempoDeMonitoramento_h-AmostragemMediaMovel_h)

	if j <= AmostragemMediaMovel_h
		MediaMovel(j) = sum(Concentracao(1:j))/j;
	else
		MediaMovel(j) = sum(Concentracao(j-(Metade):j+(Metade)))/AmostragemMediaMovel_h;
	endif
endfor


figure(1);
plot(x-1,Concentracao(x),MediaMovel(x));
grid on;
xlabel('x');
ylabel('F(x)');

Taxa_IntervaloMeiavida = Intervalo_Adm_h/Meia_Vida_h;
Taxa_DoseConcentracaoFinal = MediaMovel(length(Concentracao)-horasmedia)/Dose;

disp(Taxa_IntervaloMeiavida);
disp(Taxa_DoseConcentracaoFinal);



