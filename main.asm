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

    alien_sprite    db 0,0,0,0AH,0AH,0AH,2,0EH,0EH,0EH,0EH,0,0,0
                    db 0,0,0,2,2,2,2,2,2,2,2,0EH,0EH,0
                    db 0,0,2,2,2,2,2,2,2,2,2,2,0EH,0
                    db 0,0,2,2,2,2,2,2,2,2,2,2,2,0EH
                    db 0AH,0AH,0AH,5,5,0AH,2,0EH,0EH,5,5,0EH,0EH,0EH
                    db 0AH,0AH,0AH,5,5,0AH,2,0EH,0EH,5,5,0EH,0EH,0EH
                    db 0AH,0AH,0AH,0AH,0AH,0AH,2,0EH,0EH,0EH,0EH,0EH,0EH,0EH
                    db 0,0AH,0AH,0AH,2,5,5,2,0EH,0EH,0EH,0,0,0
                    db 0,0AH,0AH,0AH,2,5,5,2,0EH,0EH,0EH,0,0,0
                    db 0,0,5,0AH,0AH,5,5,2,0EH,0EH,0EH,0,0,0
                    db 0,0,5,0AH,0AH,5,5,2,0EH,0EH,0EH,0,0,0
                    db 0,0,5,0,2,5,5,2,0EH,0EH,0EH,0,0,0
                    db 0,0,5,0,2,5,5,2,0EH,0EH,0EH,0,0,0
                    db 0,0,0,0,0AH,0AH,2,0EH,0EH,0,0,0,0,0

    alien_pos dw 125*320 + 300 ; posi??o inicial (linha 100, x = 300)
    alien_r db 0
    
    ship_sprite db 0,0,0,0,0,1,1,1,1,0,0,0,0,0
                db 0,0,0,0,1,4,4,4,4,1,0,0,0,0
                db 0,0,0,1,4,4,4,4,4,4,1,0,0,0
                db 0,0,1,4,4,4,4,4,4,4,4,1,0,0
                db 0,1,4,4,1,4,4,4,4,1,4,4,1,0
                db 1,4,4,1,1,4,4,4,4,1,1,4,4,1
                db 1,4,4,4,4,4,4,4,4,4,4,4,4,1
                db 1,4,4,4,4,4,4,4,4,4,4,4,4,1
                db 0,1,4,4,4,4,4,4,4,4,4,4,1,0
                db 0,0,1,4,4,4,4,4,4,4,4,1,0,0
                db 0,0,0,1,4,4,4,4,4,4,1,0,0,0
                db 0,0,0,0,1,4,4,4,4,1,0,0,0,0
                db 0,0,0,0,0,1,5,5,1,0,0,0,0,0
                db 0,0,0,0,0,1,1,1,1,0,0,0,0,0
    ship_pos dw 75*320 + 0 ; posi??o inicial (linha 100, x = 300)
    SCREEN_W    EQU 320
    SCREEN_H    EQU 200

    SPR_W       EQU 14
    SPR_H       EQU 14
    RIGHT_X     EQU (SCREEN_W - SPR_W)   ; ?ltimo X v?lido p/ canto esquerdo do sprite

    ROW_METEOR  EQU 100
    ROW_ALIEN   EQU 125
    ROW_SHIP    EQU 75

    ; Limites horizontais por objeto (linha fixa)
    METEOR_L    EQU (ROW_METEOR*SCREEN_W)
    METEOR_R    EQU (ROW_METEOR*SCREEN_W + RIGHT_X)

    ALIEN_L     EQU (ROW_ALIEN*SCREEN_W)
    ALIEN_R     EQU (ROW_ALIEN*SCREEN_W + RIGHT_X)

    SHIP_L      EQU (ROW_SHIP*SCREEN_W)
    SHIP_R      EQU (ROW_SHIP*SCREEN_W + RIGHT_X)

    fase1   db 7 dup(" "),"                  ",13,10
            db 7 dup(" "),"  ___             ",13,10
            db 7 dup(" ")," | __|_ _ ___ ___ ",13,10
            db 7 dup(" ")," | _/ _` (_-</ -_)",13,10
            db 7 dup(" ")," |_|\__,_/__/\___|",13,10
            db 7 dup(" "),"        / |       ",13,10
            db 7 dup(" "),"        | |       ",13,10
            db 7 dup(" "),"        |_|       ",13,10
    fase1_length equ $-fase1

    
.code
MAIN:
    mov AX, @data
    mov DS, AX
    mov AX, 0A000H
    mov ES, AX
    xor DI, DI

    call SYSTIME_SEED
    call INIT_ALIEN_RANDOM

    ; Define o modo de video
    xor ah, ah
    xor bh, bh
    mov al, 13h
    int 10h

    ; Exibe titulo e botoes do menu
    call PRINT_TITLE_MENU
    call PRINT_BUTTONS
    
LOOP_MENU:
    call MOVE_MENU
    ; Recebe entrada do usu??rio
    mov ah, 1H
    int 16H
    jz LOOP_MENU

    ; Chama a fun????o de navega????o
    call HANDLE_INPUT

    ; Condi????o para iniciar o jogo
    cmp ah, 1CH
    je SELECT_OPTION

    ; Retorno ao loop do menu
    xor ah, ah
    int 16H
    jmp LOOP_MENU
SELECT_OPTION:
    xor ah, ah
    int 16H
    
    mov ah, menu
    cmp ah, 1
    je FINISH

    call CLEAR_SCREEN
    call PRINT_FASE_1
    
    ; Wait 4s
    mov cx, 3DH
    mov dx, 900H
    mov ah, 86H
    int 15h

    ;call RESET
FINISH:
    CALL END_GAME
    
    ret
    
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


PRINT_FASE_1 proc
    mov ax, ds 
    mov es, ax
    
    ; ajusta resgitradores pro PRINT_STRING
    mov bp, offset fase1
    mov cx, fase1_length ; tamanho
    mov bl, 0BH ; Cor verde (se bit 1 de AL estiver limpo, usamos BL)
    mov dl, 7           ; coluna inicial = 7
    mov dh, 9           ; linha inicial  = 9
    call PRINT_STRING

    ret
PRINT_FASE_1 endp

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

RANDOM_UINT16 proc
    push dx

    mov ax, 39541
    mul seed
    add ax, 16259
    mov seed, ax

    pop dx
    ret
endp

; Inicializa posi??o e dire??o aleat?rias do alien
; Requer: RANDOM_UINT16 (retorna AX pseudo-aleat?rio)
; Usa: y fixo = 100 (troque se quiser), largura sprite = 14 (logo x<=306)

INIT_ALIEN_RANDOM proc
    push ax
    push bx
    push cx
    push dx

    ; x aleat?rio em [0..306]
    call RANDOM_UINT16         ; AX = rand
    xor dx, dx
    mov bx, 307                ; divisor
    div bx                     ; AX/307
    mov cx, dx                 ; CX = x (0..306)

    ; y*320 (y = 125)
    mov bx, 125
    mov ax, bx
    shl bx, 6                  ; y<<6
    shl ax, 8                  ; y<<8
    add bx, ax                 ; bx = y*320

    ; alien_pos = y*320 + x
    add bx, cx
    mov alien_pos, bx

    pop dx
    pop cx
    pop bx
    pop ax
    ret
INIT_ALIEN_RANDOM endp

; DI = posi??o linear do canto esquerdo do sprite
CLEAR_SPRITE proc
    push ax
    push cx
    push di
    push es
    
    mov ax, 0A000h
    mov es, ax
    mov cx, SPR_H

CLEAR_LINE:
    push cx
    mov cx, SPR_W
    xor al, al          ; cor 0 (preto)
    rep stosb
    add di, SCREEN_W - SPR_W
    pop cx
    loop CLEAR_LINE

    pop es
    pop di
    pop cx
    pop ax
    ret
CLEAR_SPRITE endp

; MOVE_WRAP_LEFT_AND_DRAW
; Entradas:
;   BX = &pos_var           (ex.: OFFSET meteor_pos)
;   SI = offset sprite      (ex.: OFFSET meteor_sprite)
;   AX = L (left bound)     (ex.: METEOR_L)
;   DX = R (right bound)    (ex.: METEOR_R)
; Efeito:
;   - limpa, move 1 px p/ esquerda (wrap p/ direita se necess?rio), redesenha
MOVE_WRAP_LEFT_AND_DRAW proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp

    mov bp, ax              ; BP = L
    mov di, [bx]            ; DI = pos atual
    mov ax, di
    call CLEAR_SPRITE

    mov ax, [bx]            ; AX = pos
    cmp ax, bp              ; pos <= L ?
    ja  MOVE_LEFT
    ; wrap p/ direita
    mov ax, dx              ; AX = R
    mov [bx], ax
    jmp DRAW

MOVE_LEFT:
    dec ax
    mov [bx], ax

DRAW:
    mov si, si              ; (SI j? ? o sprite)
    ; AX j? tem pos atualizada
    call RENDER_SPRITE

    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
MOVE_WRAP_LEFT_AND_DRAW endp

; MOVE_BOUNCE_X_AND_DRAW
; Entradas:
;   BX = &pos_var           (ex.: OFFSET alien_pos)
;   BP = &dir_flag          (ex.: OFFSET alien_r)  ; byte: 0=esq, 1=dir
;   SI = offset sprite      (ex.: OFFSET alien_sprite)
;   AX = L (left bound)     (ex.: ALIEN_L)
;   DX = R (right bound)    (ex.: ALIEN_R)
; Efeito:
;   - limpa, quica nas bordas, move 1 px na dire??o, redesenha
MOVE_BOUNCE_X_AND_DRAW proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov cx, ax              ; CX = L (guarda L)
    mov di, [bx]            ; DI = pos atual
    mov ax, di
    call CLEAR_SPRITE

    mov ax, [bx]            ; AX = pos

    ; borda esquerda
    cmp ax, cx
    ja  CHECK_RIGHT
    mov ax, cx              ; clamp = L
    mov [bx], ax
    mov byte ptr [bp], 1    ; ir para direita
    jmp DECIDE

CHECK_RIGHT:
    ; borda direita
    cmp ax, dx
    jb  DECIDE
    mov ax, dx              ; clamp = R
    mov [bx], ax
    mov byte ptr [bp], 0    ; ir para esquerda

DECIDE:
    mov dl, byte ptr [bp]   ; DL = dir (0 / 1)
    cmp dl, 1
    jz  RIGHT
    ; esquerda
    dec ax
    mov [bx], ax
    jmp DRAW_BOUNCE

RIGHT:
    inc ax
    mov [bx], ax

DRAW_BOUNCE:
    ; AX j? tem pos atualizada
    call RENDER_SPRITE

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
MOVE_BOUNCE_X_AND_DRAW endp

MOVE_WRAP_RIGHT_AND_DRAW proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    mov cx, ax              ; CX = L (guarda limite esquerdo)
    mov di, [bx]            ; DI = posi??o atual
    mov ax, di
    call CLEAR_SPRITE       ; apaga sprite antigo

    mov ax, [bx]            ; AX = posi??o atual
    cmp ax, dx              ; pos >= R ?
    jb  MOVE_RIGHT        ; se pos < R, ainda pode andar p/ direita
    ; wrap para a esquerda
    mov ax, cx              ; AX = L
    mov [bx], ax
    jmp DRAW_RIGHT

MOVE_RIGHT:
    inc ax
    mov [bx], ax

DRAW_RIGHT:
    ; AX j? tem a posi??o atualizada; SI j? tem o sprite
    call RENDER_SPRITE

    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
MOVE_WRAP_RIGHT_AND_DRAW endp

MOVE_MENU PROC
    mov bx, OFFSET meteor_pos
    mov si, OFFSET meteor_sprite
    mov ax, METEOR_L
    mov dx, METEOR_R
    call MOVE_WRAP_LEFT_AND_DRAW
    mov bx, OFFSET alien_pos
    mov bp, OFFSET alien_r
    mov si, OFFSET alien_sprite
    mov ax, ALIEN_L
    mov dx, ALIEN_R
    call MOVE_BOUNCE_X_AND_DRAW

    mov bx, OFFSET ship_pos
    mov si, OFFSET ship_sprite
    mov ax, SHIP_L
    mov dx, SHIP_R
    call MOVE_WRAP_RIGHT_AND_DRAW
    ; Delay
    ; usa interrup??o 15h que faz o delay
    ; dx fica com o valor do deplay, quanto maior mais delay tera
    xor cx, cx
    mov dx, 2710H
    mov ah, 86H
    int 15h
MOVE_MENU ENDP


HANDLE_INPUT PROC
    cmp ah, 48H
    je ARROW_UP

    cmp ah, 50H
    je ARROW_DOWN

    jmp END_HANDLE

ARROW_UP:
    xor ah, ah
    mov menu, ah

    jmp RENDER_BUTTONS

ARROW_DOWN:
    mov ah, 1
    mov menu, ah

RENDER_BUTTONS:
    call PRINT_BUTTONS

END_HANDLE:
    ret
ENDP

END_GAME proc
    ; Back to text mode
    xor ah, ah
    mov al, 3h
    int 10h

    ; Ends program
    mov ah, 4ch
    xor al, al
    int 21h
    ret
endp

CLEAR_SCREEN proc
    push ax
    push cx
    push es
    push di

    mov ax,0A000h
    mov es,ax
    xor di, di
    mov cx, 32000d
    cld
    xor ax, ax
    rep stosw
    
    pop di
    pop es
    pop cx
    pop ax
    ret
endp

end MAIN
