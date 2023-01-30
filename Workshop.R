#################################################
### Vorbereitungen
## Einmalige Installation
# install.packages("exams", dependencies = TRUE)
# tinytex::install_tinytex()

## Paket aktivieren
library(exams)

#################################################

## Beipiel 1
# Als html
exams2html("Fragen/F1_SitzFOM.Rmd")
# Ohne Antworten
exams2html("Fragen/F1_SitzFOM.Rmd", solution = FALSE)
# Als pdf
exams2pdf("Fragen/F1_SitzFOM.Rmd")

## Beipiel 2. Wie 1, nur mit R
exams2html("Fragen/F2_SitzFOM_R.Rmd")

## Beispiel 3. Mit Dynamik
exams2html("Fragen/F3_SitzFOM_Dynamik.Rmd")
exams2html("Fragen/F3_SitzFOM_Dynamik.Rmd")
exams2html("Fragen/F3_SitzFOM_Dynamik.Rmd")

## Beispiel 4. Zahl als Lösung - 2 Versionen
exams2html("Fragen/F4_Algebra.Rmd", n = 2, mathjax = TRUE)

## Beispiel 5. Text als Lösung
exams2html("Fragen/F5_Modellierung.Rmd")

## Mehrere Aufgaben als Klausur
set.seed(1896)
klausurfragen <- c("Fragen/F3_SitzFOM_Dynamik.Rmd",
                   sample(c("Fragen/F4_Algebra.Rmd", 
                            "Fragen/F5_Modellierung.Rmd"), 1))
# Export nach Word
exams2pandoc(klausurfragen, type = "docx", name = "Testklausur")
# Export nach moodle
exams2moodle(klausurfragen, name = "Testklausur")

# Export nach pdf - mit Umwandlung deutsche Texte etc.
formatierung <- {
  to_latex <- make_exercise_transform_pandoc(to = "latex")
  function(x) {
    x <- to_latex(x)
    x$question <- c(sprintf("Aufgabe "), 
                    sprintf("\\emph{(%s %s)}:", x$metainfo$points, 
                            ifelse(x$metainfo$points != 1, "Punkte", 
                                   "Punkt")), x$question)
    return(x)
  }
}
exams2pdf(klausurfragen, name = "Testklausur",
             template = "tex/fom.tex", transform = formatierung)

