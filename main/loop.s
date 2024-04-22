# BRIEF
# SPECIAL REGISTERS:
# 29 - clock cycle counter for game loop
# 28 - game timer
# 27 - current score
# 26 - max score
# 25 - stepper control - bit 1 is direction; bit 0 is enable
# 24 - moment of score increase
# 23 - actuator control - bit 0 is up(1)/down(0)
# 22 - led control - bits 0-2 are for start of game; bit 3 is for score; bit 4 is for game end; bit 5-6 is for high score
# 21 - LED counter
# SPECIAL MEMORY LOCATIONS:
# address 0 - new game input
# address 1 - ultrasonic sensor distance (not implemented yet)
# address 2 - actuator input
loop:
    addi $2, $0, 1
    lw $1, 0($0)
    bne $2, $1, gameOff
    gameOn:
        # Game Setup
        addi $28, $0, 80 # game length 
        add $29, $0, $0
        addi $25, $0, 1
        addi $24, $0, 81
        addi $1, $0, 762 # Start of LED control to show start of game
        sll $1, $1, 16
        addi $1, $1, 61568
        stallLoopGameStartLED1:
            addi $21, $0, 5
            blt $1, $21, TurnLED1On
            j stallLoopGameStartLED1
        TurnLED1On:
            addi $22, $0, 1
        addi $21, $0, 5
        stallLoopGameStartLED2:
            addi $21, $0, 5
            blt $1, $21, TurnLED2On
            j stallLoopGameStartLED2
        TurnLED2On:
            addi $22, $0, 3
        addi $21, $0, 5
        stallLoopGameStartLED3:
            addi $21, $0, 5
            blt $1, $21, TurnLED3On
            j stallLoopGameStartLED3
        TurnLED3On:
            addi $22, $0, 7
        addi $21, $0, 5
        stallLoopGameStartLEDoff:
            addi $21, $0, 5
            blt $1, $21, TurnLEDStartOff
            j stallLoopGameStartLEDoff
        TurnLEDStartOff:
            addi $22, $0, 0
        gameLoop:
            addi $29, $29, 10 # approx number of clock cycles for each game loop
            addi $1, $0, 762 # this block adds 50 000 000 to r1, the number of isns executed per second
            sll $1, $1, 16
            addi $1, $1, 61568
            blt $1, $29, changeGameTimer
            j dontChangeTimer
            changeGameTimer:
                addi $28, $28, -1
                add $29, $0, $0
            dontChangeTimer:
                # if sensor distance < 15cm, score+=1
                lw $1, 1($0)
                addi $2, $0, 15
                blt $2, $1, noScore
                blt $28, $24, Score
                j noScore
            Score:
                addi $27, $27, 1
                add $24, $28, $0
                addi $24, $24, -1 # can't score in contiguous seconds, is fine because of actuator delay
                addi $22, $0, 8
            noScore:
                # LED Check
                blt $28, $24, ScoreLEDOff
                j noLEDScoreCtrl
                ScoreLEDOff:
                    addi $22, $0, 0
                noLEDScoreCtrl:
                # Motor Control
                addi $2, $0, 2
                and $3, $2, $28 # checks if bit1 of game clock is 1 - effectively, every two seconds
                addi $4, $0, 1
                blt $3, $4, motorLeft
                motorRight:
                    addi $25, $0, 3
                    j motorDone
                motorLeft:
                    addi $25, $0, 1
                motorDone:
                    #Actuator Control
                    lw $1, 2($0)
                    blt $0, $1, actuatorOn
                    j actuatorOff
                    actuatorOn:
                        addi $23, $0, 1
                        j actuatorDone
                    actuatorOff:
                        addi $23, $0, 0
                    actuatorDone:
                    blt $0, $28, gameLoop      
    gameOver:
        add $25, $0, $0 #stop motors
        add $23, $0, $0 #retract actuator      
        addi $2, $0, 7629 # stall for a bit; adds 500 000 000 to r2, 10 seconds worth of isns
        sll $2, $2, 16
        addi $2, $2, 25856        
        stallLoop:
            addi $22, $0, 16
            blt $2, $1, gameOff
            addi $1, $1, 1
            j stallLoop
    gameOff:
        addi $22, $0, 0
        addi $28, $0, 80 # game length
        addi $23, $0, 0
        blt $26, $27, maxScoreBeaten
        j maxScoreRemains
        maxScoreBeaten:
            add $26, $27, $0 # Replace max score
            addi $1, $0, 762 # Start of LED control to show new high score
            sll $1, $1, 16
            addi $1, $1, 61568
            stallLoopHighScoreLED1:
                addi $21, $0, 3
                blt $1, $21, TurnLEDHS1On
                j stallLoopHighScoreLED1
            TurnLEDHS1On:
                addi $22, $0, 32
            addi $21, $0, 3
            stallLoopHighScoreLED2:
                addi $21, $0, 3
                blt $1, $21, TurnLEDHS2On
                j stallLoopHighScoreLED2
            TurnLEDHS2On:
                addi $22, $0, 64
            addi $21, $0, 3
            stallLoopHighScoreLED1Again:
                addi $21, $0, 3
                blt $1, $21, TurnLEDHS1AgainOn
                j stallLoopHighScoreLED1Again
            TurnLEDHS1AgainOn:
                addi $22, $0, 32
            addi $21, $0, 5
            stallLoopHSLEDoff:
                addi $21, $0, 5
                blt $1, $21, TurnLEDHSOff
                j stallLoopHSLEDoff
            TurnLEDHSOff:
                addi $21, $0, 0
        maxScoreRemains:
            add $27, $0, $0 
j loop