# MINI-BRIEF

# SPECIAL REGISTERS:
# 29 - clock cycle counter for game loop
# 28 - game timer
# 27 - current score
# 26 - max score
# 25 - stepper control - bit 1 is direction; bit 0 is enable

# SPECIAL MEMORY LOCATIONS:
# address 0 - new game input
# address 1 - ultrasonic sensor distance (not implemented yet)

loop:
    lw $1, 0($0)
    bne $0, $1, gameOff

    gameOn:
        # Game Setup
        addi $28, $0, 80 # game length 
        add $29, $0, $0
        addi $25, $0, 1
        # LED countdown/sounds if applicable

        #Game Loop
        gameLoop:
            addi $29, $29, 10 # number of clock cycles for each game loop
            addi $1, $0, 50000000
            blt $1, $29, changeGameTimer
            j dontChangeTimer
            changeGameTimer:
                addi $28, $28, -1
                add $29, $0, $0
            dontChangeTimer:
                # if sensor distance < 10cm, score+=1
                add $1, $28, $0
                addi $2, $0, 4
                or $3, $2, $1 # checks if bit2 of game clock is 1 - effectively, every four seconds
                addi $4, $0, 2
                blt $3, $4, motorLeft
                motorRight:
                    addi $25, $0, 3
                    j motorDone
                motorLeft:
                    addi $25, $0, 1
                motorDone:
                    blt $0, $28, gameLoop
                 
    gameOver:
        #stop motors
        add $25, $0, $0
        # stall for a bit, so can see current score for a bit, can add bells and whistles
        addi $2, $0, 500000000
        stallLoop:
            blt $2, $1, gameOff
            addi $1, $1, 1
            j stallLoop

    gameOff:
        addi $28, $0, 80 # game length
        blt $26, $27, maxScoreBeaten
        j maxScoreRemains
        maxScoreBeaten:
            add $26, $27, $0
            # LED if high score
        maxScoreRemains:
            add $27, $0, $0 
            #set all LEDs to low
            
j loop