Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D97FCDB466
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 08:53:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5ED883E53C0
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 10:53:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE36C3E54ED
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 10:53:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 946AD600732
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 10:53:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0FCBE7067E;
 Mon, 22 Jun 2026 08:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782118400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5JGMl2NNmtU5pQChpaVrM/wYdZZISgkjmpF1XsodkI=;
 b=1Cvu9GEYVaIlb+Al3zFgb6J5g2KR66y5o8pH4Vw58Ahwf8+hG0G1Z65IPe3P/zaYB3zuXZ
 ESJ9ENP9cQdEPdspJ8J3X3p6tC5nBxBpFOTVejbSrHUHdov5VWkDxYEW4T+7eUG7bKN67a
 ht7eDuaA636/dWAOfjU5EyJu5/1dbzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782118400;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5JGMl2NNmtU5pQChpaVrM/wYdZZISgkjmpF1XsodkI=;
 b=02QDiqt1zTaUzD/wgeqGXafHIetzUrLwctUbV6HBn0J6d9xjGzN6BeE0gab1CJ8GBqYZni
 Xt/bO6DvucbGMrCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1Cvu9GEY;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=02QDiqt1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782118400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5JGMl2NNmtU5pQChpaVrM/wYdZZISgkjmpF1XsodkI=;
 b=1Cvu9GEYVaIlb+Al3zFgb6J5g2KR66y5o8pH4Vw58Ahwf8+hG0G1Z65IPe3P/zaYB3zuXZ
 ESJ9ENP9cQdEPdspJ8J3X3p6tC5nBxBpFOTVejbSrHUHdov5VWkDxYEW4T+7eUG7bKN67a
 ht7eDuaA636/dWAOfjU5EyJu5/1dbzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782118400;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B5JGMl2NNmtU5pQChpaVrM/wYdZZISgkjmpF1XsodkI=;
 b=02QDiqt1zTaUzD/wgeqGXafHIetzUrLwctUbV6HBn0J6d9xjGzN6BeE0gab1CJ8GBqYZni
 Xt/bO6DvucbGMrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3FD9779AB;
 Mon, 22 Jun 2026 08:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yBEYMf/3OGoeFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Jun 2026 08:53:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Jun 2026 10:53:17 +0200
MIME-Version: 1.0
Message-Id: <20260622-metadata_groups-v3-1-45651d685c3c@suse.com>
References: <20260622-metadata_groups-v3-0-45651d685c3c@suse.com>
In-Reply-To: <20260622-metadata_groups-v3-0-45651d685c3c@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782118399; l=17287;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=mk+hKxBtB2qlVkpB4yC/2x1QyLk2gYkKV2D2nJ4NkZA=;
 b=PT1KK0pPbOiSYgntJqtYA17XvAk63FXpxOGM6pHi7sPAYlbwPi6FwNoGolO77tAoUHm04oXkB
 H6v4YRZMbBhA2VSBkuL5Ptxlt3QfiPF862MLAPbEEOPvXstimEgDb2L
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0FCBE7067E
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] metadata: add tests grouping support
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
 metadata/metaparse.c                  | 163 +++++++++++++++++++++++++++-------
 metadata/tests/array_size01.c.json    |   2 +
 metadata/tests/array_size02.c.json    |   2 +
 metadata/tests/array_size03.c.json    |   2 +
 metadata/tests/array_size04.c.json    |   2 +
 metadata/tests/empty_struct.c.json    |   2 +
 metadata/tests/expand_flags.c.json    |   2 +
 metadata/tests/groups.c               |  11 +++
 metadata/tests/groups.c.json          |  12 +++
 metadata/tests/include.c.json         |   2 +
 metadata/tests/macro.c.json           |   2 +
 metadata/tests/macro_str.c.json       |   2 +
 metadata/tests/multiline_macro.c.json |   2 +
 metadata/tests/tags.c.json            |   2 +
 14 files changed, 177 insertions(+), 31 deletions(-)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 561cbb9d2d54689988c9aa49d591628696bcf847..f83acc5f057719ca1a48e24db7dec22b9f04e789 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -17,6 +17,7 @@
 #include "data_storage.h"
 
 #define INCLUDE_PATH_MAX 5
+#define GROUPS_TAG "@groups"
 
 static int verbose;
 static char *cmdline_includepath[INCLUDE_PATH_MAX];
@@ -34,7 +35,7 @@ static void remove_to_newline(FILE *f)
 	} while (c != '\n');
 }
 
-static const char *eat_asterisk_space(const char *c)
+static char *eat_asterisk_space(char *c)
 {
 	unsigned int i = 0;
 
@@ -50,7 +51,51 @@ static const char *eat_asterisk_space(const char *c)
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
+	s = eat_asterisk_space(line);
+	if (strncmp(s, GROUPS_TAG, sizeof(GROUPS_TAG) - 1))
+		return 0;
+
+	s += sizeof(GROUPS_TAG) - 1;
+	if (*s && *s != ' ' && *s != '\t') {
+		WARN("Empty @group");
+		return 1;
+	}
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
@@ -62,12 +107,14 @@ static void multiline_comment(FILE *f, struct data_node *doc)
 
 		if (doc) {
 			if (c == '\n') {
-				struct data_node *line;
+				char *str;
 				buf[bufp] = 0;
-				line = data_node_string(eat_asterisk_space(buf));
-				if (data_node_array_add(doc, line))
-					WARN("doc string comment truncated");
+				str = eat_asterisk_space(buf);
 				bufp = 0;
+				if (parse_groups(groups, str))
+					continue;
+				if (data_node_array_add(doc, data_node_string(str)))
+					WARN("doc string comment truncated");
 				continue;
 			}
 
@@ -100,7 +147,8 @@ static void multiline_comment(FILE *f, struct data_node *doc)
 
 static const char doc_prefix[] = "\\\n";
 
-static void maybe_doc_comment(FILE *f, struct data_node *doc)
+static void maybe_doc_comment(FILE *f, struct data_node *doc,
+			      struct data_node *groups)
 {
 	int c, i;
 
@@ -113,14 +161,15 @@ static void maybe_doc_comment(FILE *f, struct data_node *doc)
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
 
@@ -129,7 +178,7 @@ static void maybe_comment(FILE *f, struct data_node *doc)
 		remove_to_newline(f);
 	break;
 	case '*':
-		maybe_doc_comment(f, doc);
+		maybe_doc_comment(f, doc, groups);
 	break;
 	default:
 		ungetc(c, f);
@@ -137,7 +186,8 @@ static void maybe_comment(FILE *f, struct data_node *doc)
 	}
 }
 
-static char *next_token2(FILE *f, char *buf, size_t buf_len, struct data_node *doc)
+static char *next_token2(FILE *f, char *buf, size_t buf_len,
+			 struct data_node *doc, struct data_node *groups)
 {
 	size_t i = 0;
 	int c;
@@ -194,7 +244,7 @@ static char *next_token2(FILE *f, char *buf, size_t buf_len, struct data_node *d
 			buf[i++] = c;
 		break;
 		case '/':
-			maybe_comment(f, doc);
+			maybe_comment(f, doc, groups);
 		break;
 		case '"':
 			in_str = 1;
@@ -216,11 +266,11 @@ exit:
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
@@ -383,7 +433,7 @@ static int array_is_hash(FILE *f)
 	int in_id = 1;
 	char *token;
 
-	while ((token = next_token(f, NULL))) {
+	while ((token = next_token(f, NULL, NULL))) {
 
 		if (!strcmp(token, "}")) {
 			if (in_id && !comma_last)
@@ -402,7 +452,7 @@ static int array_is_hash(FILE *f)
 			int level = 1;
 
 			for (;;) {
-				token = next_token(f, NULL);
+				token = next_token(f, NULL, NULL);
 
 				if (!token)
 					goto ret;
@@ -453,7 +503,7 @@ static int parse_array(FILE *f, const char *arr_id, struct data_node **ret)
 		*ret = data_node_array();
 
 	for (;;) {
-		if (!(token = next_token(f, NULL)))
+		if (!(token = next_token(f, NULL, NULL)))
 			return 1;
 
 		if (!strcmp(token, "{")) {
@@ -529,14 +579,14 @@ static int parse_get_array_len(FILE *f)
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
@@ -565,7 +615,7 @@ static void look_for_array_size(FILE *f, const char *arr_id, struct data_node **
 	int prev_buf = 1;
 
 	for (;;) {
-		if (!(token = next_token2(f, buf[cur_buf], sizeof(buf[cur_buf]), NULL)))
+		if (!(token = next_token2(f, buf[cur_buf], sizeof(buf[cur_buf]), NULL, NULL)))
 			break;
 
 		if (!strcmp(token, "=") && !strcmp(buf[prev_buf], arr_id)) {
@@ -595,13 +645,13 @@ static int parse_array_size(FILE *f, struct data_node **res)
 
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
@@ -621,7 +671,7 @@ static int parse_array_size(FILE *f, struct data_node **res)
 		rewind(f);
 
 		for (;;) {
-			if (!(token = next_token(f, NULL)))
+			if (!(token = next_token(f, NULL, NULL)))
 				break;
 
 			if (token[0] == '#') {
@@ -654,7 +704,8 @@ static int parse_array_size(FILE *f, struct data_node **res)
 	return 0;
 }
 
-static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *node)
+static int parse_test_struct(FILE *f, struct data_node *doc,
+			     struct data_node *groups, struct data_node *node)
 {
 	char *token;
 	char *id = NULL;
@@ -662,7 +713,7 @@ static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *n
 	struct data_node *ret;
 
 	for (;;) {
-		if (!(token = next_token(f, doc)))
+		if (!(token = next_token(f, doc, groups)))
 			return 1;
 
 		if (!strcmp(token, "}"))
@@ -842,7 +893,7 @@ static void parse_include_macros(FILE *f, int level)
 	if (!inc)
 		return;
 
-	while ((token = next_token(inc, NULL))) {
+	while ((token = next_token(inc, NULL, NULL))) {
 		if (token[0] == '#') {
 			hash = 1;
 			continue;
@@ -907,6 +958,49 @@ static void load_internal_macros(void)
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
+	if (!buf) {
+		fprintf(stderr, "Allocation failed!\n");
+		exit(1);
+	}
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
@@ -923,15 +1017,18 @@ static struct data_node *parse_file(const char *fname)
 
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
@@ -948,7 +1045,7 @@ static struct data_node *parse_file(const char *fname)
 			continue;
 
 		found = 1;
-		parse_test_struct(f, doc, res);
+		parse_test_struct(f, doc, groups, res);
 	}
 
 	if (data_node_array_len(doc)) {
@@ -958,6 +1055,9 @@ static struct data_node *parse_file(const char *fname)
 		data_node_free(doc);
 	}
 
+	/* inside the testcases/ folder we will always have at least one group */
+	data_node_hash_add(res, "groups", groups);
+
 	fclose(f);
 
 	if (!found) {
@@ -985,7 +1085,7 @@ static void parse_must_files(void)
 			if (!f)
 				continue;
 
-			while ((token = next_token(f, NULL))) {
+			while ((token = next_token(f, NULL, NULL))) {
 				if (!strcmp(token, "define"))
 					parse_macro(f);
 			}
@@ -1238,6 +1338,7 @@ int main(int argc, char *argv[])
 	}
 
 	data_node_hash_add(res, "fname", data_node_string(argv[optind]));
+
 	printf("  \"%s\": ", strip_name(argv[optind]));
 	data_to_json(res, stdout, 2);
 	data_node_free(res);
diff --git a/metadata/tests/array_size01.c.json b/metadata/tests/array_size01.c.json
index ec364be1207673c7c2efe8a3b6284dc70d0d5e68..98ad9f6b0ba483b19a7b7253606e0ccf92060f29 100644
--- a/metadata/tests/array_size01.c.json
+++ b/metadata/tests/array_size01.c.json
@@ -1,4 +1,6 @@
   "array_size01": {
    "test_variants": 1,
+   "groups": [
+   ],
    "fname": "array_size01.c"
   }
\ No newline at end of file
diff --git a/metadata/tests/array_size02.c.json b/metadata/tests/array_size02.c.json
index 1226869525dfc5cc298f2916150e491f9a1f0db6..10e08c6af8a2d57e463431c3b350bb0d66739554 100644
--- a/metadata/tests/array_size02.c.json
+++ b/metadata/tests/array_size02.c.json
@@ -1,4 +1,6 @@
   "array_size02": {
    "test_variants": 3,
+   "groups": [
+   ],
    "fname": "array_size02.c"
   }
\ No newline at end of file
diff --git a/metadata/tests/array_size03.c.json b/metadata/tests/array_size03.c.json
index bb690c9f5abc332c2c55d2af7aaeec9e315bcaa8..44727933187cf465aaf91e43cc47d67cbcdae5a0 100644
--- a/metadata/tests/array_size03.c.json
+++ b/metadata/tests/array_size03.c.json
@@ -1,4 +1,6 @@
   "array_size03": {
    "test_variants": 2,
+   "groups": [
+   ],
    "fname": "array_size03.c"
   }
\ No newline at end of file
diff --git a/metadata/tests/array_size04.c.json b/metadata/tests/array_size04.c.json
index 6b8d41792035bbb04e8e69b2ae0f0e2d89af3073..13a987e1c0852d8520f0e37f38b467a8652469de 100644
--- a/metadata/tests/array_size04.c.json
+++ b/metadata/tests/array_size04.c.json
@@ -1,4 +1,6 @@
   "array_size04": {
    "test_variants": 3,
+   "groups": [
+   ],
    "fname": "array_size04.c"
   }
\ No newline at end of file
diff --git a/metadata/tests/empty_struct.c.json b/metadata/tests/empty_struct.c.json
index 9f49f53320040441c46f7ba314ec20912e0d94d7..3fbd9a38a664acf9ec893bf29ab6d0ab1a387ef8 100644
--- a/metadata/tests/empty_struct.c.json
+++ b/metadata/tests/empty_struct.c.json
@@ -1,3 +1,5 @@
   "empty_struct": {
+   "groups": [
+   ],
    "fname": "empty_struct.c"
   }
\ No newline at end of file
diff --git a/metadata/tests/expand_flags.c.json b/metadata/tests/expand_flags.c.json
index 079972e4a7cf65a3717c179f7ddeb30c49964820..3941ae7f6ccb1d3c98176f75d1f10e6a99c2d18d 100644
--- a/metadata/tests/expand_flags.c.json
+++ b/metadata/tests/expand_flags.c.json
@@ -1,4 +1,6 @@
   "expand_flags": {
+   "groups": [
+   ],
    "all_filesystems": true,
    "needs_device": true,
    "needs_tmpdir": true,
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
diff --git a/metadata/tests/include.c.json b/metadata/tests/include.c.json
index b7c636e82e1ec2d90e680cc8b79891f147848cea..df0e5814bdac5c12a0c62b3a02b14718179449a1 100644
--- a/metadata/tests/include.c.json
+++ b/metadata/tests/include.c.json
@@ -1,4 +1,6 @@
   "include": {
+   "groups": [
+   ],
    "test_variants": 10,
    "fname": "include.c"
   }
\ No newline at end of file
diff --git a/metadata/tests/macro.c.json b/metadata/tests/macro.c.json
index c3f53ae432de6a4db851b02fcb0d384530d0c8a6..85907d3aba42330c0b7b5da5d7a86470097ae5d9 100644
--- a/metadata/tests/macro.c.json
+++ b/metadata/tests/macro.c.json
@@ -1,4 +1,6 @@
   "macro": {
+   "groups": [
+   ],
    "test_variants": 10,
    "fname": "macro.c"
   }
\ No newline at end of file
diff --git a/metadata/tests/macro_str.c.json b/metadata/tests/macro_str.c.json
index b162283166dfa13c9023c018206c0e7617d8c702..23a5dbd0775e303cfdc6e996daa13f53d4982aa6 100644
--- a/metadata/tests/macro_str.c.json
+++ b/metadata/tests/macro_str.c.json
@@ -1,4 +1,6 @@
   "macro_str": {
    "syscall": "syscall(\"foo\")",
+   "groups": [
+   ],
    "fname": "macro_str.c"
   }
\ No newline at end of file
diff --git a/metadata/tests/multiline_macro.c.json b/metadata/tests/multiline_macro.c.json
index 63451624256d9845cd4f1552f03b23b033c9a55b..4ae49bc0df1f89c24e3fc70cac3aa2c798b2cc88 100644
--- a/metadata/tests/multiline_macro.c.json
+++ b/metadata/tests/multiline_macro.c.json
@@ -1,4 +1,6 @@
   "multiline_macro": {
+   "groups": [
+   ],
    "test_variants": 10,
    "fname": "multiline_macro.c"
   }
\ No newline at end of file
diff --git a/metadata/tests/tags.c.json b/metadata/tests/tags.c.json
index d45c9f447f1337c9bed86edb7fd71a134db5d25e..4d176f5448640f87c9ea189a300e167b0030e97b 100644
--- a/metadata/tests/tags.c.json
+++ b/metadata/tests/tags.c.json
@@ -9,5 +9,7 @@
      "tag-value-2"
     ]
    ],
+   "groups": [
+   ],
    "fname": "tags.c"
   }
\ No newline at end of file

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
