
NITC = /usr/bin/nit/bin/nitc
COMPILE_DIR = .nit_compile/

.SUFFIXES:

link: run

build: 
	$(NITC) testProgram.nit

run: build
	./testProgram

clean:
	rm -rf $(COMPILE_DIR)
	rm -f testProgram
