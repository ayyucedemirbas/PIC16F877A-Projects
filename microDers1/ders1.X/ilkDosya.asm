	;KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'larin tanimlandigi kutuphane
	
	__CONFIG H'3F31'    ; WDT, ossilator gibi register ayarlar?

	
;KULLANILACAK DEGISKENLER

DEGISKEN_1	EQU	0x20    ;Degisken kullanmak icin GPR alaninda istediginiz adresi yazabilirsiniz
DEGISKEN_2	EQU	0x21


;***** Kesme durumunda kaydedilmesi gereken SFR ler icin kullanilacak yardimci degiskenler
w_temp		EQU	0x7D		
status_temp	EQU	0x7E		
pclath_temp	EQU	0x7F					


;********************************************************************************************
	ORG     0x000             	; Baslama vektoru

	nop			  			  	; ICD ozelliginin aktif edilmesi icin gereken bekleme 
  	goto    BASLA              	; Asil kodlarin yazili oldugu baslama etiketine git

	
;**********************************************************************************************
	ORG     0x004             	; kesme vektoru

;***********************************************************************************************

GECIKME
	MOVLW H'FE'
	MOVWF DEGISKEN_1
L1
	MOVLW H'FF'
	MOVWF DEGISKEN_2
L2
	DECFSZ DEGISKEN_2,F
	GOTO L2
	DECFSZ DEGISKEN_1,F
	GOTO L1
	RETURN
	
BASLA
	CLRF PORTB
	BANKSEL TRISB
	BCF TRISB,0
	BANKSEL PORTB
	
KILIT
	BSF PORTB,0
	CALL GECIKME
	BCF PORTB,0
	CALL GECIKME
	GOTO KILIT



	END                       ; Tum program kodlarin bittigini gosterir










