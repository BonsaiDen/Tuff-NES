
; Gravity ---------------------------------------------------------------------
logic_gravity:

        ; tick the gravity
        dec    grav_tick_counter
        bne    @no_tick

        jsr    logic_increase_fall

        ; reset tick counter
        lda    #GRAV_INTERVAL
        sta    grav_tick_counter

@no_tick:
        jsr    logic_fall
        rts


logic_fall:

        ldy    player_fall_grav
        beq    @no_fall

@fall:
        jsr    logic_collision_y
        and    #%00000010
        bne    @fall_ground

        inc    player_y
        
        dey
        bne    @fall

@no_fall:
        rts

@fall_ground:
        jsr   logic_reset_fall
        rts


logic_increase_fall:

        ; increase garvity until we reach the maximum
        lda    player_fall_grav

        cmp    #PLAYER_FALL_MAX
        beq    @no_increase

        inc    player_fall_grav

@no_increase:
        rts

