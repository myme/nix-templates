##
# Reveal.JS Org Mode presentations
#

EMACS := emacs
SLIDES := ./slides

slides: $(SLIDES)/reveal.js
	$(EMACS) -Q --batch --script publish.el --funcall publish

$(SLIDES)/reveal.js:
	mkdir -p $(SLIDES)
	ln -sf $(REVEALJS)/lib/node_modules/reveal.js $(SLIDES)

install: slides
	cp -av ./$(SLIDES)/* $(PREFIX)

clean:
	rm -rf .org-timestamps $(SLIDES) result

.PHONY: slides install clean

# end
