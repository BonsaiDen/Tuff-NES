
; engine
sleeping:               .res    1
needdraw:               .res    1
frame:                  .res    1

; globals
buttons:                .res    1
grav_tick:              .res    1
grav_tick_counter:      .res    1
move_inc_tick_counter:  .res    1
move_dec_tick_counter:  .res    1

; player
player_collision:       .res    1
player_speed_right:     .res    1
player_speed_left:      .res    1
player_x:               .res    1
player_y:               .res    1

player_image:           .res    1
player_palette:         .res    1
player_direction:       .res    1

player_fall_grav:       .res    1
player_jump_grav:       .res    1


.segment "PLAYER_SPRITE"
player_sprite:

