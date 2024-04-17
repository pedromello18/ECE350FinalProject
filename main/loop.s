loop:
    addi $r1, $r0, 1
    bne newGameInput, $r1, gameOff

    gameOn:
        # Game Setup
        add $r29, $r0, $r0 # For counting seconds
        LED countdown

        #Game Loop
        gameLoop:
            addi $r29, $r29, size of game loop
            # Timer - reg28 is for controlling displays
            addi $r1, $r0, 50000000 #every second
            blt $r1, $r29, changeTimer
            j dontChangeTimer
            changeTimer:
                addi $r28, $r28, -1
                add $r29, $r0, $r0
            dontChangeTimer:
                if sensor distance < 10cm, score+=1
                every 3 seconds, change direction of motor # needs to have integer relation to game length for motor to get back to original spot after game
                blt $r0, $r28, gameLoop
                j gameOver        
        j gameLoop
        
    gameOver:
        LED if high score
        update high score
        stall for a bit

    gameOff:
        addi $r28, $r0, 60
        add currentScoreReg, $r0, $r0 
        lw highScoretracker, highScoreAddress
        stop motors
        set all LEDs to low


j loop