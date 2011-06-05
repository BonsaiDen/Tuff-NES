.segment "HEADER"
        
        .byte   "NES", $1A      ; iNES header identifier
        .byte   1               ; 2x 16KB PRG code
        .byte   1               ; 1x  8KB CHR data
        .byte   $01, $00        ; mapper 0, vertical mirroring

;;;;;;;;;;;;;;;

.zeropage

.segment "SRAM1"
.include "variables.asm"

;;; "nes" linker config requires a STARTUP section, even if it's empty
.segment "STARTUP"

.segment "CODE"

reset:
        sei                     ; disable IRQs
        cld                     ; disable decimal mode
        ldx     #$40
        stx     $4017           ; dsiable APU frame IRQ
        ldx     #$ff            ; Set up stack
        txs                     ;  .
        inx                     ; now X = 0
        stx     $2000           ; disable NMI
        stx     $2001           ; disable rendering
        stx     $4010           ; disable DMC IRQs

        ;; first wait for vblank to make sure PPU is ready
vblankwait1:
        bit     $2002
        bpl     vblankwait1

clear_memory:
        lda     #$00
        sta     $0000, x
        sta     $0100, x
        sta     $0300, x
        sta     $0400, x
        sta     $0500, x
        sta     $0600, x
        sta     $0700, x
        lda     #$fe
        sta     $0200, x        ; move all sprites off screen
        inx
        bne     clear_memory

        ;; second wait for vblank, PPU is ready after this
vblankwait2:
        bit     $2002
        bpl     vblankwait2

load_palettes:
        lda     $2002           ; read PPU status to reset the high/low latch
        lda     #$3f
        sta     $2006
        lda     #$00
        sta     $2006
        ldx     #$00
@loop:
        lda     data_palette, x      ; load palette byte
        sta     $2007           ; write to PPU
        inx                     ; set index to next byte
        cpx     #$20
        bne     @loop           ; if x = $20, 32 bytes copied, all done

load_sprites:
        ldx     #$00            ; x = 0
@loop:
        lda     data_sprites, x      ; load byte from ROM address (sprites + x)
        sta     $0200, x        ; store into RAM address ($0200 + x)
        inx                     ; x = x + 1
        cpx     #$10            ; x == $10?
        bne     @loop           ; No, jump to @loop, yes, fall through

        ;; Setup PPU to display sprites
        lda     #%10000000      ; enable NMI, sprites from Pattern Table 0
        sta     $2000
        lda     #%00010000      ; enable sprites
        sta     $2001

        ; custom init code
        jsr init
        
forever:
        inc     sleeping        ; fall asleep

@loop:
        lda     sleeping        ; wait for nmi to wake us up
        bne     @loop
      
        ; when we wake up, handle input and sleep again
        jsr input

        jmp     forever

nmi:
        ;; Push all registers on stack
        pha
        txa
        pha
        tya
        pha

        ;; Do sprite DMA
        ;; Update palettes if needed
        ;; Draw stuff on the screen

        lda     needdraw
        beq     @drawing_done   ; If drawing flag is clear, skip drawing
        lda     $2002           ; Else, draw

        jsr     draw

        lda     #$00            ; Finished drawing, so clear drawing flat
        sta     needdraw

@drawing_done:
        lda     #$00            ; set scroll
        sta     $2005
        sta     $2005

        jsr     logic

        lda     #$00
        sta     sleeping        ; Wake up the main program

        ;; Pull all registers from stack
        pla
        tay
        pla
        tax
        pla
        
        rti

; Custom code
.include "init.asm"
.include "input.asm"
.include "logic.asm"
.include "draw.asm"

; Data ------------------------------------------------------------------------
.segment "RODATA"
.include "data.asm"

;;;;;;;;;;;;;;  
  
.segment "VECTORS"

        .word   0, 0, 0         ; Unused, but needed to advance PC to $fffa.
        .word   nmi             ; NMI interrupt handler
        .word   reset
        .word   0
  
;;;;;;;;;;;;;;  
  
.segment "CHARS"

        .incbin "graphics/tuff.chr"     ; The tuff sprite map

