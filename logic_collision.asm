
; Collision -------------------------------------------------------------------
logic_collision_x:

        ldx    #$00

        ; left
        lda    player_x
        sec
        sbc    #$06
        cmp    #$08 ; do a tile compare here
        bne    @no_col_left

        inx
        inx

@no_col_left:

        ; right
        lda    player_x
        clc
        adc    #$06
        cmp    #$FA ; do a tile compare here
        bne    @no_col_right
        
        inx

@no_col_right:
        txa
        rts

logic_collision_y:

        ldx    #$00

        ; top
        lda    player_y
        sec
        sbc    #$0C
        cmp    #$08 ; do a tile compare here
        bne    @no_col_top

        inx

@no_col_top:

        ; bottom
        lda    player_y
        cmp    #$E0 ; do a tile compare here
        bne    @no_col_bottom
        
        inx
        inx

@no_col_bottom:
        txa
        rts

