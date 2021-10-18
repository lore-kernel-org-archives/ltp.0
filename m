Return-Path: <SRS0=Jxr4=PG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFE1C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:47:31 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 302BE60F36
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 15:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 302BE60F36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E377E3C2F54
	for <ltp@archiver.kernel.org>; Mon, 18 Oct 2021 17:47:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 875823C02DA
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 17:47:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8981360028E
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 17:47:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 449D721966
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634572035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUUzjh81EV5pv+plOl6I1/iyJQU4ILS3QEqLwxY1e4M=;
 b=FnHQ5tqPHrHaIhG7P5v6JOqItAmNPnh0cnxTik/vxCjYNFE2Ag6psEZi5I3utm3/N7YZoz
 U1f0ZVbGCK5F9Kh2po3hXD/JobpCOODl0G4EbtI6TUmIG3oHy+Ud3Hx6yjgPWjQxS1+r9J
 xKT2vz0zWGpHo9eMTe4/gtr6mtbgtnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634572035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zUUzjh81EV5pv+plOl6I1/iyJQU4ILS3QEqLwxY1e4M=;
 b=kwakVFzd7rPfbWYNdzOb7/xW+bc71lU+P4CyZXPEcVG48rVim4iBf+mjq77XDZni+3bGs4
 C03uUU15UFfHGAAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A1EA140B7
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5irxCAOXbWFwJwAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 18 Oct 2021 15:47:15 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 18 Oct 2021 17:47:53 +0200
Message-Id: <20211018154800.11013-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211018154800.11013-1-chrubis@suse.cz>
References: <20211018154800.11013-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/7] docparse: Implement #define and #include
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

We ignore most of the include statements and we attempt to parse only
header files that reside in the same directory as the test source code,
that is since we are not interested in any system or library headers as
we are only looking for constants used in the tst_test structure that
are always either directly in the test source or in header in the same
directory.

The macro support is very simple as well, it's a single pass as we are
not interested in intricate macros. We just need values for constants
that are used in the tst_test structure intializations.

+ Also add -v verbose mode that prints included files and defined macros

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 docparse/docparse.c | 219 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 209 insertions(+), 10 deletions(-)

diff --git a/docparse/docparse.c b/docparse/docparse.c
index 8cd0d0eef..cab01c384 100644
--- a/docparse/docparse.c
+++ b/docparse/docparse.c
@@ -1,9 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) 2019-2021 Cyril Hrubis <chrubis@suse.cz>
  * Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
  */
 
+#define _GNU_SOURCE
+
+#include <search.h>
 #include <stdio.h>
 #include <string.h>
 #include <libgen.h>
@@ -12,6 +15,8 @@
 
 #include "data_storage.h"
 
+static int verbose;
+
 #define WARN(str) fprintf(stderr, "WARNING: " str "\n")
 
 static void oneline_comment(FILE *f)
@@ -126,7 +131,7 @@ static void maybe_comment(FILE *f, struct data_node *doc)
 	}
 }
 
-const char *next_token(FILE *f, struct data_node *doc)
+static char *next_token(FILE *f, struct data_node *doc)
 {
 	size_t i = 0;
 	static char buf[4096];
@@ -172,6 +177,7 @@ const char *next_token(FILE *f, struct data_node *doc)
 		case '.':
 		case '_':
 		case '-':
+		case '#':
 			buf[i++] = c;
 		break;
 		case '/':
@@ -197,6 +203,46 @@ exit:
 	return buf;
 }
 
+static FILE *open_include(const char *includepath, FILE *f)
+{
+	char buf[256];
+	char *path;
+	FILE *inc;
+
+	if (!fscanf(f, "%s\n", buf))
+		return NULL;
+
+	if (buf[0] != '"')
+		return NULL;
+
+	char *filename = buf + 1;
+
+	if (!buf[0])
+		return NULL;
+
+	filename[strlen(filename)-1] = 0;
+
+	if (asprintf(&path, "%s/%s", includepath, filename) < 0)
+		return NULL;
+
+	inc = fopen(path, "r");
+
+	if (inc && verbose)
+		fprintf(stderr, "INCLUDE %s\n", path);
+
+	free(path);
+
+	return inc;
+}
+
+static void close_include(FILE *inc)
+{
+	if (verbose)
+		fprintf(stderr, "INCLUDE END\n");
+
+	fclose(inc);
+}
+
 static int parse_array(FILE *f, struct data_node *node)
 {
 	const char *token;
@@ -234,9 +280,28 @@ static int parse_array(FILE *f, struct data_node *node)
 	return 0;
 }
 
+static void try_apply_macro(char **res)
+{
+	ENTRY macro = {
+		.key = *res,
+	};
+
+	ENTRY *ret;
+
+	ret = hsearch(macro, FIND);
+
+	if (!ret)
+		return;
+
+	if (verbose)
+		fprintf(stderr, "APPLYING MACRO %s=%s\n", ret->key, (char*)ret->data);
+
+	*res = ret->data;
+}
+
 static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *node)
 {
-	const char *token;
+	char *token;
 	char *id = NULL;
 	int state = 0;
 	struct data_node *ret;
@@ -280,6 +345,7 @@ static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *n
 			ret = data_node_array();
 			parse_array(f, ret);
 		} else {
+			try_apply_macro(&token);
 			ret = data_node_string(token);
 		}
 
@@ -302,6 +368,103 @@ static const char *tokens[] = {
 	"{",
 };
 
+static void macro_get_string(FILE *f, char *buf, char *buf_end)
+{
+	int c;
+
+	for (;;) {
+		c = fgetc(f);
+
+		switch (c) {
+		case '"':
+		case EOF:
+			*buf = 0;
+			return;
+		default:
+			if (buf < buf_end)
+				*(buf++) = c;
+		}
+	}
+}
+
+static void macro_get_val(FILE *f, char *buf, size_t buf_len)
+{
+	int c, prev = 0;
+	char *buf_end = buf + buf_len - 1;
+
+	c = fgetc(f);
+	if (c == '"') {
+		macro_get_string(f, buf, buf_end);
+		return;
+	}
+
+	for (;;) {
+		switch (c) {
+		case '\n':
+			if (prev == '\\') {
+				buf--;
+			} else {
+				*buf = 0;
+				return;
+			}
+		break;
+		case EOF:
+			*buf = 0;
+			return;
+		case ' ':
+		case '\t':
+		break;
+		default:
+			if (buf < buf_end)
+				*(buf++) = c;
+		}
+
+		prev = c;
+		c = fgetc(f);
+	}
+}
+
+static void parse_macro(FILE *f)
+{
+	char name[128];
+	char val[256];
+
+	if (!fscanf(f, "%s[^\n]", name))
+		return;
+
+	if (fgetc(f) == '\n')
+		return;
+
+	macro_get_val(f, val, sizeof(val));
+
+	ENTRY e = {
+		.key = strdup(name),
+		.data = strdup(val),
+	};
+
+	if (verbose)
+		fprintf(stderr, " MACRO %s=%s\n", e.key, (char*)e.data);
+
+	hsearch(e, ENTER);
+}
+
+static void parse_include_macros(const char *includepath, FILE *f)
+{
+	FILE *inc;
+	const char *token;
+
+	inc = open_include(includepath, f);
+	if (!inc)
+		return;
+
+	while ((token = next_token(inc, NULL))) {
+		if (!strcmp(token, "#define"))
+			parse_macro(inc);
+	}
+
+	close_include(inc);
+}
+
 static struct data_node *parse_file(const char *fname)
 {
 	int state = 0, found = 0;
@@ -314,14 +477,25 @@ static struct data_node *parse_file(const char *fname)
 
 	FILE *f = fopen(fname, "r");
 
+	const char *includepath = dirname(strdup(fname));
+
 	struct data_node *res = data_node_hash();
 	struct data_node *doc = data_node_array();
 
 	while ((token = next_token(f, doc))) {
-		if (state < 6 && !strcmp(tokens[state], token))
+		if (state < 6 && !strcmp(tokens[state], token)) {
 			state++;
-		else
+		} else {
+			if (token[0] == '#') {
+				if (!strcmp(token, "#define"))
+					parse_macro(f);
+
+				if (!strcmp(token, "#include"))
+					parse_include_macros(includepath, f);
+			}
+
 			state = 0;
+		}
 
 		if (state < 6)
 			continue;
@@ -386,17 +560,42 @@ const char *strip_name(char *path)
 	return name;
 }
 
+static void print_help(const char *prgname)
+{
+	printf("usage: %s [-vh] input.c\n\n", prgname);
+	printf("-v sets verbose mode\n");
+	printf("-h prints this help\n\n");
+	exit(0);
+}
+
 int main(int argc, char *argv[])
 {
 	unsigned int i, j;
 	struct data_node *res;
+	int opt;
+
+	while ((opt = getopt(argc, argv, "hv")) != -1) {
+		switch (opt) {
+		case 'h':
+			print_help(argv[0]);
+		break;
+		case 'v':
+			verbose = 1;
+		break;
+		}
+	}
+
+	if (optind >= argc) {
+		fprintf(stderr, "No input filename.c\n");
+		return 1;
+	}
 
-	if (argc != 2) {
-		fprintf(stderr, "Usage: docparse filename.c\n");
+	if (!hcreate(128)) {
+		fprintf(stderr, "Failed to initialize hash table\n");
 		return 1;
 	}
 
-	res = parse_file(argv[1]);
+	res = parse_file(argv[optind]);
 	if (!res)
 		return 0;
 
@@ -425,8 +624,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	data_node_hash_add(res, "fname", data_node_string(argv[1]));
-	printf("  \"%s\": ", strip_name(argv[1]));
+	data_node_hash_add(res, "fname", data_node_string(argv[optind]));
+	printf("  \"%s\": ", strip_name(argv[optind]));
 	data_to_json(res, stdout, 2);
 	data_node_free(res);
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
