STOPSERVICE(Y.ID)

$USING EB.SystemTables
$USING EB.Reports
$USING EB.DataAccess
$USING EB.Service


GOSUB PROCESS
RETURN


PROCESS:

 EB.DataAccess.FRead(FN.TSA.SERVICE,Y.ID,R.REC,F.TSA.SERVICE,TSA.ERR)
 IF R.REC THEN
 OfsRec<EB.Service.Se> = 'STOP' */Check the package name 
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
      IF TxnSuccessFlg EQE 1 THEN
      GOSUB WRITE.PROCESS
      END
    END
 END
 RETURN
 
 WRITE.PROCESS:
  
  FILE.NAME = :"ServiceStop"
  OutPut = Y.ID:"*":OfsRec
  Open "&SAVELISTS&" TO F.PATH ELSE F.PATH = ""
  WRITE OutPut TO F.PATH,FILE.NAME
  RETURN 
  END
