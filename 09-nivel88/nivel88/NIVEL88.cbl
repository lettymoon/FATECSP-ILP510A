       IDENTIFICATION DIVISION.
       PROGRAM-ID. NIVEL88.
       AUTHOR. LETICIA CANDIDO.
       INSTALLATION. FATEC-SP.
       DATE-WRITTEN. 15/08/2023.
       DATE-COMPILED. 15/08/2023.
       SECURITY. APENAS O AUTOR PODE MODIFICAR.
       
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. LETTY-PC.
       OBJECT-COMPUTER. LETTY-PC.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.
       
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CAD-ENT ASSIGN TO DISK
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT CAD-OK ASSIGN TO DISK
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT CAD-RUIM ASSIGN TO DISK
           ORGANIZATION IS LINE SEQUENTIAL.
       
       DATA DIVISION.
       FILE SECTION.
       
       FD CAD-ENT
           LABEL RECORDS ARE STANDARD
           DATA RECORD IS REG-ENT
           VALUE OF FILE-ID IS "CAD-ENT.DAT".
       01 REG-ENT.
           02 COD-ENT  PIC 9(02).
           02 NOME-ENT PIC X(30).
               88 NOME-INVALIDO VALUE SPACES.
           02 SEXO-ENT PIC X(01).
               88 SEXO-VALIDO VALUE "F", "f", "M", "m".
           02 MES-ENT  PIC 9(02).
               88 MES-VALIDO VALUE 1 THRU 12.
       
       FD CAD-OK
           LABEL RECORD IS OMITTED.
       01 REG-OK.
           02 COD-SAI  PIC 9(02).
           02 NOME-SAI PIC X(30).
           02 SEXO-SAI PIC X(01).
           02 MES-SAI  PIC 9(02).
       
       FD CAD-RUIM
           LABEL RECORD IS OMITTED.
       01 REG-RUIM.
           02 COD-SAIR  PIC 9(02).
           02 NOME-SAIR PIC X(30).
           02 SEXO-SAIR PIC X(01).
           02 MES-SAIR  PIC 9(02).
       
       WORKING-STORAGE SECTION.
           77 FIM-ARQ PIC X(01) VALUE "N".
           77 CH-ERRO PIC X(01) VALUE "N".
       
       PROCEDURE DIVISION.
       PGM-NIVEL88.
           PERFORM INICIO
           PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL "S"
           PERFORM FIM.
           STOP RUN.
       
           INICIO.
               OPEN INPUT  CAD-ENT
                    OUTPUT CAD-OK
                           CAD-RUIM.
               PERFORM LEITURA.
       
           LEITURA.
               READ CAD-ENT 
                   AT END MOVE "S" TO FIM-ARQ.
           PRINCIPAL.
               PERFORM CONDICAO.
               PERFORM LEITURA.
           CONDICAO.
               MOVE "N" TO CH-ERRO.
               PERFORM VALIDACAO.
               IF CH-ERRO EQUAL "N"
                   PERFORM GRAVA-OK
               ELSE 
                   PERFORM GRAVA-RUIM
               END-IF.

           VALIDACAO.
               IF NOT (NOME-INVALIDO) AND SEXO-VALIDO AND MES-VALIDO
                   MOVE "N" TO CH-ERRO
               ELSE
                   MOVE "S" TO CH-ERRO
               END-IF.
           GRAVA-OK.
               MOVE COD-ENT TO COD-SAI
               MOVE NOME-ENT TO NOME-SAI
               MOVE SEXO-ENT TO SEXO-SAI
               MOVE MES-ENT TO MES-SAI
               WRITE REG-OK.
           
           GRAVA-RUIM.
               MOVE COD-ENT TO COD-SAIR
               MOVE NOME-ENT TO NOME-SAIR
               MOVE SEXO-ENT TO SEXO-SAIR
               MOVE MES-ENT TO MES-SAIR
               WRITE REG-RUIM.
       
           FIM.
                  CLOSE CAD-ENT CAD-OK CAD-RUIM.


