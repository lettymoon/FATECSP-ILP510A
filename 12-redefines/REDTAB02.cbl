           IDENTIFICATION DIVISION.
           PROGRAM-ID. REDTAB02.
           AUTHOR. LETICIA CANDIDO.
           INSTALLATION. FATECSP.
           DATE-WRITTEN. 22/10/23.
           DATE-COMPILED. 22/10/23.
           SECURITY. APENAS O AUTOR PODE MODIFICAR.

           ENVIRONMENT DIVISION.
           CONFIGURATION SECTION.
           SOURCE-COMPUTER. LETTY-PC.
           OBJECT-COMPUTER. LETTY-PC.
           SPECIAL-NAMES. DECIMAL-POINT IS COMMA.

           INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT ARQ-ENT ASSIGN TO DISK
               ORGANIZATION IS LINE SEQUENTIAL.
               SELECT CAD-SAI ASSIGN TO DISK
               ORGANIZATION IS LINE SEQUENTIAL.

           DATA DIVISION.
           FILE SECTION.

           FD ARQ-ENT
               LABEL RECORD ARE STANDARD 
               VALUE OF FILE-ID IS "ARQ-ENT.DAT".

           01 REG-ENT.
               02 COD-ENT    PIC 9(03).
               02 DATA-ENT.
                   03 DIA-ENT PIC 9(02).
                   03 MES-ENT PIC 9(02).
                   03 ANO-ENT PIC 9(02).

           FD CAD-SAI
               LABEL RECORD ARE STANDARD.
           01 REG-SAI.
               02 COD-SAI PIC 9(03).
               02 DATA-SAI.
                   03 DIA-SAI PIC 9(02).
                   03 MES-SAI PIC X(09).
                   03 ANO-SAI PIC 9(02).
           WORKING-STORAGE SECTION.
               77 FIM-ARQ PIC X(03) VALUE "N".
               01 TABELA-MES.
                   02 DEF-MES.
                       03 FILLER PIC X(09) VALUE "JANEIRO".
                       03 FILLER PIC X(09) VALUE "FEVEREIRO".
                       03 FILLER PIC X(09) VALUE "MARÇO".
                       03 FILLER PIC X(09) VALUE "ABRIL".
                       03 FILLER PIC X(09) VALUE "MAIO".
                       03 FILLER PIC X(09) VALUE "JUNHO".
                       03 FILLER PIC X(09) VALUE "JULHO".
                       03 FILLER PIC X(09) VALUE "AGOSTO".
                       03 FILLER PIC X(09) VALUE "SETEMBRO".
                       03 FILLER PIC X(09) VALUE "OUTUBRO".
                       03 FILLER PIC X(09) VALUE "NOVEMBRO".
                       03 FILLER PIC X(09) VALUE "DEZEMBRO".
               01 TABELA-MES-RED REDEFINES TABELA-MES.
                   02 MES PIC X(09) OCCURS 12 TIMES.
           
           PROCEDURE DIVISION.
           PGM-TAB02.
               PERFORM INICIO.
               PERFORM PRINCIPAL UNTIL FIM-ARQ EQUAL "S".
               PERFORM FIM.
               STOP RUN.

           INICIO.
               OPEN INPUT  ARQ-ENT
                    OUTPUT CAD-SAI.
               PERFORM LEITURA.

           LEITURA.
               READ ARQ-ENT AT END MOVE "S" TO FIM-ARQ.

           PRINCIPAL.
               PERFORM PESQUISA-TABELA.
               PERFORM GRAVA-SAI.
               PERFORM LEITURA.

           PESQUISA-TABELA.
               MOVE MES(MES-ENT) TO MES-SAI.
           
           GRAVA-SAI.
               MOVE COD-ENT TO COD-SAI.
               MOVE DIA-ENT TO DIA-SAI.
               MOVE ANO-ENT TO ANO-SAI.
               WRITE REG-SAI.
           
           FIM.
               CLOSE ARQ-ENT
                     CAD-SAI.



                   