
logic_init:

        jsr    logic_reset_player
        jsr    logic_reset_gravity
        jsr    logic_reset_jump
        jsr    logic_reset_fall
        jsr    logic_reset_move

        rts


; Mainloop --------------------------------------------------------------------
logic:

        jsr    logic_gravity
        jsr    logic_move

        jsr    logic_debug
        
        lda    #$01
        sta    needdraw

        rts

; includes
.include "logic_movement.asm"
.include "logic_gravity.asm"
.include "logic_collision.asm"


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

logic_reset_move:

        lda    #MOVE_INC_INTERVAL
        sta    move_inc_tick_counter

        lda    #MOVE_DEC_INTERVAL
        sta    move_dec_tick_counter

        lda    #$00
        sta    player_speed_left
        sta    player_speed_right

logic_reset_player:

        lda    #$01
        sta    player_image

        lda    #$00
        lda    player_collision
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

