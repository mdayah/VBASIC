' ------------------------------------------------------------------------
' Visual Basic for MS-DOS Presentation Graphics Toolkit
' Scatter Chart Example
'
' The Presentation Graphics Toolkit must be loaded to run
' this example (VBDOS /L CHART).
'
' Copyright (C) 1982-1992 Microsoft Corporation
'
' You have a royalty-free right to use, modify, reproduce
' and distribute the sample applications and toolkits provided with
' Visual Basic for MS-DOS (and/or any modified version)
' in any way you find useful, provided that you agree that
' Microsoft has no warranty, obligations or liability for
' any of the sample applications or toolkits.
' ------------------------------------------------------------------------

DEFINT A-Z

' Include files containing declarations for called procedures.
' $INCLUDE: 'CHART.BI'
 
DECLARE FUNCTION BestMode ()

CONST FALSE = 0
CONST TRUE = NOT FALSE
CONST MONTHS = 12
CONST HIGHESTMODE = 13

DIM Env AS ChartEnvironment                 ' Variable to hold environment structure
DIM OJvalues(1 TO MONTHS) AS SINGLE         ' Array for 1st data series
DIM HCvalues(1 TO MONTHS) AS SINGLE         ' Array for 2nd data series

' Initialize the data arrays
FOR index = 1 TO MONTHS: READ OJvalues(index): NEXT index
FOR index = 1 TO MONTHS: READ HCvalues(index): NEXT index

' Pass the value returned by the BestMode function to the Presentation
' Graphics routine ChartScreen to set the graphics mode for charting
ChartScreen (BestMode)      ' Even if SCREEN is already set to an acceptable
							' mode, you still have to set it with ChartScreen

IF ChartErr = cBadScreen THEN   ' Check to make sure ChartScreen succeeded
	PRINT "Cannot switch to a graphics screen mode."
	END
END IF

' Initialize a default pie chart
DefaultChart Env, cScatter, cNoLines  ' Constant cScatter (for Scatter Chart), cNoLines (unjoined points)

' Add Titles and some chart options. These assignments modify some default
' values set in the variable Env (of type ChartEnvironment) by DefaultChart
Env.MainTitle.Title = "Good Neighbor Grocery" ' Specifies text of chart title
Env.MainTitle.TitleColor = 11                 ' Specifies color of title text
Env.MainTitle.Justify = cRight                ' How to align of title text
Env.SubTitle.Title = "OJ vs. Hot Chocolate"   ' Text of chart subtitle
Env.SubTitle.TitleColor = 15                  ' Color of subtitle text
Env.SubTitle.Justify = cRight                 ' How to align of subtitle text
Env.ChartWindow.Border = cNo                  ' Specifies chart has no border

' Label the x and y axes of the chart
Env.XAxis.AxisTitle.Title = "Orange Juice Sales"
Env.YAxis.AxisTitle.Title = "Hot Chocolate Sales"

' Call the pie-charting routine --- Arguments for call to ChartPie are:
' Env                 - Environment variable
' OJvalues            - Array containing orange-juice sales values to chart
' HCvalues            - Array containing hot-chocolate sales values to chart
' MONTHS              - Tells number of data values to chart
ChartScatter Env, OJvalues(), HCvalues(), MONTHS

SLEEP

END

' Simulate data generation for chart values and category labels
DATA 33,27,42,64,106,157,182,217,128,62,43,36
DATA 37,37,30,19,10,5,2,1,7,15,28,39     

' Best graphics screenmode retrieval routine.
'
' Determines the best graphics screenmode available
' for displaying the chart.
'
FUNCTION BestMode ()
	' Set error trap for determining supported screenmodes.
	ON LOCAL ERROR GOTO ScreenError

	FOR TestValue = HIGHESTMODE TO 0 STEP -1
		DisplayError = FALSE
		SCREEN TestValue
		IF DisplayError = FALSE THEN
			SELECT CASE TestValue
				CASE 12, 13
					BestMode = 12
				CASE 9, 10, 11
					BestMode = 9
				CASE 8, 4, 3
					BestMode = TestValue
				CASE 2, 7
					BestMode = 2
				CASE 1
					BestMode = 1
				CASE ELSE
					PRINT "Graphics screenmode required to display charts."
					END
			END SELECT
			EXIT FUNCTION
		END IF
	NEXT TestValue


	EXIT FUNCTION

' Screenmode error trap
' Handles invalid SCREEN values.
ScreenError:
	IF ERR = 5 THEN
		DisplayError = TRUE
		RESUME NEXT
	ELSE
		ERROR ERR
	END IF
END FUNCTION

