* @ValidationCode : MjoxODAzNjI1NjA0OkNwMTI1MjoxNjgwMDAwNjY4NzI3OjEwNzAxNTYyOi0xOi0xOjA6MDpmYWxzZTpOL0E6REVWXzIwMjExMC4wOi0xOi0x
* @ValidationInfo : Timestamp         : 28 Mar 2023 16:21:08
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
SUBROUTINE STOPSERVICES.SELECT


    $USING EB.DataAccess
    $USING EB.Service


    FN.TSA.SERVICE  = 'F.TSA.SERVICE'
    F.TSA.SERVICE = ''
    EB.DataAccess.Opf(FN.TSA.SERVICE,F.TSA.SERVICE)
    

    STR.SelCmd = 'SELECT ': FN.TSA.SERVICE :' SERVICE.CONTROL EQ AUTO OR SERVICE.CONTROL EQ START AND WITH @ID NE TSM '
    KeyList = ""
	EB.DataAccess.Readlist(STR.SelCmd, KeyList, "", Selected, SystemReturnCode)
	EB.Service.BatchBuildList("",KeyList)
	
RETURN
END