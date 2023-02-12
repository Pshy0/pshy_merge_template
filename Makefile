OUT_DIR					= tfm_lua
TEST_RESULTS_DIR		= test_results
DEPS_DIR				= deps

# Modulepacks names:
NAME_MAIN				= $(OUT_DIR)/modulename.tfm.lua.txt
NAME_TRIBEHOUSE			= $(OUT_DIR)/modulename_tribehouse.tfm.lua.txt
NAME_FUNCORP			= $(OUT_DIR)/modulename_funcorp.tfm.lua.txt
ALL_NAMES				= $(NAME_MAIN) $(NAME_TRIBEHOUSE) $(NAME_FUNCORP)
ALL_TESTS				= $(patsubst $(OUT_DIR)/%.tfm.lua.txt, $(TEST_RESULTS_DIR)/%.stdout.txt, $(ALL_NAMES))

OPTIONS					= --werror --test-init --minify

# Rules:
all: $(ALL_NAMES)

.PHONY: clip
clip: OPTIONS += --clip
clip: $(NAME_MAIN)

test: $(ALL_TESTS)

.PHONY: init-submodules
init-submodules:
	git submodule update --init

pshy_merge/combine.py:
	make init-submodules

%/:
	mkdir -p $@

-include $(DEPS_DIR)/*.tfm.lua.txt.d

$(OUT_DIR)/%.tfm.lua.txt: | pshy_merge/combine.py $(OUT_DIR)/ $(DEPS_DIR)/
	@printf "\e[92m Generating %s\n" $@ || true
	@printf "\e[94m" || true
	./pshy_merge/combine.py $(OPTIONS) --deps $(patsubst $(OUT_DIR)/%.tfm.lua.txt, $(DEPS_DIR)/%.tfm.lua.txt.d, $@) --out $@ -- $(patsubst $(OUT_DIR)/%.tfm.lua.txt, %, $@)
	@printf "\e[0m" || true

$(TEST_RESULTS_DIR)/%.stdout.txt: $(OUT_DIR)/%.tfm.lua.txt $(NAME_TFMEMULATOR) | $(TEST_RESULTS_DIR)/
	@printf "\e[93m \nTesting %s:\n" $< || true
	@printf "\e[95m" || true
	(echo "\npackage.path = ';./lua/?.lua;./lua/?/init.lua;./pshy_merge/lua/?.lua;./pshy_merge/lua/?/init.lua'\npshy = {require = require}\ntfmenv = require(\"pshy.tfm_emulator\")\ntfmenv.InitBasicTest()\ntfmenv.LoadModule(\"$<\")\ntfmenv.BasicTest()\n") > $@.test.lua
	@echo 'cat $@.test.lua | lua5.2 > $@'
	@echo -n "\e[91m" 1>&2
	@cat $@.test.lua | lua > $@
	@printf "\e[95mSTDOUT: \e[96m\n" || true
	@cat $@
	@printf "\e[0m" || true

.PHONY: clean
clean:
	@printf "\e[91m" || true
	rm -rf $(DEPS_DIR)/*.tfm.lua.txt.d
	rmdir $(DEPS_DIR) || true
	rm -rf $(TEST_RESULTS_DIR)/*.stdout.txt
	rmdir $(TEST_RESULTS_DIR) || true
	@printf "\e[0m" || true

.PHONY: fclean
fclean: clean
	@printf "\e[91m" || true
	rm -rf $(OUT_DIR)/*.tfm.lua.txt
	rmdir $(OUT_DIR) || true
	@printf "\e[0m" || true

.PHONY: re
re: fclean all
