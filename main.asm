
; M0 ? Sanity check: texto -> 13h -> desenha 1 pixel -> volta pro texto
.model small
.stack

.data
    ale dw 0
    menu db 0
    fase db 1
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
    string  db 2 dup(" "),"                                    ",13,10
            db 2 dup(" "),"  ___                    _    _     ",13,10
            db 2 dup(" ")," / __| __ _ _ __ _ _ __ | |__| |___ ",13,10
            db 2 dup(" ")," \__ \/ _| '_/ _` | '  \| '_ \ / -_)",13,10
            db 2 dup(" ")," |___/\__|_| \__,_|_|_|_|_.__/_\___|",13,10


    string_length equ $-string
    meteor_sprite   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,1,1,4,4,4,1,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,1,4,4,4,4,4,4,1,0,1,1,0,0,0,0,0
                    db 0,0,0,0,0,1,4,4,4,5,5,4,4,4,1,0,0,0,0,0,0,0
                    db 0,0,0,0,1,4,4,5,5,5,5,5,4,4,1,0,0,0,0,0,0,0
                    db 0,0,0,0,1,4,4,5,5,5,5,5,5,4,1,5,5,0,0,0,0,0
                    db 0,0,0,0,1,4,4,4,5,5,5,5,4,4,1,4,5,0,0,0,0,0
                    db 0,0,0,0,0,1,4,4,4,4,5,4,4,1,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,1,4,4,4,4,4,4,4,1,0,1,5,0,0,0,0,0
                    db 0,0,0,0,0,0,1,4,4,4,4,4,1,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,1,4,4,4,1,0,4,4,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,1,1,1,0,0,1,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


    alien_sprite    db 0,0,0,0,0,0,0,0AH,0AH,0AH,2,0EH,0AH,0AH,0AH,0,0,0,0,0,0,0
                    db 0,0,0,0,0EH,2,2,2,2,2,2,2,2,2,2,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0EH,2,2,2,2,2,2,2,2,2,2,0EH,0,0,0,0,0,0
                    db 0,0,0,0EH,2,2,2,2,2,2,2,2,2,2,2,2,0EH,0,0,0,0,0
                    db 0,0,0,0EH,0EH,0AH,5,5,0AH,2,0EH,0AH,5,5,0AH,0EH,0EH,0,0,0,0,0
                    db 0,0,0,0EH,0EH,0AH,5,5,0AH,2,0EH,0AH,5,5,0AH,0EH,0EH,0,0,0,0,0
                    db 0,0,0,0EH,0EH,0EH,0AH,0AH,0AH,2,0EH,0AH,0AH,0AH,0EH,0EH,0EH,0,0,0,0,0
                    db 0,0,0,0,0,0EH,0AH,2,5,5,2,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0EH,0AH,2,5,5,2,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0EH,0AH,2,5,5,0AH,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0EH,0AH,2,5,5,0AH,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0EH,0AH,2,5,5,2,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0EH,0AH,2,5,5,2,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0AH,0AH,0AH,2,0EH,0AH,0AH,0AH,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    alien_pos dw 125*320 + 300 ; posição inicial (linha 125, x = 300)
    alien_dir db 0  ; direção do alien (0=esquerda, 1=direita)
    
    ; Sprite da nave principal (29x13 pixels) - baseado no exemplo
    ship_sprite db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,15,15,15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,1,15,15,0AH,0AH,0AH,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,1,15,15,15,0AH,0AH,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,1,15,15,15,15,15,15,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,1,09H,09H,09H,09H,09H,09H,15,15,15,15,15,15,0,0,0,0
                db 0,0,0,0,0,1,09H,09H,09H,09H,09H,09H,15,15,15,15,15,15,0,0,0,0
                db 0,0,0,0,0,1,15,15,15,15,15,15,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,1,15,15,15,0AH,0AH,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,1,15,15,0AH,0AH,0AH,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,15,15,15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    ROW_METEOR  EQU 100
    ROW_ALIEN   EQU 125
    ROW_SHIP    EQU 75

    meteor_pos_ini EQU ROW_METEOR*320 + 300  ; posição inicial do meteoro (linha 100, x = 300)
    meteor_pos dw meteor_pos_ini ; posi??o inicial (linha 100, x = 300)

    ship_pos_ini EQU ROW_SHIP*320 
    ship_pos dw ship_pos_ini ; posição inicial (linha 95, coluna 41)
    ship_speed EQU 4

    LIFES_START EQU 3
    lives db LIFES_START  ; número de vidas

    SCREEN_W    EQU 320
    SCREEN_H    EQU 200

    SPR_W       EQU 22  ; para meteoro e alien
    SPR_H       EQU 18
    RIGHT_X     EQU (SCREEN_W - SPR_W)   ; ?ltimo X v?lido p/ canto esquerdo do sprite


    ; Limites horizontais por objeto (linha fixa)
    METEOR_L    EQU (ROW_METEOR*SCREEN_W)
    METEOR_R    EQU (ROW_METEOR*SCREEN_W + RIGHT_X)

    ALIEN_L     EQU (ROW_ALIEN*SCREEN_W)
    ALIEN_R     EQU (ROW_ALIEN*SCREEN_W + RIGHT_X)

    fase1   db 7 dup(" ")," ___                  _ ",13,10
            db 7 dup(" "),"| __|_ _ ___ ___     / |",13,10
            db 7 dup(" "),"| _/ _` (_-</ -_)    | |",13,10
            db 7 dup(" "),"|_|\__,_/__/\___|    |_|",13,10
            db 7 dup(" "),"                        ",13,10
            db 7 dup(" "),"                        ",13,10
    
    fase2   db 7 dup(" ")," ___                ___ ",13,10
            db 7 dup(" "),"| __|_ _ ___ ___   |_  )",13,10
            db 7 dup(" "),"| _/ _` (_-</ -_)   / / ",13,10
            db 7 dup(" "),"|_|\__,_/__/\___|  /___|",13,10
            db 7 dup(" "),"                        ",13,10
            db 7 dup(" "),"                        ",13,10
            
    fase3   db 7 dup(" ")," ___                ____",13,10
            db 7 dup(" "),"| __|_ _ ___ ___   |__ /",13,10
            db 7 dup(" "),"| _/ _` (_-</ -_)   |_ \",13,10
            db 7 dup(" "),"|_|\__,_/__/\___|  |___/",13,10
            db 7 dup(" "),"                        ",13,10
            db 7 dup(" "),"                        ",13,10

    fase_string_length equ $-fase3
    
    fase_vec dw offset fase1, offset fase2, offset fase3
    
    SECONDS_START  EQU 60

    time db SECONDS_START
    timeout db 0
    time_buffer db '00'
    time_buffer_len equ $-time_buffer

    
    time_str db "TEMPO:"
    time_str_len equ $-time_str
    
    score dw 0
    score_buffer db '00000'
    score_buffer_len equ $-score_buffer
    
    score_str db "SCORE:"
    score_str_len equ $-score_str
    
    ; Terreno da fase 1
    terrain db 320 dup(0)
        db 320 dup(0)
        db 168 dup(0),3 dup (6),149 dup(0)
        db 166 dup(0),6 dup (6),148 dup(0)
        db 34 dup(0),4 dup (6),7 dup(0),6 dup (6),63 dup(0),2 dup (6),25 dup(0),6 dup (6),18 dup(0),8 dup (6),87 dup(0),9 dup (6),51 dup(0)
        db 33 dup(0),6 dup (6),5 dup(0),9 dup (6),37 dup(0),9 dup (6),12 dup(0),7 dup (6),20 dup(0),10 dup (6),17 dup(0),9 dup (6),15 dup(0),5 dup (6),40 dup(0),5 dup (6),19 dup(0),11 dup (6),15 dup(0),4 dup (6),32 dup(0)
        db 12 dup(0),4 dup (6),16 dup(0),7 dup (6),4 dup(0),11 dup (6),17 dup(0),3 dup (6),15 dup(0),11 dup (6),10 dup(0),10 dup (6),15 dup(0),14 dup (6),15 dup(0),11 dup (6),13 dup(0),7 dup (6),8 dup(0),6 dup (6),23 dup(0),9 dup (6),15 dup(0),15 dup (6),12 dup(0),7 dup (6),30 dup(0)
        db 11 dup(0),7 dup (6),14 dup(0),23 dup (6),16 dup(0),3 dup (6),15 dup(0),11 dup (6),9 dup(0),11 dup (6),13 dup(0),17 dup (6),14 dup(0),12 dup (6),11 dup(0),9 dup (6),5 dup(0),9 dup (6),20 dup(0),12 dup (6),13 dup(0),17 dup (6),10 dup(0),9 dup (6),29 dup(0)
        db 1 dup (6),9 dup(0),10 dup (6),10 dup(0),26 dup (6),15 dup(0),5 dup (6),12 dup(0),34 dup (6),8 dup(0),21 dup (6),12 dup(0),14 dup (6),9 dup(0),11 dup (6),2 dup(0),13 dup (6),16 dup(0),17 dup (6),8 dup(0),20 dup (6),8 dup(0),11 dup (6),8 dup(0),3 dup (6),8 dup(0),6 dup (6),2 dup(0),1 dup (6)
        db 2 dup (6),7 dup(0),12 dup (6),8 dup(0),31 dup (6),10 dup(0),6 dup (6),10 dup(0),65 dup (6),11 dup(0),17 dup (6),7 dup(0),28 dup (6),12 dup(0),49 dup (6),5 dup(0),13 dup (6),5 dup(0),7 dup (6),4 dup(0),11 dup (6)
        db 3 dup (6),5 dup(0),14 dup (6),4 dup(0),36 dup (6),6 dup(0),10 dup (6),6 dup(0),68 dup (6),9 dup(0),19 dup (6),5 dup(0),109 dup (6),3 dup(0),8 dup (6),3 dup(0),12 dup (6)
        db 63 dup (6),4 dup(0),11 dup (6),4 dup(0),71 dup (6),7 dup(0),23 dup (6),1 dup(0),122 dup (6),1 dup(0),13 dup (6)
        db 320 dup (6)
        db 320 dup (6)
        db 320 dup (6)
        db 25 dup(6),3 dup(05H),22 dup(6),2 dup(0DH),28 dup(6),4 dup(05H),24 dup(6),3 dup(0DH),26 dup(6),2 dup(05H),30 dup(6),4 dup(0DH),23 dup(6),3 dup(05H),27 dup(6),2 dup(0DH),25 dup(6),4 dup(05H),20 dup(6)
        db 18 dup(6),6 dup(0DH),16 dup(6),8 dup(05H),20 dup(6),7 dup(0DH),18 dup(6),9 dup(05H),22 dup(6),8 dup(0DH),19 dup(6),7 dup(05H),21 dup(6),10 dup(0DH),17 dup(6),9 dup(05H),20 dup(6),8 dup(0DH),18 dup(6)
        db 12 dup(6),12 dup(05H),14 dup(6),14 dup(0DH),16 dup(6),11 dup(05H),15 dup(6),13 dup(0DH),18 dup(6),12 dup(05H),16 dup(6),14 dup(0DH),17 dup(6),15 dup(05H),14 dup(6),13 dup(0DH),15 dup(6),12 dup(05H),13 dup(6)
        db 8 dup(6),18 dup(0DH),10 dup(6),20 dup(05H),12 dup(6),17 dup(0DH),11 dup(6),19 dup(05H),14 dup(6),18 dup(0DH),13 dup(6),20 dup(05H),12 dup(6),19 dup(0DH),11 dup(6),18 dup(05H),10 dup(6),17 dup(0DH),9 dup(6)
        db 4 dup(6),25 dup(05H),6 dup(6),28 dup(0DH),8 dup(6),24 dup(05H),7 dup(6),26 dup(0DH),9 dup(6),25 dup(05H),8 dup(6),27 dup(0DH),7 dup(6),26 dup(05H),6 dup(6),24 dup(0DH),5 dup(6)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
        db 320 dup (0DH)
        db 320 dup (05H)
    
    terrain_pos dw 320 * 180  ; Linha 130 (1/3 superior da tela)

    
.code
MAIN:
    mov AX, @data
    mov DS, AX
    mov AX, 0A000H
    mov ES, AX
    xor DI, DI

    call N_ALE
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
    
    call RESET_GAME  ; Reseta score, vidas e fase
    
    call RENDER_FASE  ; Mostra a tela da fase
    
    ; Aguarda um pouco para ver a fase
    xor cx, cx
    mov dx, 0FFFFH
    mov ah, 86H
    int 15h
    
    ; Limpa completamente a tela antes de iniciar o jogo
    call CLEAR_SCREEN
    call CLEAR_SCREEN  ; Limpa duas vezes para garantir

    call RESET_SHIP
    
    GAME_LOOP:
    call RENDER_TERRAIN  ; Renderiza o terreno primeiro
    call RENDER_STATUS   ; Renderiza score, vidas e tempo
    call UPDATE_TIME
    call UPDATE_SHIP
    
    jmp GAME_LOOP

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

; gera um valor aleatorio do clock com 1AH
N_ALE proc
    push ax
    push cx
    push dx

    xor ax, ax
    int 1AH
    mov ale, dx

    pop dx
    pop cx
    pop ax
    ret
N_ALE endp

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
    mov dx, 320*3 ; linha / coluna
    call PRINT_STRING

    ret
PRINT_TITLE_MENU endp

; Renderiza sprite da nave
; AX = posição na tela
; SI = offset do sprite
RENDER_SPRITE proc
    push bx
    push cx
    push dx
    push di
    push es
    push ds
    push ax

    mov ax, @data
    mov ds, ax

    mov ax, 0A000h
    mov es, ax

    pop ax
    mov di, ax
    mov dx, SPR_H
    push ax

DRAW_SHIP_LINE:
    mov cx, SPR_W
    rep movsb
    add di, SCREEN_W - SPR_W
    dec dx
    jnz DRAW_SHIP_LINE

    pop ax
    pop ds  
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    ret
RENDER_SPRITE endp

; usando o valor aleatorio gerado em N_ALE
RANDOM_UINT16 proc
    push dx

    mov ax, 25173
    mul ale
    add ax, 13849
    mov ale, ax

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

; DI = posição linear do canto esquerdo da nave (29x13)
CLEAR_SHIP_SPRITE proc
    push ax
    push cx
    push di
    push es
    
    mov ax, 0A000h
    mov es, ax
    mov cx, SPR_H

CLEAR_SHIP_LINE:
    push cx
    mov cx, SPR_W
    xor al, al
    rep stosb
    add di, SCREEN_W - SPR_W
    pop cx
    loop CLEAR_SHIP_LINE

    pop es
    pop di
    pop cx
    pop ax
    ret
CLEAR_SHIP_SPRITE endp


; MOVE_WRAP_LEFT_AND_DRAW
; Entradas:
;   BX = &pos_var           (ex.: OFFSET meteor_pos)
;   SI = offset sprite      (ex.: OFFSET meteor_sprite)  
;   AX = pos_inicial        (ex.: meteor_pos_ini)
;   DX = limite_esquerdo    (ex.: 4)
; Efeito:
;   - limpa, move 1 px p/ esquerda (wrap p/ direita se necessário), redesenha
MOVE_WRAP_LEFT_AND_DRAW proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp

    mov bp, ax              ; BP = posição inicial (para wrap)
    mov di, dx              ; DI = limite esquerdo
    


    ; Verifica limites: x = pos % 320
    mov ax, [bx]
    xor dx, dx
    mov cx, 320
    div cx                  ; DX = x (coordenada X)
    
    cmp dx, di              ; compara com limite esquerdo
    ja  MOVE_LEFT_MENU
    
    ; wrap para a direita
    mov di, [bx]
    call CLEAR_SPRITE

    mov ax, bp              ; AX = posição inicial
    mov [bx], ax

    ; jmp DRAW_SPRITE

MOVE_LEFT_MENU:
    ; move para a esquerda usando MOVE_LEFT_PROC
    ; configura parâmetros para MOVE_LEFT_PROC
    push bx                     ; salva BX original
    push di                     ; salva DI original
    
    ; BX = ponteiro para posição (já está correto)
    mov cx, 1                   ; velocidade = 1 pixel
    mov dx, di                  ; limite esquerdo
    call MOVE_LEFT_PROC
    
    pop di                      ; restaura DI
    pop bx                      ; restaura BX

DRAW_SPRITE:
    ; Renderiza sprite na nova posição
    mov ax, [bx]            ; AX = nova posição
    ; SI já contém o offset do sprite
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
;   BP = &dir_flag          (ex.: OFFSET alien_dir)  ; byte: 0=esq, 1=dir
;   SI = offset sprite      (ex.: OFFSET alien_sprite)
;   AX = L (left bound)     (ex.: ALIEN_L)
;   DX = R (right bound)    (ex.: ALIEN_R)
; Efeito:
;   - limpa as bordas, move 1 px na direção, redesenha
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

    mov si, offset ship_pos
    mov di, [si]
    ; Verifica limites: x = ship_pos % 320
    mov ax, [ship_pos]
    xor dx, dx
    mov cx, 320
    div cx                       ; DX = x
    ; se x >= (320-SPR_W), não anda para a direita
    mov bx, 320 - SPR_W         ; limite direito considerando largura da nave
    cmp dx, bx
    jb MOVE_RIGHT_MENU
    ; wrap para a esquerda
    mov di, ship_pos
    call CLEAR_SPRITE
    mov ship_pos, ship_pos_ini            ; AX = L

MOVE_RIGHT_MENU:
    call MOVE_RIGHT_PROC

DRAW_RIGHT:
    
    call RENDER_SHIP

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
    mov ax, meteor_pos_ini      ; posição inicial para wrap
    mov dx, 4                   ; limite esquerdo
    call MOVE_WRAP_LEFT_AND_DRAW

    mov bx, OFFSET alien_pos
    mov bp, OFFSET alien_dir
    mov si, OFFSET alien_sprite
    mov ax, ALIEN_L
    mov dx, ALIEN_R
    call MOVE_BOUNCE_X_AND_DRAW

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

RENDER_FASE proc
    push ax
    push bx
    push cx
    push dx
    push bp

    call CLEAR_SCREEN

    mov ship_pos, 0
    
    ; Print Sector
    xor ax, ax
    mov al, fase

    cmp al, 4
    jne SUM_POINTS
    ;call SHOW_YOU_WIN

SUM_POINTS:
    dec al ; number vector index

    ;mov bx, 1000
    ;mul bx
    ;xor bx, bx
    ;mov bl, allies_count
    ;mul bx
    ;add score, ax

    xor ax, ax
    mov al, fase
    dec al ; number vector index
    shl al, 1 ; multiply by 2 (since num_vec values are dw)
    mov bx, offset fase_vec ; get the vector
    add bx, ax ; add the index to the vector ptr
    mov bp, [bx] ; set BP to base address of number
    mov cx, fase_string_length
    xor dl, dl; line
    mov dh, 10

    mov bl, 0BH ; Cor verde (se bit 1 de AL estiver limpo, usamos BL)
    call PRINT_STRING

    xor cx, cx
    mov cx, 1Eh
    mov dx, 2710H
    mov ah, 86H
    int 15h
    
    call CLEAR_SCREEN

    pop bp
    pop dx
    pop cx
    pop bx
    pop ax
    ret
endp

RENDER_TIME proc
    push bp
    push bx
    push cx
    push dx

    mov bp, offset time_str
    mov cx, time_str_len
    mov bl, 0FH ; white
    xor dh, dh
    mov dl, 30
    call PRINT_STRING

    xor ax, ax
    mov al, time
    mov si, offset time_buffer
    add si, time_buffer_len - 1
    mov cx, 2
    call CONVERT_UINT16
    
    mov bp, offset time_buffer
    mov cx, time_buffer_len
    mov bl, 02H ; green
    xor dh, dh
    mov dl, 36
    call PRINT_STRING

    pop dx
    pop cx
    pop bx
    pop bp

    ret
endp


; AX = uint16 value to output
; SI = offset of end off string buffer
; CX = number of digits to write
CONVERT_UINT16 proc 
    push si
    push ax
    push bx
    push cx
    push dx

    mov bx, 10

LOOP_DIV:
    xor dx, dx
    div bx

    add dl, '0'
    mov byte ptr ds:[si], dl
    dec si

    dec cx
    jnz LOOP_DIV

    pop dx
    pop cx
    pop bx
    pop ax
    pop si
    ret     
endp

; Renderiza o score na parte superior esquerda
RENDER_SCORE proc
    push si
    push bp
    push ax
    push bx
    push cx
    push dx

    mov bp, offset score_str
    mov cx, score_str_len
    mov bl, 0FH ; branco
    xor dx, dx  ; linha 0, coluna 0
    call PRINT_STRING

    mov ax, score
    mov si, offset score_buffer
    add si, score_buffer_len - 1
    mov cx, score_buffer_len
    call CONVERT_UINT16
    
    mov bp, offset score_buffer
    mov cx, score_buffer_len
    mov bl, 0AH ; verde claro
    xor dh, dh
    mov dl, 7   ; coluna 7 (após "SCORE:")
    call PRINT_STRING

    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    pop si
    ret
RENDER_SCORE endp

; Renderiza as vidas no centro da barra de status
RENDER_LIVES proc
    push ax
    push bx
    push cx
    push si
    push di

    xor cx, cx
    mov cl, lives
    cmp cl, 0
    je END_RENDER_LIVES

    ; Posição inicial: linha 5, centralizado
    ; Centro da tela = 160, cada vida ocupa 19 pixels + 6 de espaço = 25
    ; Para 3 vidas: 3*25 = 75 pixels, começa em 160-37 = 123
    mov ax, 5 * SCREEN_W + 123  ; linha 5, coluna 123 (centralizado)
    mov si, offset ship_sprite

RENDER_SINGLE_LIFE:
    push cx
    push ax
    push si
    mov si, offset ship_sprite  ; Resetar SI para o início do sprite
    call RENDER_SPRITE
    pop si
    pop ax
    add ax, 25  ; próxima vida (19 pixels + 6 de espaço)
    pop cx
    loop RENDER_SINGLE_LIFE

END_RENDER_LIVES:
    pop di
    pop si
    pop cx
    pop bx
    pop ax
    ret
RENDER_LIVES endp

; Renderiza toda a barra de status (score + vidas + tempo)
RENDER_STATUS proc
    call RENDER_SCORE
    call RENDER_LIVES
    call RENDER_TIME
    ret
RENDER_STATUS endp

UPDATE_TIME proc
    push ax
    push bx

    mov ah, timeout
    inc ah
    cmp ah, 100
    jne SAVE_TIMEOUT

    mov ah, time
    dec ah
    jnz SAVE_TIME

    mov ah, fase
    inc ah
    mov fase, ah
    
    call RENDER_FASE
    
    jmp END_TIME

SAVE_TIME:
    mov time, ah
    
    ; Adiciona pontos por segundo baseado na fase
    mov bl, fase
    cmp bl, 1
    jne CHECK_FASE2
    add score, 10  ; Fase 1: +10 pontos/segundo
    jmp SAVE_TIMEOUT
    
CHECK_FASE2:
    cmp bl, 2
    jne CHECK_FASE3
    add score, 15  ; Fase 2: +15 pontos/segundo
    jmp SAVE_TIMEOUT
    
CHECK_FASE3:
    cmp bl, 3
    jne SAVE_TIMEOUT
    add score, 20  ; Fase 3: +20 pontos/segundo
    
    xor ah, ah

SAVE_TIMEOUT:
    mov timeout, ah

END_TIME:
    pop bx
    pop ax
    ret
endp



UPDATE_SHIP proc
    push si
    push di
    push ax
    push bx

    mov ah, 1H
    int 16H
    jz END_SHIP_UPDATE

    call HANDLE_CONTROLS
    xor ah, ah
    int 16H

END_SHIP_UPDATE:
    pop bx
    pop ax
    pop di
    pop si
    call RENDER_SHIP
    ret
endp


; Proc para controle da nave
HANDLE_CONTROLS proc
    push si
    push di
    push ax
    push bx
    push cx

    mov si, offset ship_pos
    mov di, [si]

    cmp ah, 48H
    je MOVE_UP

    cmp ah, 50H
    je MOVE_DOWN
    
    cmp ah, 4BH
    je MOVE_LEFT

    cmp ah, 4DH
    je MOVE_RIGHT

    ;cmp ah, 39H
    ;je FIRE
    
    cmp al, 'q'
    jne END_CONTROLS

    xor ax, ax
    int 16h
    call END_GAME

FIRE:
    ;call SHOOT
    jmp END_CONTROLS

MOVE_UP:
    call MOVE_UP_PROC
    jmp END_CONTROLS
MOVE_DOWN:
    call MOVE_DOWN_PROC
    jmp END_CONTROLS
MOVE_LEFT:
    mov bx, OFFSET ship_pos     ; ponteiro para posição da nave
    mov cx, ship_speed          ; velocidade da nave
    mov dx, 4                   ; limite esquerdo
    call MOVE_LEFT_PROC
    jmp END_CONTROLS

MOVE_RIGHT:
    call MOVE_RIGHT_PROC
    jmp END_CONTROLS

END_CONTROLS:
    pop cx
    pop bx
    pop ax
    pop di
    pop si
    ret
endp

; AL = axis (0 is X, 1 is Y)
; AH = direction (0 is positive, 1 is negative)
; SI = position pointer
; BX = increment
MOVE_SPRITE proc
    push si
    push ax
    push bx

    mov cx, [si]
    cmp al, 0
    jne MOVE_Y_AXIS
    jmp CHECK_DIRECTION

MOVE_Y_AXIS:
    push ax
    mov ax, 320
    mul bx
    mov bx, ax
    pop ax

CHECK_DIRECTION:
    cmp ah, 0
    jne MOVE_NEGATIVE
    add cx, bx
    jmp SAVE_POS

MOVE_NEGATIVE:
    sub cx, bx

SAVE_POS:
    mov [si], cx

    pop bx
    pop ax
    pop si
    ret
endp

RENDER_SHIP proc
    push si
    push di
    push bx
    push ax
    
    mov ax, ship_pos
    mov si, offset ship_sprite
    call RENDER_SPRITE

    pop ax
    pop bx
    pop di
    pop si
    ret
endp

RESET_SHIP proc
    push si
    push bx

    mov ship_pos, ship_pos_ini ; Ship stating position
    
    pop bx
    pop si
    ret
endp

RENDER_ALIEN proc
    ; AX = posição na tela
    push di
    push bx

    mov si, offset alien_sprite
    call RENDER_SPRITE

    pop bx
    pop di
    ret
endp

RENDER_METEOR proc
    ; AX = posição na tela
    push di
    push bx

    mov si, offset meteor_sprite
    call RENDER_SPRITE

    pop bx
    pop di
    ret
endp

; Reseta o jogo (score, vidas, fase)
RESET_GAME proc
    push ax
    
    mov score, 0
    mov lives, LIFES_START
    mov fase, 1
    mov time, SECONDS_START
    mov timeout, 0
    mov terrain_pos, 320 * 130
    
    pop ax
    ret
endp

; Renderiza o terreno (montanhoso para fase 1)
RENDER_TERRAIN proc
    push bx
    push cx
    push dx
    push di
    push es
    push ds
    push ax

    mov ax, @data
    mov ds, ax

    mov ax, 0A000h
    mov es, ax

    mov si, offset terrain
    mov di, terrain_pos
    dec terrain_pos
    cmp terrain_pos, 320*130 - 1
    jnz SKIP_POS_UPDATE
    mov terrain_pos, 320*131 - 1 

SKIP_POS_UPDATE:
    mov cx, 320*70  ; 70 linhas (130 a 199 - não ultrapassa a tela)
    rep movsb

    pop ax
    pop ds  
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    ret
endp

MOVE_UP_PROC proc
    push di
    push si
    push ax
    
    ; Verifica limites
    mov bx, [ship_pos]
    cmp bx, 320 * 20 + 47
    jb END_UP
    
    ; Move a nave
    mov al, 1
    mov ah, 1
    mov bx, ship_speed
    call MOVE_SPRITE
    
    
END_UP:
    pop ax
    pop si
    pop di
    ret
endp

MOVE_DOWN_PROC proc
    push di
    push si
    push ax
    
    ; Verifica limites
    mov bx, [ship_pos]
    cmp bx, 320 * 115
    jae END_DOWN
    
    ; Move a nave
    mov al, 1
    xor ah, ah
    mov bx, ship_speed
    call MOVE_SPRITE

    
END_DOWN:
    pop ax
    pop si
    pop di
    ret
endp

MOVE_LEFT_PROC proc
    ; Entradas:
    ;   BX = ponteiro para posição (ex.: OFFSET ship_pos)
    ;   CX = velocidade (ex.: ship_speed)
    ;   DX = limite esquerdo (ex.: 4)
    push di
    push si
    push ax
    push dx
    push cx
    push bp

    mov bp, cx              ; BP = velocidade
    mov di, dx              ; DI = limite esquerdo

    ; Verifica limites: x = pos % 320
    mov ax, [bx]            ; AX = posição atual
    xor dx, dx
    mov cx, 320
    div cx                  ; DX = coordenada X
    
    cmp dx, di              ; compara com limite esquerdo
    jbe END_LEFT
    
    ; Move para a esquerda
    mov si, bx              ; SI = ponteiro para posição
    mov ah, 1               ; direção negativa (esquerda)
    mov bx, bp              ; BX = velocidade
    mov al, 0               ; eixo X
    call MOVE_SPRITE

END_LEFT:
    pop bp
    pop cx
    pop dx
    pop ax
    pop si
    pop di
    ret
endp

MOVE_RIGHT_PROC proc
    push di
    push si
    push ax
    push dx
    push cx
    
    ; Verifica limites: x = ship_pos % 320
    mov ax, [ship_pos]
    xor dx, dx
    mov cx, 320
    div cx                       ; DX = x
    ; se x >= (320-SPR_W), não anda para a direita
    mov bx, 320 - SPR_W         ; limite direito considerando largura da nave
    cmp dx, bx
    jae END_RIGHT
    
    ; Move a nave
    xor ah, ah                   ; direção positiva (direita)
    mov bx, ship_speed
    mov al, 0                   ; eixo X
    call MOVE_SPRITE
    
    
END_RIGHT:
    pop cx
    pop dx
    pop ax
    pop si
    pop di
    ret
endp

end MAIN
