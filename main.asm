
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
    string  db 2 dup(" "),"                                    ",13,10
            db 2 dup(" "),"  ___                    _    _     ",13,10
            db 2 dup(" ")," / __| __ _ _ __ _ _ __ | |__| |___ ",13,10
            db 2 dup(" ")," \__ \/ _| '_/ _` | '  \| '_ \ / -_)",13,10
            db 2 dup(" ")," |___/\__|_| \__,_|_|_|_|_.__/_\___|",13,10


    string_length equ $-string
    meteor_sprite   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,1,1,4,4,4,4,4,1,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,1,4,4,4,4,4,4,4,4,1,0,1,1,0,0,0,0,0,0
                    db 0,0,0,0,0,1,4,4,4,4,4,4,4,4,1,0,1,1,0,0,0,0,0,0
                    db 0,0,0,0,1,4,4,4,5,5,5,5,4,4,4,1,0,0,0,0,0,0,0,0
                    db 0,0,0,1,4,4,5,5,5,5,5,5,5,4,4,1,0,0,0,0,0,0,0,0
                    db 0,0,0,1,4,4,5,5,5,5,5,5,5,5,4,1,5,5,0,0,0,0,0,0
                    db 0,0,0,1,4,4,4,5,5,5,5,5,5,4,4,1,4,5,0,0,0,0,0,0
                    db 0,0,0,1,4,4,4,5,5,5,5,5,5,4,4,1,4,5,0,0,0,0,0,0
                    db 0,0,0,1,4,4,4,5,5,5,5,5,5,4,4,1,4,5,0,0,0,0,0,0
                    db 0,0,0,0,1,4,4,4,4,5,5,5,4,4,1,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,1,4,4,4,4,4,4,4,4,4,1,0,1,5,0,0,0,0,0,0
                    db 0,0,0,0,0,1,4,4,4,4,4,4,4,1,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,1,4,4,4,4,4,1,0,4,4,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,1,4,4,4,4,4,1,0,4,4,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,1,1,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0


    alien_sprite    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0AH,0AH,0AH,2,0EH,0AH,0AH,0AH,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0EH,2,2,2,2,2,2,2,2,2,2,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0EH,2,2,2,2,2,2,2,2,2,2,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0EH,2,2,2,2,2,2,2,2,2,2,2,2,0EH,0,0,0,0,0
                    db 0,0,0,0,0,0EH,0EH,0AH,5,5,0AH,2,0EH,0AH,5,5,0AH,0EH,0EH,0,0,0,0,0
                    db 0,0,0,0,0,0EH,0EH,0AH,5,5,0AH,2,0EH,0AH,5,5,0AH,0EH,0EH,0,0,0,0,0
                    db 0,0,0,0,0,0EH,0EH,0EH,0AH,0AH,0AH,2,0EH,0AH,0AH,0AH,0EH,0EH,0EH,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0EH,0AH,2,5,5,2,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0EH,0AH,2,5,5,2,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0EH,0AH,2,5,5,0AH,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0EH,0AH,2,5,5,0AH,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0EH,0AH,2,5,5,2,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0EH,0AH,2,5,5,2,5,5,2,0AH,0EH,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0AH,0AH,0AH,2,0EH,0AH,0AH,0AH,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                    db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    alien_pos dw 125*320 + 300 ; posição inicial (linha 125, x = 300)
    alien_dir db 0  ; direção do alien (0=esquerda, 1=direita)
    
    ; Sprite da nave principal (29x13 pixels) - baseado no exemplo
    ship_sprite db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,15,15,15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,1,15,15,0AH,0AH,0AH,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,1,15,15,15,0AH,0AH,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,1,15,15,15,15,15,15,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,1,09H,09H,09H,09H,09H,09H,15,15,15,15,15,15,0,0,0,0,0
                db 0,0,0,0,0,0,1,09H,09H,09H,09H,09H,09H,15,15,15,15,15,15,0,0,0,0,0
                db 0,0,0,0,0,0,1,15,15,15,15,15,15,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,1,15,15,15,0AH,0AH,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,1,15,15,0AH,0AH,0AH,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,15,15,15,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
                db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

    ; Sprite do tiro (8x6 pixels) - horizontal
    shot_sprite db 0,0,0,0,0,0
                db 0,0,0,0,0,0
                db 0,0,15,15,0,0
                db 0,0,15,15,0,0
                db 0,0,0,0,0,0
                db 0,0,0,0,0,0

    ROW_METEOR  EQU 100
    ROW_ALIEN   EQU 125
    ROW_SHIP    EQU 75
    
    ; Fase 3: Nave mais alta, terreno mais baixo
    ROW_SHIP_FASE3    EQU 50      ; Nave na linha 50
    ROW_TERRAIN_FASE3 EQU 150     ; Terreno começa na linha 150
    ROW_ALIEN_FASE3   EQU 50      ; Aliens mais acima (linhas 50-90)

    meteor_pos_ini EQU ROW_METEOR*320 + 300  ; posição inicial do meteoro (linha 100, x = 300)
    meteor_pos dw meteor_pos_ini ; posi??o inicial (linha 100, x = 300)

    ship_pos_ini EQU ROW_SHIP*320 
    ship_pos dw ship_pos_ini ; posição inicial (linha 95, coluna 41)
    ship_speed EQU 5
    
    ; Sistema de tiro (3 tiros simultâneos)
    shot_count db 3
    shot_pos dw 0, 0, 0       ; Posições dos 3 tiros
    shot_active db 0, 0, 0    ; Status dos 3 tiros (0=inativo, 1=ativo)

    ; Sistema de aliens/meteoros (usa mesmo sistema para ambos)
    alien_count db 5            
    alien_array_pos dw 5 dup(0)  ; Expandido para 5
    alien_array_active db 5 dup(0) ; Expandido para 5
    alien_spawn_timer dw 0
    alien_spawn_delay dw 60      ; 60 frames = ~1 segundo
    alien_move_speed dw 1        ; Velocidade de movimento aliens fase 1 (pixels por frame)
    meteor_move_speed dw 1       ; Velocidade de movimento meteoros fase 2 (pixels por frame)
    meteor_spawn_delay dw 60     ; 45 frames entre spawns de meteoros
    alien_fase3_move_speed dw 3  ; Velocidade maior para fase 3
    alien_fase3_spawn_delay dw 45  ; Spawn mais rápido na fase 3

    LIFES_START EQU 3
    lives db LIFES_START  ; número de vidas

    SCREEN_W    EQU 320
    SCREEN_H    EQU 200

    SPR_W       EQU 24  ; para meteoro e alien
    SPR_H       EQU 20

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
    
    ; ASCII art para Game Over
    game_over_msg   db 5 dup(" "),"                          ",13,10
                    db 5 dup(" "),"   ___   _   __  __ ___  ",13,10
                    db 5 dup(" "),"  / __| /_\ |  \/  | __| ",13,10
                    db 5 dup(" ")," | (_ |/ _ \| |\/| | _|  ",13,10
                    db 5 dup(" "),"  \___/_/ \_\_|_ |_|___| ",13,10
                    db 5 dup(" "),"  / _ \ \ / / __| _ \    ",13,10
                    db 5 dup(" ")," | (_) \ V /| _||   /    ",13,10
                    db 5 dup(" "),"  \___/ \_/ |___|_|_\    ",13,10
                    db 5 dup(" "),"                          ",13,10

    game_over_msg_length equ $-game_over_msg
    
    ; ASCII art para Vencedor
    vencedor_msg    db 2 dup(" "),"                                    ",13,10
                    db 2 dup(" ")," __   __                  _         ",13,10
                    db 2 dup(" ")," \ \ / /__ _ _  __ ___ __| |___ _ _ ",13,10
                    db 2 dup(" "),"  \ V / -_) ' \/ _/ -_) _` / _ \ '_|",13,10
                    db 2 dup(" "),"   \_/\___|_||_\__\___\__,_\___/_|  ",13,10
                    db 2 dup(" "),"                                    ",13,10

    vencedor_msg_length equ $-vencedor_msg

    
    ; Mensagem para pressionar tecla
    press_key_msg db "Pressione qualquer tecla",13,10,0
    press_key_msg_length equ $-press_key_msg
    
    ; Mensagem de score final
    final_score_msg db "SCORE FINAL: ",0
    final_score_msg_length equ $-final_score_msg
    
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
    terrain_fase1 db 320 dup(0)
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
    
    ; Terreno da fase 2 - mais desafiador com mais obstáculos
    terrain_fase2 db 320 dup(0)
        db 320 dup(0)
        db 120 dup(0),8 dup (4),192 dup(0)
        db 115 dup(0),12 dup (4),193 dup(0)
        db 50 dup(0),6 dup (4),10 dup(0),8 dup (4),90 dup(0),4 dup (4),30 dup(0),8 dup (4),100 dup(0),4 dup (4),24 dup(0)
        db 45 dup(0),8 dup (4),8 dup(0),12 dup (4),80 dup(0),6 dup (4),25 dup(0),12 dup (4),95 dup(0),6 dup (4),23 dup(0)
        db 40 dup(0),10 dup (4),15 dup(0),8 dup (4),70 dup(0),8 dup (4),20 dup(0),15 dup (4),85 dup(0),8 dup (4),21 dup(0)
        db 35 dup(0),12 dup (4),12 dup(0),10 dup (4),60 dup(0),10 dup (4),18 dup(0),18 dup (4),75 dup(0),10 dup (4),20 dup(0)
        db 30 dup(0),15 dup (4),10 dup(0),12 dup (4),50 dup(0),12 dup (4),15 dup(0),20 dup (4),65 dup(0),12 dup (4),19 dup(0)
        db 25 dup(0),18 dup (4),8 dup(0),15 dup (4),40 dup(0),15 dup (4),12 dup(0),25 dup (4),55 dup(0),15 dup (4),17 dup(0)
        db 20 dup(0),20 dup (4),6 dup(0),18 dup (4),30 dup(0),18 dup (4),10 dup(0),30 dup (4),45 dup(0),18 dup (4),15 dup(0)
        db 20 dup(0),20 dup (4),6 dup(0),18 dup (4),30 dup(0),18 dup (4),10 dup(0),30 dup (4),45 dup(0),18 dup (4),15 dup(0)
        db 20 dup(0),20 dup (4),6 dup(0),18 dup (4),30 dup(0),18 dup (4),10 dup(0),30 dup (4),45 dup(0),18 dup (4),15 dup(0)
        db 20 dup(0),20 dup (4),6 dup(0),18 dup (4),30 dup(0),18 dup (4),10 dup(0),30 dup (4),45 dup(0),18 dup (4),15 dup(0)
        db 20 dup(0),20 dup (4),6 dup(0),18 dup (4),30 dup(0),18 dup (4),10 dup(0),30 dup (4),45 dup(0),18 dup (4),15 dup(0)
        db 20 dup(0),20 dup (4),6 dup(0),18 dup (4),30 dup(0),18 dup (4),10 dup(0),30 dup (4),45 dup(0),18 dup (4),15 dup(0)
        db 15 dup(0),25 dup (4),4 dup(0),20 dup (4),20 dup(0),20 dup (4),8 dup(0),35 dup (4),35 dup(0),20 dup (4),13 dup(0)
        db 15 dup(0),25 dup (4),4 dup(0),20 dup (4),20 dup(0),20 dup (4),8 dup(0),35 dup (4),35 dup(0),20 dup (4),13 dup(0)
        db 15 dup(0),25 dup (4),4 dup(0),20 dup (4),20 dup(0),20 dup (4),8 dup(0),35 dup (4),35 dup(0),20 dup (4),13 dup(0)
        db 15 dup(0),25 dup (4),4 dup(0),20 dup (4),20 dup(0),20 dup (4),8 dup(0),35 dup (4),35 dup(0),20 dup (4),13 dup(0)
        db 15 dup(0),25 dup (4),4 dup(0),20 dup (4),20 dup(0),20 dup (4),8 dup(0),35 dup (4),35 dup(0),20 dup (4),13 dup(0)
        db 15 dup(0),25 dup (4),4 dup(0),20 dup (4),20 dup(0),20 dup (4),8 dup(0),35 dup (4),35 dup(0),20 dup (4),13 dup(0)
        db 320 dup (4)
        db 320 dup (4)
        db 320 dup (4)
        db 30 dup(4),4 dup(0CH),25 dup(4),3 dup(02H),35 dup(4),5 dup(0CH),30 dup(4),4 dup(02H),32 dup(4),3 dup(0CH),35 dup(4),5 dup(02H),28 dup(4),4 dup(0CH),30 dup(4)
        db 30 dup(4),4 dup(0CH),25 dup(4),3 dup(02H),35 dup(4),5 dup(0CH),30 dup(4),4 dup(02H),32 dup(4),3 dup(0CH),35 dup(4),5 dup(02H),28 dup(4),4 dup(0CH),30 dup(4)
        db 30 dup(4),4 dup(0CH),25 dup(4),3 dup(02H),35 dup(4),5 dup(0CH),30 dup(4),4 dup(02H),32 dup(4),3 dup(0CH),35 dup(4),5 dup(02H),28 dup(4),4 dup(0CH),30 dup(4)
        db 25 dup(4),7 dup(02H),20 dup(4),9 dup(0CH),25 dup(4),8 dup(02H),22 dup(4),10 dup(0CH),27 dup(4),9 dup(02H),25 dup(4),11 dup(0CH),20 dup(4),10 dup(02H),23 dup(4)
        db 25 dup(4),7 dup(02H),20 dup(4),9 dup(0CH),25 dup(4),8 dup(02H),22 dup(4),10 dup(0CH),27 dup(4),9 dup(02H),25 dup(4),11 dup(0CH),20 dup(4),10 dup(02H),23 dup(4)
        db 25 dup(4),7 dup(02H),20 dup(4),9 dup(0CH),25 dup(4),8 dup(02H),22 dup(4),10 dup(0CH),27 dup(4),9 dup(02H),25 dup(4),11 dup(0CH),20 dup(4),10 dup(02H),23 dup(4)
        db 20 dup(4),10 dup(0CH),18 dup(4),12 dup(02H),20 dup(4),11 dup(0CH),19 dup(4),13 dup(02H),22 dup(4),12 dup(0CH),21 dup(4),14 dup(02H),18 dup(4),13 dup(0CH),19 dup(4)
        db 20 dup(4),10 dup(0CH),18 dup(4),12 dup(02H),20 dup(4),11 dup(0CH),19 dup(4),13 dup(02H),22 dup(4),12 dup(0CH),21 dup(4),14 dup(02H),18 dup(4),13 dup(0CH),19 dup(4)
        db 20 dup(4),10 dup(0CH),18 dup(4),12 dup(02H),20 dup(4),11 dup(0CH),19 dup(4),13 dup(02H),22 dup(4),12 dup(0CH),21 dup(4),14 dup(02H),18 dup(4),13 dup(0CH),19 dup(4)
        db 15 dup(4),15 dup(02H),13 dup(4),18 dup(0CH),15 dup(4),16 dup(02H),14 dup(4),19 dup(0CH),17 dup(4),17 dup(02H),16 dup(4),20 dup(0CH),13 dup(4),18 dup(02H),15 dup(4)
        db 10 dup(4),20 dup(0CH),8 dup(4),25 dup(02H),10 dup(4),21 dup(0CH),9 dup(4),26 dup(02H),12 dup(4),22 dup(0CH),11 dup(4),27 dup(02H),8 dup(4),23 dup(0CH),10 dup(4)
        db 320 dup (0CH)
        db 320 dup (02H)
        db 320 dup (0CH)
        db 320 dup (02H)
        db 320 dup (0CH)
        db 320 dup (02H)
        db 320 dup (0CH)
        db 320 dup (02H)
        db 320 dup (0CH)
        db 320 dup (02H)
        db 320 dup (0CH)
        db 320 dup (02H)
        db 320 dup (0CH)
        db 320 dup (02H)
        db 320 dup (0CH)


base    db 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7 , 0, 0 
        db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0
        db 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0  
        db 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0  
        db 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0  
        db 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 4, 4, 4, 4, 4, 4, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0  
        db 0, 0, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 7, 7, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 0BH, 7, 7, 0, 0 
        db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 0, 0  

        
topo    db 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 0, 0 
        db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 0, 0 
        db 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 0, 0 
        db 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 0, 0 
        db 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 0, 0 
        db 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 0, 0 
        db 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 7, 7, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 7, 7, 0, 0 
        db 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 0, 0                    

    ; Vetor de terrenos para cada fase (fase3 não usa terreno fixo)
    terrain_vec dw offset terrain_fase1, offset terrain_fase2, 0
    
    terrain_pos dw 0  ; Offset de scroll horizontal (0-319)
    
    ; Estrutura para torres da fase 3 (geração procedural)
    MAX_TOWERS EQU 12
    tower_heights db MAX_TOWERS dup(0)  ; Altura de cada torre (em andares)
    tower_x_pos   dw MAX_TOWERS dup(0)  ; Posição X de cada torre
    tower_active  db MAX_TOWERS dup(0)  ; Torre ativa? (0=não, 1=sim)
    next_tower_x  dw 320                ; Próxima posição X para gerar torre
    tower_spawn_counter dw 0            ; Contador para spawnar novas torres
    tower_min_spacing   EQU 34          ; Espaçamento = 34 frames (mesma largura das torres)
    
    ; Variáveis temporárias para clipping de torre
    tower_sprite_offset dw 0            ; Offset no sprite (pixels a pular)
    tower_render_width  dw BASE_WIDTH   ; Largura a renderizar
    
    ; Dimensões dos andares
    BASE_WIDTH  EQU 34  ; Largura de um andar (em pixels)
    BASE_HEIGHT EQU 8   ; Altura de um andar (em pixels)

    
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

LOOP_MENU:
    ; Exibe titulo e botoes do menu
    call PRINT_TITLE_MENU
    call PRINT_BUTTONS
    
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

    call RESET_SHIP
    
    GAME_LOOP:
    call RENDER_TERRAIN  ; Renderiza o terreno primeiro
    call RENDER_STATUS   ; Renderiza score, vidas e tempo
    call UPDATE_TIME
    call UPDATE_SHIP
    call UPDATE_SHOT     ; Atualiza os tiros
    call UPDATE_ALIENS   ; Atualiza aliens
    call CHECK_ALIEN_SHOT_COLLISION   ; Colisão tiros vs aliens
    call CHECK_ALIEN_SHIP_COLLISION   ; Colisão nave vs aliens
    
    ; Verifica condições de fim de jogo
    call CHECK_GAME_END
    cmp al, 1            ; Game Over?
    je GAME_OVER_END
    cmp al, 2            ; Vitória?
    je VICTORY_END
    
    jmp GAME_LOOP
    
GAME_OVER_END:
    call SHOW_GAME_OVER
    jmp LOOP_MENU        ; Volta ao menu principal
    
VICTORY_END:
    call SHOW_VICTORY
    jmp LOOP_MENU        ; Volta ao menu principal

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
    push bp

    mov cx, ax              ; CX = limite esquerdo (coordenada X)
    mov di, dx              ; DI = limite direito (coordenada X)
    
    ; Verifica limites: x = pos % 320
    mov ax, [bx]
    xor dx, dx
    mov bp, 320
    div bp                  ; DX = x atual (coordenada X)
    
    ; Verifica bounce esquerdo
    cmp dx, cx              ; compara X atual com X limite esquerdo
    jbe BOUNCE_LEFT
    
    ; Verifica bounce direito
    cmp dx, di              ; compara X atual com X limite direito
    jae BOUNCE_RIGHT
    jmp MOVE_BOUNCE_MENU

BOUNCE_LEFT:
    ; chegou na borda esquerda, muda direção para direita
    ; BP foi usado para a chamada anterior mas preciso recuperar o ponteiro da direção
    ; Vou usar o parâmetro BP original que foi passado na chamada
    mov al, 1               ; direção = direita
    jmp SET_DIRECTION

BOUNCE_RIGHT:
    ; chegou na borda direita, muda direção para esquerda  
    mov al, 0               ; direção = esquerda

SET_DIRECTION:
    ; BP original está na pilha, preciso acessar diferente
    ; Vou usar uma abordagem mais simples - usar a variável global alien_dir
    mov alien_dir, al       ; atualiza direção global

MOVE_BOUNCE_MENU:
    ; configura parâmetros para movimento
    push bx                 ; salva BX original
    push di                 ; salva DI original
    push cx                 ; salva CX original
    
    mov dl, alien_dir       ; DL = dir (0=esq, 1=dir)
    cmp dl, 1
    jz  MOVE_RIGHT_BOUNCE
    
    ; move para esquerda usando MOVE_LEFT_PROC
    mov ax, cx              ; AX = limite esquerdo em coordenada X (do stack)
    mov cx, 1               ; velocidade = 1 pixel  
    mov dx, ax              ; limite esquerdo em coordenada X
    call MOVE_LEFT_PROC
    jmp RESTORE_BOUNCE

MOVE_RIGHT_BOUNCE:
    ; move para direita usando MOVE_RIGHT_PROC
    mov cx, 1               ; velocidade = 1 pixel
    mov dx, di              ; limite direito em coordenada X
    call MOVE_RIGHT_PROC

RESTORE_BOUNCE:
    pop cx                  ; restaura CX
    pop di                  ; restaura DI
    pop bx                  ; restaura BX

DRAW_BOUNCE:
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
    mov bx, OFFSET ship_pos     ; ponteiro para posição da nave
    mov cx, ship_speed          ; velocidade da nave
    mov dx, 320 - SPR_W         ; limite direito
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
    mov ax, 4                       ; limite esquerdo (coordenada X)
    mov dx, 298                     ; limite direito (coordenada X)
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

    ; Ajusta posição da nave baseado na fase
    mov al, fase
    cmp al, 3
    jne SHIP_POS_NORMAL_RENDER
    mov ship_pos, ROW_SHIP_FASE3*320
    jmp SHIP_POS_SET_RENDER
SHIP_POS_NORMAL_RENDER:
    mov ship_pos, ship_pos_ini
SHIP_POS_SET_RENDER:
    
    ; Print Sector
    xor ax, ax
    mov al, fase

    cmp al, 4
    jne SUM_POINTS
SUM_POINTS:
    dec al ; number vector index

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

    ; Primeiro limpa todas as posições possíveis de vidas (3 posições)
    mov cx, LIFES_START         ; Limpa todas as 3 posições
    mov ax, 5 * SCREEN_W + 123  ; Posição inicial
    
CLEAR_LIVES_LOOP:
    push cx
    push ax
    mov di, ax
    call CLEAR_SPRITE           ; Limpa cada sprite de vida
    pop ax
    add ax, 25                  ; Próxima posição
    pop cx
    loop CLEAR_LIVES_LOOP

    ; Agora renderiza apenas as vidas restantes
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
    mov fase, ah              ; Atualiza a fase primeiro
    
    cmp ah, 4                 ; Verifica se passou da fase 3
    jae FINISH_GAME          ; Se sim, marca como completado
    
    ; Reseta o tempo para a nova fase
    mov time, SECONDS_START
    
    ; Reseta aliens ao mudar de fase
    call RESET_ALIENS
    
    ; Ajusta posição do terreno baseado na fase
    cmp ah, 3
    jne TERRAIN_POS_NORMAL_ADVANCE
    ; Fase 3: terreno mais baixo (linha 110) e inicializa torres
    mov terrain_pos, 0
    call INIT_FASE3_TOWERS
    jmp TERRAIN_POS_SET_ADVANCE
TERRAIN_POS_NORMAL_ADVANCE:
    ; Fases 1 e 2: terreno normal (linha 150)
    mov terrain_pos, 0
TERRAIN_POS_SET_ADVANCE:
    
    call RENDER_FASE
    
    jmp END_TIME

FINISH_GAME:
    ; Player completou todas as fases - fase agora é 4
    ; A verificação de vitória será feita no CHECK_GAME_END
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
    call RENDER_ALIENS
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

    cmp ah, 39H
    je FIRE
    
    cmp al, 'q'
    jne END_CONTROLS

    xor ax, ax
    int 16h
    call END_GAME

FIRE:
    call SHOOT
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
    mov bx, OFFSET ship_pos     ; ponteiro para posição da nave
    mov cx, ship_speed          ; velocidade da nave
    mov dx, 320 - SPR_W         ; limite direito
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
    push cx
    push si
    
    mov score, 0
    mov lives, LIFES_START
    mov fase, 1
    mov time, SECONDS_START
    mov timeout, 0
    mov terrain_pos, 0
    
    ; Reset all shots
    mov byte ptr [shot_active], 0
    mov byte ptr [shot_active + 1], 0
    mov byte ptr [shot_active + 2], 0
    
    ; Reset aliens
    call RESET_ALIENS
    
    ; Reset fase 3 towers
    call INIT_FASE3_TOWERS
    
    pop si
    pop cx
    pop ax
    ret
endp

; Sistema de Tiro Múltiplo (3 tiros)
SHOOT proc
    push ax
    push bx
    push cx
    push si

    ; Procura um slot livre para o tiro
    xor cx, cx
    mov cl, shot_count
    mov si, offset shot_active

FIND_FREE_SHOT:
    cmp byte ptr [si], 0    ; Verifica se este slot está livre
    je FOUND_FREE_SHOT
    inc si                  ; Próximo slot
    loop FIND_FREE_SHOT
    jmp END_SHOOT          ; Todos os slots ocupados

FOUND_FREE_SHOT:
    ; Calcula o índice do slot livre
    mov ax, si
    sub ax, offset shot_active  ; AX = índice do slot (0 ou 1)
    
    ; Ativa o tiro na posição da nave
    mov bx, ship_pos
    add bx, 29              ; Posição no nariz da nave (largura do sprite = 29)
    add bx, 320 * 6         ; Ajusta para o meio vertical da nave (altura/2 ≈ 6)
    
    ; Armazena a posição do tiro
    shl ax, 1               ; Multiplica por 2 (words são 2 bytes)
    mov si, offset shot_pos
    add si, ax
    mov [si], bx
    
    ; Marca o tiro como ativo
    shr ax, 1               ; Volta para índice original
    mov si, offset shot_active
    add si, ax
    mov byte ptr [si], 1

END_SHOOT:
    pop si
    pop cx
    pop bx
    pop ax
    ret
SHOOT endp


UPDATE_SHOT proc
    push di
    push si
    push ax
    push bx
    push cx
    push dx

    ; Loop através de todos os tiros
    xor cx, cx
    mov cl, shot_count

UPDATE_SHOT_LOOP:
    push cx                 ; Salva contador
    dec cx                  ; Converte para índice base 0
    
    ; Verifica se este tiro está ativo
    mov si, offset shot_active
    add si, cx
    cmp byte ptr [si], 1
    jne NEXT_SHOT
    
    ; Obtém a posição do tiro
    push cx                 ; Salva índice
    shl cx, 1               ; Multiplica por 2 (words)
    mov si, offset shot_pos
    add si, cx
    mov di, [si]            ; DI = posição atual do tiro
    pop cx                  ; Restaura índice

    ; Limpa a posição anterior do tiro
    call CLEAR_SHOT_SPRITE

    ; Calcula posição X atual
    mov ax, di
    mov bx, 320
    xor dx, dx
    div bx
    ; DX = posição X na linha
    
    ; Se posição X >= 310, desativa o tiro (mais conservador)
    cmp dx, 310
    jae DEACTIVATE_THIS_SHOT
    
    ; Move o tiro para direita (2 pixels)
    add di, 2
    
    ; Atualiza posição
    push cx
    shl cx, 1
    mov si, offset shot_pos
    add si, cx
    mov [si], di
    pop cx

    ; Renderiza o tiro na nova posição
    mov ax, di
    mov si, offset shot_sprite
    call RENDER_SHOT_SPRITE
    jmp NEXT_SHOT

DEACTIVATE_THIS_SHOT:
    ; Desativa este tiro específico
    mov si, offset shot_active
    add si, cx
    mov byte ptr [si], 0

NEXT_SHOT:
    pop cx                  ; Restaura contador
    loop UPDATE_SHOT_LOOP

    pop dx
    pop cx
    pop bx
    pop ax
    pop si
    pop di
    ret
UPDATE_SHOT endp

; Renderiza sprite da nave
; AX = posição na tela
; SI = offset do sprite
RENDER_SHOT_SPRITE proc
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
    mov dx, 6               ; Sprite do tiro tem 6 linhas de altura
    push ax

DRAW_SHOT_LINE:
    mov cx, 6              ; Cada linha do sprite tem 22 bytes
    rep movsb
    add di, SCREEN_W - 6   ; Ajusta para próxima linha (320 - 22)
    dec dx
    jnz DRAW_SHOT_LINE

    pop ax
    pop ds  
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    ret
RENDER_SHOT_SPRITE endp

; Limpa sprite do tiro na posição DI
CLEAR_SHOT_SPRITE proc
    push ax
    push cx
    push di
    push es
    
    mov ax, 0A000h
    mov es, ax
    mov cx, 6               ; Altura do sprite do tiro

CLEAR_SHOT_LINE:
    push cx
    mov cx, 6              ; Largura do sprite do tiro
    xor al, al              ; cor 0 (preto)
    rep stosb
    add di, SCREEN_W - 6   ; Próxima linha
    pop cx
    loop CLEAR_SHOT_LINE

    pop es
    pop di
    pop cx
    pop ax
    ret
CLEAR_SHOT_SPRITE endp


; Renderiza o terreno baseado na fase atual
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

    ; Verifica se é fase 3 (usa renderização procedural)
    mov al, fase
    cmp al, 3
    je RENDER_TERRAIN_FASE3

    ; Seleciona o terreno correto baseado na fase
    xor ax, ax
    mov al, fase
    dec al                      ; fase 1->0, fase 2->1
    shl al, 1                   ; multiplica por 2 (offsets são words)
    mov bx, offset terrain_vec
    add bx, ax
    mov si, [bx]               ; SI = offset do terreno da fase atual

    ; DI = posição inicial do terreno na tela (linha 150)
    mov di, 320*150
    
    ; SI já aponta para o offset do terreno
    ; Adiciona o scroll horizontal
    add si, terrain_pos
    
    ; Copia 50 linhas de 320 bytes
    mov cx, 50
COPY_TERRAIN_LINE:
    push cx
    push si
    push di
    
    mov cx, 320
    rep movsb
    
    pop di
    pop si
    pop cx
    
    add di, 320         ; Próxima linha na tela
    add si, 320         ; Próxima linha do terreno
    loop COPY_TERRAIN_LINE
    
    ; Atualiza scroll horizontal (1 pixel por frame)
    inc terrain_pos
    cmp terrain_pos, 320  ; Se completou uma linha
    jl TERRAIN_DONE_RENDER
    mov terrain_pos, 0    ; Reseta para início

TERRAIN_DONE_RENDER:
    pop ax
    pop ds  
    pop es
    pop di
    pop dx
    pop cx
    pop bx
    ret

RENDER_TERRAIN_FASE3:
    ; Renderização procedural para fase 3
    ; Limpa apenas a borda esquerda (onde torres saem)
    push ax
    push cx
    push di
    push es
    
    mov ax, 0A000h
    mov es, ax
    
    ; Limpa apenas primeiros pixels da borda esquerda (pequena margem)
    mov di, 70*320
    mov cx, 130
CLEAR_LEFT_EDGE:
    push cx
    push di
    mov cx, 5               ; Limpa apenas 5 pixels
    xor al, al
    rep stosb
    pop di
    pop cx
    add di, 320
    loop CLEAR_LEFT_EDGE
    
    pop es
    pop di
    pop cx
    pop ax
    
    ; Atualiza e renderiza torres
    call UPDATE_FASE3_TOWERS
    call RENDER_FASE3_TOWERS
    
    jmp TERRAIN_DONE_RENDER

endp


; Inicializa sistema de torres da fase 3
; Cria torres iniciais distribuídas pela tela
INIT_FASE3_TOWERS proc
    push ax
    push bx
    push cx
    push dx
    
    ; Inicializa torres preenchendo a tela toda (da direita para esquerda)
    xor bx, bx
    mov dx, 320                      ; Começa em X = 320 (borda direita)
    mov cx, MAX_TOWERS               ; 12 torres x 34 pixels = 408 pixels (cobre tela e mais)
    
INIT_TOWER_LOOP:
    ; Ativa torre
    mov byte ptr tower_active[bx], 1
    
    ; Define posição X
    push bx
    shl bx, 1                     ; BX = BX * 2
    mov word ptr tower_x_pos[bx], dx
    pop bx
    
    ; Altura aleatória (3 a 6 andares para início)
    push bx
    push cx
    push dx
    call RANDOM_UINT16
    and ax, 3               ; 0-3
    add al, 3               ; 3-6 andares
    pop dx
    pop cx
    pop bx
    mov byte ptr tower_heights[bx], al
    
    ; Próxima torre colada (BASE_WIDTH pixels à esquerda)
    sub dx, BASE_WIDTH
    
    inc bx
    loop INIT_TOWER_LOOP
    
    ; Reseta contadores
    ; Contador em 0 porque a primeira torre já está no ciclo correto
    mov next_tower_x, 320
    mov tower_spawn_counter, 0
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
INIT_FASE3_TOWERS endp


; Atualiza posição das torres e gera novas
UPDATE_FASE3_TOWERS proc
    push ax
    push bx
    push cx
    push dx
    
    ; Move todas as torres para esquerda
    xor bx, bx
    mov cx, MAX_TOWERS
MOVE_TOWERS_LOOP:
    cmp byte ptr tower_active[bx], 0
    je SKIP_MOVE_TOWER
    
    ; Calcula offset para tower_x_pos (word array)
    push bx
    shl bx, 1                     ; BX = BX * 2
    
    ; Move torre 1 pixel para esquerda
    dec word ptr tower_x_pos[bx]
    
    ; Verifica se saiu pela esquerda (X < -40)
    mov ax, word ptr tower_x_pos[bx]
    pop bx
    
    ; Se X >= 0, continua
    test ax, ax
    jns SKIP_MOVE_TOWER
    
    ; X é negativo, converte para positivo e verifica
    neg ax
    cmp ax, 40
    jl SKIP_MOVE_TOWER
    
    ; Torre saiu pela esquerda, desativa e será respawnada
    mov byte ptr tower_active[bx], 0
    
SKIP_MOVE_TOWER:
    inc bx
    loop MOVE_TOWERS_LOOP
    
    ; Verifica se deve gerar nova torre
    inc tower_spawn_counter
    mov ax, tower_spawn_counter
    cmp ax, tower_min_spacing
    jl SKIP_SPAWN_TOWER         ; Pula se counter < 34
    
    ; Reseta contador e gera nova torre
    mov tower_spawn_counter, 0
    call SPAWN_FASE3_TOWER
    
SKIP_SPAWN_TOWER:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
UPDATE_FASE3_TOWERS endp


; Gera uma nova torre aleatória
SPAWN_FASE3_TOWER proc
    push ax
    push bx
    push cx
    
    ; Procura slot vazio
    xor bx, bx
    mov cx, MAX_TOWERS
FIND_EMPTY_SLOT:
    cmp byte ptr tower_active[bx], 0
    je FOUND_EMPTY_SLOT
    inc bx
    loop FIND_EMPTY_SLOT
    jmp SPAWN_DONE  ; Sem slots vazios
    
FOUND_EMPTY_SLOT:
    ; Ativa torre
    mov byte ptr tower_active[bx], 1
    
    ; Posição X inicial (320 para spawnar fora e aparecer gradualmente)
    push bx
    shl bx, 1                     ; BX = BX * 2
    mov word ptr tower_x_pos[bx], 320  ; X = 320 (fora da tela)
    pop bx
    
    ; Gera altura aleatória (2 a 8 andares)
    call RANDOM_UINT16
    and ax, 7        ; AX = 0-7
    add al, 2        ; AL = 2-9
    mov byte ptr tower_heights[bx], al
    
SPAWN_DONE:
    pop cx
    pop bx
    pop ax
    ret
SPAWN_FASE3_TOWER endp


; Renderiza todas as torres ativas
RENDER_FASE3_TOWERS proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    xor bx, bx
    mov cx, MAX_TOWERS
RENDER_TOWERS_LOOP:
    cmp byte ptr tower_active[bx], 0
    je SKIP_RENDER_TOWER
    
    ; Renderiza esta torre
    push bx
    push cx
    
    xor ah, ah
    mov al, byte ptr tower_heights[bx]
    mov cx, ax                      ; CX = altura em andares
    
    ; Calcula offset para tower_x_pos (word array)
    push bx
    shl bx, 1                     ; BX = BX * 2
    mov dx, word ptr tower_x_pos[bx]  ; DX = posição X
    pop bx
    
    call RENDER_TOWER
    
    pop cx
    pop bx
    
SKIP_RENDER_TOWER:
    inc bx
    loop RENDER_TOWERS_LOOP
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
RENDER_FASE3_TOWERS endp


; Renderiza uma torre na posição especificada
; Entrada: CX = altura (número de andares), DX = posição X
RENDER_TOWER proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    push bp
    push es
    
    ; Garante direção forward para movsb
    cld
    
    ; Configura ES para apontar para memória de vídeo
    mov ax, 0A000h
    mov es, ax
    
    ; Verifica se torre está visível (permite renderização parcial)
    cmp dx, -BASE_WIDTH
    jl TOWER_NOT_VISIBLE_JMP
    cmp dx, 320
    jge TOWER_NOT_VISIBLE_JMP
    jmp TOWER_VISIBLE
    
TOWER_NOT_VISIBLE_JMP:
    jmp TOWER_NOT_VISIBLE
    
TOWER_VISIBLE:
    
    push cx                 ; Salva altura da torre original
    
    ; Calcula clipping horizontal usando variáveis globais
    ; DX = X da torre (pode ser negativo)
    mov tower_sprite_offset, 0
    mov ax, BASE_WIDTH
    mov tower_render_width, ax
    
    ; Verifica se X < 0 (saindo pela esquerda)
    cmp dx, 0
    jge CLIP_RIGHT_CHECK
    
    ; X negativo: calcula offset e ajusta
    mov ax, dx
    neg ax                      ; AX = |X|
    mov tower_sprite_offset, ax ; Offset = |X|
    mov bx, BASE_WIDTH
    sub bx, ax                  ; BX = largura - offset
    mov tower_render_width, bx
    mov dx, 0                   ; Desenha a partir de X=0
    jmp CLIP_DONE
    
CLIP_RIGHT_CHECK:
    ; Verifica se ultrapassa borda direita
    mov ax, dx
    add ax, BASE_WIDTH
    cmp ax, 320
    jle CLIP_DONE
    ; Ajusta largura
    mov ax, 320
    sub ax, dx                  ; AX = 320 - X
    mov tower_render_width, ax
    
CLIP_DONE:
    
    ; Calcula posição Y inicial (topo da torre)
    ; Y_topo = ROW_TERRAIN_FASE3 - (altura * BASE_HEIGHT)
    mov ax, cx
    mov bl, BASE_HEIGHT
    mul bl                  ; AX = altura * BASE_HEIGHT (tamanho total em pixels)
    mov bx, ROW_TERRAIN_FASE3
    sub bx, ax              ; BX = linha do terreno - altura total
    
    ; Permite torres altas que começam acima da tela
    cmp bx, 0
    jge TOWER_Y_OK
    xor bx, bx              ; Y inicial = 0
TOWER_Y_OK:
    
    ; Calcula offset linear: Y * 320 + X
    push dx                 ; Salva X na stack
    mov ax, bx              ; AX = Y inicial (topo da torre)
    mov bx, 320
    mul bx                  ; DX:AX = Y * 320
    pop bx                  ; BX = X
    add ax, bx              ; AX = Y * 320 + X
    mov di, ax              ; DI = posição inicial
    
    ; Calcula total de andares a renderizar
    pop ax                  ; AX = altura original da torre
    mov bp, ax              ; BP = altura da torre
    add ax, 6               ; +6 andares de preenchimento
    mov cx, ax              ; CX = total de andares
    
RENDER_FLOOR_LOOP:
    push cx
    push bp
    
    ; Verifica se é o primeiro andar (topo da torre)
    ; CX começa com o valor máximo (altura + 6)
    mov ax, bp
    add ax, 6               ; Total de andares
    cmp cx, ax
    pop bp
    jne RENDER_BASE_ANDAR_2
    
    ; Renderiza TOPO
    push di
    mov si, offset topo
    
    ; Adiciona offset do sprite (pixels a pular)
    add si, tower_sprite_offset
    
    mov cx, BASE_HEIGHT
RENDER_TOP_LINE_LOOP:
    push cx
    push di
    push si
    
    mov cx, tower_render_width  ; Largura a renderizar
    rep movsb                   ; Copia CX pixels
    
    pop si
    add si, BASE_WIDTH          ; Próxima linha do sprite
    pop di
    pop cx
    add di, 320                 ; Próxima linha da tela
    loop RENDER_TOP_LINE_LOOP
    pop di
    jmp NEXT_FLOOR
    
RENDER_BASE_ANDAR_2:
    ; Renderiza andar da BASE (usado tanto para torre quanto preenchimento)
    push di
    mov si, offset base
    
    ; Adiciona offset do sprite (pixels a pular)
    add si, tower_sprite_offset
    
    mov cx, BASE_HEIGHT
RENDER_BASE_LINE_LOOP:
    push cx
    push di
    push si
    
    mov cx, tower_render_width  ; Largura a renderizar
    rep movsb                   ; Copia CX pixels
    
    pop si
    add si, BASE_WIDTH          ; Próxima linha do sprite
    pop di
    pop cx
    add di, 320                 ; Próxima linha da tela
    loop RENDER_BASE_LINE_LOOP
    pop di
    
NEXT_FLOOR:
    ; Move para o próximo andar (descendo na tela)
    mov ax, BASE_HEIGHT
    mov bx, 320
    mul bx
    add di, ax          ; DI += BASE_HEIGHT * 320
    
    pop cx
    loop RENDER_FLOOR_LOOP
    jmp TOWER_DONE
    
TOWER_NOT_VISIBLE:
    ; Torre não visível, não faz nada
    
TOWER_DONE:
    pop es
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
RENDER_TOWER endp

; Exibe tela de Game Over (vidas = 0)
SHOW_GAME_OVER proc
    push ax
    push bx
    push cx
    push dx
    push si
    
    call CLEAR_SCREEN
    xor cx, cx
    mov cx, 1Eh
    mov dx, 2710H
    mov ah, 86H
    int 15h
    ; Configura ES para apontar para o segmento de dados
    mov ax, ds 
    mov es, ax
    
    ; Exibe mensagem Game Over em vermelho
    mov bp, offset game_over_msg
    mov cx, game_over_msg_length ; tamanho
    mov bl, 0Ch     ; cor vermelha
    mov dx, 320*3 ; linha / coluna
    call PRINT_STRING
    
    ; ; Move cursor para baixo
    ; mov ah, 02h
    ; mov bh, 0
    ; mov dh, 15      ; linha 15
    ; mov dl, 5       ; coluna 5
    ; int 10h
    
    ; Exibe mensagem para pressionar tecla em branco
    ; mov bp, offset press_key_msg
    ; mov cx, 999     ; tamanho grande
    ; mov bl, 0Fh     ; cor branca
    ; call PRINT_STRING
    
    mov bp, offset press_key_msg
    mov cx, press_key_msg_length ; tamanho correto
    mov bl, 0Fh     ; cor branca
    mov dx, 320*18 ; linha 18, coluna 8 (centralizado)
    call PRINT_STRING

    ; Aguarda tecla
    call WAIT_KEY
    call WAIT_KEY
    call CLEAR_SCREEN
    
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
SHOW_GAME_OVER endp

; Exibe tela de Vitória (completou todas as fases)
SHOW_VICTORY proc
    push ax
    push bx
    push cx
    push dx
    push si
    
    call CLEAR_SCREEN
    xor cx, cx
    mov cx, 1Eh
    mov dx, 2710H
    mov ah, 86H
    int 15h
    ; Configura ES para apontar para o segmento de dados
    mov ax, ds 
    mov es, ax
    
    ; Exibe mensagem Vencedor em verde
    mov bp, offset vencedor_msg
    mov cx, vencedor_msg_length ; tamanho correto
    mov bl, 0Ah     ; cor verde
    mov dx, 320*5 ; linha 5
    call PRINT_STRING
    
    ; Exibe score final em branco
    mov bp, offset final_score_msg
    mov cx, final_score_msg_length ; tamanho correto
    mov bl, 0Fh     ; cor branca
    mov dx, 320*12 + 10 ; linha 12, coluna 15 (centralizado)
    call PRINT_STRING
    
    ; Converte e exibe o score
    mov ax, score
    mov si, offset score_buffer + 4  ; final do buffer
    mov cx, 5                        ; 5 dígitos
    call CONVERT_UINT16
    
    mov bp, offset score_buffer
    mov cx, 5       ; 5 dígitos
    mov bl, 0Fh     ; cor branca
    mov dx, 320*12 + 23 ; linha 12, coluna 28 (logo após "SCORE FINAL: ")
    call PRINT_STRING
    
    ; Exibe mensagem para pressionar tecla
    mov bp, offset press_key_msg
    mov cx, press_key_msg_length ; tamanho correto
    mov bl, 0Fh     ; cor branca
    mov dx, 320*18 ; linha 18, coluna 8 (centralizado)
    call PRINT_STRING
    ; Aguarda tecla
    call WAIT_KEY
    call WAIT_KEY
    call CLEAR_SCREEN
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
SHOW_VICTORY endp

; Aguarda qualquer tecla ser pressionada
WAIT_KEY proc
    push ax
    
WAIT_KEY_LOOP:
    mov ah, 01h     ; verifica se há tecla disponível
    int 16h
    jz WAIT_KEY_LOOP  ; se não há tecla, continua aguardando
    
    mov ah, 00h     ; lê a tecla
    int 16h
    
    pop ax
    ret
WAIT_KEY endp

; Verifica condições de fim de jogo
; Retorna: AL = 0 (continua), 1 (game over), 2 (vitória)
CHECK_GAME_END proc
    push bx
    
    ; Verifica se perdeu todas as vidas
    cmp lives, 0
    je GAME_OVER_CONDITION
    
    ; Verifica se completou todas as fases (fase > 3)
    cmp fase, 3
    ja VICTORY_CONDITION
    
    ; Jogo continua
    mov al, 0
    jmp END_CHECK
    
GAME_OVER_CONDITION:
    mov al, 1
    jmp END_CHECK
    
VICTORY_CONDITION:
    mov al, 2
    
END_CHECK:
    pop bx
    ret
CHECK_GAME_END endp

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
    
    ; Verifica limites (até linha 135, deixando espaço antes do terreno)
    mov bx, [ship_pos]
    cmp bx, 320 * 135
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
    ; Entradas:
    ;   BX = ponteiro para posição (ex.: OFFSET alien_pos)
    ;   CX = velocidade (ex.: 1)
    ;   DX = limite direito em coordenada X (ex.: 320-SPR_W)
    push di
    push si
    push ax
    push dx
    push cx
    push bp

    mov bp, cx              ; BP = velocidade
    mov di, dx              ; DI = limite direito

    ; Verifica limites: x = pos % 320
    mov ax, [bx]            ; AX = posição atual
    xor dx, dx
    mov cx, 320
    div cx                  ; DX = coordenada X
    
    cmp dx, di              ; compara com limite direito
    jae END_RIGHT
    
    ; Move para a direita
    mov si, bx              ; SI = ponteiro para posição
    xor ah, ah              ; direção positiva (direita)
    mov bx, bp              ; BX = velocidade
    mov al, 0               ; eixo X
    call MOVE_SPRITE

END_RIGHT:
    pop bp
    pop cx
    pop dx
    pop ax
    pop si
    pop di
    ret
endp

; ==================== SISTEMA DE ALIENS (PADRÃO K-STAR PATROL) ====================

; Reseta sistema de aliens
RESET_ALIENS proc
    push ax
    push bx
    push cx
    
    mov alien_spawn_timer, 0
    
    ; Quantidade baseada na fase: 4 (fase 1) ou 5 (fases 2 e 3)
    mov cx, 4
    cmp fase, 2
    je RESET_ALIENS_5
    cmp fase, 3
    je RESET_ALIENS_5
    jmp RESET_ALIENS_START
RESET_ALIENS_5:
    mov cx, 5
RESET_ALIENS_START:
    xor bx, bx
    
RESET_ALIENS_LOOP:
    mov byte ptr [alien_array_active + bx], 0
    shl bx, 1
    mov word ptr [alien_array_pos + bx], 0
    shr bx, 1
    inc bx
    dec cx
    jnz RESET_ALIENS_LOOP
    
    ; Força spawn imediato de 1 alien para teste
    call SPAWN_ALIEN
    
    pop cx
    pop bx
    pop ax
    ret
endp

; Atualiza sistema de aliens
UPDATE_ALIENS proc
    push ax
    push bx
    push cx
    push dx
    
    ; Incrementa timer
    inc alien_spawn_timer
    
    ; Verifica spawn (delay baseado na fase)
    mov ax, alien_spawn_timer
    mov dx, alien_spawn_delay
    cmp fase, 2
    je USE_FASE2_DELAY
    cmp fase, 3
    je USE_FASE3_DELAY
    jmp USE_NORMAL_DELAY
USE_FASE2_DELAY:
    mov dx, meteor_spawn_delay  ; Fase 2: spawn meteoros
    jmp USE_NORMAL_DELAY
USE_FASE3_DELAY:
    mov dx, alien_fase3_spawn_delay  ; Fase 3: spawn mais rápido
USE_NORMAL_DELAY:
    cmp ax, dx
    jb UPDATE_EXISTING_ALIENS
    
    ; Reset timer e spawna
    mov alien_spawn_timer, 0
    call SPAWN_ALIEN
    
UPDATE_EXISTING_ALIENS:
    ; Move aliens/meteoros existentes
    ; Quantidade baseada na fase: 4 (fase 1) ou 5 (fases 2 e 3)
    mov cx, 4
    cmp fase, 2
    je UPDATE_ALIENS_5
    cmp fase, 3
    je UPDATE_ALIENS_5
    jmp UPDATE_ALIENS_START
UPDATE_ALIENS_5:
    mov cx, 5
UPDATE_ALIENS_START:
    xor bx, bx
    
UPDATE_ALIENS_LOOP:
    cmp byte ptr [alien_array_active + bx], 0
    je NEXT_UPDATE_ALIEN
    
    ; Pega posição do alien (BX * 2 para word array)
    push bx
    shl bx, 1
    mov ax, word ptr [alien_array_pos + bx]
    pop bx
    
    ; Verifica se X >= 2 para evitar underflow
    push ax
    push bx
    xor dx, dx
    mov bx, 320
    div bx              ; ax = y, dx = x
    pop bx
    
    cmp dx, 2
    pop ax              ; recupera posição original
    jb REMOVE_ALIEN
    
    ; Move para esquerda (velocidade baseada na fase)
    push bx
    mov bx, alien_move_speed
    cmp fase, 2
    je USE_FASE2_SPEED
    cmp fase, 3
    je USE_FASE3_SPEED
    jmp USE_NORMAL_SPEED
USE_FASE2_SPEED:
    mov bx, meteor_move_speed  ; Fase 2: meteoros
    jmp USE_NORMAL_SPEED
USE_FASE3_SPEED:
    mov bx, alien_fase3_move_speed  ; Fase 3: aliens mais rápidos
USE_NORMAL_SPEED:
    sub ax, bx
    pop bx
    
    push bx
    shl bx, 1
    mov word ptr [alien_array_pos + bx], ax
    pop bx
    jmp NEXT_UPDATE_ALIEN
    
REMOVE_ALIEN:
    ; Limpa sprite do alien antes de desativar
    push bx
    shl bx, 1
    mov di, word ptr [alien_array_pos + bx]
    call CLEAR_SPRITE
    pop bx
    
    mov byte ptr [alien_array_active + bx], 0
    
NEXT_UPDATE_ALIEN:
    inc bx
    dec cx
    jnz UPDATE_ALIENS_LOOP
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
endp

; Spawna novo alien
SPAWN_ALIEN proc
    push ax
    push bx
    push cx
    push dx
    
    ; Procura slot livre (quantidade baseada na fase: 4 (fase 1) ou 5 (fases 2 e 3))
    mov cx, 4
    cmp fase, 2
    je SPAWN_ALIEN_5
    cmp fase, 3
    je SPAWN_ALIEN_5
    jmp SPAWN_ALIEN_START
SPAWN_ALIEN_5:
    mov cx, 5
SPAWN_ALIEN_START:
    xor bx, bx
    
FIND_SLOT:
    cmp byte ptr [alien_array_active + bx], 0
    je FOUND_SLOT
    inc bx
    dec cx
    jnz FIND_SLOT
    jmp END_SPAWN
    
FOUND_SLOT:
    ; BX contém o índice do slot livre (0-3)
    push bx             ; Salva índice do slot
    
    ; Gera Y aleatório baseado na fase
    call RANDOM_UINT16
    xor dx, dx          ; Zera DX para divisão
    
    ; Fase 3: espaço vertical seguro (linha 25-60)
    ; HUD está nas linhas 0-20, torres começam em Y~78
    ; Aliens devem ficar entre a HUD e as torres
    cmp fase, 3
    jne SPAWN_ALIEN_NORMAL_Y
    mov cx, 36          ; Divisor para fase 3 (36 linhas de espaço)
    div cx              ; AX / CX, resto em DX
    mov ax, dx          ; Usa resto (0-35)
    add ax, 25          ; Y entre 25-60 (área segura)
    jmp SPAWN_ALIEN_CALC_POS
    
SPAWN_ALIEN_NORMAL_Y:
    ; Fases 1 e 2: Y entre 20-130
    mov cx, 110         ; Divisor em CX
    div cx              ; AX / CX, resto em DX
    mov ax, dx          ; Usa resto (0-109)
    add ax, 20          ; Y entre 20-129
    
SPAWN_ALIEN_CALC_POS:
    
    ; Calcula posição: Y*320 + X
    ; X = 298 (320 - 22 = 298, garante sprite dentro da tela)
    mov cx, 320
    mul cx              ; AX = Y * 320, resultado em DX:AX
    add ax, 298         ; Adiciona X=298 (lado direito, sprite completo visível)
    
    ; Ativa alien
    pop bx              ; Recupera índice do slot
    mov byte ptr [alien_array_active + bx], 1
    shl bx, 1           ; BX *= 2 para word array
    mov word ptr [alien_array_pos + bx], ax
    
END_SPAWN:
    pop dx
    pop cx
    pop bx
    pop ax
    ret
endp

; Verifica sobreposição entre aliens
; Entrada: AX = Y do novo alien
; Retorna: AL = 1 se há sobreposição, 0 caso contrário
CHECK_ALIEN_OVERLAP proc
    push bx
    push cx
    push dx
    push si
    
    mov si, ax          ; SI = Y do novo alien
    mov cx, 4
    xor bx, bx
    
CHECK_OVERLAP_LOOP:
    cmp byte ptr [alien_array_active + bx], 0
    je NEXT_CHECK_OVERLAP
    
    ; Calcula Y do alien existente
    push bx
    shl bx, 1
    mov ax, word ptr [alien_array_pos + bx]
    pop bx
    
    push bx
    mov bx, 320
    xor dx, dx
    div bx              ; ax = y
    pop bx
    
    ; Verifica distância
    sub ax, si
    cmp ax, 0
    jge POSITIVE_DIST
    neg ax
POSITIVE_DIST:
    cmp ax, 25
    jb OVERLAP_FOUND
    
NEXT_CHECK_OVERLAP:
    inc bx
    dec cx
    jnz CHECK_OVERLAP_LOOP
    
    mov al, 0
    jmp END_CHECK_OVERLAP
    
OVERLAP_FOUND:
    mov al, 1
    
END_CHECK_OVERLAP:
    pop si
    pop dx
    pop cx
    pop bx
    ret
endp

; Renderiza aliens/meteoros
RENDER_ALIENS proc
    push ax
    push bx
    push cx
    push si
    
    ; Quantidade baseada na fase: 4 (fase 1) ou 5 (fases 2 e 3)
    mov cx, 4
    cmp fase, 2
    je RENDER_ALIENS_5
    cmp fase, 3
    je RENDER_ALIENS_5
    jmp RENDER_ALIENS_START
RENDER_ALIENS_5:
    mov cx, 5
RENDER_ALIENS_START:
    xor bx, bx
    
RENDER_ALIENS_LOOP:
    cmp byte ptr [alien_array_active + bx], 0
    je NEXT_RENDER_ALIEN
    
    push bx
    shl bx, 1
    mov ax, word ptr [alien_array_pos + bx]
    pop bx
    
    ; Escolhe sprite baseado na fase
    cmp fase, 2
    je USE_METEOR_SPRITE
    ; Fases 1 e 3 usam alien sprite
    mov si, offset alien_sprite
    jmp DRAW_ENEMY
USE_METEOR_SPRITE:
    mov si, offset meteor_sprite
DRAW_ENEMY:
    call RENDER_SPRITE
    
NEXT_RENDER_ALIEN:
    inc bx
    dec cx
    jnz RENDER_ALIENS_LOOP
    
    pop si
    pop cx
    pop bx
    pop ax
    ret
endp

; Verifica colisões tiros vs aliens/meteoros
CHECK_ALIEN_SHOT_COLLISION proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    ; Quantidade baseada na fase: 4 (fase 1) ou 5 (fases 2 e 3)
    mov cx, 4
    cmp fase, 2
    je CHECK_SHOT_COLLISION_5
    cmp fase, 3
    je CHECK_SHOT_COLLISION_5
    jmp CHECK_SHOT_COLLISION_START
CHECK_SHOT_COLLISION_5:
    mov cx, 5
CHECK_SHOT_COLLISION_START:
    xor bx, bx
    
CHECK_COLLISION_ALIEN_LOOP:
    cmp byte ptr [alien_array_active + bx], 0
    jne CHECK_ALIEN_ACTIVE
    jmp NEXT_COLLISION_ALIEN
CHECK_ALIEN_ACTIVE:
    
    ; Posição do alien
    push bx
    shl bx, 1
    mov di, word ptr [alien_array_pos + bx]
    pop bx
    
    ; Verifica cada tiro
    push cx
    push bx
    
    mov cl, shot_count
    xor ch, ch
    xor si, si
    
CHECK_COLLISION_SHOT_LOOP:
    cmp byte ptr [shot_active + si], 0
    je NEXT_COLLISION_SHOT
    
    ; Posição do tiro
    push si
    shl si, 1
    mov ax, word ptr [shot_pos + si]
    pop si
    
    ; Verifica colisão
    call CHECK_COLLISION_XY
    cmp al, 1
    jne NEXT_COLLISION_SHOT
    
    ; Colisão detectada! Chama handler apropriado
    cmp fase, 2
    je CALL_METEOR_HIT
    call HANDLE_ALIEN_DESTROYED
    jmp END_COLLISION_CHECK
CALL_METEOR_HIT:
    call HANDLE_METEOR_HIT
END_COLLISION_CHECK:
    pop bx
    pop cx
    jmp NEXT_COLLISION_ALIEN
    
NEXT_COLLISION_SHOT:
    inc si
    dec cl
    jnz CHECK_COLLISION_SHOT_LOOP
    
    pop bx
    pop cx
    
NEXT_COLLISION_ALIEN:
    inc bx
    dec cx
    cmp cx, 0
    jne CHECK_COLLISION_ALIEN_LOOP
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
endp

; Handler para alien destruído (fases 1 e 3)
; Entrada: BX = índice do alien, SI = índice do tiro
HANDLE_ALIEN_DESTROYED proc
    push ax
    push bx
    push si
    push di
    
    ; Limpa sprite do alien
    push bx
    shl bx, 1
    mov di, word ptr [alien_array_pos + bx]
    call CLEAR_SPRITE
    pop bx
    
    ; Limpa sprite do tiro
    push si
    shl si, 1
    mov di, word ptr [shot_pos + si]
    call CLEAR_SHOT_SPRITE
    pop si
    
    ; Desativa alien e tiro
    mov byte ptr [alien_array_active + bx], 0
    mov byte ptr [shot_active + si], 0
    
    ; Pontuação: 100 (fase 1) ou 150 (fase 3)
    cmp fase, 3
    je ALIEN_SCORE_150
    add score, 100
    jmp END_ALIEN_SCORE
ALIEN_SCORE_150:
    add score, 150
END_ALIEN_SCORE:
    
    pop di
    pop si
    pop bx
    pop ax
    ret
endp

; Handler para meteoro atingido (fase 2)
; Entrada: SI = índice do tiro
HANDLE_METEOR_HIT proc
    push si
    push di
    
    ; Limpa sprite do tiro apenas
    push si
    shl si, 1
    mov di, word ptr [shot_pos + si]
    call CLEAR_SHOT_SPRITE
    pop si
    
    ; Desativa tiro (meteoro continua ativo)
    mov byte ptr [shot_active + si], 0
    
    pop di
    pop si
    ret
endp

; Verifica colisões nave vs aliens/meteoros
CHECK_ALIEN_SHIP_COLLISION proc
    push ax
    push bx
    push cx
    push di
    
    ; Quantidade baseada na fase: 4 (fase 1) ou 5 (fases 2 e 3)
    mov cx, 4
    cmp fase, 2
    je CHECK_SHIP_COLLISION_5
    cmp fase, 3
    je CHECK_SHIP_COLLISION_5
    jmp CHECK_SHIP_COLLISION_START
CHECK_SHIP_COLLISION_5:
    mov cx, 5
CHECK_SHIP_COLLISION_START:
    xor bx, bx
    
CHECK_SHIP_COLLISION_LOOP:
    cmp byte ptr [alien_array_active + bx], 0
    je NEXT_SHIP_COLLISION
    
    ; Posição do alien
    push bx
    shl bx, 1
    mov di, word ptr [alien_array_pos + bx]
    pop bx
    
    ; Posição da nave
    mov ax, ship_pos
    
    ; Verifica colisão
    call CHECK_COLLISION_XY
    cmp al, 1
    jne NEXT_SHIP_COLLISION
    
    ; Colisão! Perde vida
    ; Limpa sprite do alien da tela
    push bx
    shl bx, 1
    mov di, word ptr [alien_array_pos + bx]
    call CLEAR_SPRITE
    pop bx
    
    mov byte ptr [alien_array_active + bx], 0
    dec lives
    
    ; Atualiza exibição de vidas na tela
    call RENDER_LIVES
    
NEXT_SHIP_COLLISION:
    inc bx
    dec cx
    jnz CHECK_SHIP_COLLISION_LOOP
    
    pop di
    pop cx
    pop bx
    pop ax
    ret
endp

; Verifica colisão entre dois objetos
; Entrada: AX = posição 1, DI = posição 2
; Retorna: AL = 1 se colidiu, 0 caso contrário
CHECK_COLLISION_XY proc
    push bx
    push cx
    push dx
    push si
    
    ; Calcula X,Y do objeto 1
    mov bx, 320
    xor dx, dx
    div bx              ; ax = y1, dx = x1
    mov cx, ax          ; cx = y1
    mov si, dx          ; si = x1
    
    ; Calcula X,Y do objeto 2
    mov ax, di
    xor dx, dx
    div bx              ; ax = y2, dx = x2
    
    ; Distância X
    sub si, dx
    cmp si, 0
    jge ABS_X
    neg si
ABS_X:
    cmp si, 20
    ja NO_COLLISION_XY
    
    ; Distância Y
    sub cx, ax
    cmp cx, 0
    jge ABS_Y
    neg cx
ABS_Y:
    cmp cx, 15
    ja NO_COLLISION_XY
    
    mov al, 1
    jmp END_COLLISION_XY
    
NO_COLLISION_XY:
    mov al, 0
    
END_COLLISION_XY:
    pop si
    pop dx
    pop cx
    pop bx
    ret
endp

end MAIN
