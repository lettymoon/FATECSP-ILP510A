       IDENTIFICATION DIVISION.   
       PROGRAM-ID.    EX06.
       AUTHOR.        LETICIA CANDIDO.
       INSTALLATION.  FATECSP.
       DATE-WRITTEN.  12/11/2023.
       DATE-COMPILED. 14/11/2023.
       SECURITY.	APENAS O AUTOR PODE MODIFICAR.

       ENVIRONMENT DIVISION.

       CONFIGURATION SECTION.
       SOURCE-COMPUTER. lettyPC.
       OBJECT-COMPUTER. lettyPC.
       SPECIAL-NAMES.   DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT CADVEND ASSIGN TO DISK 
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT REL-PAG ASSIGN TO DISK.
       SELECT TRAB    ASSIGN TO DISK.

       DATA DIVISION.

       FILE SECTION.
       FD CADVEND
           LABEL RECORD ARE STANDARD 
           VALUE OF FILE-ID IS "CADVEND.DAT".

       01 REG-ENT.
           02 COD-DEP-ENT   PIC X(01).
           02 COD-SEC-ENT   PIC X(01).
           02 COD-VEND-ENT  PIC 9(05).
           02 NOME-ENT      PIC X(20).
           02 VAL-VEND-ENT  PIC 9(07)V99.
           02 SAL-FIXO-ENT  PIC 9(07)V99.
           02 DENCONTO-ENT  PIC 9(05)V99.

       FD REL-PAG
           LABEL RECORD IS OMITTED.

       01 REG-ATR          PIC X(80).

       SD TRAB.

       01 REG-TRAB.
           02 COD-DEP-TRAB  PIC X(01).
           02 COD-SEC-TRAB  PIC X(01).
           02 COD-VEND-TRAB PIC 9(05).
           02 NOME-TRAB     PIC X(20).
           02 VAL-VEND-TRAB PIC 9(07)V99.
           02 SAL-FIXO-TRAB PIC 9(07)V99.
           02 DENCONTO-TRAB PIC 9(05)V99.

       WORKING-STORAGE SECTION.

           77 FIM-ARQ          PIC 9(01) VALUE 0.
           77 CT-PAG           PIC 9(03) VALUE 0.
           77 CT-LIN           PIC 9(02) VALUE 41.
           77 COMISSAO         PIC 9(07)V99.
           77 SAL-BRUTO        PIC 9(07)V99.
           77 SAL-LIQUIDO      PIC 9(07)V99.
           77 TOTAL-SAL-SEC    PIC 9(09)V99.
           77 TOTAL-SAL-DEP    PIC 9(12)V99.
           77 COD-DEP-ATUAL    PIC X(01).
           77 COD-SEC-ATUAL    PIC X(01).
           77 FLAG-01          PIC 9(01) VALUE 1.

       01 CAB-01.
           02 FILLER    PIC X(29) VALUE SPACES.
           02 FILLER    PIC X(22) VALUE "RELAT RIO DE PAGAMENTO".
           02 FILLER    PIC X(19) VALUE SPACES.
           02 FILLER    PIC X(05) VALUE "PAG. ".
           02 VAR-PAG   PIC ZZ9.
           02 FILLER    PIC X(18) VALUE SPACES.

       01 CAB-02.
           02 FILLER       PIC X(01) VALUE SPACES.
           02 FILLER       PIC X(16) VALUE "DEPARTAMENTO  = ".
           02 COD-DEP-REL  PIC X(01).
           02 FILLER       PIC X(62) VALUE SPACES.
 
       01 CAB-03.
           02 FILLER       PIC X(01) VALUE SPACES.
           02 FILLER       PIC X(16) VALUE "SECAO         = ".
           02 COD-SEC-REL  PIC X(01).
           02 FILLER       PIC X(62) VALUE SPACES.

       01 CAB-04.
           02 FILLER       PIC X(06) VALUE "CODIGO".
           02 FILLER       PIC X(02) VALUE SPACES.
           02 FILLER       PIC X(04) VALUE "NOME".
           02 FILLER       PIC X(16) VALUE SPACES.
           02 FILLER       PIC X(08) VALUE "SAL.FIXO".
           02 FILLER       PIC X(03) VALUE SPACES.
           02 FILLER       PIC X(08) VALUE "COMISSAO".
           02 FILLER       PIC X(02) VALUE SPACES.
           02 FILLER       PIC X(10) VALUE "SAL.BRUTO".
           02 FILLER       PIC X(01) VALUE SPACES.
           02 FILLER       PIC X(08) VALUE "DESCONTO".
           02 FILLER       PIC X(01) VALUE SPACES.
           02 FILLER       PIC X(11) VALUE "SAL.LIQUIDO".

       01 CAB-05.
           02 FILLER PIC X(28) VALUE
                    "TOTAL DE SALARIOS DA SECAO: ".
           02 TOTAL-SAL-SEC-REL PIC ZZZ.ZZZ.ZZ9,99.
           02 FILLER PIC X(38) VALUE SPACES.

       01 CAB-06.
           02 FILLER PIC X(35) VALUE
                    "TOTAL DE SALARIOS DO DEPARTAMENTO: ".
           02 TOTAL-SAL-DEP-REL PIC ZZZ.ZZZ.ZZZ.ZZ9,99.
           02 FILLER PIC X(27) VALUE SPACES.

       01 DETALHE.
           02 COD-VEND-REL PIC 9(05).
           02 FILLER       PIC X(01) VALUE SPACES.
           02 NOME-REL     PIC X(20).
           02 FILLER       PIC X(01) VALUE SPACES.
           02 SAL-FIXO-REL PIC ZZZZZZ9,99.
           02 FILLER       PIC X(01) VALUE SPACES.
           02 COMISSAO-REL PIC ZZZZZZ9,99.
           02 FILLER       PIC X(01) VALUE SPACES.
           02 SAL-BRUT-REL PIC ZZZZZZ9,99.
           02 FILLER       PIC X(01) VALUE SPACES.
           02 DESCONTO-REL PIC ZZZZ9,99.
           02 FILLER       PIC X(01) VALUE SPACES.
           02 SAL-LIQU-REL PIC ZZZZZZ9,99.
           02 FILLER       PIC X(01) VALUE SPACES.

       PROCEDURE DIVISION.

       SORT TRAB
            ASCENDING COD-DEP-TRAB
            ASCENDING COD-SEC-TRAB
            USING CADVEND
            OUTPUT PROCEDURE GERA-REL.
       STOP RUN.

       INICIO.
              OPEN INPUT CADVEND OUTPUT REL-PAG.
              PERFORM VERIFICA-FIM.

       VERIFICA-FIM.
              RETURN TRAB AT END MOVE 1 TO FIM-ARQ.

       FIM.
              CLOSE CADVEND REL-PAG.

       PRINCIPAL.
              IF COD-DEP-ATUAL NOT EQUAL COD-DEP-TRAB

                 IF CT-PAG NOT EQUAL 0
                     PERFORM CABECALHO-SECAO-DEPARTAMENTO
                 END-IF

                 MOVE 0 TO TOTAL-SAL-DEP

                 MOVE COD-DEP-TRAB  TO COD-DEP-ATUAL 
                 MOVE COD-DEP-ATUAL TO COD-DEP-REL

                 PERFORM AVANCA-PAGINA
                 PERFORM CABECALHO-DEPARTAMENTO

                 MOVE COD-SEC-TRAB TO COD-SEC-REL
                 WRITE REG-ATR FROM CAB-03 AFTER ADVANCING 1 LINE
                 MOVE 1 TO FLAG-01

              END-IF

              IF COD-SEC-ATUAL NOT EQUAL COD-SEC-TRAB

                 MOVE COD-SEC-TRAB  TO COD-SEC-ATUAL 
                 MOVE COD-SEC-ATUAL TO COD-SEC-REL

                 IF FLAG-01 NOT EQUAL 1
                    MOVE TOTAL-SAL-SEC TO TOTAL-SAL-SEC-REL
                    WRITE REG-ATR FROM CAB-05 AFTER ADVANCING 2 LINES

                    WRITE REG-ATR FROM CAB-03 AFTER ADVANCING 2 LINES
                 END-IF

                 MOVE 0 TO FLAG-01
                 MOVE 0 TO TOTAL-SAL-SEC

                 WRITE REG-ATR FROM CAB-04 AFTER ADVANCING 2 LINES

              END-IF

              PERFORM IMPRESSAO.
              PERFORM VERIFICA-FIM.

       IMPRESSAO.
              IF CT-LIN GREATER THAN 40
                 PERFORM AVANCA-PAGINA
              END-IF
              PERFORM IMPDET.

       IMPDET.
              PERFORM CALCULA-COMISSAO.
              ADD SAL-FIXO-TRAB COMISSAO GIVING SAL-BRUTO.
              SUBTRACT DENCONTO-TRAB FROM SAL-BRUTO GIVING SAL-LIQUIDO.

              MOVE COD-VEND-TRAB TO COD-VEND-REL.
              MOVE NOME-TRAB     TO NOME-REL.
              MOVE SAL-FIXO-TRAB TO SAL-FIXO-REL.
              MOVE COMISSAO      TO COMISSAO-REL.
              MOVE SAL-BRUTO     TO SAL-BRUT-REL.
              MOVE SAL-LIQUIDO   TO SAL-LIQU-REL.
              MOVE DENCONTO-TRAB TO DESCONTO-REL.

              WRITE REG-ATR FROM DETALHE AFTER ADVANCING 1 LINE.
              ADD 1 TO CT-LIN.

              ADD SAL-LIQUIDO    TO TOTAL-SAL-DEP   TOTAL-SAL-SEC.

       AVANCA-PAGINA.
              ADD  1 TO CT-PAG.
              MOVE 0 TO CT-LIN.
              MOVE SPACES TO REG-ATR.
              WRITE REG-ATR AFTER ADVANCING PAGE.

       CABECALHO-SECAO-DEPARTAMENTO.
                    MOVE TOTAL-SAL-SEC TO TOTAL-SAL-SEC-REL.
                    WRITE REG-ATR FROM CAB-05 AFTER ADVANCING 2 LINES.
                    MOVE TOTAL-SAL-DEP TO TOTAL-SAL-DEP-REL.
                    WRITE REG-ATR FROM CAB-06 AFTER ADVANCING 1 LINE.

       CALCULA-COMISSAO.
              IF VAL-VEND-TRAB NOT GREATER THAN 1000
                 MULTIPLY VAL-VEND-TRAB BY 0,05 GIVING COMISSAO
              ELSE
                 IF VAL-VEND-TRAB NOT GREATER THAN 3000
                    MULTIPLY VAL-VEND-TRAB BY 0,10 GIVING COMISSAO
                 ELSE
                    MULTIPLY VAL-VEND-TRAB BY 0,15 GIVING COMISSAO
                 END-IF
              END-IF.

       CABECALHO-DEPARTAMENTO.
              MOVE CT-PAG TO VAR-PAG.
              WRITE REG-ATR FROM CAB-01 AFTER ADVANCING 1 LINE.
              WRITE REG-ATR FROM CAB-02 AFTER ADVANCING 2 LINES.         

       GERA-REL SECTION.
              PERFORM INICIO.
              PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL 1.
              PERFORM CABECALHO-SECAO-DEPARTAMENTO.
              PERFORM FIM.
