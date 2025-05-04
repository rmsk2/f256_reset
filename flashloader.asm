LOAD_ADDRESS   = $A000

* = LOAD_ADDRESS
.cpu "w65c02"

; This is the kernel header. It must begin at LOAD_ADDRESS
KUPHeader
.byte $F2                                  ; signature
.byte $56                                  ; signature
.byte $01                                  ; length of program in consecutive 8K flash blocks
.byte LOAD_ADDRESS / $2000                 ; block in 16 bit address space to which the first block is mapped
.word loader                               ; start address of program
.byte $01, $00, $00, $00                   ; reserved. All examples I looked at had a $01 in the first position
.text "reset"                              ; name of the program used for starting
.byte $00                                  ; zero termination for "mless"
.byte $00                                  ; no parameter description, i.e. an empty string
.text "Perform a soft reset"               ; Comment shown in lsf
.byte $00                                  ; zero termination for comment



loader
    ; setup MMU
    lda #%10110011                         ; set active and edit LUT to three and allow editing
    sta 0
    lda #%00000000                         ; enable io pages and set active page to 0
    sta 1

    lda #$DE
    sta $D6A2
    lda #$AD
    sta $D6A3
    lda #$80
    sta $D6A0
    lda #00
    sta $D6A0
    ; we never get here
    rts