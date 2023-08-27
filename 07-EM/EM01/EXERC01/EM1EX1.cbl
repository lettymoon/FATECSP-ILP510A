       IDENTIFICATION DIVISION.
       PROGRAM-ID. EX01.
       AUTHOR. LETICIA CÂNDIDO 
       INSTALLATION. FATEC-SP
       DATE-WRITTEN. 26/08/2023
       DATE-COMPILED. 26/08/2023
       SECURITY. APENAS O AUTOR PODE MODIFICA-LO
       
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
           OBJECT-COMPUTER. IBM-PC.
           SPECIAL-NAMES. DECIMAL-POINT IS COMMA.
       
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CADCLI1 ASSIGN TO DISK
                  ORGANIZATION IS LINE SEQUENTIAL.
           SELECT CADCLI2 ASSIGN TO DISK
                  ORGANIZATION IS LINE SEQUENTIAL.
       
       DATA DIVISION.
       FILE SECTION.
       FD CADCLI1.
       01 REG-ENT.
          02 COD-ENT  PIC 9(05).
          02 NOME-ENT PIC X(20).
       
       FD CADCLI2.
       01 REG-SAI.
          02 NOME-SAI PIC X(20).
          02 COD-SAI  PIC 9(05).
       
       WORKING-STORAGE SECTION.
          77 FIM-ARQ-ENT PIC X VALUE "N".
       
       PROCEDURE DIVISION.
               PERFORM INICIO
               PERFORM PRINCIPAL UNTIL FIM-ARQ-ENT EQUAL "S"
               PERFORM FIM
               STOP RUN.
       
           INICIO.
               OPEN INPUT CADCLI1 OUTPUT CADCLI2
               PERFORM LEITURA.
       
           LEITURA.
               READ CADCLI1
                  AT END MOVE "S" TO FIM-ARQ-ENT.
       
           PRINCIPAL.
               PERFORM GRAVACAO
               PERFORM LEITURA.
       
           GRAVACAO.
               MOVE COD-ENT TO COD-SAI
               MOVE NOME-ENT TO NOME-SAI
               WRITE REG-SAI.
       
           FIM.
               CLOSE CADCLI1 CADCLI2.
