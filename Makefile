# should always be the "all" rule, so that "make" and "make all" are identical.
all: praca_licencjacka.pdf

# CUSTOM BUILD RULES

# In case you didn't know, '$@' is a variable holding the name of the target,
# and '$<' is a variable holding the (first) dependency of a rule.
# "raw2tex" and "dat2tex" are just placeholders for whatever custom steps
# you might have.

%.tex: %.raw
	./raw2tex $< > $@

%.tex: %.dat
	./dat2tex $< > $@

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file referece and interactively asking you for an alternative.

praca_licencjacka.pdf: praca_licencjacka.tex
	latexmk -pdflua -lualatex="lualatex -interaction=nonstopmode" -use-make praca_licencjacka.tex

clean:
	latexmk -C
	rm praca_licencjacka.bbl
	rm img/UMCS_logotyp_gray-eps-converted-to.pdf
