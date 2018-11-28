From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 28 Nov 2018 11:44:20 +0100
Subject: [LTP] [PATCH] [RFC] Proof-of-concept for test documentation format
Message-ID: <20181128104420.30110-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is just hacked up proof of concept in order to continue our
discussion on test documentation. The code itself is just meant to prove
that something is possible and it's not mean for inclusion.

With that in mind, let me describe what I attempted to prove to be
possible here:

The test metadata are written in special comment in the test source, see
test_docs.c and top level comment starting with /*RST tag.

There is a hacked up tool that parses the comment prior to the test
compilation and picks up relevant parts and formats them into C data
structures, the results can be seen in test_docs.gen.c once you run make
in the newlib_tests directory. This data structures are then linked with
the actual test e.g. test_docs and used by the test library.

The upside of this approach is that all the metadata can now reside in
the special comment used to describe the test and at the same time the
test can access this information at runtime, there is no need to repeat
any piece of information in this setup. Even the needs_root fileds can
be moved to the comment after this and indeed that works nicely here. At
the same time the test can print the test description when passed -h
flag, etc.

The only downside is that this is automagical process that adds
complexity to the compliation process.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: automated-testing@yoctoproject.org
---
 include/tst_metadata.h       |  28 +++++
 include/tst_test.h           |   1 +
 lib/newlib_tests/.gitignore  |   3 +
 lib/newlib_tests/Makefile    |   7 ++
 lib/newlib_tests/docparse.c  | 220 +++++++++++++++++++++++++++++++++++
 lib/newlib_tests/test_docs.c |  40 +++++++
 lib/tst_test.c               |  21 +++-
 7 files changed, 318 insertions(+), 2 deletions(-)
 create mode 100644 include/tst_metadata.h
 create mode 100644 lib/newlib_tests/docparse.c
 create mode 100644 lib/newlib_tests/test_docs.c

diff --git a/include/tst_metadata.h b/include/tst_metadata.h
new file mode 100644
index 000000000..8a7363320
--- /dev/null
+++ b/include/tst_metadata.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef TST_METADATA_H__
+#define TST_METADATA_H__
+
+struct tst_tag {
+	const char *name;
+	const char *value;
+};
+
+struct tst_metadata {
+	/* help string printed with -h */
+	const char *help;
+
+	/* general test tags */
+	const struct tst_tag *tags;
+
+	/* set if test needs root */
+	int needs_root:1;
+
+	/* NULL-terminated list of required kernel config option */
+	const char *const *kconfigs;
+};
+
+#endif /* TST_METADATA_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 2ebf746eb..82f607a37 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -43,6 +43,7 @@
 #include "tst_get_bad_addr.h"
 #include "tst_path_has_mnt_flags.h"
 #include "tst_sys_conf.h"
+#include "tst_metadata.h"
 
 /*
  * Reports testcase result.
diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
index c702644f0..931d05b1b 100644
--- a/lib/newlib_tests/.gitignore
+++ b/lib/newlib_tests/.gitignore
@@ -24,3 +24,6 @@ test19
 tst_expiration_timer
 test_exec
 test_exec_child
+*.gen.c
+test_docs
+docparse
diff --git a/lib/newlib_tests/Makefile b/lib/newlib_tests/Makefile
index 2fc50160a..3d4f1e25b 100644
--- a/lib/newlib_tests/Makefile
+++ b/lib/newlib_tests/Makefile
@@ -12,6 +12,13 @@ test16: CFLAGS+=-pthread
 test16: LDLIBS+=-lrt
 tst_expiration_timer: LDLIBS+=-lrt
 
+FILTER_OUT_MAKE_TARGETS += $(subst .c,,$(wildcard *.gen.c))
+
+%.gen.c: %.c
+	./docparse $< > $@
+
+test_docs: test_docs.gen.c
+
 ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= test08
 endif
diff --git a/lib/newlib_tests/docparse.c b/lib/newlib_tests/docparse.c
new file mode 100644
index 000000000..4e9abb04b
--- /dev/null
+++ b/lib/newlib_tests/docparse.c
@@ -0,0 +1,220 @@
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+struct strlist {
+	struct strlist *next;
+	char str[];
+};
+
+static struct rst_reqs {
+	int needs_root:1;
+	struct strlist *kconfigs;
+} rst_reqs;
+
+static void strlist_add(struct strlist **root, const char *str)
+{
+	struct strlist *s = malloc(sizeof(struct strlist) + strlen(str) + 1);
+
+	if (!s) {
+		fprintf(stderr, "malloc failed :(\n");
+		abort();
+	}
+
+	strcpy(s->str, str);
+	s->next = *root;
+	*root = s;
+}
+
+static int rst_output = 0;
+
+static int help_parsed;
+static int tags_parsed;
+
+static void rst_start_sec(const char *buf)
+{
+	if (strstr(buf, "Description")) {
+		printf("static const char tst_help[] = \\\n");
+		rst_output = 1;
+		help_parsed = 1;
+	};
+
+	if (strstr(buf, "Tags")) {
+		printf("\nstatic const struct tst_tag tst_tags[] = {\n");
+		rst_output = 2;
+		tags_parsed = 1;
+	}
+
+	if (strstr(buf, "Requirements")) {
+		rst_output = 3;
+	}
+}
+
+static void rst_end_sec(void)
+{
+	if (rst_output == 1) {
+		printf(";\n");
+	}
+
+	if (rst_output == 2) {
+		printf("\t{NULL, NULL}\n");
+		printf("};\n");
+	}
+
+	rst_output = 0;
+}
+
+static void start_comment(void)
+{
+	printf("#include <stdlib.h>\n");
+	printf("#include \"tst_metadata.h\"\n\n");
+}
+
+static void end_comment(void)
+{
+	rst_end_sec();
+
+	if (!help_parsed && !tags_parsed)
+		return;
+
+	if (rst_reqs.kconfigs) {
+		struct strlist *s;
+
+		printf("\nconst char *const tst_kconfigs[] = {\n");
+
+		for (s = rst_reqs.kconfigs; s; s = s->next)
+			printf("\t\"%s\",\n", s->str);
+
+		printf("\tNULL\n");
+		printf("};\n");
+	}
+
+	printf("\nstruct tst_metadata tst_metadata = {\n");
+
+	if (help_parsed)
+		printf("\t.help = tst_help,\n");
+
+	if (tags_parsed)
+		printf("\t.tags = tst_tags,\n");
+
+	if (rst_reqs.kconfigs)
+		printf("\t.kconfigs = tst_kconfigs,\n");
+
+	if (rst_reqs.needs_root)
+		printf("\t.needs_root = 1\n");
+
+	printf("};\n");
+}
+
+static void rst_text(char *buf)
+{
+	if (!rst_output)
+		return;
+
+	buf[strlen(buf) - 1] = '\0';
+
+	if (rst_output == 1)
+		printf("\t\"%s\\n\"\\\n", buf);
+
+	if (rst_output == 2) {
+		if (!buf[0])
+			return;
+
+		printf("\t{\"cve\", \"%s\"},\n", buf);
+	}
+
+	if (rst_output == 3) {
+		if (strstr(buf, "* root")) {
+			rst_reqs.needs_root = 1;
+			return;
+		}
+
+		const char *str = strstr(buf, "CONFIG_");
+		if (str) {
+			strlist_add(&rst_reqs.kconfigs, str);
+			return;
+		}
+		//WARNING on non-empty lines
+	};
+}
+
+enum rst_state {
+	RST_ST_START,
+	RST_ST_TEXT,
+	RST_ST_SEC,
+};
+
+static void parse_rst_comment(char *buf)
+{
+	static int state = RST_ST_START;
+
+	switch (state) {
+	case RST_ST_START:
+		if (buf[0] == '=')
+			state = RST_ST_SEC;
+	break;
+	case RST_ST_SEC:
+		if (buf[0] == '=') {
+			state = RST_ST_TEXT;
+			return;
+		}
+		rst_start_sec(buf);
+	break;
+	case RST_ST_TEXT:
+		if (buf[0] == '=') {
+			state = RST_ST_SEC;
+			rst_end_sec();
+			return;
+		}
+		rst_text(buf);
+	break;
+	}
+}
+
+enum state {
+	ST_NONE,
+	ST_IN_COMMENT,
+	ST_IN_TEST,
+};
+
+int main(int argc, char *argv[])
+{
+	FILE *fp = fopen(argv[1], "r");
+	char buf[1024];
+	int state = ST_NONE;
+
+	while (fgets(buf, sizeof(buf), fp)) {
+		if (state == ST_NONE) {
+			if (!strncmp(buf, "/*RST", 5)) {
+				state = ST_IN_COMMENT;
+				start_comment();
+				continue;
+			}
+
+			if (strstr(buf, "static struct tst_test test = {")) {
+				state = ST_IN_TEST;
+				continue;
+			}
+		}
+
+		if (state == ST_IN_COMMENT) {
+			if (strstr(buf, "*/")) {
+				state = ST_NONE;
+				end_comment();
+				continue;
+			}
+			parse_rst_comment(buf);
+		}
+
+		if (state == ST_IN_TEST) {
+			if (strstr(buf, "};")) {
+				state = ST_NONE;
+				continue;
+			}
+		}
+	};
+
+	fclose(fp);
+
+	return 0;
+}
diff --git a/lib/newlib_tests/test_docs.c b/lib/newlib_tests/test_docs.c
new file mode 100644
index 000000000..3ee715cb4
--- /dev/null
+++ b/lib/newlib_tests/test_docs.c
@@ -0,0 +1,40 @@
+/*
+ * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
+ */
+#include "tst_test.h"
+
+/*RST
+
+===========
+Description
+===========
+
+This is a test for the comment parser.
+
+* This is a list
+* And one more
+
+====
+Tags
+====
+
+CVE-2007-2002
+
+============
+Requirements
+============
+
+* root
+* CONFIG_FOO=y
+
+*/
+
+static void do_test(void)
+{
+	tst_res(TPASS, "Passed");
+}
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.needs_root = 1,
+};
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 661fbbfce..15c825df0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -409,10 +409,17 @@ static struct option {
 	{"C:", "-C ARG   Run child process with ARG arguments (used internally)"},
 };
 
+extern const struct tst_metadata tst_metadata;
+
+const struct tst_metadata tst_metadata __attribute__((weak));
+
 static void print_help(void)
 {
 	unsigned int i;
 
+	if (tst_metadata.help)
+		fprintf(stderr, "%s", tst_metadata.help);
+
 	for (i = 0; i < ARRAY_SIZE(options); i++)
 		fprintf(stderr, "%s\n", options[i].help);
 
@@ -762,6 +769,17 @@ static void prepare_device(void)
 	}
 }
 
+static int needs_root(void)
+{
+	if (tst_test->needs_root)
+		return 1;
+
+	if (tst_metadata.needs_root)
+		return 1;
+
+	return 0;
+}
+
 static void do_setup(int argc, char *argv[])
 {
 	if (!tst_test)
@@ -779,7 +797,7 @@ static void do_setup(int argc, char *argv[])
 
 	parse_opts(argc, argv);
 
-	if (tst_test->needs_root && geteuid() != 0)
+	if (needs_root() && geteuid() != 0)
 		tst_brk(TCONF, "Test needs to be run as root");
 
 	if (tst_test->min_kver)
@@ -1191,7 +1209,6 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	do_exit(ret);
 }
 
-
 void tst_flush(void)
 {
 	int rval;
-- 
2.18.1

