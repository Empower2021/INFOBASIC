* @ValidationCode : Mjo5MjMwNDUzMzA6Q3AxMjUyOjE2ODAwMDA2MzQyNzk6MTA3MDE1NjI6LTE6LTE6MDowOmZhbHNlOk4vQTpERVZfMjAyMTEwLjA6LTE6LTE=
* @ValidationInfo : Timestamp         : 28 Mar 2023 16:20:34
* @ValidationInfo : Encoding          : Cp1252
* @ValidationInfo : User Name         : 10701562
* @ValidationInfo : Nb tests success  : N/A
* @ValidationInfo : Nb tests failure  : N/A
* @ValidationInfo : Rating            : N/A
* @ValidationInfo : Coverage          : N/A
* @ValidationInfo : Strict flag       : N/A
* @ValidationInfo : Bypass GateKeeper : false
* @ValidationInfo : Compiler Version  : DEV_202110.0
* @ValidationInfo : Copyright Temenos Headquarters SA 1993-2021. All rights reserved.
SUBROUTINE STOPSERVICES(Y.ID)

    $USING EB.SystemTables
    $USING EB.Reports
    $USING EB.DataAccess
    $USING EB.Service
    $USING EB.Foundation
    $USING EB.Interface
    
    GOSUB PROCESS
RETURN


PROCESS:

    R.REC = EB.Service.TsaService.Read(RecId, Error)
* EB.DataAccess.FRead(FN.TSA.SERVICE,Y.ID,R.REC,F.TSA.SERVICE,TSA.ERR)
    IF R.REC THEN
        OfsRec<EB.Service.TsaService.TsTsmServiceControl> = 'STOP' ;*/Check the package name
        GOSUB POST.OFS
    END
RETURN
 
POST.OFS:
 
    Y.APPL.NAME    = "TSA.SERVICE"
    Y.FUNCT        = "I"
    Y.PROCESS      = "PROCESS"
    Y.OFS.VER      = "TSA.SERVICE,INP"
    Y.GTS.CONTROL  = ""
    Y.NO.AUTH      = "0"
    Y.OFS.RECORD   = ""
    Y.VERSION      = ""
    Y.OFS.MSG      = ""
    Y.OFS.MSG.ARR  = ""
 
    IF R.REC THEN
        EB.Foundation.OfsBuildRecord(OfsAppl, Y.FUNCT, Y.PROCESS, OfsVer, Y.GTS.CONTROL, Y.NO.AUTH , OfsTxnid, OfsRec, Y.OFS.MSG)
        IF Y.OFS.MSG THEN
            EB.Interface.OfsCallBulkManager(Options, Y.OFS.MSG, Theresponse, Txncommitted)
            TxnSuccessFlg = FIELD(FIELD(Theresponse,",",1),"/",3)
            IF TxnSuccessFlg EQ 1 THEN
                GOSUB WRITE.PROCESS
            END
        END
    END
RETURN
 
WRITE.PROCESS:
  
    FILE.NAME = "ServiceStop"
    OutPut = Y.ID:"*":OfsRec
    OPEN "&SAVELISTS&" TO F.PATH ELSE NULL
    WRITE OutPut TO F.PATH,FILE.NAME
RETURN
END
