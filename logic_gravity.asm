
; Player Gravity / Falling / Jumping  =========================================
; =============================================================================


; Handle gravity ticks ( A ) --------------------------------------------------
logic_gravity:

        ; tick the gravity
        dec    grav_tick
        bne    @no_tick

        ; incease the falling gravity
        jsr    logic_increase_fall
        jsr    logic_decrease_jump

        ; reset tick counter
        lda    #GRAV_INTERVAL
        sta    grav_tick
@no_tick:

        jsr    logic_fall
        jsr    logic_jump
        rts


; Handle jumping ( Y, A ) -----------------------------------------------------
logic_jump:


        ; detect A button press
        lda    buttons
        and    #%10000000
        beq    @no_jump_button

        ; jump still pressed?
        lda    player_jump_pressed
        bne    @no_ground

        ; Save that the jump button is pressed
        lda    #$01
        sta    player_jump_pressed

        ; check whether we're on the ground
        lda    player_ground
        beq    @no_ground

        ; jump
        lda    #GRAV_INTERVAL
        sta    grav_tick

        lda    #PLAYER_JUMP_MAX
        sta    player_jump_power
        jmp    @no_ground

@no_jump_button: ; no button pressed
        lda    #$00
        sta    player_jump_pressed

@no_ground:    ; not on ground but jump button pressed

        ; load jump power gravity
        ldy    player_jump_power
        beq    @no_jump

        ; check whether the button was released
        lda    player_jump_pressed
        bne    @jump

        ; if not, decrease the jump speed rapidly
        lsr    player_jump_power

@jump:  ; more jumping

        ; check for ceiling collision
        jsr    logic_collision_y
        and    #%00000001
        bne    @jump_ceiling

        lda    #$00
        sta    player_ground

        ; move player
        dec    player_y
        
        dey
        bne    @jump
@no_jump:      ; moved player_jump_power pixels

        rts

@jump_ceiling: ; ceiling was hit

        jsr   logic_reset_jump
        rts


; Decrease jumping power ( A ) ------------------------------------------------
logic_decrease_jump:

        ; decrease jump power until we reach 0
        lda    player_jump_power
        beq    @no_decrease
        dec    player_jump_power
@no_decrease:

        rts


; Handle falling ( A, Y ) -----------------------------------------------------
logic_fall:

        ; load falling gravity
        ldy    player_fall_grav
        beq    @no_fall
@fall:

        ; check for ground collision
        jsr    logic_collision_y
        and    #%00000010
        bne    @fall_ground

        ; reset ground state
        lda    #$00
        sta    player_ground

        ; move player
        inc    player_y
        
        dey
        bne    @fall
@no_fall:      ; moved player_fall_grav pixels

        rts

@fall_ground: ; ground was hit
        jsr   logic_reset_fall
        lda    #$01
        sta    player_ground

        rts


; Increase falling gravity ( A ) ----------------------------------------------
logic_increase_fall:

        ; check jump power
        lda    player_jump_power
        bne    @no_increase

        ; increase garvity until we reach the maximum
        lda    player_fall_grav

        cmp    #PLAYER_FALL_MAX
        beq    @no_increase

        inc    player_fall_grav
@no_increase:

        rts

