; M0 ? Sanity check: texto -> 13h -> desenha 1 pixel -> volta pro texto
.model small
.stack 100h

.data
    CR EQU 13
    LF EQU 10
    SPR_W  EQU 13
    SPR_H  EQU 29
.data
    CR EQU 13
    LF EQU 10
    SPR_W  EQU 13
    SPR_H  EQU 29
    sprite_ally db 0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,1,0,0,0,0,1,0,0
                db 0,0,0,0,1,5,1,0,1,5,1,0,0
                db 0,0,0,0,0,1,0,0,0,1,0,0,0
                db 0,0,0,1,1,4,1,1,1,4,1,1,0
                db 0,0,0,1,4,4,4,4,4,4,4,1,0
                db 0,0,1,1,4,4,4,4,4,4,4,1,1
                db 0,0,1,4,4,4,4,4,4,4,4,4,1
                db 0,1,1,4,4,1,4,1,4,4,4,4,1
                db 0,1,4,4,4,4,4,4,4,4,4,4,1
                db 1,5,4,4,4,4,4,4,4,4,4,5,1
                db 0,1,4,4,4,4,4,4,4,4,4,4,1
                db 0,1,1,4,4,4,4,4,4,4,4,1,1
                db 0,0,1,4,4,4,4,4,4,4,4,1,0
                db 0,0,0,1,1,4,1,1,1,4,1,1,0
                db 0,0,0,0,0,1,0,0,0,1,0,0,0
                db 0,0,0,0,1,5,1,0,1,5,1,0,0
                db 0,0,0,0,0,1,0,0,0,1,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0
    
.code
INICIO:
    mov  ax, @data
    mov  ds, ax

    ; Entra no v?deo 13h e aponta ES pra A000h
    call VIDEO13_INIT
    mov al, 1Fh
    call CLEAR13

    ; Linha no topo (y=0), largura 320, cor 0Fh
    mov bx, 0      ; x0
    mov cx, 0      ; y
    mov dx, 640    ; largura
    mov al, 0Fh
    call HLINE

    ; Linha embaixo (y=199), largura 320, cor 1Eh
    mov bx, 0
    mov cx, 199
    mov dx, 640
    mov al, 1Eh
    call HLINE

    mov  bx, 0
    mov  cx, 0
    mov  dx, 200   ; altura
    call VLINE

    mov  bx, 319
    mov  cx, 0
    mov  dx, 200
    call VLINE
    
    
    ; ret?ngulo central 
    mov  bx, 135   ; x
    mov  cx, 160    ;y
    mov  si, 50   ; largura
    mov  di, 20    ; altura
    mov  al, 10h
    call RECTFILL
    

    ; ret?ngulo central
    mov  bx, 135   ; x
    mov  cx, 135    ;y
    mov  si, 50   ; largura
    mov  di, 20    ; altura
    mov  al, 10h
    call RECTFILL
    
   ; desenha opaco em (40,40)
    mov  bx, 40
    mov  cx, 40
    mov  si, offset sprite_ally
    call BLIT_SPRITE_OPAQUE

    ; desenha transparente em (120,60)
    mov  bx, 120
    mov  cx, 60
    mov  si, offset sprite_ally
    call BLIT_SPRITE_TRANS
    
    ; espera ~5s
    mov  ah, 86h
    mov  cx, 004Ch
    mov  dx, 4B40h
    int  15h

    
    ; espera ~5s
    mov  ah, 86h
    mov  cx, 004Ch
    mov  dx, 4B40h
    int  15h
    call VIDEO_TEXT

    
    mov  ax, 4C00h
    int  21h

;-----------------------------------------
; Procs utilit?rias (estilo do professor)
;-----------------------------------------

; Quebra de linha (CR/LF) - usa AH=02h
NL PROC
    push ax
    push dx
    mov  dl, CR
    mov  ah, 02h
    int  21h
    mov  dl, LF
    mov  ah, 02h
    int  21h
    pop  dx
    pop  ax
    ret
NL ENDP

; Inicializa modo 13h e ES=A000h, CLD para strings
VIDEO13_INIT PROC
    push ax
    mov  ax, 0013h
    int  10h
    mov  ax, 0A000h
    mov  es, ax
    cld
    pop  ax
    ret
VIDEO13_INIT ENDP

; Volta ao modo texto 80x25
VIDEO_TEXT PROC
    push ax
    mov  ax, 0003h
    int  10h
    pop  ax
    ret
VIDEO_TEXT ENDP

; PUTPIXEL ? Entrada: BX=x (0..319), CX=y (0..199), AL=cor
; Usa ES:A000h. Calcula offset: y*320 + x = y*256 + y*64 + x
PUTPIXEL PROC
    push dx
    push di

    mov  di, cx      ; di = y
    shl  di, 6       ; y*64
    mov  dx, cx
    shl  dx, 8       ; y*256
    add  di, dx      ; y*256 + y*64
    add  di, bx      ; + x
    mov  es:[di], al

    pop  di
    pop  dx
    ret
PUTPIXEL ENDP

; CLEAR13 ? preenche a tela 320x200 com a cor AL
; Pr?: ES = A000h (chame VIDEO13_INIT antes), CLD setado
CLEAR13 PROC
    push cx
    push di
    xor  di, di
    mov  cx, 320*200      ; 64.000 pixels
    rep  stosb            ; escreve AL em ES:[DI], CX vezes
    pop  di
    pop  cx
    ret
CLEAR13 ENDP

; HLINE ? desenha linha horizontal
; Entradas: BX=x0, CX=y, DX=largura, AL=cor
; Pr?: ES=A000h, CLD
HLINE PROC
    push ax
    push dx
    push di

    ; DI = y*320 + x
    mov  di, cx
    shl  di, 6
    mov  ax, cx
    shl  ax, 8
    add  di, ax
    add  di, bx

    mov  cx, dx      ; CX = largura
    rep  stosb       ; escreve AL em ES:[DI], CX vezes

    pop  di
    pop  dx
    pop  ax
    ret
HLINE ENDP

VLINE PROC
    push ax
    push cx
    push dx
    push di
    ; DI = y*320 + x
    mov  di, cx
    shl  di, 6
    mov  ax, cx
    shl  ax, 8
    add  di, ax
    add  di, bx

    mov  cx, dx      ; CX = altura
    VL_S_LOOP:
        stosb              ; escreve AL em ES:[DI] e DI += 1
        add   di, 319      ; total do passo = 1 + 319 = 320
        loop  VL_S_LOOP

        pop  di
        pop  dx
        pop  cx
        pop  ax
        ret
    
        ;rep  stosb       ; escreve AL em ES:[DI], CX vezes

; RECTFILL ? preenche ret?ngulo LxA
; BX=x, CX=y, SI=largura, DI=altura, AL=cor | Pr?: ES=A000h, CLD
RECTFILL PROC
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp

    mov  bp, di         ; bp = altura (guardamos porque DI vira offset)

    ; DI = y*320 + x
    mov  di, cx
    shl  di, 6
    mov  dx, cx
    shl  dx, 8
    add  di, dx
    add  di, bx

    RF_Y_LOOP:
        mov  cx, si         ; cx = largura
        rep  stosb          ; pinta uma linha com AL

        ; avan?a para a pr?xima linha: +320 - largura
        mov  dx, 320
        sub  dx, si
        add  di, dx

        dec  bp
        jnz  RF_Y_LOOP

        pop  bp
        pop  di
        pop  si
        pop  dx
        pop  cx
        pop  bx
        pop  ax
        ret
RECTFILL ENDP

; BLIT_SPRITE_OPAQUE ? copia SPR_W bytes por linha, SPR_H linhas
; BX=x, CX=y, SI=src (DS), Pr?: ES=A000h, CLD
BLIT_SPRITE_OPAQUE PROC
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp

    mov  bp, SPR_H       ; contador de linhas

    ; DI0 = y*320 + x
    mov  di, cx
    shl  di, 6
    mov  dx, cx
    shl  dx, 8
    add  di, dx
    add  di, bx

    ROW_LOOP_OP:
        mov  cx, SPR_W       ; bytes nesta linha
        rep  movsb           ; copia DS:[SI..] -> ES:[DI..]
        ; ajustar DI para a pr?xima linha: +320 - SPR_W
        mov  ax, 320
        sub  ax, SPR_W
        add  di, ax
        dec  bp
        jnz  ROW_LOOP_OP

        pop  bp
        pop  di
        pop  si
        pop  dx
        pop  cx
        pop  bx
        pop  ax
        ret
BLIT_SPRITE_OPAQUE ENDP

; BLIT_SPRITE_TRANS ? 0 n?o desenha; ?0 desenha
; BX=x, CX=y, SI=src (DS), Pr?: ES=A000h, CLD
BLIT_SPRITE_TRANS PROC
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp

    mov  bp, SPR_H ; contador de linhas do desenho

    ; DI0 = y*320 + x
    mov  di, cx
    shl  di, 6
    mov  dx, cx
    shl  dx, 8
    add  di, dx
    add  di, bx

    ROW_LOOP_TR:
        mov  cx, SPR_W
    COL_LOOP_TR:
        lodsb                ; AL = [DS:SI], SI++
        or   al, al          ; AL == 0 ?
        jz   skip_px
        stosb                ; escreve AL em ES:[DI], DI++
        jmp  short next_px
    skip_px:
        inc  di              ; s? avan?a destino
    next_px:
        loop COL_LOOP_TR

        ; pr?xima linha
        mov  ax, 320
        sub  ax, SPR_W
        add  di, ax
        dec  bp
        jnz  ROW_LOOP_TR

        pop  bp
        pop  di
        pop  si
        pop  dx
        pop  cx
        pop  bx
        pop  ax
        ret
BLIT_SPRITE_TRANS ENDP


end INICIO
