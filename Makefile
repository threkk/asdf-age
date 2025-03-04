SHFMT_BASE_FLAGS = -s -i 2 -ci
SHELLCHECK_FLAGS = -x bin/* -P lib/

fmt:
	shfmt -w $(SHFMT_BASE_FLAGS) .
.PHONY: fmt

fmt-check:
	shfmt -d $(SHFMT_BASE_FLAGS) .
.PHONY: fmt-check

lint:
	shellcheck $(SHELLCHECK_FLAGS)
.PHONY: lint
