; RisitOS - L'OS des Kheys ! Licence BSD 2.0 "Revised BSD Licence"
; Assembleur x86, syntaxe Intel

; Bootloader sans routine qui lance le kernel pour les kheys qui veulent test

BITS 16 ; Dire a NASM qu'on travaille en 16 bits pour la phase de boot

boot:
	mov ax, 07C0h		; 4Ko de Stack 
	add ax, 288		; (4096 + 512) / 16 octets
	mov ss, ax
	mov sp, 4096

	mov ax, 07C0h		
	mov ds, ax

	mov ah, 06h    ; Fonction de defilement
	xor al, al     ; Un "Clear Screen"
	xor cx, cx     ; Coté haut gauche CH=ligne, CL=colonne
	mov dx, 184Fh  ; Coté droit bas DH=ligne, DL=colonne 
	mov bh, 1Eh    ; Interface jaune sur bleue
	int 10h		   ; El famosos bios
	
	mov si, title_string	
	call hello_screen	
	

	jmp $			


	title_string db 'El famosos bootloader sans kernel', 0 


hello_screen:			
	
	mov ah, 0Eh		; fonction ecriture de character
	
; sous routine spécifique a NASM	

.laboucle:
	lodsb			
	cmp al, 0
	je .finiteincanttatem		
	int 10h			
	jmp .laboucle

.finiteincanttatem:
	ret


	times 510-($-$$) db 0 
	dw 0xAA55		; Boot Signature
