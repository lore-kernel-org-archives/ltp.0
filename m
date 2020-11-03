From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Nov 2020 20:13:19 +0100
Subject: [LTP] [PATCH v2 03/11] docparse: Add test documentation parser
In-Reply-To: <20201103191327.11081-1-pvorel@suse.cz>
References: <20201103191327.11081-1-pvorel@suse.cz>
Message-ID: <20201103191327.11081-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cyril Hrubis <metan@ucw.cz>

This commit implements a simple parser to pick up metadata that are
nicely structured in the tst_test structure. In order to do that it
implements very simple and very basic C tokenizer.

The result of the metadata extraction is one big json file that contains
data extracted from all new library testcases plus some information
about the LTP version etc.

The tokenizer also extracts special documentation comments that are then
used for a test description. The documentation format has been choosen
to be asciidoc.

Special documentation comments starts with string "/*\\n" and is, by
convention ended with the same, so it looks like:

/*\
 * [DOCUMENTATION]
 *  - foo
 *  - bar
 *
 * ...
 *
\*/

[ pvorel: fixes
- parse.sh: git related fixes, out-of-tree build
- docparse: Eat also space following *
- Makefile: remove header rule (broken for clang)
]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 Makefile                |   2 +-
 docparse/.gitignore     |   2 +
 docparse/Makefile       |  19 ++
 docparse/data_storage.h | 299 ++++++++++++++++++++++++++++
 docparse/docparse.c     | 423 ++++++++++++++++++++++++++++++++++++++++
 docparse/parse.sh       |  41 ++++
 docparse/testinfo.pl    |  40 ++++
 7 files changed, 825 insertions(+), 1 deletion(-)
 create mode 100644 docparse/.gitignore
 create mode 100644 docparse/Makefile
 create mode 100644 docparse/data_storage.h
 create mode 100644 docparse/docparse.c
 create mode 100755 docparse/parse.sh
 create mode 100755 docparse/testinfo.pl

diff --git a/Makefile b/Makefile
index bf5077231..3830fb6d4 100644
--- a/Makefile
+++ b/Makefile
@@ -62,7 +62,7 @@ $(1):: | $$(abs_top_builddir)/$$(basename $$(subst -,.,$(1)))
 endif
 endef
 
-COMMON_TARGETS		+= testcases tools
+COMMON_TARGETS		+= testcases tools docparse
 # Don't want to nuke the original files if we're installing in-build-tree.
 ifneq ($(BUILD_TREE_STATE),$(BUILD_TREE_SRCDIR_INSTALL))
 INSTALL_TARGETS		+= runtest scenario_groups testscripts
diff --git a/docparse/.gitignore b/docparse/.gitignore
new file mode 100644
index 000000000..f636ed847
--- /dev/null
+++ b/docparse/.gitignore
@@ -0,0 +1,2 @@
+/docparse
+/metadata.json
diff --git a/docparse/Makefile b/docparse/Makefile
new file mode 100644
index 000000000..94ba83ffe
--- /dev/null
+++ b/docparse/Makefile
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/functions.mk
+
+MAKE_TARGETS		:= metadata.json
+HOST_MAKE_TARGETS	:= docparse
+
+INSTALL_DIR = metadata
+
+.PHONY: metadata.json
+
+metadata.json: docparse
+	$(abs_srcdir)/parse.sh > metadata.json
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/docparse/data_storage.h b/docparse/data_storage.h
new file mode 100644
index 000000000..1a9265f92
--- /dev/null
+++ b/docparse/data_storage.h
@@ -0,0 +1,299 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef DATA_STORAGE_H__
+#define DATA_STORAGE_H__
+
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+enum data_type {
+	DATA_ARRAY,
+	DATA_HASH,
+	DATA_STRING,
+};
+
+struct data_node_array {
+	enum data_type type;
+	unsigned int array_len;
+	unsigned int array_used;
+	struct data_node *array[];
+};
+
+struct data_hash_elem {
+	struct data_node *node;
+	char *id;
+};
+
+struct data_node_hash {
+	enum data_type type;
+	unsigned int elems_len;
+	unsigned int elems_used;
+	struct data_hash_elem elems[];
+};
+
+struct data_node_string {
+	enum data_type type;
+	char val[];
+};
+
+struct data_node {
+	union {
+		enum data_type type;
+		struct data_node_hash hash;
+		struct data_node_array array;
+		struct data_node_string string;
+	};
+};
+
+static inline struct data_node *data_node_string(const char *string)
+{
+	size_t size = sizeof(struct data_node_string) + strlen(string) + 1;
+	struct data_node *node = malloc(size);
+
+	if (!node)
+		return NULL;
+
+	node->type = DATA_STRING;
+	strcpy(node->string.val, string);
+
+	return node;
+}
+
+#define MAX_ELEMS 20
+
+static inline struct data_node *data_node_hash(void)
+{
+	size_t size = sizeof(struct data_node_hash)
+	              + MAX_ELEMS * sizeof(struct data_hash_elem);
+	struct data_node *node = malloc(size);
+
+	if (!node)
+		return NULL;
+
+	node->type = DATA_HASH;
+	node->hash.elems_len = MAX_ELEMS;
+	node->hash.elems_used = 0;
+
+	return node;
+}
+
+static inline struct data_node *data_node_array(void)
+{
+	size_t size = sizeof(struct data_node_array) +
+	              + MAX_ELEMS * sizeof(struct data_node*);
+	struct data_node *node = malloc(size);
+
+	if (!node)
+		return NULL;
+
+	node->type = DATA_ARRAY;
+	node->array.array_len = MAX_ELEMS;
+	node->array.array_used = 0;
+
+	return node;
+}
+
+static inline int data_node_hash_add(struct data_node *self, const char *id, struct data_node *payload)
+{
+	if (self->type != DATA_HASH)
+		return 1;
+
+	struct data_node_hash *hash = &self->hash;
+
+	if (hash->elems_used == hash->elems_len)
+		return 1;
+
+	struct data_hash_elem *elem = &hash->elems[hash->elems_used++];
+
+	elem->node = payload;
+	elem->id = strdup(id);
+
+	return 0;
+}
+
+static inline void data_node_free(struct data_node *self)
+{
+	unsigned int i;
+
+	switch (self->type) {
+	case DATA_STRING:
+	break;
+	case DATA_HASH:
+		for (i = 0; i < self->hash.elems_used; i++) {
+			data_node_free(self->hash.elems[i].node);
+			free(self->hash.elems[i].id);
+		}
+	break;
+	case DATA_ARRAY:
+		for (i = 0; i < self->array.array_used; i++)
+			data_node_free(self->array.array[i]);
+	break;
+	}
+
+	free(self);
+}
+
+static inline int data_node_hash_del(struct data_node *self, const char *id)
+{
+	unsigned int i;
+	struct data_node_hash *hash = &self->hash;
+
+	for (i = 0; i < hash->elems_used; i++) {
+		if (!strcmp(hash->elems[i].id, id))
+			break;
+	}
+
+	if (i >= hash->elems_used)
+		return 0;
+
+	data_node_free(hash->elems[i].node);
+	free(hash->elems[i].id);
+
+	hash->elems[i] = hash->elems[--hash->elems_used];
+
+	return 1;
+}
+
+static struct data_node *data_node_hash_get(struct data_node *self, const char *id)
+{
+	unsigned int i;
+	struct data_node_hash *hash = &self->hash;
+
+	for (i = 0; i < hash->elems_used; i++) {
+		if (!strcmp(hash->elems[i].id, id))
+			break;
+	}
+
+	if (i >= hash->elems_used)
+		return NULL;
+
+	return hash->elems[i].node;
+}
+
+static inline int data_node_array_add(struct data_node *self, struct data_node *payload)
+{
+	if (self->type != DATA_ARRAY)
+		return 1;
+
+	struct data_node_array *array = &self->array;
+
+	if (array->array_used == array->array_len)
+		return 1;
+
+	array->array[array->array_used++] = payload;
+
+	return 0;
+}
+
+static inline unsigned int data_node_array_len(struct data_node *self)
+{
+	if (self->type != DATA_ARRAY)
+		return 0;
+
+	return self->array.array_used;
+}
+
+static inline void data_print_padd(unsigned int i)
+{
+	while (i-- > 0)
+		putchar(' ');
+}
+
+static inline void data_node_print_(struct data_node *self, unsigned int padd)
+{
+	unsigned int i;
+
+	switch (self->type) {
+	case DATA_STRING:
+		data_print_padd(padd);
+		printf("'%s'\n", self->string.val);
+	break;
+	case DATA_HASH:
+		for (i = 0; i < self->hash.elems_used; i++) {
+			data_print_padd(padd);
+			printf("%s = {\n", self->hash.elems[i].id);
+			data_node_print_(self->hash.elems[i].node, padd+1);
+			data_print_padd(padd);
+			printf("},\n");
+		}
+	break;
+	case DATA_ARRAY:
+		for (i = 0; i < self->array.array_used; i++) {
+			data_print_padd(padd);
+			printf("{\n");
+			data_node_print_(self->array.array[i], padd+1);
+			data_print_padd(padd);
+			printf("},\n");
+		}
+	break;
+	}
+}
+
+static inline void data_node_print(struct data_node *self)
+{
+	printf("{\n");
+	data_node_print_(self, 1);
+	printf("}\n");
+}
+
+static inline void data_fprintf(FILE *f, unsigned int padd, const char *fmt, ...)
+                   __attribute__((format (printf, 3, 4)));
+
+static inline void data_fprintf(FILE *f, unsigned int padd, const char *fmt, ...)
+{
+	va_list va;
+
+	while (padd-- > 0)
+		putc(' ', f);
+
+	va_start(va, fmt);
+	vfprintf(f, fmt, va);
+	va_end(va);
+}
+
+static inline void data_to_json_(struct data_node *self, FILE *f, unsigned int padd, int do_padd)
+{
+	unsigned int i;
+
+	switch (self->type) {
+	case DATA_STRING:
+		padd = do_padd ? padd : 0;
+		data_fprintf(f, padd, "\"%s\"", self->string.val);
+	break;
+	case DATA_HASH:
+		for (i = 0; i < self->hash.elems_used; i++) {
+			data_fprintf(f, padd, "\"%s\": ", self->hash.elems[i].id);
+			data_to_json_(self->hash.elems[i].node, f, padd+1, 0);
+			if (i < self->hash.elems_used - 1)
+				fprintf(f, ",\n");
+			else
+				fprintf(f, "\n");
+		}
+	break;
+	case DATA_ARRAY:
+		data_fprintf(f, do_padd ? padd : 0, "[\n");
+		for (i = 0; i < self->array.array_used; i++) {
+			data_to_json_(self->array.array[i], f, padd+1, 1);
+			if (i < self->array.array_used - 1)
+				fprintf(f, ",\n");
+			else
+				fprintf(f, "\n");
+		}
+		data_fprintf(f, padd, "]");
+	break;
+	}
+}
+
+static inline void data_to_json(struct data_node *self, FILE *f, unsigned int padd)
+{
+	fprintf(f, "{\n");
+	data_to_json_(self, f, padd + 1, 1);
+	data_fprintf(f, padd, "}");
+}
+
+#endif /* DATA_STORAGE_H__ */
diff --git a/docparse/docparse.c b/docparse/docparse.c
new file mode 100644
index 000000000..63d131c87
--- /dev/null
+++ b/docparse/docparse.c
@@ -0,0 +1,423 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <libgen.h>
+#include <ctype.h>
+#include <unistd.h>
+
+#include "data_storage.h"
+
+static void oneline_comment(FILE *f)
+{
+	int c;
+
+	do {
+		c = getc(f);
+	} while (c != '\n');
+}
+
+static const char *eat_asterisk_space(const char *c)
+{
+	unsigned int i = 0;
+
+	while (isspace(c[i]))
+		i++;
+
+	if (c[i] == '*') {
+		while (isspace(c[i+1]))
+			i++;
+		return &c[i+1];
+	}
+
+	return c;
+}
+
+static void multiline_comment(FILE *f, struct data_node *doc)
+{
+	int c;
+	int state = 0;
+	char buf[4096];
+	unsigned int bufp = 0;
+
+	for (;;) {
+		c = getc(f);
+
+		if (doc) {
+			if (c == '\n') {
+				struct data_node *line;
+				buf[bufp] = 0;
+				line = data_node_string(eat_asterisk_space(buf));
+				data_node_array_add(doc, line);
+				bufp = 0;
+				continue;
+			}
+
+			if (bufp + 1 >= sizeof(buf))
+				continue;
+
+			buf[bufp++] = c;
+		}
+
+		switch (state) {
+		case 0:
+			if (c == '*')
+				state = 1;
+		break;
+		case 1:
+			switch (c) {
+			case '/':
+				return;
+			case '*':
+				continue;
+			default:
+				state = 0;
+			break;
+			}
+		break;
+		}
+	}
+
+}
+
+static const char doc_prefix[] = "\\\n";
+
+static void maybe_doc_comment(FILE *f, struct data_node *doc)
+{
+	int c, i;
+
+	for (i = 0; doc_prefix[i]; i++) {
+		c = getc(f);
+
+		if (c == doc_prefix[i])
+			continue;
+
+		if (c == '*')
+			ungetc(c, f);
+
+		multiline_comment(f, NULL);
+		return;
+	}
+
+	multiline_comment(f, doc);
+}
+
+static void maybe_comment(FILE *f, struct data_node *doc)
+{
+	int c = getc(f);
+
+	switch (c) {
+	case '/':
+		oneline_comment(f);
+	break;
+	case '*':
+		maybe_doc_comment(f, doc);
+	break;
+	default:
+		ungetc(c, f);
+	break;
+	}
+}
+
+const char *next_token(FILE *f, struct data_node *doc)
+{
+	size_t i = 0;
+	static char buf[4096];
+	int c;
+	int in_str = 0;
+
+	for (;;) {
+		c = fgetc(f);
+
+		if (c == EOF)
+			goto exit;
+
+		if (in_str) {
+			if (c == '"') {
+				if (i == 0 || buf[i-1] != '\\') {
+					buf[i++] = c;
+					goto exit;
+				}
+			}
+
+			buf[i++] = c;
+			continue;
+		}
+
+		switch (c) {
+		case '{':
+		case '}':
+		case ';':
+		case '(':
+		case ')':
+		case '=':
+		case ',':
+		case '[':
+		case ']':
+			if (i) {
+				ungetc(c, f);
+				goto exit;
+			}
+
+			buf[i++] = c;
+			goto exit;
+		case '0' ... '9':
+		case 'a' ... 'z':
+		case 'A' ... 'Z':
+		case '.':
+		case '_':
+		case '-':
+			buf[i++] = c;
+		break;
+		case '/':
+			maybe_comment(f, doc);
+		break;
+		case '"':
+			in_str = 1;
+		break;
+		case ' ':
+		case '\n':
+		case '\t':
+			if (i)
+				goto exit;
+		break;
+		}
+	}
+
+exit:
+	if (i == 0)
+		return NULL;
+
+	buf[i] = 0;
+	return buf;
+}
+
+#define WARN(str) fprintf(stderr, str "\n")
+
+static int parse_array(FILE *f, struct data_node *node)
+{
+	const char *token;
+
+	for (;;) {
+		if (!(token = next_token(f, NULL)))
+			return 1;
+
+		if (!strcmp(token, "{")) {
+			struct data_node *ret = data_node_array();
+			parse_array(f, ret);
+
+			if (data_node_array_len(ret))
+				data_node_array_add(node, ret);
+			else
+				data_node_free(ret);
+
+			continue;
+		}
+
+		if (!strcmp(token, "}"))
+			return 0;
+
+		if (!strcmp(token, ","))
+			continue;
+
+		if (!strcmp(token, "NULL"))
+			continue;
+
+		struct data_node *str = data_node_string(token);
+
+		data_node_array_add(node, str);
+	}
+
+	return 0;
+}
+
+static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *node)
+{
+	const char *token;
+	char *id = NULL;
+	int state = 0;
+	struct data_node *ret;
+
+	for (;;) {
+		if (!(token = next_token(f, doc)))
+			return 1;
+
+		if (!strcmp(token, "}"))
+			return 0;
+
+		switch (state) {
+		case 0:
+			id = strdup(token);
+			state = 1;
+			continue;
+		case 1:
+			if (!strcmp(token, "="))
+				state = 2;
+			else
+				WARN("Expected '='");
+			continue;
+		case 2:
+			if (!strcmp(token, "(")) {
+				state = 3;
+				continue;
+			}
+		break;
+		case 3:
+			if (!strcmp(token, ")"))
+				state = 2;
+			continue;
+
+		case 4:
+			if (!strcmp(token, ","))
+				state = 0;
+			continue;
+		}
+
+		if (!strcmp(token, "{")) {
+			ret = data_node_array();
+			parse_array(f, ret);
+		} else {
+			ret = data_node_string(token);
+		}
+
+		const char *key = id;
+		if (key[0] == '.')
+			key++;
+
+		data_node_hash_add(node, key, ret);
+		free(id);
+		state = 4;
+	}
+}
+
+static const char *tokens[] = {
+	"static",
+	"struct",
+	"tst_test",
+	"test",
+	"=",
+	"{",
+};
+
+static struct data_node *parse_file(const char *fname)
+{
+	int state = 0, found = 0;
+	const char *token;
+
+	if (access(fname, F_OK)) {
+		fprintf(stderr, "file %s is not exist\n", fname);
+		return NULL;
+	}
+
+	FILE *f = fopen(fname, "r");
+
+	struct data_node *res = data_node_hash();
+	struct data_node *doc = data_node_array();
+
+	while ((token = next_token(f, doc))) {
+		if (state < 6 && !strcmp(tokens[state], token))
+			state++;
+		else
+			state = 0;
+
+		if (state < 6)
+			continue;
+
+		found = 1;
+		parse_test_struct(f, doc, res);
+	}
+
+
+	if (data_node_array_len(doc)) {
+		data_node_hash_add(res, "doc", doc);
+		found = 1;
+	} else {
+		data_node_free(doc);
+	}
+
+	fclose(f);
+
+	if (!found) {
+		data_node_free(res);
+		return NULL;
+	}
+
+	return res;
+}
+
+static const char *filter_out[] = {
+	"bufs",
+	"cleanup",
+	"mntpoint",
+	"setup",
+	"tcnt",
+	"test",
+	"test_all",
+	NULL
+};
+
+static struct implies {
+	const char *flag;
+	const char *implies;
+} implies[] = {
+	{"format_device", "needs_device"},
+	{"mount_device", "needs_device"},
+	{"mount_device", "format_device"},
+	{"all_filesystems", "needs_device"},
+	{"needs_device", "needs_tmpdir"},
+	{NULL, NULL}
+};
+
+const char *strip_name(char *path)
+{
+	char *name = basename(path);
+	size_t len = strlen(name);
+
+	if (len > 2 && name[len-1] == 'c' && name[len-2] == '.')
+		name[len-2] = '\0';
+
+	return name;
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int i;
+	struct data_node *res;
+
+	if (argc != 2) {
+		fprintf(stderr, "Usage: docparse filename.c\n");
+		return 1;
+	}
+
+	res = parse_file(argv[1]);
+	if (!res)
+		return 0;
+
+	/* Filter out useless data */
+	for (i = 0; filter_out[i]; i++)
+		data_node_hash_del(res, filter_out[i]);
+
+	/* Normalize the result */
+	for (i = 0; implies[i].flag; i++) {
+		if (!data_node_hash_get(res, implies[i].flag))
+			continue;
+
+		if (data_node_hash_get(res, implies[i].implies)) {
+			fprintf(stderr, "%s: useless tag: %s\n", argv[1], implies[i].implies);
+			continue;
+		}
+
+		data_node_hash_add(res, implies[i].implies, data_node_string("1"));
+	}
+
+	data_node_hash_add(res, "fname", data_node_string(argv[1]));
+	printf("  \"%s\": ", strip_name(argv[1]));
+	data_to_json(res, stdout, 2);
+	data_node_free(res);
+
+	return 0;
+}
diff --git a/docparse/parse.sh b/docparse/parse.sh
new file mode 100755
index 000000000..4ae0c42b2
--- /dev/null
+++ b/docparse/parse.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+set -e
+
+top_builddir=$PWD/..
+top_srcdir="$(dirname $0)/.."
+
+cd $top_srcdir
+
+version=$(cat $top_srcdir/VERSION)
+if [ -d .git ]; then
+	version=$(git describe 2>/dev/null) || version=$(cat $top_srcdir/VERSION).GIT-UNKNOWN
+fi
+
+echo '{'
+echo ' "testsuite": "Linux Test Project",'
+echo ' "testsuite_short": "LTP",'
+echo ' "url": "https://github.com/linux-test-project/ltp/",'
+echo ' "scm_url_base": "https://github.com/linux-test-project/ltp/tree/master/",'
+echo ' "timeout": 300,'
+echo " \"version\": \"$version\","
+echo ' "tests": {'
+
+first=1
+
+for test in `find testcases/ -name '*.c'`; do
+	a=$($top_builddir/docparse/docparse "$test")
+	if [ -n "$a" ]; then
+		if [ -z "$first" ]; then
+			echo ','
+		fi
+		first=
+		echo -n "$a"
+	fi
+done
+
+echo
+echo ' }'
+echo '}'
diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
new file mode 100755
index 000000000..d93d7d701
--- /dev/null
+++ b/docparse/testinfo.pl
@@ -0,0 +1,40 @@
+#!/usr/bin/perl
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+
+use strict;
+use warnings;
+
+use JSON;
+use Data::Dumper;
+
+sub load_json
+{
+	my ($fname) = @_;
+	local $/;
+
+	open(my $fh, '<', $fname) or die("Can't open $fname $!");
+
+	return <$fh>;
+}
+
+sub query_flag
+{
+	my ($json, $flag) = @_;
+
+	my $tests = $json->{'tests'};
+
+	foreach my $key (sort(keys %$tests)) {
+		if ($tests->{$key}->{$flag}) {
+			if ($tests->{$key}->{$flag} eq "1") {
+				print("$key\n");
+			} else {
+				print("$key:\n" . Dumper($tests->{$key}->{$flag}) . "\n");
+			}
+		}
+	}
+}
+
+my $json = decode_json(load_json($ARGV[0]));
+
+query_flag($json, $ARGV[1]);
-- 
2.29.1

