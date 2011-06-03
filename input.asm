
input:

        ; Controller data is accessed at 4016 / 4017, write 1 and 0 to 4016 to fetch data
        lda    #$01
        sta    $4016
        lda    #$00
        sta    $4016     ; tell both the controllers to latch buttons
        ldx    #$08

@loop:
        lda $4016
        lsr A

        ; A     B   select start  up   down  left right
        rol buttons
        dex
        bne @loop

        rts

