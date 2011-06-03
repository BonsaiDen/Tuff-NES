
; constants
GRAV_MAX           = 3
GRAV_INTERVAL      = 10 ; TODO use another value for the intitial reset when on ground?
MOVE_INTERVAL      = 2
PLAYER_SPEED_MAX   = 1
PLAYER_JUMP_MAX    = 9
PLAYER_FALL_MAX    = 4


; Init variables
init:

        jsr    logic_init
      
        rts

