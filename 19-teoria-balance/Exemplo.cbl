       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXEMPLO.
       AUTHOR. HIRO.
       INSTALLATION. FATECSP.
       DATE-WRITTEN. 17/09/2004.
       DATE-COMPILED. 
       SECURITY. APENAS O AUTOR PODE MODIFICAR.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBMPC.
       OBJECT-COMPUTER. IBMPC.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT MVT ASSIGN TO DISK.
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT ANT ASSIGN TO DISK.
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT ATU ASSIGN TO DISK.
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD MVT
           LABEL RECORD ARE STANDARD 
           VALUE OF FILE-ID IS "MVTO.DAT".
       01 REG-MVTO.
           02 COD-MVTO  PIC  9(04).
           02 NOME-MVTO PIC X(30).

       FD ANT
           LABEL RECORD ARE STANDARD 
           VALUE OF FILE-ID IS "ANT.DAT".
       01 REG-ANT.
           03 COD-ANT PIC 9(04).
           03 NOME-ANT PIC X(30).

       FD ATU
           LABEL RECORD ARE STANDARD 
           VALUE OF FILE-ID IS "ATU.DAT".
           03 COD-ATU PIC 9(04).
           02 NOME-ATU PIC X(30).

       WORKING-STORAGE SECTION.
       PGM-EX04.
           PERFORM INICIO.
           PERFORM PRINCIPAL
                   UNTIL 
                   CH-MVTO EQUAL CH-ANT AND CH-ANT EQUAL HIGH-VALUES.
           PERFORM FIM.
           STOP RUN.

           INICIO.
               OPEN INPUT MVTO ANT
                    OUTPUT ATU.
               PERFORM LER-MVTO.

           LER-MVTO.
               READ MVTO AT END MOVE HIGH-VALUES TO CH-MVTO.
               IF CH-MVTO EQUAL HIGH-VALUES.
                   NEXT SENTENCE 
               ELSE 
                   MOVE COD-MVTO TO CH-MVTO.

           LER-ANT.
               READ ANT AT END MOVE HIGH-VALUES TO CH-ANT.
           IF CH-ANT EQUAL HIGH-VALUES
               NEXT SENTENCE 
           ELSE
               MOVE COD-ANT TO CH-ANT.

       PRINCIPAL.
           IF CH-MVTO EQUAL CH-ANT
               PERFORM IGUAL
               PERFORM LER-MVTO
               PERFORM LER-ANT
           ELSE
           PERFORM ANT-MENOR
           PERFORM ANT-MENOR.
       
       IGUAL.
           PERFORM GRAVA-MVTO.
           PERFORM GRAVA-ANT.

       MVTO-MENOR.
           PERFORM GRAVA-MVTO.

       GRAVA-ANT.
           MOVE COF-ANT TO COD-ATU.
           MOVE NOME-ANT TO NOME-ATU.
           WRITE REG-ATU.

       GRAVA-MVTO.
           MOVE COD-MVTO TO COD-ATU.
           MOVE NOME-MVTO TO NOME-ATU.
           WRITE REG-ATU.

       FIM.
           MVTO ANT ATU.
