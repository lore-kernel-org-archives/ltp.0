Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA71CD98F8
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 14:11:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB2723E587F
	for <ltp@archiver.kernel.org>; Thu, 18 Jun 2026 16:10:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC7183CEDDE
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:10:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8A31E14010E3
 for <ltp@lists.linux.it>; Thu, 18 Jun 2026 16:10:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E97475F6B;
 Thu, 18 Jun 2026 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781791828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIh5UwnINgVuKLZei5F5IjVyV2ZzetAjP7f7iTbqui4=;
 b=aTxB8YRKLI8oXa5YFjVDD2wYL3tjbduEnRyEuybmWZ3AZQC0NJEYhgRKaIK0D/cnQ7uLqX
 ylbOjJQWHUaeIJib/pkgqfycIbV5LGaxcnvEhbErg8w+6GJbMAWILQiwsE1yIQ/ggqWewT
 LJMcss8DBBKKM47W5te7Gxh/DhWJTJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781791828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIh5UwnINgVuKLZei5F5IjVyV2ZzetAjP7f7iTbqui4=;
 b=6Y/dK3owqRZtfd9KLKLu6bBX6nqt0m/v8mAA7vJ0b8kWpoSy7M4QjAHGZmaxj3Kt/9sbv2
 fP2BNhSsBUYdzkAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781791828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIh5UwnINgVuKLZei5F5IjVyV2ZzetAjP7f7iTbqui4=;
 b=aTxB8YRKLI8oXa5YFjVDD2wYL3tjbduEnRyEuybmWZ3AZQC0NJEYhgRKaIK0D/cnQ7uLqX
 ylbOjJQWHUaeIJib/pkgqfycIbV5LGaxcnvEhbErg8w+6GJbMAWILQiwsE1yIQ/ggqWewT
 LJMcss8DBBKKM47W5te7Gxh/DhWJTJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781791828;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIh5UwnINgVuKLZei5F5IjVyV2ZzetAjP7f7iTbqui4=;
 b=6Y/dK3owqRZtfd9KLKLu6bBX6nqt0m/v8mAA7vJ0b8kWpoSy7M4QjAHGZmaxj3Kt/9sbv2
 fP2BNhSsBUYdzkAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53F6A779AB;
 Thu, 18 Jun 2026 14:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6HHVEVT8M2p7CgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 18 Jun 2026 14:10:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 18 Jun 2026 16:10:26 +0200
MIME-Version: 1.0
Message-Id: <20260618-metadata_groups-v2-1-6ab298932233@suse.com>
References: <20260618-metadata_groups-v2-0-6ab298932233@suse.com>
In-Reply-To: <20260618-metadata_groups-v2-0-6ab298932233@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781791828; l=11946;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=Xdj+NIiA3zQHE6TUdiL3VNtfmpf3ZVNLtKpTuHNN22U=;
 b=6XqbLJJy7AWvIqF85sHNVW1FV5X7/8UfO3yo/P+ujs7QTu0StoJJJDehXO6V9hTTGEcHFBec3
 Df0G6Gi0h0vD1XSFIXpxXmnVZde9K+tceDffBEXL1D3sZi7O5H4s6VL
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] metadata: add tests grouping support
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add groups field to metaparse JSON output, so we can filter out tests
in kirk. Groups are derived from:

1. Source file path - the two nearest parent directories (immediate
   parent first), skipping 'kernel' as too generic. For example:
   - testcases/kernel/syscalls/clone/clone01.c -> clone, syscalls
   - testcases/kernel/kvm/kvm_pagefault01.c -> kvm
   - testcases/cve/cve-2017-16939.c -> cve

2. @groups tags in the doc comment block, e.g.:
   /*\
    * Test description.
    *
    * @groups stress syscalls
    * @groups memory
    */

Add test case for @groups tag parsing.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 metadata/metaparse.c         | 159 +++++++++++++++++++++++++++++++++++--------
 metadata/tests/groups.c      |  11 +++
 metadata/tests/groups.c.json |  12 ++++
 3 files changed, 152 insertions(+), 30 deletions(-)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 561cbb9d2d54689988c9aa49d591628696bcf847..94e795c275aebda41737558d06f7d9c8c1a2f4f7 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -17,6 +17,7 @@
 #include "data_storage.h"
 
 #define INCLUDE_PATH_MAX 5
+#define GROUPS_TAG "groups"
 
 static int verbose;
 static char *cmdline_includepath[INCLUDE_PATH_MAX];
@@ -50,7 +51,49 @@ static const char *eat_asterisk_space(const char *c)
 	return c;
 }
 
-static void multiline_comment(FILE *f, struct data_node *doc)
+/*
+ * Add a group to the groups array, skipping 'kernel' as it's too generic.
+ * Returns 0 if no group was added, 1 otherwise.
+ */
+static int add_group(struct data_node *groups, const char *name)
+{
+	if (name && strcmp(name, "kernel")) {
+		data_node_array_add(groups, data_node_string(name));
+		return 1;
+	}
+
+	return 0;
+}
+
+/*
+ * Parse a '@groups foo bar baz' doc comment line, adding each
+ * whitespace-separated name to the groups array. Returns 1 if the line
+ * was a @groups tag (and should be consumed), 0 otherwise.
+ */
+static int parse_groups(struct data_node *groups, char *line)
+{
+	char *s;
+	char *name;
+
+	if (!groups)
+		return 0;
+
+	s = (char *)eat_asterisk_space(line);
+	if (strncmp(s, GROUPS_TAG, sizeof(GROUPS_TAG) - 1))
+		return 0;
+
+	s += sizeof(GROUPS_TAG) - 1;
+	if (*s && *s != ' ' && *s != '\t')
+		return 0;
+
+	for (name = strtok(s, " \t"); name; name = strtok(NULL, " \t"))
+		add_group(groups, name);
+
+	return 1;
+}
+
+static void multiline_comment(FILE *f, struct data_node *doc,
+			      struct data_node *groups)
 {
 	int c;
 	int state = 0;
@@ -62,12 +105,14 @@ static void multiline_comment(FILE *f, struct data_node *doc)
 
 		if (doc) {
 			if (c == '\n') {
-				struct data_node *line;
+				char *str;
 				buf[bufp] = 0;
-				line = data_node_string(eat_asterisk_space(buf));
-				if (data_node_array_add(doc, line))
-					WARN("doc string comment truncated");
+				str = (char *)eat_asterisk_space(buf);
 				bufp = 0;
+				if (parse_groups(groups, str))
+					continue;
+				if (data_node_array_add(doc, data_node_string(str)))
+					WARN("doc string comment truncated");
 				continue;
 			}
 
@@ -100,7 +145,8 @@ static void multiline_comment(FILE *f, struct data_node *doc)
 
 static const char doc_prefix[] = "\\\n";
 
-static void maybe_doc_comment(FILE *f, struct data_node *doc)
+static void maybe_doc_comment(FILE *f, struct data_node *doc,
+			      struct data_node *groups)
 {
 	int c, i;
 
@@ -113,14 +159,15 @@ static void maybe_doc_comment(FILE *f, struct data_node *doc)
 		if (c == '*')
 			ungetc(c, f);
 
-		multiline_comment(f, NULL);
+		multiline_comment(f, NULL, NULL);
 		return;
 	}
 
-	multiline_comment(f, doc);
+	multiline_comment(f, doc, groups);
 }
 
-static void maybe_comment(FILE *f, struct data_node *doc)
+static void maybe_comment(FILE *f, struct data_node *doc,
+			  struct data_node *groups)
 {
 	int c = getc(f);
 
@@ -129,7 +176,7 @@ static void maybe_comment(FILE *f, struct data_node *doc)
 		remove_to_newline(f);
 	break;
 	case '*':
-		maybe_doc_comment(f, doc);
+		maybe_doc_comment(f, doc, groups);
 	break;
 	default:
 		ungetc(c, f);
@@ -137,7 +184,8 @@ static void maybe_comment(FILE *f, struct data_node *doc)
 	}
 }
 
-static char *next_token2(FILE *f, char *buf, size_t buf_len, struct data_node *doc)
+static char *next_token2(FILE *f, char *buf, size_t buf_len,
+			 struct data_node *doc, struct data_node *groups)
 {
 	size_t i = 0;
 	int c;
@@ -194,7 +242,7 @@ static char *next_token2(FILE *f, char *buf, size_t buf_len, struct data_node *d
 			buf[i++] = c;
 		break;
 		case '/':
-			maybe_comment(f, doc);
+			maybe_comment(f, doc, groups);
 		break;
 		case '"':
 			in_str = 1;
@@ -216,11 +264,11 @@ exit:
 	return buf;
 }
 
-static char *next_token(FILE *f, struct data_node *doc)
+static char *next_token(FILE *f, struct data_node *doc, struct data_node *groups)
 {
 	static char buf[4096];
 
-	return next_token2(f, buf, sizeof(buf), doc);
+	return next_token2(f, buf, sizeof(buf), doc, groups);
 }
 
 static FILE *open_file(const char *dir, const char *fname)
@@ -383,7 +431,7 @@ static int array_is_hash(FILE *f)
 	int in_id = 1;
 	char *token;
 
-	while ((token = next_token(f, NULL))) {
+	while ((token = next_token(f, NULL, NULL))) {
 
 		if (!strcmp(token, "}")) {
 			if (in_id && !comma_last)
@@ -402,7 +450,7 @@ static int array_is_hash(FILE *f)
 			int level = 1;
 
 			for (;;) {
-				token = next_token(f, NULL);
+				token = next_token(f, NULL, NULL);
 
 				if (!token)
 					goto ret;
@@ -453,7 +501,7 @@ static int parse_array(FILE *f, const char *arr_id, struct data_node **ret)
 		*ret = data_node_array();
 
 	for (;;) {
-		if (!(token = next_token(f, NULL)))
+		if (!(token = next_token(f, NULL, NULL)))
 			return 1;
 
 		if (!strcmp(token, "{")) {
@@ -529,14 +577,14 @@ static int parse_get_array_len(FILE *f)
 	const char *token;
 	int cnt = 0, depth = 0, prev_comma = 0;
 
-	if (!(token = next_token(f, NULL)))
+	if (!(token = next_token(f, NULL, NULL)))
 		return 0;
 
 	if (strcmp(token, "{"))
 		return 0;
 
 	for (;;) {
-		if (!(token = next_token(f, NULL)))
+		if (!(token = next_token(f, NULL, NULL)))
 			return 0;
 
 		if (!strcmp(token, "{"))
@@ -565,7 +613,7 @@ static void look_for_array_size(FILE *f, const char *arr_id, struct data_node **
 	int prev_buf = 1;
 
 	for (;;) {
-		if (!(token = next_token2(f, buf[cur_buf], sizeof(buf[cur_buf]), NULL)))
+		if (!(token = next_token2(f, buf[cur_buf], sizeof(buf[cur_buf]), NULL, NULL)))
 			break;
 
 		if (!strcmp(token, "=") && !strcmp(buf[prev_buf], arr_id)) {
@@ -595,13 +643,13 @@ static int parse_array_size(FILE *f, struct data_node **res)
 
 	*res = NULL;
 
-	if (!(token = next_token(f, NULL)))
+	if (!(token = next_token(f, NULL, NULL)))
 		return 1;
 
 	if (strcmp(token, "("))
 		return 1;
 
-	if (!(token = next_token(f, NULL)))
+	if (!(token = next_token(f, NULL, NULL)))
 		return 1;
 
 	arr_id = strdup(token);
@@ -621,7 +669,7 @@ static int parse_array_size(FILE *f, struct data_node **res)
 		rewind(f);
 
 		for (;;) {
-			if (!(token = next_token(f, NULL)))
+			if (!(token = next_token(f, NULL, NULL)))
 				break;
 
 			if (token[0] == '#') {
@@ -654,7 +702,8 @@ static int parse_array_size(FILE *f, struct data_node **res)
 	return 0;
 }
 
-static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *node)
+static int parse_test_struct(FILE *f, struct data_node *doc,
+			     struct data_node *groups, struct data_node *node)
 {
 	char *token;
 	char *id = NULL;
@@ -662,7 +711,7 @@ static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *n
 	struct data_node *ret;
 
 	for (;;) {
-		if (!(token = next_token(f, doc)))
+		if (!(token = next_token(f, doc, groups)))
 			return 1;
 
 		if (!strcmp(token, "}"))
@@ -842,7 +891,7 @@ static void parse_include_macros(FILE *f, int level)
 	if (!inc)
 		return;
 
-	while ((token = next_token(inc, NULL))) {
+	while ((token = next_token(inc, NULL, NULL))) {
 		if (token[0] == '#') {
 			hash = 1;
 			continue;
@@ -907,6 +956,47 @@ static void load_internal_macros(void)
 		fprintf(stderr, "END PREDEFINED MACROS\n");
 }
 
+/*
+ * Add groups derived from the source file path.
+ *
+ * Groups are the two nearest parent directories (immediate parent
+ * first), skipping 'kernel' as it's too generic:
+ *
+ *   testcases/kernel/syscalls/clone/clone01.c  -> clone, syscalls
+ *   testcases/kernel/kvm/kvm_pagefault01.c     -> kvm
+ *   testcases/cve/cve-2017-16939.c             -> cve
+ */
+static void add_path_groups(struct data_node *groups, const char *fname)
+{
+	char *buf;
+	char *dirs[8];
+	int ndirs = 0;
+	char *p;
+
+	if (strncmp(fname, "testcases/", 10))
+		return;
+
+	buf = strdup(fname + 10);
+	if (!buf)
+		return;
+
+	p = strtok(buf, "/");
+	while (p && ndirs < 8) {
+		dirs[ndirs++] = p;
+		p = strtok(NULL, "/");
+	}
+
+	/* Last element is the filename, skip it */
+	ndirs--;
+
+	if (ndirs >= 1)
+		add_group(groups, dirs[ndirs - 1]);
+	if (ndirs >= 2)
+		add_group(groups, dirs[ndirs - 2]);
+
+	free(buf);
+}
+
 static struct data_node *parse_file(const char *fname)
 {
 	int state = 0, found = 0;
@@ -923,15 +1013,18 @@ static struct data_node *parse_file(const char *fname)
 
 	struct data_node *res = data_node_hash();
 	struct data_node *doc = data_node_array();
+	struct data_node *groups = data_node_array();
+
+	add_path_groups(groups, fname);
 
 	load_internal_macros();
 
-	while ((token = next_token(f, doc))) {
+	while ((token = next_token(f, doc, groups))) {
 		if (state < 6 && !strcmp(tokens[state], token)) {
 			state++;
 		} else {
 			if (token[0] == '#') {
-				token = next_token(f, doc);
+				token = next_token(f, doc, groups);
 				if (token) {
 					if (!strcmp(token, "define"))
 						parse_macro(f);
@@ -948,7 +1041,7 @@ static struct data_node *parse_file(const char *fname)
 			continue;
 
 		found = 1;
-		parse_test_struct(f, doc, res);
+		parse_test_struct(f, doc, groups, res);
 	}
 
 	if (data_node_array_len(doc)) {
@@ -958,6 +1051,11 @@ static struct data_node *parse_file(const char *fname)
 		data_node_free(doc);
 	}
 
+	if (data_node_array_len(groups))
+		data_node_hash_add(res, "groups", groups);
+	else
+		data_node_free(groups);
+
 	fclose(f);
 
 	if (!found) {
@@ -985,7 +1083,7 @@ static void parse_must_files(void)
 			if (!f)
 				continue;
 
-			while ((token = next_token(f, NULL))) {
+			while ((token = next_token(f, NULL, NULL))) {
 				if (!strcmp(token, "define"))
 					parse_macro(f);
 			}
@@ -1238,6 +1336,7 @@ int main(int argc, char *argv[])
 	}
 
 	data_node_hash_add(res, "fname", data_node_string(argv[optind]));
+
 	printf("  \"%s\": ", strip_name(argv[optind]));
 	data_to_json(res, stdout, 2);
 	data_node_free(res);
diff --git a/metadata/tests/groups.c b/metadata/tests/groups.c
new file mode 100644
index 0000000000000000000000000000000000000000..40032a7ef60e398c50690995fc68025575d7f684
--- /dev/null
+++ b/metadata/tests/groups.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*\
+ * Test for @groups tag parsing.
+ *
+ * @groups stress regression
+ * @groups smoke
+ */
+
+static struct tst_test test = {
+};
diff --git a/metadata/tests/groups.c.json b/metadata/tests/groups.c.json
new file mode 100644
index 0000000000000000000000000000000000000000..2ca8b5d21d980cdffae4bdaeea20b659a52bad8a
--- /dev/null
+++ b/metadata/tests/groups.c.json
@@ -0,0 +1,12 @@
+  "groups": {
+   "doc": [
+    "Test for @groups tag parsing.",
+    ""
+   ],
+   "groups": [
+    "stress",
+    "regression",
+    "smoke"
+   ],
+   "fname": "groups.c"
+  }
\ No newline at end of file

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
