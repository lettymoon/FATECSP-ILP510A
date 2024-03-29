       IDENTIFICATION DIVISION.   
       PROGRAM-ID.    EX07.
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
       SELECT CADALU ASSIGN TO DISK 
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT RELADU ASSIGN TO DISK.
       SELECT TRAB   ASSIGN TO DISK.

       DATA DIVISION.

       FILE SECTION.
       FD CADALU
           LABEL RECORD ARE STANDARD 
           VALUE OF FILE-ID IS "CADALU.DAT".

       01 REG-ENT.
           02 TURMA-ENT  PIC 9(03).
           02 CODIGO-ENT PIC 9(07).
           02 NOME-ENT   PIC X(30).
           02 NOTAS-ENT  PIC 9(02)V9(02) OCCURS 4 TIMES.

       FD RELADU
           LABEL RECORD IS OMITTED.

       01 REG-ATR  PIC X(80).

       SD TRAB.

       01 REG-TRAB.
           02 TURMA-TRAB  PIC 9(03).
           02 CODIGO-TRAB PIC 9(07).
           02 NOME-TRAB   PIC X(30).
           02 NOTAS-TRAB  PIC 9(02)V9(02) OCCURS 4 TIMES.

       WORKING-STORAGE SECTION.

           77 FIM-ARQ          PIC 9(01) VALUE 0.
           77 TOTAL-APROVADOS  PIC 9(03).
           77 TOTAL-REPROVADOS PIC 9(03).
           77 SOMATORIA-MEDIA  PIC 9(02)V9(02).
           77 MEDIA            PIC 9(02)V9(02).
           77 CT-PAG           PIC 9(03) VALUE 0.
           77 CT-LIN           PIC 9(02) VALUE 41.
           77 INDICE           PIC 9(01).
           77 TURMA-ATUAL      PIC 9(03).

       01 CAB-01.
           02 FILLER    PIC X(18) VALUE SPACES.
           02 FILLER    PIC X(17) VALUE "RELATOR DE ALUNOS".
           02 FILLER    PIC X(19) VALUE SPACES.
           02 FILLER    PIC X(05) VALUE "PAG. ".
           02 VAR-PAG   PIC ZZ9.
           02 FILLER    PIC X(18) VALUE SPACES.

       01 CAB-02.
           02 FILLER    PIC X(11) VALUE SPACES.
           02 FILLER    PIC X(07) VALUE "TURMA: ".
           02 NUM-TURMA PIC 9(03).
           02 FILLER    PIC X(59) VALUE SPACES.

       01 CAB-03.
           02 FILLER    PIC X(07) VALUE SPACES.
           02 FILLER    PIC X(06) VALUE "CODIGO".
           02 FILLER    PIC X(25) VALUE SPACES.
           02 FILLER    PIC X(04) VALUE "NOME".
           02 FILLER    PIC X(19) VALUE SPACES.
           02 FILLER    PIC X(05) VALUE "MEDIA".
           02 FILLER    PIC X(14) VALUE SPACES.

       01 DETALHE.
           02 FILLER     PIC X(06) VALUE SPACES.
           02 CODIGO-REL PIC X(10) VALUE "999.999-9".
           02 FILLER     PIC X(08) VALUE SPACES.
           02 NOME-REL   PIC X(30).
           02 FILLER     PIC X(07) VALUE SPACES.
            02 MEDIA-REL  PIC 99,99.
         
       01 CAB-TOTAL-1.
           02 FILLER       PIC X(38) VALUE SPACES.
           02 FILLER       PIC X(25) VALUE "TOTAL DE ALUNOS APROVADOS".
           02 FILLER       PIC X(03) VALUE SPACES.
           02 TOTAL-APROV  PIC 99,99.
           02 FILLER       PIC X(09) VALUE SPACES.

       01 CAB-TOTAL-2.
           02 FILLER       PIC X(38) VALUE SPACES.
           02 FILLER       PIC X(26) VALUE "TOTAL DE ALUNOS REPROVADOS".
           02 FILLER       PIC X(02) VALUE SPACES.
           02 TOTAL-REPROV PIC 99,99.
           02 FILLER       PIC X(09) VALUE SPACES.

       01 CAB-TOTAL-3.
           02 FILLER       PIC X(38) VALUE SPACES.
           02 FILLER       PIC X(11) VALUE "MEDIA GERAL".
           02 FILLER       PIC X(17) VALUE SPACES.
           02 MEDIA-GERAL  PIC 99,99.
           02 FILLER       PIC X(09) VALUE SPACES.

       PROCEDURE DIVISION.

       SORT TRAB
           ASCENDING KEY TURMA-TRAB
           ASCENDING KEY CODIGO-TRAB
           USING CADALU
           OUTPUT PROCEDURE GERA-REL.

       STOP RUN.

       INICIO.
              OPEN INPUT CADALU OUTPUT RELADU.
              PERFORM VERIFICA-FIM.

       VERIFICA-FIM.
              RETURN TRAB AT END MOVE 1 TO FIM-ARQ.

       PRINCIPAL.
              IF TURMA-ATUAL NOT EQUAL TURMA-TRAB
                 IF CT-PAG NOT EQUAL 0
                    PERFORM CABECARIO-TOTAL
                 END-IF
                 MOVE TURMA-TRAB TO TURMA-ATUAL
                 MOVE 0 TO SOMATORIA-MEDIA
                 MOVE 0 TO TOTAL-APROVADOS TOTAL-REPROVADOS
                 PERFORM AVANCA-PAGINA
                 PERFORM CABECALHO-TURMA
              END-IF
              PERFORM IMPRESSAO.
              PERFORM VERIFICA-FIM.

       IMPRESSAO.
              MOVE 0 TO MEDIA.
              MOVE 1 TO INDICE.
              PERFORM CALCULA-MEDIA 04 TIMES.
              DIVIDE 4 INTO MEDIA.  
              IF MEDIA NOT LESS THAN 7
                     ADD 1 TO TOTAL-APROVADOS
              ELSE
                     ADD 1 TO TOTAL-REPROVADOS
              END-IF
              ADD MEDIA TO SOMATORIA-MEDIA.
              IF CT-LIN GREATER THAN 40
                     PERFORM AVANCA-PAGINA
              END-IF
              PERFORM IMPDET.

       CALCULA-MEDIA. 
              ADD NOTAS-TRAB(INDICE) TO MEDIA.
              ADD 1 TO INDICE.

       FIM.
              CLOSE CADALU RELADU.

       IMPDET.
              MOVE CODIGO-TRAB(1:3) TO CODIGO-REL(1:3).
              MOVE CODIGO-TRAB(4:3) TO CODIGO-REL(5:3).
              MOVE CODIGO-TRAB(7:1) TO CODIGO-REL(9:1).
              MOVE NOME-TRAB TO NOME-REL.
              MOVE MEDIA TO MEDIA-REL.
              WRITE REG-ATR FROM DETALHE AFTER ADVANCING 1 LINE.
              ADD 1 TO CT-LIN.

       CABECALHO-TURMA.
              MOVE CT-PAG TO VAR-PAG.
              WRITE REG-ATR FROM CAB-01 AFTER ADVANCING 1 LINE.
              MOVE TURMA-TRAB TO NUM-TURMA.
              WRITE REG-ATR FROM CAB-02 AFTER ADVANCING 2 LINES.
              WRITE REG-ATR FROM CAB-03 AFTER ADVANCING 2 LINES.
              MOVE SPACES TO REG-ATR.
              WRITE REG-ATR AFTER ADVANCING 1 LINE.
              MOVE 0 TO CT-LIN.

       CABECARIO-TOTAL.
              MOVE TOTAL-APROVADOS  TO TOTAL-APROV.
              MOVE TOTAL-REPROVADOS TO TOTAL-REPROV.
              WRITE REG-ATR FROM CAB-TOTAL-1 AFTER ADVANCING 2 LINES.
              WRITE REG-ATR FROM CAB-TOTAL-2 AFTER ADVANCING 1 LINE.
              ADD TOTAL-APROVADOS TO TOTAL-REPROVADOS.
              DIVIDE TOTAL-REPROVADOS INTO SOMATORIA-MEDIA.
              MOVE SOMATORIA-MEDIA TO MEDIA-GERAL.
              WRITE REG-ATR FROM CAB-TOTAL-3 AFTER ADVANCING 1 LINE.

       AVANCA-PAGINA.
              ADD  1 TO CT-PAG.
              MOVE 0 TO CT-LIN.
              MOVE SPACES TO REG-ATR.
              WRITE REG-ATR AFTER ADVANCING PAGE.

       GERA-REL SECTION.
              PERFORM INICIO.
              PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL 1.
              PERFORM CABECARIO-TOTAL.
              PERFORM FIM.
