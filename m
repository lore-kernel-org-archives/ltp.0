From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 28 Jul 2021 13:34:05 +0100
Subject: [LTP] [PATCH v3 1/8] Add Sparse based checker and TST_RET/ERR check
In-Reply-To: <20210728123412.31858-1-rpalethorpe@suse.com>
References: <20210728123412.31858-1-rpalethorpe@suse.com>
Message-ID: <20210728123412.31858-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Vendors in Sparse as a git module. Then uses it to check for stores to
TST_RET/ERR within the library.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 .gitmodules               |   3 +
 tools/Makefile            |   2 +
 tools/sparse/.gitignore   |   1 +
 tools/sparse/Makefile     |  27 +++++++
 tools/sparse/README.md    |  51 +++++++++++++
 tools/sparse/sparse-ltp.c | 147 ++++++++++++++++++++++++++++++++++++++
 tools/sparse/sparse-src   |   1 +
 7 files changed, 232 insertions(+)
 create mode 100644 tools/sparse/.gitignore
 create mode 100644 tools/sparse/Makefile
 create mode 100644 tools/sparse/README.md
 create mode 100644 tools/sparse/sparse-ltp.c
 create mode 160000 tools/sparse/sparse-src

diff --git a/.gitmodules b/.gitmodules
index 1c9e9c38a..a3c34af4b 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,3 +1,6 @@
 [submodule "testcases/kernel/mce-test"]
 	path = testcases/kernel/mce-test
 	url = git://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/mce-test.git
+[submodule "tools/sparse/sparse-src"]
+	path = tools/sparse/sparse-src
+	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
diff --git a/tools/Makefile b/tools/Makefile
index def1c6fa9..adbf4fe70 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -28,4 +28,6 @@ INSTALL_TARGETS		:= *.awk *.pl *.sh html_report_header.txt
 
 INSTALL_DIR		:= bin
 
+FILTER_OUT_DIRS		+= sparse
+
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/tools/sparse/.gitignore b/tools/sparse/.gitignore
new file mode 100644
index 000000000..b2d2c37fa
--- /dev/null
+++ b/tools/sparse/.gitignore
@@ -0,0 +1 @@
+sparse-ltp
diff --git a/tools/sparse/Makefile b/tools/sparse/Makefile
new file mode 100644
index 000000000..4247dd86e
--- /dev/null
+++ b/tools/sparse/Makefile
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com>
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/functions.mk
+
+SPARSE_SRC	?= sparse-src
+
+$(SPARSE_SRC)/Makefile:
+ifeq ($(SPARSE_SRC),sparse-src)
+	git submodule update --init
+else
+	$(error "Can't find $(SPARSE_SRC)/Makefile")
+endif
+
+$(SPARSE_SRC)/libsparse.a: $(SPARSE_SRC)/Makefile
+	$(MAKE) -C $(SPARSE_SRC) libsparse.a
+
+HOST_MAKE_TARGETS	:= sparse-ltp
+MAKE_DEPS		+= $(SPARSE_SRC)/libsparse.a
+HOST_CFLAGS		+= -I$(SPARSE_SRC) -Werror
+HOST_LDLIBS		+= $(SPARSE_SRC)/libsparse.a
+
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/tools/sparse/README.md b/tools/sparse/README.md
new file mode 100644
index 000000000..aaf24f7ba
--- /dev/null
+++ b/tools/sparse/README.md
@@ -0,0 +1,51 @@
+# Sparse based linting
+
+This tool checks LTP test and library code for common problems.
+
+## Usage
+
+It is integrated with the LTP build system. Just run `make check` or
+`make check-a_test01`, where `a_test01` is an arbitrary test
+executable or object file.
+
+## Building
+
+The bad news is you must get and build Sparse[^1]. The good news is
+that this only takes a minute and the build system does it for
+you. Just try running `make check` as described above.
+
+However if you want to reuse an existing Sparse checkout. Then you can
+do the following. Where `$SRC_PATH` is the path to the Sparse
+directory.
+
+```sh
+$ cd tools/sparse
+$ make SPARSE_SRC=$SRC_PATH
+```
+You can also manually fetch it via the git submodule
+
+```sh
+$ cd tools/sparse
+$ git submodule update --init
+```
+
+### Modifying CFLAGS and -m32
+
+When compiling the LTP with `-m32` it may break building
+`sparse-ltp`. We do not pass LTP's `CFLAGS` or `HOST_CFLAGS` to
+`libsparse.a`. In the best case it produces a lot of noise, in the
+worst it breaks building anyway.
+
+To avoid issues with m32, just pre-build the checker with a non-m32
+config. It won't need to be built again unless you are modifying the
+tool itself. Similar issues with cross-compiling could be handled in a
+similar way. Simply pre-build `sparse-ltp` and `libsparse.a` with a separate
+config.
+
+### Clang
+
+Note that while it is possible to build Sparse with Clang. This may
+cause some issues. Namely `GCC_BASE` is set to the Clang resource
+directory. This contains some headers Sparse can not parse.
+
+[1]: Many distributions have a Sparse package. This only contains some executables. There is no shared library
diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
new file mode 100644
index 000000000..45874e8eb
--- /dev/null
+++ b/tools/sparse/sparse-ltp.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SUSE LLC <rpalethorpe@suse.com>
+ *
+ * Sparse allows us to perform checks on the AST (struct symbol) or on
+ * a linearized representation. In the latter case we are given a set
+ * of entry points (functions) containing basic blocks of
+ * instructions.
+ *
+ * The basic blocks contain byte code in SSA form. This is similar to
+ * the intermediate representation most compilers use during
+ * optimisation.
+ */
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <ctype.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include "lib.h"
+#include "allocate.h"
+#include "opcode.h"
+#include "token.h"
+#include "parse.h"
+#include "symbol.h"
+#include "expression.h"
+#include "linearize.h"
+
+/* The rules for test, library and tool code are different */
+enum ltp_tu_kind {
+	LTP_LIB,
+	LTP_OTHER,
+};
+
+static enum ltp_tu_kind tu_kind = LTP_OTHER;
+
+/* Check for LTP-002
+ *
+ * Inspects the destination symbol of each store instruction. If it is
+ * TST_RET or TST_ERR then emit a warning.
+ */
+static void check_lib_sets_TEST_vars(const struct instruction *insn)
+{
+	static struct ident *TST_RES_id, *TST_ERR_id;
+
+	if (!TST_RES_id) {
+		TST_RES_id = built_in_ident("TST_RET");
+		TST_ERR_id = built_in_ident("TST_ERR");
+	}
+
+	if (insn->opcode != OP_STORE)
+		return;
+	if (insn->src->ident != TST_RES_id &&
+	    insn->src->ident != TST_ERR_id)
+		return;
+
+	warning(insn->pos,
+		"LTP-002: Library should not write to TST_RET or TST_ERR");
+}
+
+static void do_basicblock_checks(struct basic_block *bb)
+{
+	struct instruction *insn;
+
+	FOR_EACH_PTR(bb->insns, insn) {
+		if (!bb_reachable(insn->bb))
+			continue;
+
+		if (tu_kind == LTP_LIB)
+			check_lib_sets_TEST_vars(insn);
+	} END_FOR_EACH_PTR(insn);
+}
+
+static void do_entrypoint_checks(struct entrypoint *ep)
+{
+	struct basic_block *bb;
+
+	FOR_EACH_PTR(ep->bbs, bb) {
+		do_basicblock_checks(bb);
+	} END_FOR_EACH_PTR(bb);
+}
+
+/* Compile the AST into a graph of basicblocks */
+static void process_symbols(struct symbol_list *list)
+{
+	struct symbol *sym;
+
+	FOR_EACH_PTR(list, sym) {
+		struct entrypoint *ep;
+
+		expand_symbol(sym);
+		ep = linearize_symbol(sym);
+		if (!ep || !ep->entry)
+			continue;
+
+		do_entrypoint_checks(ep);
+
+		if (dbg_entry)
+			show_entry(ep);
+	} END_FOR_EACH_PTR(sym);
+}
+
+static void collect_info_from_args(const int argc, char *const *const argv)
+{
+	int i;
+
+	for (i = 0; i < argc; i++) {
+		if (!strcmp("-DLTPLIB", argv[i]))
+			tu_kind = LTP_LIB;
+	}
+}
+
+int main(int argc, char **argv)
+{
+	struct string_list *filelist = NULL;
+	char *file;
+
+	Waddress_space = 0;
+	Wbitwise = 0;
+	Wcast_truncate = 0;
+	Wcontext = 0;
+	Wdecl = 0;
+	Wexternal_function_has_definition = 0;
+	Wflexible_array_array = 0;
+	Wimplicit_int = 0;
+	Wint_to_pointer_cast = 0;
+	Wmemcpy_max_count = 0;
+	Wnon_pointer_null = 0;
+	Wone_bit_signed_bitfield = 0;
+	Woverride_init = 0;
+	Wpointer_to_int_cast = 0;
+	Wvla = 0;
+
+	do_output = 0;
+
+	collect_info_from_args(argc, argv);
+
+	process_symbols(sparse_initialize(argc, argv, &filelist));
+	FOR_EACH_PTR(filelist, file) {
+		process_symbols(sparse(file));
+	} END_FOR_EACH_PTR(file);
+
+	report_stats();
+	return 0;
+}
diff --git a/tools/sparse/sparse-src b/tools/sparse/sparse-src
new file mode 160000
index 000000000..8af243292
--- /dev/null
+++ b/tools/sparse/sparse-src
@@ -0,0 +1 @@
+Subproject commit 8af2432923486c753ab52cae70b94ee684121080
-- 
2.31.1

