
; Main Game Code  =============================================================
; =============================================================================


; Initiate the game logic
logic_init:
        
        lda    #$00
        sta    tmp

        ; TODO set speed to zero when hitting a wall
        jsr    logic_reset_player
        jsr    logic_reset_gravity
        jsr    logic_reset_move

        ; init the low frame counter
        ; this thing only fires every 10th frame
        lda    #$10
        sta    low_frame

        rts


; Mainloop ( A )
logic:

        dec    low_frame
        bne    @no_low
        jsr    logic_low

@no_low:
        ; movement and stuff
        jsr    logic_gravity
        jsr    logic_move
        jsr    logic_sleep
        jsr    logic_animation

        jsr    logic_debug

        lda    #$01
        sta    needdraw

        rts

logic_low:
        lda    #$10
        sta    low_frame
        jsr    logic_sleep_tick

        rts


; Logic includes
.include "logic_animation.asm"
.include "logic_movement.asm"
.include "logic_gravity.asm"
.include "logic_collision.asm"


; Resets ======================================================================
; =============================================================================

; Reset jump force ( A )
logic_reset_gravity:

        lda    #GRAV_INTERVAL
        sta    grav_tick

        jsr    logic_reset_fall
        jsr    logic_reset_jump

        rts


; Reset jump force ( A )
logic_reset_jump:

        lda    #$00
        sta    player_jump_power
        sta    player_jump_pressed

        rts


; Reset fall grav ( A )
logic_reset_fall:

        lda    #$00
        sta    player_fall_grav

        rts


; Reset movement speed grav ( A )
logic_reset_move:

        lda    #MOVE_INC_INTERVAL
        sta    move_inc_tick

        lda    #MOVE_DEC_INTERVAL
        sta    move_dec_tick

        lda    #$00
        sta    player_speed_left
        sta    player_speed_right


; Reset the player ( A )
logic_reset_player:

        lda    #$00
        sta    player_image
        sta    player_direction
        sta    player_animation_frame
        sta    player_animation_index
        sta    player_animation_length

        lda    #PLAYER_SLEEP_WAIT
        sta    player_sleep

        ; initiliaze to this value so a animation change is triggered
        lda    #$FF
        sta    player_animation

        lda    #$80
        sta    player_x

        lda    #$40
        sta    player_y

        rts


; Debugging ===================================================================
; =============================================================================
logic_debug:

        lda    buttons    
        and    #%00010000
        beq    @no_select

        jsr    logic_reset_player
        jsr    logic_reset_gravity
        jsr    logic_reset_jump
        jsr    logic_reset_fall

@no_select:
        rts

