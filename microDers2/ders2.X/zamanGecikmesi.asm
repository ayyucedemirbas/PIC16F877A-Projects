	;KODLAMA SABLONU

	list		p=16f877A	; hangi pic
	#include	<p16f877A.inc>	; SFR register 'larin tanimlandigi kutuphane
	
	__CONFIG H'3F31'    ; WDT, ossilator gibi register ayarlar?

	
;KULLANILACAK DEGISKENLER

D1	EQU	0x20    ;Degisken kullanmak icin GPR alaninda istediginiz adresi yazabilirsiniz
D2	EQU	0x21

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
	
	MOVLW	0xFF
	MOVWF	D2
	
LOOP2	MOVLW	0xFF
	MOVWF	D1
	
LOOP	DECFSZ	D1,F
	GOTO LOOP
	
	DECFSZ	D2,F
	GOTO	LOOP2
	
	RETURN
	
BASLA
	CLRF	PORTB
	BANKSEL	TRISB
	CLRF	TRISB
	BCF STATUS,5
	
DONGU
	MOVLW	0x01
	BTFSC	PORTB,0
	MOVLW	0x00
	MOVWF	PORTB
	CALL GECIKME
	GOTO DONGU
	


	END                       ; Tum program kodlarin bittigini gosterir



