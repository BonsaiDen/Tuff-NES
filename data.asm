
data_palette:
        .incbin "graphics/tuff.plt"     ; The tuff palette

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
        
        ; TODO make these smaller by defining a length...

        ; 0: idle
        .byte   $00,$01,$00,$01, $00,$02,$00,$01 ; image ids
        .byte   $F0,$08,$07,$09, $B0,$35,$D0,$08 ; time in frames

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
        .byte   $20,$25,$20,$25, $FF,$FF,$FF,$FF
        

; tiles are saved in 16x16 pixels blocks;
; so the need to get constructed from the few 8x8 ones in the chr bank
; tile ID is 0-23
; that takes 5 bytes, the other 3 are used for special stuff 
; (todo: figure out the special stuff)
data_tiles:
        
        ; 16 full borders
        .byte    4,4,4,4 ; none
        .byte    1,1,4,4 ; top
        .byte    4,5,4,5 ; right
        .byte    1,2,4,5 ; top right

        .byte    4,4,7,7 ; bottom
        .byte    1,1,7,7 ; top bottom
        .byte    4,5,7,8 ; bottom right
        .byte    1,2,7,8 ; top right bttom

        .byte    3,4,3,4 ; left
        .byte    0,1,3,4 ; top left
        .byte    3,5,3,5 ; left right
        .byte    0,2,3,5 ; left top right

        .byte    3,4,6,7 ; left bottom
        .byte    0,1,6,7 ; bottom left top
        .byte    3,5,6,8 ; left bottom right
        .byte    0,2,6,8 ; all

        ; 16 edges (and background)
        .byte   13,13,13,13 ; background
        .byte    9, 4, 4, 4 ; top left
        .byte    4,10, 4, 4 ; top right
        .byte    9,10, 4, 4 ; top left, top right

        .byte    4, 4, 4,12 ; bottom right
        .byte    9, 4, 4,10 ; top left, bottom right
        .byte    4,10, 4,12 ; top right, bottom right
        .byte    9,10, 4,12 ; top left, top right, bottom right

        .byte    4, 4,11, 4 ; bottom left
        .byte    9, 4,11, 4 ; top left, bottom left
        .byte    4,10,11, 4 ; top right, bottom left
        .byte    9,10,11, 4 ; top left, top right, bottom left

        .byte    4, 4,11,12 ; bottom left, bottom right
        .byte    9, 4,11,12 ; top left, bottom left, bottom right
        .byte    4,10,11,12 ; top right, bottom right, bottom left
        .byte    9,10,11,12 ; all

        ; 8 full + edges
        .byte    1, 1,11,12 ; top full, bottom edges
        .byte    9, 5,11, 5 ; right full, left edges

        .byte    1, 2,11, 5 ; top / right full, left/bottom edge
        .byte    9,10, 7, 7 ; top edges, bottom full

        .byte    9, 5, 7, 8 ; bottom / right full, top / left edge
        .byte    3,10, 3,12 ; left full / right edgges

        .byte    0, 1, 3,12 ; top / left full, bottom / right edge
        .byte    3,10, 6, 7 ; bottom / left full, top / right edge

        ; tunnel transistion n 4 where there is no tunnel and at least one sky
        .byte   22,21, 3, 4 ; up, left
        .byte   21,21, 4, 4; up, center
        .byte   21,24, 4, 5; up, right
 
        .byte    3, 4,23,20; down, left
        .byte    4, 4,20,20; down, center
        .byte    4, 5,20,25; down, right

        .byte   16, 1,20, 4; left, top
        .byte   20, 4,20, 4; left, center
        .byte   20, 4,28, 7; left, bottom

        .byte    1,17, 4,21; right, top
        .byte    4,21, 4,21; right, center
        .byte    4,21, 7,29; right, bottom

