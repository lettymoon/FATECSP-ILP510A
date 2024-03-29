       IDENTIFICATION DIVISION.   
       PROGRAM-ID.    EX04.
       AUTHOR.        Leticia Candido.
       INSTALLATION.  FATEC-SP.
       DATE-WRITTEN.  13/11/2023.
       DATE-COMPILED. 14/11/2023.
       SECURITY.      APENAS O AUTOR PODE MODIFICAR.

       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.
       SOURCE-COMPUTER. lettyPC.
       OBJECT-COMPUTER. lettyPC.
       SPECIAL-NAMES.   DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CAD-CLI ASSIGN TO DISK 
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT REL-GRL ASSIGN TO DISK.
           SELECT TRAB    ASSIGN TO DISK.
       
       DATA DIVISION.
       FILE SECTION.

       FD CAD-CLI
         LABEL RECORD ARE STANDARD 
         VALUE OF FILE-ID IS "CAD-CLI.DAT".

       01 REG-ENT.
           02 CODIGO-ENT    PIC 9(03).
           02 CPF-ENT       PIC 9(11).
           02 NOME-ENT      PIC X(30).
           02 ESTADO-ENT    PIC X(02).
           02 CIDADE-ENT    PIC X(30).
           02 EMAIL-ENT     PIC X(30).

       SD TRAB.

       01 REG-TRAB.
           02 CODIGO-TRAB    PIC 9(03).
           02 CPF-TRAB       PIC 9(11).
           02 NOME-TRAB      PIC X(30).
           02 ESTADO-TRAB    PIC X(02).
           02 CIDADE-TRAB    PIC X(30).
           02 EMAIL-TRAB     PIC X(30).

       FD REL-GRL 
           LABEL RECORD IS OMITTED.

       01 REG-ATR          PIC X(80).

       WORKING-STORAGE SECTION.

           77 FIM-ARQ       PIC 9(01) VALUE 0.
           77 CT-PAG        PIC 9(02) VALUE 0.
           77 CT-LIN        PIC 9(02) VALUE 21.
           77 ESTADO-ATUAL  PIC X(02).
           77 CIDADE-ATUAL  PIC X(30).
           77 FLAG-1        PIC 9(01) VALUE 1.

       01 CAB-01.
           02 FILLER      PIC X(23) VALUE SPACES.
           02 FILLER      PIC X(37) VALUE 
                               "RELA  O DE CLIENTES POR ESTADO/CIDADE".
           02 FILLER      PIC X(05) VALUE SPACES.
           02 FILLER      PIC X(05) VALUE "PAG. ".
           02 VAR-PAG     PIC ZZ9.
           02 FILLER      PIC X(07) VALUE SPACES.

       01 CAB-02.
           02 FILLER      PIC X(08) VALUE "ESTADO: ".
           02 ESTADO-REL  PIC X(02).
           02 FILLER      PIC X(70) VALUE SPACES.
         
       01 CAB-03.
           02 FILLER      PIC X(08) VALUE "CIDADE: ".
           02 CIDADE-REL  PIC X(30).
           02 FILLER      PIC X(42) VALUE SPACES.
  
       01 CAB-04.
           02 FILLER      PIC X(03) VALUE "CPF".
           02 FILLER      PIC X(24) VALUE SPACES.
           02 FILLER      PIC X(04) VALUE "NOME".
           02 FILLER      PIC X(20) VALUE SPACES.
           02 FILLER      PIC X(06) VALUE "E-MAIL". 
           02 FILLER      PIC X(23) VALUE SPACES.

       01 DETALHE.
           02 CPF-REL     PIC X(14) VALUE "999.999.999-99".
           02 FILLER      PIC X(03) VALUE SPACES.
           02 NOME-REL    PIC X(30).
           02 FILLER      PIC X(03) VALUE SPACES.
           02 EMAIL-REL   PIC X(30).
         
       PROCEDURE DIVISION.

       SORT TRAB
            ASCENDING KEY ESTADO-TRAB
            ASCENDING KEY CIDADE-TRAB
            ASCENDING KEY CPF-TRAB
            USING CAD-CLI
            OUTPUT PROCEDURE GERA-REL.

       STOP RUN.

       INICIO.
              OPEN INPUT CAD-CLI OUTPUT REL-GRL.
              PERFORM VERIFICA-FIM.

       VERIFICA-FIM.
              RETURN TRAB AT END MOVE 1 TO FIM-ARQ.

       FIM.
              CLOSE CAD-CLI REL-GRL.

       AVANCA-PAGINA.
              ADD  1 TO CT-PAG.
              MOVE 0 TO CT-LIN.
              MOVE SPACES TO REG-ATR.
              WRITE REG-ATR AFTER ADVANCING PAGE.

       PRINCIPAL.
              IF ESTADO-ATUAL NOT EQUAL ESTADO-TRAB
                 MOVE ESTADO-TRAB  TO ESTADO-ATUAL
                 MOVE ESTADO-ATUAL TO ESTADO-REL
                 PERFORM AVANCA-PAGINA
                 PERFORM CABECALHO-ESTADO
              END-IF

              IF CIDADE-ATUAL NOT EQUAL CIDADE-TRAB
                 MOVE CIDADE-TRAB  TO CIDADE-ATUAL
                 MOVE CIDADE-ATUAL TO CIDADE-REL
                 PERFORM CABECALHO-CIDADE
              END-IF

              PERFORM IMPRESSAO.
              PERFORM VERIFICA-FIM.

       IMPRESSAO.
              IF CT-LIN GREATER THAN 20
                 PERFORM AVANCA-PAGINA
              END-IF
              PERFORM IMPDET.

       IMPDET.
              MOVE CPF-TRAB(1:3)  TO CPF-REL(1:3).
              MOVE CPF-TRAB(4:3)  TO CPF-REL(5:3).
              MOVE CPF-TRAB(7:3)  TO CPF-REL(9:3).
              MOVE CPF-TRAB(10:2) TO CPF-REL(13:2).
              MOVE NOME-TRAB  TO NOME-REL.
              MOVE EMAIL-TRAB TO EMAIL-REL.
              WRITE REG-ATR FROM DETALHE AFTER ADVANCING 1 LINE.
              ADD 1 TO CT-LIN.

       CABECALHO-ESTADO.
              MOVE CT-PAG TO VAR-PAG.
              WRITE REG-ATR FROM CAB-01 AFTER ADVANCING 1 LINE.
              WRITE REG-ATR FROM CAB-02 AFTER ADVANCING 2 LINES.

       CABECALHO-CIDADE.
              WRITE REG-ATR FROM CAB-03 AFTER ADVANCING 2 LINES.
              WRITE REG-ATR FROM CAB-04 AFTER ADVANCING 2 LINES.
              MOVE SPACES TO REG-ATR.
              WRITE REG-ATR AFTER ADVANCING 1 LINE.

       GERA-REL SECTION.
              PERFORM INICIO.
              PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL 1.
              PERFORM FIM.
