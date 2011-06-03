
data_palette:
        ;; Background palette
        .byte   $00,$1D,$30,$10
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

data_player_sprites:
        .byte   $00,$02,$04,$06

