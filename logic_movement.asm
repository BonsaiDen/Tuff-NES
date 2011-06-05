
; Player Movement =============================================================
; =============================================================================

; Control movement and speeds ( A ) -------------------------------------------
logic_move:

        ; decrease increment tick counter
        dec    move_inc_tick
        bne    @no_inc_tick
        
        jsr    logic_increase_speed

        lda    #MOVE_INC_INTERVAL
        sta    move_inc_tick
@no_inc_tick:  ; no speed increase


        ; decrease decrement tick counter
        dec    move_dec_tick
        bne    @no_dec_tick
        
        jsr    logic_decrease_speed

        lda    #MOVE_DEC_INTERVAL
        sta    move_dec_tick
@no_dec_tick:  ; no speed decrease


        ; check whether no direction is pressed
        lda    buttons
        and    #%00000011
        eor    #%00000011
        cmp    #$03
        bne    @no_direction

        lda    #MOVE_INC_START
        sta    move_inc_tick
@no_direction: ; no direction pressed


        jsr    logic_move_right
        jsr    logic_move_left

        rts


; Handle speed increasement ( A ) ---------------------------------------------
logic_increase_speed:

        ; check right direction
        lda    buttons
        and    #%0000001
        beq    @no_right

        ; set player direction to right
        lda    #$01
        sta    player_direction

        ; reset dec interval
        lda    #MOVE_DEC_INTERVAL
        sta    move_dec_tick

        ; increase until maximum is reached
        lda    player_speed_right
        cmp    #PLAYER_SPEED_MAX
        beq    @no_right
        inc    player_speed_right
@no_right:     ; right direction isn't pressed


        ; check left direction
        lda    buttons
        and    #%0000010
        beq    @no_left

        ; set player direction to left
        lda    #$00
        sta    player_direction

        ; reset dec interval
        lda    #MOVE_DEC_INTERVAL
        sta    move_dec_tick

        ; increase until maximum is reached
        lda    player_speed_left
        cmp    #PLAYER_SPEED_MAX
        beq    @no_left
        inc    player_speed_left
@no_left:      ; left direction isn't pressed

        rts


; Handle speed decreasement ( A ) ---------------------------------------------
logic_decrease_speed:

        ; check right direction being pressed
        lda    buttons
        and    #%0000001
        bne    @no_right

        lda    player_speed_right
        beq    @no_right
        dec    player_speed_right
@no_right:     ; no right direction pressed


        ; check left direction being pressed
        lda    buttons
        and    #%0000010
        bne    @no_left

        lda    player_speed_left
        beq    @no_left
        dec    player_speed_left
@no_left:      ; no left direction pressed

        rts


; Move to the right ( Y ) -----------------------------------------------------
logic_move_right:

        ; Load right Movement
        ldy    player_speed_right
        beq    @no_right
@move_right:   ; no right movement


        ; check collision
        jsr    logic_collision_x
        and    #%00000001
        bne    @col_right

        ; move player
        inc    player_x
        
        dey    ; decrease number of pixels to move
        bne    @move_right
@no_right:

        rts

@col_right:
        lda    #$00
        sta    player_speed_right


; Move to the left ( Y ) ------------------------------------------------------
logic_move_left:

        ; Left Movement
        ldy    player_speed_left
        beq    @no_left
@move_left:    ; no right movement


        ; check collision
        jsr    logic_collision_x
        and    #%00000010
        bne    @col_left

        ; move player
        dec    player_x
        
        dey    ; decrease number of pixels to move
        bne    @move_left
@no_left:

        rts

@col_left:
        lda    #$00
        sta    player_speed_left


; Fall asleep ( A ) -----------------------------------------------------------
logic_sleep:

        lda    buttons
        beq    @no_sleep
        lda    #PLAYER_SLEEP_WAIT
        sta    player_sleep
@no_sleep:

        rts

logic_sleep_tick:

        lda    player_sleep
        beq    @sleeping
        dec    player_sleep
@sleeping:

        rts

