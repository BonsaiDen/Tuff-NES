
; constants
GRAV_MAX           = 3
GRAV_INTERVAL      = 10 ; TODO use another value for the intitial reset when on ground?
MOVE_INC_INTERVAL  = 12
MOVE_INC_START     = 3
MOVE_DEC_INTERVAL  = 3
PLAYER_SPEED_MAX   = 2
PLAYER_JUMP_MAX    = 9
PLAYER_FALL_MAX    = 4

; Init variables
init:

        jsr    logic_init
      
        rts

