
; engine
sleeping:               .res    1
needdraw:               .res    1
low_frame:              .res    1

; helpers
tmp:                    .res    1

; globals
buttons:                .res    1
grav_tick:              .res    1
move_inc_tick:          .res    1
move_dec_tick:          .res    1

; player
player_speed_right:     .res    1
player_speed_left:      .res    1
player_x:               .res    1
player_y:               .res    1
player_ground:          .res    1

player_sleep:           .res    1

player_image:           .res    1
player_palette:         .res    1
player_direction:       .res    1

player_animation:       .res    1
player_animation_frame: .res    1
player_animation_index: .res    1
player_animation_length:.res    1

player_fall_grav:       .res    1
player_jump_power:      .res    1
player_jump_pressed:    .res    1


; player sprite offset into PPU RAM
.segment "PLAYER_SPRITE"
player_sprite:

