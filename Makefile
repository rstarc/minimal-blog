build_dir = build
src_dir = source

# This target depends on all output files in the 'build' directory, as inferred by the files in the 'source' directory.
# Require .md files to be converted to .html files.
# Use $$ for the 'sed' as otherwise make will interpret "$/" as a variable
build: $(patsubst $(src_dir)/%,$(build_dir)/%,$(shell find $(src_dir) -type f | sed "s/\.md$$/.html/"))

# TODO: Make it possible to write files in *either* markdown or html
$(build_dir)/%.html: $(src_dir)/%.md header.html Makefile
	$(info $< -> $@)
	@mkdir -p $(dir $@)
	pandoc --standalone $< > $@
	cat header.html $@ > $@.tmp
	mv $@.tmp $@

# Copy all non-md files directly
$(build_dir)/%: $(src_dir)/%
	cp $< $@

serve: build
	python3 -m http.server -d $(build_dir)
