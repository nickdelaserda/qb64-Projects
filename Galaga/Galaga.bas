'------------------------
'- Variable Declaration -
'------------------------

CONST FALSE = 0 '
CONST TRUE = NOT FALSE

DIM Theme&
DIM Ship&
DIM Bullet&
DIM Stars&
DIM Space&
DIM sHeight%
DIM sWidht%
DIM bHeight%
DIM sx%
DIM sy%
DIM bgy%
DIM bgy2%
DIM Count%
DIM bx%
DIM by%
DIM start%



'----------------
'- Main Program -
'----------------

SCREEN _NEWIMAGE(600, 900, 32) '                                                            display a new screen
_TITLE "Galaga" '                                                                           title of program
CLS
_SCREENMOVE _MIDDLE
_MOUSEHIDE

LOADFILES

sx% = 600 / 2
sy% = 900 - sHeight% - 10

bgy% = 0
bgy2% = -899


by% = sy%


Spacebar = 32


DO
    MAINMENU
    DO
        CLS
        DISPLAYIMAGES
        Count% = 0
        '_SNDPLAY Theme&
        '_DELAY 6.5
        DO
            CLS
            MOVEBACKGROUND
            DISPLAYIMAGES
            _LIMIT 30
            bx% = sx% + (sWidth% / 2)
            IF _KEYDOWN(19200) THEN sx% = sx% - 10
            IF _KEYDOWN(19712) THEN sx% = sx% + 10
            IF sx% > (600 - sWidth%) THEN sx% = (600 - sWidth%)
            IF sx% < 0 THEN sx% = 0
            TEMP$ = RIGHT$(INKEY$, 1)
            IF LEN(TEMP$) THEN KeyPress = ASC(TEMP$)
            SELECT CASE KeyPress
                CASE IS = Spacebar
                    Count% = Count% + 1
                    KeyPress = 0
                    SHOOTBULLET
            END SELECT
            _DISPLAY

        LOOP
    LOOP
LOOP


'------------------------------------------------------------------------------------------------------------------------

SUB LOADFILES

SHARED Theme&
SHARED Ship&
SHARED Bullet&
SHARED Stars&
SHARED sHeight%
SHARED sWidth%
SHARED bHeight%

Theme& = _SNDOPEN(".\Galaga\theme.ogg", "VOL,SYNC")
Fire& = _SNDOPEN(".\Galaga\fire.ogg", "VOL,SYNC")
Ship& = _LOADIMAGE(".\Galaga\ship.png")
Bullet& = _LOADIMAGE(".\Galaga\bullet.png")
Stars& = _LOADIMAGE(".\Galaga\stars.png")

sHeight% = _HEIGHT(Ship&)
sWidth% = _WIDTH(Ship&)
bHeight% = _HEIGHT(Bullet&)





END SUB

'------------------------------------------------------------------------------------------------------------------------

SUB DISPLAYIMAGES

SHARED Ship&
SHARED Stars&
SHARED sHeight%
SHARED sx%
SHARED sy%
SHARED Bullet&
SHARED bgy%
SHARED bgy2%
SHARED Count%

_PUTIMAGE (0, bgy%), Stars&
_PUTIMAGE (0, bgy2%), Stars&
_PUTIMAGE (sx%, sy%), Ship&

IF Count% THEN


END IF




END SUB

'------------------------------------------------------------------------------------------------------------------------

SUB MOVEBACKGROUND

SHARED bgy%
SHARED bgy2%

bgy% = bgy% + 1
bgy2% = bgy2% + 1

IF bgy% = 899 THEN bgy% = -899
IF bgy2% = 899 THEN bgy2% = -899




END SUB

'------------------------------------------------------------------------------------------------------------------------

SUB SHOOTBULLET

SHARED Bullet&
SHARED Count%
SHARED bx%, by%
SHARED sx%, sWidth%, sy%
SHARED bHeight%

DIM x%
DIM y%
DIM ennd%


DO
    _PUTIMAGE (bx%, by%), Bullet&
    x% = bx%
    y% = by%

    DO
        ennd% = 1
        y% = y% - 25
    LOOP UNTIL y% = 0 - bHeight%
LOOP UNTIL ennd% = 1

ennd% = 0

END SUB


'------------------------------------------------------------------------------------------------------------------------

SUB MAINMENU

SHARED start%

DO

    '_DELAY 2
    start% = 1




LOOP UNTIL start%

start% = 0


END SUB

'------------------------------------------------------------------------------------------------------------------------








