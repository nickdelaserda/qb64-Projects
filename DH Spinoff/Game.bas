'------------------------
'- Variable Declaration -
'------------------------

CONST FALSE = 0 '
CONST TRUE = NOT FALSE

DIM Target& '                                                                               handle for target image
DIM Test& '                                                                                 ?
DIM sBar& '                                                                                 handle for Score Bar image
DIM Flash& '                                                                                handle for screen flash
DIM tTest& '                                                                                test variable
DIM Bird& '                                                                                 handle for bird image
DIM Gun& '                                                                                  handle for gun sfx
DIM Ding& '                                                                                 handle for ding noise
DIM Start& '                                                                                handle for start button
DIM Quit& '                                                                                 handle for quit button
DIM tarx% '                                                                                 x cord of target
DIM tary% '                                                                                 y cord of target
DIM tHeight% '                                                                              target height
DIM tWidth% '                                                                               target width
DIM lClick% '                                                                               left button variable
DIM Latch% '                                                                                left button latch
DIM bx% '                                                                                   bird x velocity
DIM by% '                                                                                   bird y belocity
DIM ttestx% '                                                                               test
DIM ttesty% '                                                                               test
DIM start% '                                                                                boolean to start game
DIM sCount% '                                                                               start game counter
DIM pPoint% '                                                                               player point




'----------------
'- Main Program -
'----------------

SCREEN _NEWIMAGE(800, 600, 32) '                                                            display a new screen
_TITLE "Shooter" '                                                                          title of program

DO
    _FULLSCREEN
    IF NOT sCount% THEN _MOUSESHOW '                                                        show mouse if start game counter isn't 0
    MainMenu '                                                                              main menu sub

    IF start% = TRUE THEN
        _FULLSCREEN
        _MOUSEHIDE
        LoadFiles '                                                                         load images, sounds, etc.

        sCount% = sCount% + 1 '                                                             set game counter to 1

        tHeight% = _HEIGHT(Target&) '                                                       find height of target
        tWidth% = _WIDTH(Target&) '                                                         find width of target
        bHeight% = _HEIGHT(Bird&) '                                                         find height of bird
        bWidth% = _WIDTH(Bird&) '                                                           find width of bird

        tarx% = (800 / 2) '                                                                 initially center target
        tary% = (600 / 2)


        bx% = -35 '                                                                         set initial bird coords
        by% = 480

        DO
            CLS
            _LIMIT 60 '                                                                     set fps limit
            _MOUSEHIDE
            DisplayImages '                                                                 display images sub
            UpdateScore '                                                                   updatescore sub (in progress)
            MoveBird '                                                                      movebird sub
            DO WHILE _MOUSEINPUT '                                                          get the latest mouse input
            0 LOOP
            lClick% = _MOUSEBUTTON(1) '                                                     set the left mouse button to variable
            tarx% = _MOUSEX '                                                               change the target x coord to mouse x axis
            tary% = _MOUSEY '                                                               change the target y coord to mouse y axis
            PRINT pPoint% '                                                                 test point system
            IF tary% > (480 - tHeight%) THEN tary% = (480 - tHeight%) '                     if target goes past a set limit for the play
            IF tarx% > (800 - (tWidth% / 2)) THEN tarx% = (800 - (tWidth% / 2)) '           screen then set it back to limit
            IF NOT lClick% THEN Latch% = FALSE '                                            left click control with boolean statements
            IF NOT Latch% THEN '                                                            thanks ritchie
                IF lClick% THEN '                                                           left button clicked?
                    CheckHit '                                                              yes, check for hit on the bird
                    _SNDPLAYCOPY Gun& '                                                     play gun shot sfx
                    _PUTIMAGE (0, 0), Flash& '                                              flash the screen with a white image
                    Latch% = TRUE '                                                         more boolean statements
                END IF
            END IF
            _DISPLAY
        LOOP UNTIL _KEYDOWN(27) '                                                           continue to loop until esc is pressed
    END IF
    _DISPLAY
LOOP
SYSTEM '                                                                                    close program


'---------------------------------------------------------------------------------

SUB LoadFiles

SHARED Test& '                                                                              share variables
SHARED Target&
SHARED sBar&
SHARED Flash&
SHARED Gun&
SHARED tTest&
SHARED Bird&
SHARED Ding&

Target& = _LOADIMAGE(".\Game\target.png") '                                                 load images, sounds, etc.
Test& = _LOADIMAGE(".\game\sky.png")
sBar& = _LOADIMAGE(".\game\sBar.png")
Flash& = _LOADIMAGE(".\game\flash.png")
Gun& = _SNDOPEN(".\game\gun.ogg", "VOL,sync")
tTest& = _LOADIMAGE(".\game\test.png")
Bird& = _LOADIMAGE(".\game\bird.png")
Ding& = _SNDOPEN(".\game\ding.ogg", "Vol,SYNC")

END SUB

'----------------------------------------------------------

SUB DisplayImages

SHARED Test& '                                                                              share variables
SHARED Target&
SHARED tarx%
SHARED tary%
SHARED sBar&
SHARED Flash&
SHARED tTest&
SHARED Bird&
SHARED bx%
SHARED by%


_PUTIMAGE (0, 0), Test& '                                                                   display images onto the screen
_PUTIMAGE (640, 0), Test&
_PUTIMAGE (bx%, by%), Bird&
_PUTIMAGE (tarx%, tary%), Target&
_PUTIMAGE (0, 480), sBar&
_PUTIMAGE (tarx% + 55, tary% + 55), tTest&
_SETALPHA 0, _RGB(255, 255, 255), tTest&
_SETALPHA 0, _RGB(255, 255, 255), Target&

END SUB

'-----------------------------------------------------------


SUB MoveBird

SHARED Bird& '                                                                              share variables
SHARED bx%
SHARED by%
SHARED bWidth%
SHARED bHeight%

'bx% = bx% + 3 '                                                                            bird x velocity (change to bxv% &
'by% = by% - 1 '                                                                            bird y velocity  byx%)
bx% = 800 / 2
by% = 480 / 2

END SUB

'-----------------------------------------------------------

SUB CheckHit

SHARED tTest& '                                                                             share variables
SHARED tarx%
SHARED tary%
SHARED bx%
SHARED by%
SHARED bWidth%
SHARED bHeight%
SHARED ttestx%
SHARED ttesty%
SHARED Ding&
SHARED pPoint%

ttestx% = tarx% + 57
ttesty% = tary% + 57

IF ttestx% >= bx% AND ttestx% <= bx% + bWidth% THEN '                                       check to see if middle of the
    IF ttesty% >= by% AND ttesty% <= by% + bHeight% THEN '                                  target is inside bird area
        _SNDPLAYCOPY Ding& '                                                                yes? play ding sound
        pPoint% = pPoint% + 1 '                                                             add 1 point
    END IF
END IF

END SUB

'-----------------------------------------------------------

SUB MainMenu

SHARED lClick% '                                                                            share variables
SHARED Title&
SHARED start%
SHARED Title&
SHARED Start&
SHARED Quit&
SHARED sCount%

DIM x%, y% '                                                                                set mouse x axis, y axis
DIM sx%, qx% '                                                                              start and quit image x coord
DIM sy%, qy% '                                                                              start and quit image y coord
DIM sWidth% '                                                                               width of start button
DIM sHeight% '                                                                              height of start button
DIM qWidth% '                                                                               width of quit button
DIM qHeight% '                                                                              height of quit button

start% = 0 '                                                                                set start to false
sCount% = 0 '                                                                               set start counter to 0

CLS
_LIMIT 60

Title& = _LOADIMAGE(".\game\title.png")
Start& = _LOADIMAGE(".\game\start.png")
Quit& = _LOADIMAGE(".\game\quit.png")

sWidth% = _WIDTH(Start&)
sHeight% = _HEIGHT(Start&)
qWidth% = _WIDTH(Quit&)
qHeight% = _HEIGHT(Quit&)

sx% = 220
sy% = 250
qx% = sx%
qy% = 400

_PUTIMAGE (160, 50), Title&
_PUTIMAGE (sx%, sy%), Start&
_PUTIMAGE (qx%, qy%), Quit&

WHILE _MOUSEINPUT: WEND
x% = _MOUSEX
y% = _MOUSEY
lClick% = _MOUSEBUTTON(1)

IF lClick% THEN
    IF x% >= sx% AND x% <= sx% + sWidth% THEN
        IF y% >= sy% AND y% <= sy% + sHeight% THEN
            start% = TRUE
        END IF
    END IF
END IF
IF lClick% THEN
    IF x% >= qx% AND x% <= qx% + qWidth% THEN
        IF y% >= qy% AND y% <= qy% + qHeight% THEN
            SYSTEM
        END IF
    END IF
END IF

END SUB

'-----------------------------------------------------------

SUB UpdateScore







END SUB

'-----------------------------------------------------------

