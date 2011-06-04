
; TODO reset move interval when both speeds are 0?

; Move ------------------------------------------------------------------------
logic_move:

        dec    move_inc_tick_counter
        bne    @no_inc_tick
        
        jsr    logic_increase_speed

        lda    #MOVE_INC_INTERVAL
        sta    move_inc_tick_counter

@no_inc_tick:

        dec    move_dec_tick_counter
        bne    @no_dec_tick
        
        jsr    logic_decrease_speed

        lda    #MOVE_DEC_INTERVAL
        sta    move_dec_tick_counter

@no_dec_tick:

        jsr    logic_move_right
        jsr    logic_move_left
        rts


logic_increase_speed:

        lda    buttons
        and    #%0000001
        beq    @no_right

        ; increase until maximum is reached
        lda    player_speed_right
        cmp    #PLAYER_SPEED_MAX
        beq    @no_right
        inc    player_speed_right

@no_right:

        lda    buttons
        and    #%0000010
        beq    @no_left

        ; increase until maximum is reached
        lda    player_speed_left
        cmp    #PLAYER_SPEED_MAX
        beq    @no_left
        inc    player_speed_left

@no_left:
        rts

logic_decrease_speed:

        lda    buttons
        and    #%0000001
        bne    @no_right

        lda    player_speed_right
        beq    @no_right
        dec    player_speed_right

@no_right:

        lda    buttons
        and    #%0000010
        bne    @no_left

        lda    player_speed_left
        beq    @no_left
        dec    player_speed_left

@no_left:
        rts


; Right -----------------------------------------------------------------------
logic_move_right:

        ; Right Movement
        ldy    player_speed_right
        beq    @no_right
        
@move_right:
        jsr    logic_collision_x
        and    #%00000001
        bne    @no_right

        inc    player_x
        
        dey
        bne    @move_right
        rts

@no_right:
        rts

; Left ------------------------------------------------------------------------
logic_move_left:

        ; Left Movement
        ldy    player_speed_left
        beq    @no_left

@move_left:
        jsr    logic_collision_x
        and    #%00000010
        bne    @no_left

        dec    player_x
        
        dey
        bne    @move_left

@no_left:
        rts

