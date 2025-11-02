; M0 ? Sanity check: texto -> 13h -> desenha 1 pixel -> volta pro texto
.model small
.stack

.data
    seed dw 0
    menu db 0
    btn_iniciar db  14 dup(" "),218,196,196,196,196,196,196,196,196,196,191,13,10
                 db 14 dup(" "),179,"  JOGAR  ",179,10,13
                 db 14 dup(" "),192,196,196,196,196,196,196,196,196,196,217,13,10

    btn_iniciar_length equ $-btn_iniciar

    btn_sair db  14 dup(" "),218,196,196,196,196,196,196,196,196,196,191,13,10
              db 14 dup(" "),179,"  SAIR   ",179,10,13
              db 14 dup(" "),192,196,196,196,196,196,196,196,196,196,217,13,10

    btn_sair_length equ $-btn_sair
    CR EQU 13
    LF EQU 10
    SPR_W  EQU 13
    SPR_H  EQU 29
    string  db 7 dup(" ")," ___                    ",13,10
            db 7 dup(" "),"/ __| __ _ _ __ _ _ __  ",13,10
            db 7 dup(" "),"\__ \/ _| '_/ _` | '  \ ",13,10
            db 7 dup(" "),"|___/\__|_|_\__,_|_|_|_|",13,10
            db 7 dup(" "),"     | |__| |___        ",13,10
            db 7 dup(" "),"     | '_ \ / -_)       ",13,10
            db 7 dup(" "),"     |_.__/_\___|       ",13,10

            
            
    string_length equ $-string
    meteor_sprite   db 0,0,0,0,0,0,0,1,1,0,0,0,0,0
                    db 0,0,0,0,1,1,4,4,4,1,0,0,0,0
                    db 0,0,0,1,4,4,4,4,4,4,1,0,1,1
                    db 0,0,1,4,4,4,5,5,4,4,4,1,0,0
                    db 0,1,4,4,5,5,5,5,5,4,4,1,0,0
                    db 0,1,4,4,5,5,5,5,5,5,4,1,5,5
                    db 0,1,4,4,4,5,5,5,5,4,4,1,4,5
                    db 0,0,1,4,4,4,4,5,4,4,1,0,0,0
                    db 0,0,1,4,4,4,4,4,4,4,1,0,1,5
                    db 0,0,0,1,4,4,4,4,4,1,0,0,0,0
                    db 0,0,0,0,1,4,4,4,1,0,4,4,0,0
                    db 0,0,0,0,0,1,1,1,0,0,1,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
    meteor_pos dw 100*320 + 300 ; posi??o inicial (linha 100, x = 300)

    
.code
MAIN:
    mov AX, @data
    mov DS, AX
    mov AX, 0A000H
    mov ES, AX
    xor DI, DI

    ; call SYSTIME_SEED

    ; Define o modo de video
    xor ah, ah
    xor bh, bh
    mov al, 13h
    int 10h

    ; Exibe titulo e botoes do menu
    call PRINT_TITLE_MENU
    call PRINT_BUTTONS
    
LOOP_MENU:
    call MOVE_METEOR
    jmp LOOP_MENU

; Procedimento para exibir os botoes INICIAR e SAIR
; se menu == 0 o bot?o jogar fica vermelho
; se menu == 1 o botao sair fica vermelho
PRINT_BUTTONS proc
    push ax
    mov bl, 0FH
    mov ah, menu
    cmp ah, 0
    jne START_BTN
    mov bl, 0CH

START_BTN:
    ; Exibe o bot??o INICIAR
    mov bp, offset btn_iniciar
    mov cx, btn_iniciar_length ; tamanho
    xor dl, dl ; coluna = 0
    mov dh, 18 ; linha = 18
    call PRINT_STRING

    mov bl, 0FH
    mov ah, menu
    cmp ah, 1
    jne EXIT_BTN
    mov bl, 0CH

EXIT_BTN:
    mov bp, offset btn_sair
    mov cx, btn_sair_length ; tamanho
    xor dl, dl ; coluna = 0
    mov dh, 21 ; linha = 21
    call PRINT_STRING

    pop ax
    ret
PRINT_BUTTONS endp


SYSTIME_SEED proc
    push ax
    push cx
    push dx

    xor ax, ax
    int 1AH
    mov seed, dx

    pop dx
    pop cx
    pop ax
    ret
SYSTIME_SEED endp

;  Desenha CX caracteres a partir de ES:BP na posi??o (linha DH, coluna DL).
;  Usa a cor/atributo em BL (p.ex.: 0Fh = branco, 0Ch = vermelho-claro).
;  Atualiza o cursor ap?s imprimir (modo AL=1).
;  ES deve apontar para o segmento onde est? a string (comumente ES=DS).
;  BP deve conter o offset da string dentro de ES.
PRINT_STRING PROC
    push AX
    push BX
    push DS
    push ES
    push SI
    push BP

    mov ah, 13h         
    mov al, 1          
                        
    xor bh, bh           
    int 10h  ; escreve string          

    pop BP
    pop SI
    pop ES
    pop DS
    pop BX
    pop AX
    ret
PRINT_STRING ENDP

PRINT_TITLE_MENU proc
    mov ax, ds 
    mov es, ax
    
    ; ajusta resgitradores pro PRINT_STRING
    mov bp, offset string
    mov cx, string_length ; tamanho
    mov bl, 02H ; Cor verde (se bit 1 de AL estiver limpo, usamos BL)
    xor dx, dx ; linha / coluna
    call PRINT_STRING

    ret
PRINT_TITLE_MENU endp

RENDER_SPRITE proc
    ; joga pra pilha valres dos registradores pra n?o perder
    push bx
    push cx
    push dx
    push di
    push es
    push ds
    push ax

    ; ds apotando pros dados onde a sprite t?
    mov ax, @data
    mov ds, ax

    ; garante que continua no modo 13h
    mov ax, 0A000h
    mov es, ax

    ; pega da pilha o ax (posi??o da tela)
    ; joga pra di do movsb
    pop ax
    mov di, ax
    mov dx, 14 ; 14 linhas pro loop
    push ax

DRAW_LINE:
    mov cx, 14 ; 14 colunas
    rep movsb
    add di, 320 - 14 ; avan?a pro come?o da prox linha
    dec dx
    jnz DRAW_LINE

    ; devolve os valores empilhados no comeco
    pop ax
    pop ds  
    pop es
    pop di
    pop dx
    pop cx
    pop bx
ret
RENDER_SPRITE endp


MOVE_METEOR proc
    ; joga pra pilha valres dos registradores pra n?o perder
    push ax
    push di
    push si
    push cx
    push dx

    ; Apaga sprite atual
    ; joga em ax a posi??o do meteoro
    ; copia pra di isso pra ser usado na proc
    mov ax, meteor_pos
    mov di, ax
    call CLEAR_SPRITE

    ; Verifica se chegou no limite esquerdo (coluna 0)
    ; joga de novo a posi??o do meteoro pra ax
    ; verifica se ax ja chegou no limite esquerdo da tela
    mov ax, meteor_pos
    cmp ax, 100*320
    ja CONTINUE_MOVE

    ; Se passou do limite, reinicia no lado direito
    ; coloca a posi??o do meteoro no canto direito
    mov ax, 100*320 + 306
    mov meteor_pos, ax
    jmp DRAW_METEOR

CONTINUE_MOVE:
    ; Move o meteoro pra esquerda
    ; o movimento ? feito diminindo um pixel da posi??o
    dec meteor_pos
    dec ax

DRAW_METEOR:
    ; coloca o sprint em si
    mov si, offset meteor_sprite
    call RENDER_SPRITE

    ; Delay
    ; usa interrup??o 15h que faz o delay
    ; dx fica com o valor do deplay, quanto maior mais delay tera
    xor cx, cx
    mov dx, 4000h
    mov ah, 86h
    int 15h

    ; devolve os valores empilhados no comeco
    pop dx
    pop cx
    pop si
    pop di
    pop ax
    ret
MOVE_METEOR endp

CLEAR_SPRITE proc
    ; joga pra pilha valres dos registradores pra n?o perder
    push ax
    push cx
    push di
    push es
    
    ; aponta pra 0A000H no es pra fazer os desenhos na tela
    ; define cx = 14 pra informar o numero de linha
    mov ax, 0A000H
    mov es, ax
    mov cx, 14

CLEAR_LINE:
    ; define cx = 14 pra informar o numero de colunas
    ; usa xor pra zerar ax (0 = preto)
    ; usa stobs pra colocar preto em todos os cx pixeis 
    push cx
    mov cx, 14
    xor ax, ax
    rep stosb
    add di, 306
    pop cx
    loop CLEAR_LINE

    ; devolve os valores empilhados no come?o
    pop es
    pop di
    pop cx
    pop ax
    ret
CLEAR_SPRITE endp

end MAIN
