SRC := src/
OBJ := obj/
EXEC := exec/

SRC_FILES := $(wildcard $(SRC)*.asm)
OBJ_FILES := $(subst $(SRC),$(OBJ),$(sort $(SRC_FILES:.asm=.o)))
EXEC_FILES := $(subst $(SRC),$(EXEC),$(sort $(SRC_FILES:.asm=)))

marker = $1.f

.PHONY: all
all: $(EXEC_FILES)

$(OBJ_FILES): $(call marker,$(OBJ))
$(EXEC_FILES): $(call marker,$(EXEC))

.PHONY: clean
clean: ; rm -rf $(OBJ) $(EXEC)

# https://blog.jgc.org/2015/04/the-one-line-you-should-add-to-every.html
print-%: ; @echo $*=$($*)

$(OBJ)%.o: $(SRC)%.asm
	nasm -f elf32 $< -o $@

$(EXEC)%: $(OBJ)%.o
	ld -m elf_i386 $< -o $@

$(call marker,$(OBJ)):
	mkdir -p $(OBJ)
	touch $@

$(call marker,$(EXEC)):
	mkdir -p $(EXEC)
	touch $@
