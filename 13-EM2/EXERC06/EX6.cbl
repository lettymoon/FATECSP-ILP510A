       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX6.
       AUTHOR. LETICIA CANDIDO.
       INSTALLATION. FATECSP.
       DATE-WRITTEN. 24/10/2023.
       DATE-COMPILED. 24/10/2023
       SECURITY. APENAS O AUTOR POR MODIFICAR.
       
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
       OBJECT-COMPUTER. IBM-PC.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CADCLI  ASSIGN TO DISK
           ORGANIZATION IS LINE SEQUENTIAL.   
           SELECT CADOK   ASSIGN TO DISK
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT RELOCOR ASSIGN TO DISK.

       DATA DIVISION.
       FILE SECTION.
       FD CADCLI
          LABEL RECORD ARE STANDARD
          VALUE OF FILE-ID IS "CADCLI.DAT".
       01 REGCLI.
           02 CODIGO      PIC 9(03).
           02 CPF.
               03 DIG-1    PIC 9(01).
               03 DIG-2    PIC 9(01).
               03 DIG-3    PIC 9(01).
               03 DIG-4    PIC 9(01).
               03 DIG-5    PIC 9(01).
               03 DIG-6    PIC 9(01).
               03 DIG-7    PIC 9(01).
               03 DIG-8    PIC 9(01).
               03 DIG-9    PIC 9(01).
               03 DIG-V1   PIC 9(01).
               03 DIG-V2   PIC 9(01).
           02 NOME        PIC X(30).
           02 ESTADO     PIC X(02).
               88 ESTADO-VALIDO VALUE "AC" "AL" "AP" "AM" "BA" "CE" 
               "DF" "ES" "GO" "MA" "MT" "MS" "MG" "PA" "PB" "PR" "PE" 
               "PI" "RJ" "RN" "RS" "RO" "RR" "SC" "SP" "SE" "TO".
           02 CIDADE     PIC X(30).
           02 EMAIL      PIC X(30).
           02 TELEFONE   PIC 9(10).
  
       FD CADOK
          LABEL RECORD ARE STANDARD
          VALUE OF FILE-ID IS "CADOK.DAT".

       01 REGOK.
          02 CPF-OK        PIC 9(11).
          02 NOME-OK       PIC X(30).
          02 ESTADO-OK     PIC X(02).
          02 CIDADE-OK     PIC X(30).
          02 EMAIL-OK      PIC X(30).
          02 TELEFONE-OK   PIC 9(10).
          
       FD  RELOCOR
           LABEL RECORD IS OMITTED.

       01  REG-ATR PIC X(80).

       WORKING-STORAGE SECTION.

              77 FIM-ARQ       PIC 9(01) VALUE 0.
              77 CT-LIN        PIC 9(02) VALUE 41.
              77 ERRO          PIC 9(01) VALUE 0.
              77 ERRO-NOME     PIC 9(01) VALUE 0.
              77 ERRO-CPF      PIC 9(01) VALUE 0.
              77 ERRO-ESTADO   PIC 9(01) VALUE 0.
              77 ERRO-CIDADE   PIC 9(01) VALUE 0.
              77 ERRO-EMAIL    PIC 9(01) VALUE 0.
              77 RESTO         PIC 9(03).
              77 DIG-V1-CORRET PIC 9(03).
              77 DIG-V2-CORRET PIC 9(03).
              77 DIG-1-MULT    PIC 9(03).
              77 DIG-2-MULT    PIC 9(03).
              77 DIG-3-MULT    PIC 9(03).
              77 DIG-4-MULT    PIC 9(03).
              77 DIG-5-MULT    PIC 9(03).
              77 DIG-6-MULT    PIC 9(03).
              77 DIG-7-MULT    PIC 9(03).
              77 DIG-8-MULT    PIC 9(03).
              77 DIG-9-MULT    PIC 9(03).
              77 DIG-V1-CORRET-MULT PIC 9(03).

       01 CAB-01.
           02 FILLER  PIC X(31) VALUE SPACES.
           02 FILLER  PIC X(17) VALUE "TURISMAR TURISMOS".
           02 FILLER  PIC X(32) VALUE SPACES.

       01 CAB-02.
           02 FILLER    PIC X(17) VALUE SPACES.
           02 FILLER    PIC X(45) 
               VALUE "RELATORIO DE DADOS DE CLIENTES INCONSISTENTES".
           02 FILLER    PIC X(18) VALUE SPACES.
 
       01 CAB-03.
           02 FILLER  PIC X(17)  VALUE "CODIGO DO CLIENTE".
           02 FILLER  PIC X(15)  VALUE SPACES.
           02 FILLER  PIC X(15)  VALUE "DADOS INVALIDOS".
           02 FILLER  PIC X(33)  VALUE SPACES.

       01 CAB-04.
           02 FILLER    PIC X(80) VALUE ALL '-'.
       01 CAB-05.
           02 FILLER    PIC X(23)  VALUE SPACES.
       01 CAB-06.
           02 FILLER    PIC X(12)  VALUE "CPF INVALIDO".
       01 CAB-07.
           02 FILLER    PIC X(18)  VALUE "NOME NAO INFORMADO".
       01 CAB-08.
           02 FILLER    PIC X(15)  VALUE "ESTADO INVALIDO".
       01 CAB-09.
           02 FILLER    PIC X(20)  VALUE "CIDADE NAO INFORMADA".
       01 CAB-10.
           02 FILLER    PIC X(19)  VALUE "EMAIL SEM DESCRICAO".
       01 CAB-11.
           02 FILLER    PIC X(13)  VALUE "DATA INVALIDA".

       01 DETALHE.
           02 FILLER         PIC X(05)  VALUE SPACES.
           02 CODIGO-CLI     PIC ZZZ.
           02 FILLER         PIC X(25)  VALUE SPACES.
           02 MENSAGEM-ERRO  PIC X(47).
       
       PROCEDURE DIVISION.
       PROG6.

           PERFORM INICIO.
           PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL "SIM".
           PERFORM FIM.
           STOP RUN.

       INICIO.
           OPEN INPUT CADCLI OUTPUT CADOK RELOCOR.
           PERFORM VERIFICA-FIM.
       VERIFICA-FIM.
           READ CADCLI AT END MOVE "SIM" TO FIM-ARQ.
       PRINCIPAL.
           PERFORM TESTE-DE-ERRO.
           PERFORM IMPRESSAO.
           PERFORM VERIFICA-FIM.

       GRAVA-REGOK.
           MOVE CPF      TO CPF-OK.
           MOVE NOME     TO NOME-OK.
           MOVE ESTADO   TO ESTADO-OK.
           MOVE CIDADE   TO CIDADE-OK.
           MOVE EMAIL    TO EMAIL-OK.
           MOVE TELEFONE TO TELEFONE-OK.
           WRITE REGOK.
           
       TESTE-DE-ERRO.
           MOVE 0 TO ERRO.
           MOVE 0 TO ERRO-CPF.
           MOVE 0 TO ERRO-NOME.
           MOVE 0 TO ERRO-ESTADO.
           MOVE 0 TO ERRO-CIDADE.
           MOVE 0 TO ERRO-EMAIL.
           
           PERFORM VALIDAR-ESTADO.
           PERFORM VALIDAR-NOME.
           PERFORM VALIDAR-CPF.
           PERFORM VALIDAR-CIDADE.
           PERFORM VALIDAR-EMAIL.
           
       IMPRESSAO.
           IF ERRO EQUAL 0
              PERFORM GRAVA-REGOK
           ELSE
              IF CT-LIN GREATER THAN 40
                 PERFORM CABECALHO
              END-IF
              PERFORM IMPDET
           END-IF.

       IMPDET.
           MOVE CODIGO TO CODIGO-CLI.
           IF ERRO-NOME EQUAL 1
              MOVE CAB-07 TO MENSAGEM-ERRO
              MOVE 0 TO ERRO-NOME
           ELSE 
              IF ERRO-ESTADO EQUAL 1
                 MOVE CAB-08 TO MENSAGEM-ERRO
                 MOVE 0 TO ERRO-ESTADO
              ELSE
                 IF ERRO-CIDADE EQUAL 1
                    MOVE CAB-09 TO MENSAGEM-ERRO
                    MOVE 0 TO ERRO-CIDADE
                 ELSE
                    IF ERRO-EMAIL EQUAL 1
                       MOVE CAB-10 TO MENSAGEM-ERRO
                       MOVE 0 TO ERRO-EMAIL
                    ELSE
                          MOVE CAB-06 TO MENSAGEM-ERRO
                          MOVE 0 TO ERRO-CPF
                    END-IF
                 END-IF
              END-IF
           END-IF

           WRITE REG-ATR FROM DETALHE AFTER ADVANCING 2 LINES.
           ADD 1 TO CT-LIN.
           IF CT-LIN GREATER THAN 40  GO TO PRINCIPAL.
           MOVE ZEROES TO CODIGO-CLI.

           IF ERRO-NOME EQUAL 1
              MOVE CAB-07 TO MENSAGEM-ERRO
              WRITE REG-ATR FROM DETALHE AFTER ADVANCING 1 LINE
              ADD 1 TO CT-LIN
              IF CT-LIN GREATER THAN 40  GO TO PRINCIPAL
           END-IF.

           IF ERRO-ESTADO EQUAL 1
              MOVE CAB-08 TO MENSAGEM-ERRO
              WRITE REG-ATR FROM DETALHE AFTER ADVANCING 1 LINE
              ADD 1 TO CT-LIN
              IF CT-LIN GREATER THAN 40  GO TO PRINCIPAL
           END-IF.

           IF ERRO-CIDADE EQUAL 1
              MOVE CAB-09 TO MENSAGEM-ERRO
              WRITE REG-ATR FROM DETALHE AFTER ADVANCING 1 LINE
              ADD 1 TO CT-LIN
              IF CT-LIN GREATER THAN 40  GO TO PRINCIPAL
           END-IF.

           IF ERRO-EMAIL EQUAL 1
              MOVE CAB-10 TO MENSAGEM-ERRO
              WRITE REG-ATR FROM DETALHE AFTER ADVANCING 1 LINE
              ADD 1 TO CT-LIN
              IF CT-LIN GREATER THAN 40  GO TO PRINCIPAL
           END-IF.

           IF ERRO-CPF EQUAL 1
              MOVE CAB-06 TO MENSAGEM-ERRO
              WRITE REG-ATR FROM DETALHE AFTER ADVANCING 1 LINE
              ADD 1 TO CT-LIN
           END-IF.

       CABECALHO.
           WRITE REG-ATR FROM CAB-01 AFTER ADVANCING PAGE.
           WRITE REG-ATR FROM CAB-02 AFTER ADVANCING 2 LINES.
           WRITE REG-ATR FROM CAB-03 AFTER ADVANCING 2 LINES.
           WRITE REG-ATR FROM CAB-04 AFTER ADVANCING 1 LINE.
           MOVE 1 TO CT-LIN.

       VALIDAR-NOME.
           IF NOME EQUAL SPACES
              MOVE 1 TO ERRO
              MOVE 1 TO ERRO-NOME
           END-IF.
       VALIDAR-ESTADO.
           IF NOT ESTADO-VALIDO
              MOVE 1 TO ERRO
              MOVE 1 TO ERRO-ESTADO
           END-IF.
       VALIDAR-CIDADE.
           IF CIDADE EQUAL SPACES
              MOVE 1 TO ERRO
              MOVE 1 TO ERRO-CIDADE
           END-IF.
       VALIDAR-EMAIL.
           IF EMAIL EQUAL SPACES
              MOVE 1 TO ERRO
              MOVE 1 TO ERRO-EMAIL
           END-IF.

       VALIDAR-CPF.
           MULTIPLY 10 BY DIG-1 GIVING DIG-1-MULT.
           MULTIPLY 09 BY DIG-2 GIVING DIG-2-MULT.
           MULTIPLY 08 BY DIG-3 GIVING DIG-3-MULT.
           MULTIPLY 07 BY DIG-4 GIVING DIG-4-MULT.
           MULTIPLY 06 BY DIG-5 GIVING DIG-5-MULT.
           MULTIPLY 05 BY DIG-6 GIVING DIG-6-MULT.
           MULTIPLY 04 BY DIG-7 GIVING DIG-7-MULT.
           MULTIPLY 03 BY DIG-8 GIVING DIG-8-MULT.
           MULTIPLY 02 BY DIG-9 GIVING DIG-9-MULT.
           ADD DIG-1-MULT DIG-2-MULT DIG-3-MULT
               DIG-4-MULT DIG-5-MULT DIG-6-MULT
               DIG-7-MULT DIG-8-MULT DIG-9-MULT GIVING DIG-1-MULT.
           DIVIDE DIG-1-MULT BY 11 GIVING RESTO REMAINDER RESTO.
           IF RESTO LESS THAN 2
              MOVE 0 TO DIG-V1-CORRET
           ELSE
              SUBTRACT RESTO FROM 11 GIVING DIG-V1-CORRET
           END-IF

           MULTIPLY 11 BY DIG-1 GIVING DIG-1-MULT.
           MULTIPLY 10 BY DIG-2 GIVING DIG-2-MULT.
           MULTIPLY 09 BY DIG-3 GIVING DIG-3-MULT.
           MULTIPLY 08 BY DIG-4 GIVING DIG-4-MULT.
           MULTIPLY 07 BY DIG-5 GIVING DIG-5-MULT.
           MULTIPLY 06 BY DIG-6 GIVING DIG-6-MULT.
           MULTIPLY 05 BY DIG-7 GIVING DIG-7-MULT.
           MULTIPLY 04 BY DIG-8 GIVING DIG-8-MULT.
           MULTIPLY 03 BY DIG-9 GIVING DIG-9-MULT.
           MULTIPLY 02 BY DIG-V1-CORRET GIVING DIG-V1-CORRET-MULT.
      
           ADD DIG-1-MULT DIG-2-MULT DIG-3-MULT
               DIG-4-MULT DIG-5-MULT DIG-6-MULT
               DIG-7-MULT DIG-8-MULT DIG-9-MULT TO DIG-V1-CORRET-MULT.

           DIVIDE DIG-V1-CORRET-MULT BY 11 GIVING RESTO REMAINDER RESTO.

           IF RESTO LESS THAN 2
              MOVE 0 TO DIG-V2-CORRET
           ELSE
              SUBTRACT RESTO FROM 11 GIVING DIG-V2-CORRET
           END-IF

           IF (DIG-V1 NOT EQUAL DIG-V1-CORRET) OR
              (DIG-V2 NOT EQUAL DIG-V2-CORRET)
              MOVE 1 TO ERRO
              MOVE 1 TO ERRO-CPF
           END-IF.

           FIM.
               CLOSE CADCLI CADOK RELOCOR.
