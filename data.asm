
data_palette:
        ;; Background palette
        .byte   $06,$02,$03,$04
        .byte   $10,$3D,$20,$30
        .byte   $0F,$39,$3A,$3B
        .byte   $0F,$3D,$3E,$0F

        ; Sprite palette
        .incbin "graphics/tuff.plt"     ; The tuff palette
        .byte   $42,$42,$42,$42
        .byte   $00,$1D,$10,$30
        .byte   $00,$1D,$10,$30

data_sprites:
        ;vert tile attr horiz
        .byte   $00,$02,$00,$00
        .byte   $00,$03,$00,$00
        .byte   $00,$12,$00,$00
        .byte   $00,$13,$00,$00

; offsets into the chr bank for playrr images
data_player_sprites:
        .byte   $00,$02,$04,$06, $08,$0A,$0C,$0E
        .byte   $20,$22,$24,$26, $28,$2A,$2C,$2E
        .byte   $40,$42,$44,$46, $48,$4A,$4C,$4E
        .byte   $60,$62,$64,$66, $68,$6A,$6C,$6E


data_player_animation:

        ; 0: idle
        .byte   $00,$01,$00,$01, $00,$02,$00,$01 ; image ids
        .byte   $E0,$08,$07,$09, $A0,$35,$C0,$08 ; time in frames

        ; 1: walking
        .byte   $04,$05,$06,$07, $FF,$FF,$FF,$FF
        .byte   $04,$05,$04,$06, $FF,$FF,$FF,$FF

        ; these two should be reduced in size?!?
        ; 2: jumping
        .byte   $08,$FF,$FF,$FF, $FF,$FF,$FF,$FF
        .byte   $20,$FF,$FF,$FF, $FF,$FF,$FF,$FF
        
        ; 3: falling
        .byte   $0A,$FF,$FF,$FF, $FF,$FF,$FF,$FF
        .byte   $20,$FF,$FF,$FF, $FF,$FF,$FF,$FF

        ; 4. sleeping
        .byte   $0C,$0D,$0E,$0F, $FF,$FF,$FF,$FF
        .byte   $30,$35,$50,$40, $FF,$FF,$FF,$FF
        
