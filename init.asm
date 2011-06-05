
; constants
GRAV_MAX           =  3
GRAV_INTERVAL      = 10 ; TODO use another value for the intitial reset when on ground?
MOVE_INC_INTERVAL  = 10
MOVE_INC_START     =  6
MOVE_DEC_INTERVAL  =  3

PLAYER_SPEED_MAX   =  1
PLAYER_JUMP_MAX    =  2
PLAYER_FALL_MAX    =  4
PLAYER_SLEEP_WAIT  = 10

; Init variables
init:

        jsr    logic_init
      
        rts

