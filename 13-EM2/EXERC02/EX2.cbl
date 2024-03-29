       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX2.
       AUTHOR. LETICIA CANDIDO.
       INSTALLATION. FATEC-SP.
       DATE-WRITTEN. 22/10/23.
       DATE-COMPILED. 22/10/23.
       SECURITY. APENAS O AUTOR PODE MODIFICAR. 

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-PC.
       OBJECT-COMPUTER. IBM-PC.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CADCLI ASSIGN TO DISK
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT RELCLI ASSIGN TO DISK.

       DATA DIVISION.
       FILE SECTION.

       FD CADCLI
           LABEL RECORD ARE STANDARD
           VALUE OF FILE-IS IS "CADCLI.DAT".

       01 REG-CLI.
           02 CPF-ENT  PIC 9(11).
           02 NOME-ENT PIC X(30).
           02 ESTADO-ENT PIC X(02).
           02 CIDADE-ENT PIC X(30).
           02 TEL-ENT PIC 9(08).
           02 DATA-ENT PIC 9(08).
       
       FD RELCLI
           LABEL RECORD IS OMITTED.

       01 REG-REL
           PIC X(100).

       WORKING-STORAGE SECTION.
           77 FIM-ARQ PIC X(03) VALUE "NAO".
           77 CT-LIN PIC 9(02) VALUE 25.
           77 CT-PAG PIC 9(02) VALUE ZEROES.
           77 TOTAL  PIC 9(04) VALUE ZEROES.

       01 CAB-01.
           02 FILLER  PIC X(90) VALUE SPACES.
           02 FILLER  PIC X(05) VALUE "PAG. ".
           02 VAR-PAG PIC 99.
           02 FILLER  PIC X(03) VALUE SPACES.
       01 CAB-02.
           02 FILLER PIC X(43) VALUE SPACES.
           02 FILLER PIC X(17) VALUE "TURISMAR TURISMOS".
           02 FILLER PIC X(40) VALUE SPACES.
       01 CAB-03.
           02 FILLER PIC X(32) VALUE SPACES.
           02 FILLER PIC X(11) VALUE "CLIENTES NO".
           02 FILLER PIC X(01) VALUE SPACES.
           02 FILLER PIC X(07) VALUE "PERIODO".
           02 FILLER PIC X(01) VALUE SPACES.
           02 FILLER PIC X(15) VALUE "DE: 2010 A 2011".
           02 FILLER PIC X(43) VALUE SPACES.
       01 CAB-04.
           02 FILLER PIC X(20) VALUE SPACES.
           02 FILLER PIC X(04) VALUE "NOME".
           02 FILLER PIC X(25) VALUE SPACES.
           02 FILLER PIC X(06) VALUE "ESTADO".
           02 FILLER PIC X(20) VALUE SPACES.
           02 FILLER PIC X(8) VALUE "TELEFONE".
           02 FILLER PIC X(27) VALUE SPACES.
       01 DETALHE.
           02 FILLER PIC X(15) VALUE SPACES.
           02 NOM PIC X(30).
           02 FILLER PIC X(6) VALUE SPACES.
           02 EST PIC X(02).
           02 FILLER PIC X(22) VALUE SPACES.
           02 TEL PIC 9(08).
           02 FILLER PIC X(17) VALUE SPACES.
       01 DETALHE-FINAL.
           02 FILLER PIC X(15) VALUE SPACES.
           02 FILLER PIC X(19) VALUE "TOTAL DE CLIENTES: ".
           02 TOTALCLI PIC 9(4).
           02 FILLER PIC X(62) VALUE SPACES.

       PROCEDURE DIVISION.
           PERFORM INICIO.
           PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL "SIM".
           PERFORM TOTAL-CLIENTES.
           PERFORM FIM.
           STOP RUN.

       INICIO.
           OPEN INPUT CADCLI
                OUTPUT RELCLI.
           PERFORM LEITURA.

       LEITURA.
           READ CADCLI AT END MOVE "SIM" TO FIM-ARQ.

       PRINCIPAL.
           PERFORM IMPRESSAO.
           PERFORM LEITURA.

       IMPRESSAO.
               IF CT-LIN GREATER THAN 24
               PERFORM CABECALHO.
           PERFORM IMPRESSAO-DETALHE.

       CABECALHO.
           ADD 1 TO CT-PAG.
           MOVE CT-PAG TO VAR-PAG.
           MOVE SPACES TO REG-REL.
           WRITE REG-REL AFTER ADVANCING PAGE.
           WRITE REG-REL FROM CAB-01 AFTER ADVANCING 2 LINE.
           WRITE REG-REL FROM CAB-02 AFTER ADVANCING 2 LINE.
           WRITE REG-REL FROM CAB-03 AFTER ADVANCING 2 LINE.
           WRITE REG-REL FROM CAB-04 AFTER ADVANCING 2 LINE.
           MOVE ZEROES TO CT-LIN.

       IMPRESSAO-DETALHE.   
           MOVE NOME-ENT TO NOM.
           MOVE ESTADO-ENT TO EST.
           MOVE TEL-ENT TO TEL.
           WRITE REG-REL FROM DETALHE AFTER ADVANCING 1 LINE.
           ADD 1 TO CT-LIN.
           ADD 1 TO TOTAL.
       
       TOTAL-CLIENTES.
           MOVE TOTAL TO TOTALCLI.
           WRITE REG-REL FROM DETALHE-FINAL AFTER ADVANCING 2 LINES.
       FIM.
           CLOSE CADCLI RELCLI.
