
draw:
        jsr    draw_player_sprites

        lda    #$00
        sta    $2003  ; set the low byte (00) of the RAM address
        lda    #$02
        sta    $4014  ; set the high byte (02) of the RAM address, start the transfer

        rts

; Update the 4 player sprites; YTSX
draw_player_sprites:

        lda    #$00
        ora    player_palette
        ldx    player_direction
        cpx    #$00

        ; normal direction (left)
        beq    @left

        ; otherwise set direction to right
        ora    #%01000000

@left:
        ; set sprite status to mirrored
        ldx    #$08
        sta    player_sprite +  2
        sta    player_sprite +  6
        sta    player_sprite + 10
        sta    player_sprite + 14

        ; check direction again, this time we need to update the sprite positions...
        ldx    player_direction
        cpx    #$00
        beq    @normal

        ; set the mirrored positions
        lda    player_x
        sta    player_sprite +  3 ; top left
        sta    player_sprite + 11 ; bottom left
        sec
        sbc    #$08
        sta    player_sprite +  7 ; top right
        sta    player_sprite + 15 ; bottom right

        jmp    @vertical; skip normal drawing

@normal:

        lda    player_x
        sta    player_sprite +  7 ; top right
        sta    player_sprite + 15 ; bottom right
        sec
        sbc    #$08
        sta    player_sprite +  3 ; top left
        sta    player_sprite + 11 ; bottom left

@vertical:

        ; position sprites vertically
        lda    player_y
        sec
        sbc    #$08

        sta    player_sprite +  8 ; bottom left
        sta    player_sprite + 12 ; bottom right

        sec
        sbc    #$08
        sta    player_sprite      ; top left
        sta    player_sprite +  4 ; top right
        
        ; set tile images
        ldx    player_image
        lda    data_player_sprites, x
        clc

        sta    player_sprite + 1
        adc    #$01

        sta    player_sprite + 5
        adc    #$0F

        sta    player_sprite + 9
        adc    #$01

        sta    player_sprite + 13

        rts

