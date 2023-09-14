       identification division.
       program-id. hello.
       author. Letty
       installation. my-pc
       date-written. 26/08/2023
       date-compiled. 26/08/2023

       environment division.
       configuration section.
           object-computer. laptop-letty.
           special-names. decimal-point is comma.

       procedure division.
           perform hello.
           stop run.

           hello. 
               display "hello world!".
