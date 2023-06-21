export ELF=$1

# crate: elf-info v0.3.0
elf header
elf fn eventHandlerShim
elf sh .rel.text
elf sh
elf sym
