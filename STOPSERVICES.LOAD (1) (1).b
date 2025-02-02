SUBROUTINE STOPSERVICES.LOAD
*-----------------------------------------------------------------------------
* Load routine to setup the common area for the multi-threaded Close of Business
* job STOPSERVICES
*-----------------------------------------------------------------------------
    $USING EB.SystemTables
    $USING EB.Reports
    $USING EB.DataAccess
*-----------------------------------------------------------------------------
    FN.TSA.SERVICE  = 'F.TSA.SERVICE'
	F.TSA.SERVICE = ''
	EB.DataAccess.Opf(FN.TSA.SERVICE,F.TSA.SERVICE)
	
	FN.PATH         = ''
    F.PATH           = ''
    EB.DataAccess.Opf(FN.PATH, F.PATH)
	
RETURN
END