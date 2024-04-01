PRINT "real part of";
INPUT cx
PRINT "imaginary";
INPUT cy
CLS 0
SCREEN 12
FOR a = 0 TO 640
FOR b = 0 TO 480
    x0 = -2 + a / 25
    y0 = 2 - b / 25
    FOR i = 1 TO 20
    x1 = x0 * x0 - y0 * y0 + cx
    y1 = 2 * x0 * y0 + cy
    IF x1 * x1 + y1 + y1 > 4 THEN
    ELSE
       x0 = x1
       y0 = y1
    END IF
    NEXT
PSET (a, b), x0
NEXT
NEXT

