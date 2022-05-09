# Compiled script names:
NAME_1					= tfm.lua/authorname_modulename.tfm.lua.txt
NAME_2					= tfm.lua/authorname_modulename_ext.tfm.lua.txt
ALL_NAMES				= $(NAME_1) $(NAME_2)



# Rules:
all: $(ALL_NAMES)

tfm.lua/%tfm.lua.txt:
	@printf "\e[92m Generating %s\n" $@ || true
	@printf "\e[94m" || true
	mkdir tfm.lua || true
	./pshy_merge/combine.py pshy_merge.lua -- $(patsubst tfm.lua/%.tfm.lua.txt, %.lua, $@) >> $@
	@printf "\e[0m" || true

.PHONY: clean
clean:

.PHONY: fclean
fclean: clean
	@printf "\e[91m" || true
	rm -rf tfm.lua/*.tfm.lua.txt
	@printf "\e[0m" || true

.PHONY: re
re: fclean all
