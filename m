From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Nov 2020 16:47:48 +0100
Subject: [LTP] [PATCH v2 2/2] lib/tst_kconfig: Validate variables
In-Reply-To: <20201112154748.17857-1-chrubis@suse.cz>
References: <20201112154748.17857-1-chrubis@suse.cz>
Message-ID: <20201112154748.17857-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add variable validation so that we catch typos even before we attempt to
evaluate the expressions.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/newlib_tests/.gitignore       |   1 +
 lib/newlib_tests/test_kconfig02.c |  29 +++++++++
 lib/tst_kconfig.c                 | 102 ++++++++++++++++++++++++++++++
 3 files changed, 132 insertions(+)
 create mode 100644 lib/newlib_tests/test_kconfig02.c

diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index 89de61cf7..ac1d19be0 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -32,6 +32,7 @@ test_exec
 test_exec_child
 test_kconfig
 test_kconfig01
+test_kconfig02
 variant
 test_guarded_buf
 tst_bool_expr
diff --git a/lib/newlib_tests/test_kconfig02.c b/lib/newlib_tests/test_kconfig02.c
new file mode 100644
index 000000000..176929222
--- /dev/null
+++ b/lib/newlib_tests/test_kconfig02.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * Invalid boolean expression test.
+ */
+
+#include "tst_test.h"
+
+static void do_test(void)
+{
+	tst_res(TPASS, "Test passed!");
+}
+
+static const char *kconfigs[] = {
+	"\"CONFIG_FOO=val\"",
+	"CONFIG_a=1",
+	"CONFIG_FOO=",
+	"CONFIG_DEFAULT_HOSTNAME=\"(none",
+	"CONFIG_DEFAULT_HOSTNAME=\"(none)\"a",
+	"CONFIG_BROKEN=a\" | CONFIG_FOO",
+	"CONFIG_BROKEN=a=",
+	NULL
+};
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_kconfigs = kconfigs,
+};
diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 468f03a86..72830703c 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -224,6 +224,105 @@ static inline unsigned int get_len(const char* kconfig, unsigned int len)
 	return sep - kconfig;
 }
 
+static void print_err(FILE *f, const struct tst_expr_tok *var,
+                      size_t spaces, const char *err)
+{
+	size_t i;
+
+	for (i = 0; i < var->tok_len; i++)
+		fputc(var->tok[i], f);
+
+	fputc('\n', f);
+
+	while (spaces--)
+		fputc(' ', f);
+
+	fprintf(f, "^\n%s\n\n", err);
+}
+
+static int validate_var(const struct tst_expr_tok *var)
+{
+	size_t i = 7;
+
+	if (var->tok_len < 7 || strncmp(var->tok, "CONFIG_", 7)) {
+		print_err(stderr, var, 0, "Expected CONFIG_ prefix");
+		return 1;
+	}
+
+	while (var->tok[i]) {
+		char c;
+
+		if (i >= var->tok_len)
+			return 0;
+
+		c = var->tok[i];
+
+		if ((c >= 'A' && c <= 'Z') || c == '_') {
+			i++;
+			continue;
+		}
+
+		if (c == '=') {
+			i++;
+			break;
+		}
+
+		print_err(stderr, var, i, "Unexpected character in variable name");
+		return 1;
+	}
+
+	if (i >= var->tok_len) {
+		print_err(stderr, var, i, "Missing value");
+		return 1;
+	}
+
+	if (var->tok[i] == '"') {
+		do {
+			i++;
+		} while (i < var->tok_len && var->tok[i] != '"');
+
+		if (i < var->tok_len) {
+			print_err(stderr, var, i, "Garbage after a string");
+			return 1;
+		}
+
+		if (var->tok[i] != '"') {
+			print_err(stderr, var, i, "Untermianted string");
+			return 1;
+		}
+
+		return 0;
+	}
+
+	do {
+		i++;
+	} while (i < var->tok_len && isalnum(var->tok[i]));
+
+	if (i < var->tok_len) {
+		print_err(stderr, var, i, "Invalid character in variable value");
+		return 1;
+	}
+
+	return 0;
+}
+
+static int validate_vars(struct tst_expr *const exprs[], unsigned int expr_cnt)
+{
+	unsigned int i;
+	const struct tst_expr_tok *j;
+	unsigned int ret = 0;
+
+	for (i = 0; i < expr_cnt; i++) {
+		for (j = exprs[i]->rpn; j; j = j->next) {
+			if (j->op == TST_OP_VAR)
+				ret |= validate_var(j);
+		}
+	}
+
+	return ret;
+}
+
+
 static inline unsigned int get_var_cnt(struct tst_expr *const exprs[],
                                        unsigned int expr_cnt)
 {
@@ -372,6 +471,9 @@ void tst_kconfig_check(const char *const kconfigs[])
 			tst_brk(TBROK, "Invalid kconfig expression!");
 	}
 
+	if (validate_vars(exprs, expr_cnt))
+		tst_brk(TBROK, "Invalid kconfig variables!");
+
 	var_cnt = get_var_cnt(exprs, expr_cnt);
 	struct tst_kconfig_var vars[var_cnt];
 
-- 
2.26.2

