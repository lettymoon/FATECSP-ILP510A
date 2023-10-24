       IDENTIFICATION DIVISION.
       PROGRAM-ID. TREINO88.
       AUTHOR. LETICIA CANDIDO.
       INSTALLATION. FATECSP.
       DATE-WRITTEN. 16/08/23.
       DATE-COMPILED. 16/08/23.
       SECURITY. APENAS O AUTOR PODE MOFICAR.

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. LETTY-PC.
       OBJECT-COMPUTER. LETTY-PC.
       SPECIAL-NAMES. DECIMAL-POINT IS COMMA.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT CADENT ASSIGN TO DISK
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT CADOK ASSIGN TO DISK
           ORGANIZATION IS LINE SEQUENTIAL.
           SELECT CADRUIM ASSIGN TO DISK
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD CADENT
           LABEL RECORDS ARE STANDARD 
           DATA RECORD IS REGENT
           VALUE OF FILE-ID IS "CADENT.DAT".
       01 REGENT.
           02 CODENT    PIC 9(02).
           02 NOMEENT   PIC X(30).
               88 NOME-INVALIDO VALUE SPACES.
           02 ESTADOENT PIC X(02).
               88 ESTADO-VALIDO VALUE "AC" "AL" "AP" "AM" "BA" "CE" 
               "DF" "ES" "GO" "MA" "MT" "MS" "MG" "PA" "PB" "PR" "PE" 
               "PI" "RJ" "RN" "RS" "RO" "RR" "SC" "SP" "SE" "TO".
       FD CADOK
           LABEL RECORD IS OMITTED.
       01 REGOK.
           02 CODSAI    PIC 9(02).
           02 NOMESAI   PIC X(30).
           02 ESTADOSAI PIC X(02).
       FD CADRUIM
           LABEL RECORD IS OMITTED.
       01 REGRUIM.
           02 CODSAIR    PIC 9(02).
           02 NOMESAIR   PIC X(30).
           02 ESTADOSAIR PIC X(02).
       
       WORKING-STORAGE SECTION.
           77 FIM-ARQ PIC X(01) VALUE "N".
           77 CH-ERRO PIC X(01) VALUE "N".
       

       PROCEDURE DIVISION.
       PGM-TREINO88.
           PERFORM INICIO
           PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL "S"
           PERFORM FIM.
           STOP RUN.
       
           INICIO.
               OPEN INPUT  CADENT
                    OUTPUT CADOK   
                           CADRUIM.
               PERFORM LEITURA.
           LEITURA.
               READ CADENT
                   AT END MOVE "S" TO FIM-ARQ.
           PRINCIPAL.
               PERFORM GRAVACAO.
               PERFORM LEITURA.
           GRAVACAO.
               MOVE "N" TO CH-ERRO.
               PERFORM VERIFICACAO.
               IF CH-ERRO EQUAL "N"
                   PERFORM GRAVAOK
               ELSE
                   PERFORM GRAVARUIM
               END-IF.

           VERIFICACAO.
               IF NOT (NOME-INVALIDO) AND ESTADO-VALIDO
                   MOVE "N" TO CH-ERRO
               ELSE
                   MOVE "S" TO CH-ERRO
               END-IF.

           GRAVAOK.
               MOVE CODENT    TO CODSAI
               MOVE NOMEENT   TO NOMESAI
               MOVE ESTADOENT TO ESTADOSAI
               WRITE REGOK.
           GRAVARUIM.
               MOVE CODENT    TO CODSAIR
               MOVE NOMEENT   TO NOMESAIR
               MOVE ESTADOENT TO ESTADOSAIR
               WRITE REGRUIM.

           FIM. 
               CLOSE CADENT 
               CADOK 
               CADRUIM.
