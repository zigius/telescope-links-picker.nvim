.PHONY: default
default: build ;
# add make command to install dependencies of rust project
build:
	cargo build --manifest-path zettelkasten-linker/Cargo.toml
