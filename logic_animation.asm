
; Animations ==================================================================
; =============================================================================


; Animation Control ( A ) -----------------------------------------------------
logic_animation:

        jsr    logic_animation_update
        jsr    logic_animation_play

@no_tick:
        rts


; Update Player Animations ( A, X ) -------------------------------------------
logic_animation_update:

        ; store the current animation
        lda    player_animation
        sta    tmp
        
        ; reset to normal
        lda    #$00
        sta    player_animation
        
        ; sleeping
        lda    player_sleep
        bne    @no_sleep

        ; sleeping animation
        lda    #$04
        sta    player_animation
        jmp    @animate
@no_sleep:

        ; jumping
        lda    player_jump_power
        beq    @no_jump ; in case of 0 skip
        
        ; jumping animation
        lda    #$02
        sta    player_animation
        jmp    @animate
@no_jump:

        ; falling
        lda    player_ground
        bne    @no_fall ; in case of !0 skip

        ; falling animation
        lda    #$03
        sta    player_animation
        jmp    @animate
@no_fall:

        ; right
        lda    player_speed_right
        beq    @no_right

        ; walking animation
        lda    #$01
        sta    player_animation
        jmp    @animate
@no_right:

        ; left
        lda   player_speed_left
        beq   @animate
        
        ; walking animation
        lda    #$01 
        sta    player_animation
@animate: ; reset the animation in case it changed
        
        lda    player_animation
        cmp    tmp
        beq    @no_change

        ; update animation frame / length
        lda    #$00
        sta    player_animation_frame
        jsr    logic_animation_index

@no_change: ; did not change
        rts

; Play the current animation (A, Y, X) -----------------------------------------
logic_animation_index:
        
        lda    #$00
        ldy    player_animation
        beq    @multiplied

@next:
        clc
        adc    #$10
        dey
        bne    @next

@multiplied:
        sta    player_animation_index

        ; figuring out this missing clc took about an hour...
        clc
        adc    player_animation_frame
        tax

        lda    data_player_animation, x
        sta    player_image

        lda    data_player_animation + 8, x
        sta    player_animation_length

        rts


; Play the animation ( A ) ----------------------------------------------------
logic_animation_play:

@no_end:

        ; decrease the length
        dec    player_animation_length
        lda    player_animation_length
        bne    @frame_wait ; skip in case length hasn't dropped to zero yet

        ; are we on the last frame? if so, return to zero 
        lda    player_animation_frame
        cmp    #$07
        bne    @next_frame
        
        lda    #$00
        sta    player_animation_frame
        jsr    logic_animation_index
        rts

@next_frame:

        ; go to next frame
        inc    player_animation_frame
        jsr    logic_animation_index

        lda    player_image
        cmp    #$FF
        bne    @frame_wait

        lda    #$00
        sta    player_animation_frame
        jsr    logic_animation_index

@frame_wait:
        rts

