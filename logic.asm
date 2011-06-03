
logic_init:

        jsr    logic_reset_player
        jsr    logic_reset_gravity
        jsr    logic_reset_jump
        jsr    logic_reset_fall

        rts


; Mainloop --------------------------------------------------------------------
logic:

        jsr    logic_debug
        jsr    logic_gravity
        jsr    logic_move
        
        lda    #$01
        sta    needdraw

        rts


; Move ------------------------------------------------------------------------
logic_move:

        ; Only move right / left every #MOVE_INTERVAL frame
        dec    move_tick_counter
        bne    @no_tick
        jsr    logic_walk

        lda    #MOVE_INTERVAL
        sta    move_tick_counter

@no_tick:
        rts

logic_walk:
        
        ; Right
        lda    buttons
        and    #%00000001
        beq    @no_right
        
        ; Move right
        ldy    player_speed
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

        ; Left
        lda    buttons
        and    #%00000010
        beq    @no_left

        ; Move left
        ldy    player_speed
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


; Reset -----------------------------------------------------------------------
logic_reset_gravity:

        lda    #GRAV_INTERVAL
        sta    grav_tick_counter

        rts

logic_reset_jump:

        lda    #$00
        sta    player_jump_grav

        rts

logic_reset_fall:

        lda    #$00
        sta    player_fall_grav

        rts

logic_reset_player:
        
        lda    #MOVE_INTERVAL
        sta    move_tick_counter

        lda    #$01
        sta    player_image

        lda    #PLAYER_SPEED_MAX
        sta    player_speed 

        lda    #$00
        lda    player_collision

        lda    #$00
        sta    player_direction

        lda    #$80
        sta    player_x

        lda    #$40
        sta    player_y

        rts


; Debugging -------------------------------------------------------------------
logic_debug:

        ; is down pressed?
        lda    buttons
        and    #%00000100
        beq    @no_down

        jsr    logic_reset_player
        jsr    logic_reset_gravity
        jsr    logic_reset_jump
        jsr    logic_reset_fall

@no_down:

        lda    buttons
        and    #%00000010
        beq    @no_left
      
        lda    #$00
        sta    player_direction
@no_left:

        lda    buttons
        and    #%00000001
        beq    @no_right
      
        lda    #$01
        sta    player_direction

@no_right:
        rts

