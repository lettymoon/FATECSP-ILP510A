       IDENTIFICATION DIVISION.   
       PROGRAM-ID.    EX03.
       AUTHOR.        Leticia Candido.
       INSTALLATION.  FATECSP.
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
       SELECT CADENT ASSIGN TO DISK 
       ORGANIZATION IS LINE SEQUENTIAL.
       SELECT TRAB ASSIGN TO DISK.
       SELECT CADSAI ASSIGN TO DISK 
       ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD CADENT
           LABEL RECORD ARE STANDARD 
           VALUE OF FILE-ID IS "CADENT".

       01 REG-ENT.
           02 CODIGO-ENT   PIC 9(05).
           02 NOME-ENT     PIC X(30).
           02 DEPT-ENT     PIC 9(02).

       SD TRAB.
        
       01 REG-TRAB.
           02 CODIGO-TRAB  PIC 9(05).
           02 NOME-TRAB    PIC X(30).
           02 DEPT-TRAB    PIC 9(02).

       FD CADSAI
           LABEL RECORD ARE STANDARD 
           VALUE OF FILE-ID IS "CADSAI".

       01 REG-SAI.
           02 CODIGO-SAI   PIC 9(05).
           02 NOME-SAI     PIC X(30).

       WORKING-STORAGE SECTION.
           77 FIM-ARQ        PIC 9(01) VALUE 0.

       PROCEDURE DIVISION.

       SORT TRAB
            ASCENDING KEY CODIGO-TRAB
            USING CADENT
            OUTPUT PROCEDURE SAIDA
       STOP RUN.

       SAIDA SECTION.
              PERFORM INICIO.
              PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL 1.
              PERFORM FIM.

       INICIO SECTION.
              OPEN OUTPUT CADSAI.
              PERFORM VERIFICA-FIM.

       VERIFICA-FIM SECTION.
              RETURN TRAB AT END MOVE 1 TO FIM-ARQ.

       PRINCIPAL SECTION.
              PERFORM SELECAO.
              PERFORM VERIFICA-FIM.

       SELECAO SECTION.
              IF DEPT-TRAB EQUAL 01 OR 02 PERFORM GRAVACAO.

       GRAVACAO SECTION.
              MOVE CODIGO-TRAB TO CODIGO-SAI.
              MOVE NOME-TRAB TO NOME-SAI.
              WRITE REG-SAI.

       FIM SECTION.
              CLOSE CADSAI.
