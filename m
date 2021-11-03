Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5765C433EF
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 12:03:09 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE1E60E52
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 12:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FE1E60E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93CF03C71E9
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 13:03:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 927563C72BA
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 13:02:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3185D1A00E30
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 13:01:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D29B11FD2F;
 Wed,  3 Nov 2021 12:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635940899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djEAYtOgeJZ62TEqNIYj05qw0KJyLDZ9uyy+1N/DRVQ=;
 b=LC43+jFXDMRsANrF8WKeLGsdi1jC15Earom8wtkAepyObd5mwm3c8XF1SBmugdk9mMME1B
 MvTNbSKZcoKPcew1g8/T42AhX4lU/TMVGE6ghihmAt4xqz8yvHfiV1EDU166IHSBUiD2qY
 8i62WzDV/jv75WSBp46QIZUxGV2DGm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635940899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djEAYtOgeJZ62TEqNIYj05qw0KJyLDZ9uyy+1N/DRVQ=;
 b=qTMR28OoBupGhQ+NufscY2Np+bRYP2sV82tWlOpgERXP94oyQFsyOoiMi/GK0WhprjEUZ6
 GDXqgXydjSbh7RCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8CD113CE7;
 Wed,  3 Nov 2021 12:01:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wyr1KyN6gmFbRwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 03 Nov 2021 12:01:39 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  3 Nov 2021 13:02:30 +0100
Message-Id: <20211103120233.20728-5-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211103120233.20728-1-chrubis@suse.cz>
References: <20211103120233.20728-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 4/7] docparse: Implement ARRAY_SIZE()
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Adds a special handlingn for ARRAY_SIZE() macro.

If we stumble upon ARRAY_SIZE() in the tst_test structure we try to
lookup the array and count its members.

Proper parsing of .test_variants also requires that we add -I switch to
the docparse to be able to specify include paths on a command line since
some variants are stuck in top level include while others are in
testcases/kernel/syscalls/utils/.

+ tests

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 docparse/docparse.c                | 221 ++++++++++++++++++++++++++---
 docparse/parse.sh                  |   2 +-
 docparse/tests/array_size01.c      |   5 +
 docparse/tests/array_size01.c.json |   4 +
 docparse/tests/array_size02.c      |   9 ++
 docparse/tests/array_size02.c.json |   4 +
 docparse/tests/array_size03.c      |  10 ++
 docparse/tests/array_size03.c.json |   4 +
 docparse/tests/array_size04.c      |   5 +
 docparse/tests/array_size04.c.json |   4 +
 docparse/tests/include.h           |   6 +
 11 files changed, 255 insertions(+), 19 deletions(-)
 create mode 100644 docparse/tests/array_size01.c
 create mode 100644 docparse/tests/array_size01.c.json
 create mode 100644 docparse/tests/array_size02.c
 create mode 100644 docparse/tests/array_size02.c.json
 create mode 100644 docparse/tests/array_size03.c
 create mode 100644 docparse/tests/array_size03.c.json
 create mode 100644 docparse/tests/array_size04.c
 create mode 100644 docparse/tests/array_size04.c.json

diff --git a/docparse/docparse.c b/docparse/docparse.c
index 4cb7f5f93..bef56d004 100644
--- a/docparse/docparse.c
+++ b/docparse/docparse.c
@@ -15,7 +15,11 @@
 
 #include "data_storage.h"
 
+#define INCLUDE_PATH_MAX 5
+
 static int verbose;
+static char *cmdline_includepath[INCLUDE_PATH_MAX];
+static unsigned int cmdline_includepaths;
 static char *includepath;
 
 #define WARN(str) fprintf(stderr, "WARNING: " str "\n")
@@ -132,13 +136,14 @@ static void maybe_comment(FILE *f, struct data_node *doc)
 	}
 }
 
-static char *next_token(FILE *f, struct data_node *doc)
+static char *next_token2(FILE *f, char *buf, size_t buf_len, struct data_node *doc)
 {
 	size_t i = 0;
-	static char buf[4096];
 	int c;
 	int in_str = 0;
 
+	buf_len--;
+
 	for (;;) {
 		c = fgetc(f);
 
@@ -151,7 +156,8 @@ static char *next_token(FILE *f, struct data_node *doc)
 					goto exit;
 			}
 
-			buf[i++] = c;
+			if (i < buf_len)
+				buf[i++] = c;
 			continue;
 		}
 
@@ -171,7 +177,8 @@ static char *next_token(FILE *f, struct data_node *doc)
 				goto exit;
 			}
 
-			buf[i++] = c;
+			if (i < buf_len)
+				buf[i++] = c;
 			goto exit;
 		case '0' ... '9':
 		case 'a' ... 'z':
@@ -204,11 +211,33 @@ exit:
 	return buf;
 }
 
-static FILE *open_include(const char *includepath, FILE *f)
+static char *next_token(FILE *f, struct data_node *doc)
+{
+	static char buf[4096];
+
+	return next_token2(f, buf, sizeof(buf), doc);
+}
+
+static FILE *open_file(const char *dir, const char *fname)
 {
-	char buf[256];
+	FILE *f;
 	char *path;
+
+	if (asprintf(&path, "%s/%s", dir, fname) < 0)
+		return NULL;
+
+	f = fopen(path, "r");
+
+	free(path);
+
+	return f;
+}
+
+static FILE *open_include(FILE *f)
+{
+	char buf[256], *fname;
 	FILE *inc;
+	unsigned int i;
 
 	if (!fscanf(f, "%s\n", buf))
 		return NULL;
@@ -216,24 +245,36 @@ static FILE *open_include(const char *includepath, FILE *f)
 	if (buf[0] != '"')
 		return NULL;
 
-	char *filename = buf + 1;
+	fname = buf + 1;
 
 	if (!buf[0])
 		return NULL;
 
-	filename[strlen(filename)-1] = 0;
+	fname[strlen(fname)-1] = 0;
 
-	if (asprintf(&path, "%s/%s", includepath, filename) < 0)
-		return NULL;
+	inc = open_file(includepath, fname);
+	if (inc) {
+		if (verbose)
+			fprintf(stderr, "INCLUDE %s/%s\n", includepath, fname);
 
-	inc = fopen(path, "r");
+		return inc;
+	}
 
-	if (inc && verbose)
-		fprintf(stderr, "INCLUDE %s\n", path);
+	for (i = 0; i < cmdline_includepaths; i++) {
+		inc = open_file(cmdline_includepath[i], fname);
 
-	free(path);
+		if (!inc)
+			continue;
 
-	return inc;
+		if (verbose) {
+			fprintf(stderr, "INCLUDE %s/%s\n",
+				cmdline_includepath[i], fname);
+		}
+
+		return inc;
+	}
+
+	return NULL;
 }
 
 static void close_include(FILE *inc)
@@ -300,6 +341,136 @@ static void try_apply_macro(char **res)
 	*res = ret->data;
 }
 
+static int parse_get_array_len(FILE *f)
+{
+	const char *token;
+	int cnt = 0, depth = 0, prev_comma = 0;
+
+	if (!(token = next_token(f, NULL)))
+		return 0;
+
+	if (strcmp(token, "{"))
+		return 0;
+
+	for (;;) {
+		if (!(token = next_token(f, NULL)))
+			return 0;
+
+		if (!strcmp(token, "{"))
+			depth++;
+
+		if (!strcmp(token, "}"))
+			depth--;
+		else
+			prev_comma = 0;
+
+		if (!strcmp(token, ",") && !depth) {
+			prev_comma = 1;
+			cnt++;
+		}
+
+		if (depth < 0)
+			return cnt + !prev_comma;
+	}
+}
+
+static void look_for_array_size(FILE *f, const char *arr_id, struct data_node **res)
+{
+	const char *token;
+	char buf[2][2048] = {};
+	int cur_buf = 0;
+	int prev_buf = 1;
+
+	for (;;) {
+		if (!(token = next_token2(f, buf[cur_buf], 2048, NULL)))
+			break;
+
+		if (!strcmp(token, "=") && !strcmp(buf[prev_buf], arr_id)) {
+			int arr_len = parse_get_array_len(f);
+
+			if (verbose)
+				fprintf(stderr, "ARRAY %s LENGTH = %i\n", arr_id, arr_len);
+
+			*res = data_node_int(arr_len);
+
+			break;
+		}
+
+		if (strcmp(buf[cur_buf], "]") && strcmp(buf[cur_buf], "[")) {
+			cur_buf = !cur_buf;
+			prev_buf = !prev_buf;
+		}
+	}
+}
+
+static int parse_array_size(FILE *f, struct data_node **res)
+{
+	const char *token;
+	char *arr_id;
+	long pos;
+	int hash = 0;
+
+	*res = NULL;
+
+	if (!(token = next_token(f, NULL)))
+		return 1;
+
+	if (strcmp(token, "("))
+		return 1;
+
+	if (!(token = next_token(f, NULL)))
+		return 1;
+
+	arr_id = strdup(token);
+
+	if (verbose)
+		fprintf(stderr, "COMPUTING ARRAY '%s' LENGHT\n", arr_id);
+
+	pos = ftell(f);
+
+	rewind(f);
+
+	look_for_array_size(f, arr_id, res);
+
+	if (!*res) {
+		FILE *inc;
+
+		rewind(f);
+
+		for (;;) {
+			if (!(token = next_token(f, NULL)))
+				break;
+
+			if (token[0] == '#') {
+				hash = 1;
+				continue;
+			}
+
+			if (!hash)
+				continue;
+
+			if (!strcmp(token, "include")) {
+				inc = open_include(f);
+
+				if (inc) {
+					look_for_array_size(inc, arr_id, res);
+					close_include(inc);
+				}
+			}
+
+			if (*res)
+				break;
+		}
+	}
+
+	free(arr_id);
+
+	if (fseek(f, pos, SEEK_SET))
+		return 1;
+
+	return 0;
+}
+
 static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *node)
 {
 	char *token;
@@ -345,11 +516,17 @@ static int parse_test_struct(FILE *f, struct data_node *doc, struct data_node *n
 		if (!strcmp(token, "{")) {
 			ret = data_node_array();
 			parse_array(f, ret);
+		} else if (!strcmp(token, "ARRAY_SIZE")) {
+			if (parse_array_size(f, &ret))
+				return 1;
 		} else {
 			try_apply_macro(&token);
 			ret = data_node_string(token);
 		}
 
+		if (!ret)
+			continue;
+
 		const char *key = id;
 		if (key[0] == '.')
 			key++;
@@ -463,7 +640,7 @@ static void parse_include_macros(FILE *f)
 	const char *token;
 	int hash = 0;
 
-	inc = open_include(includepath, f);
+	inc = open_include(f);
 	if (!inc)
 		return;
 
@@ -527,7 +704,6 @@ static struct data_node *parse_file(const char *fname)
 		parse_test_struct(f, doc, res);
 	}
 
-
 	if (data_node_array_len(doc)) {
 		data_node_hash_add(res, "doc", doc);
 		found = 1;
@@ -587,6 +763,7 @@ static void print_help(const char *prgname)
 {
 	printf("usage: %s [-vh] input.c\n\n", prgname);
 	printf("-v sets verbose mode\n");
+	printf("-I add include path\n");
 	printf("-h prints this help\n\n");
 	exit(0);
 }
@@ -597,11 +774,19 @@ int main(int argc, char *argv[])
 	struct data_node *res;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "hv")) != -1) {
+	while ((opt = getopt(argc, argv, "hI:v")) != -1) {
 		switch (opt) {
 		case 'h':
 			print_help(argv[0]);
 		break;
+		case 'I':
+			if (cmdline_includepaths >= INCLUDE_PATH_MAX) {
+				fprintf(stderr, "Too much include paths!");
+				exit(1);
+			}
+
+			cmdline_includepath[cmdline_includepaths++] = optarg;
+		break;
 		case 'v':
 			verbose = 1;
 		break;
diff --git a/docparse/parse.sh b/docparse/parse.sh
index 79011bc10..2ace34fa0 100755
--- a/docparse/parse.sh
+++ b/docparse/parse.sh
@@ -26,7 +26,7 @@ echo ' "tests": {'
 first=1
 
 for test in `find testcases/ -name '*.c'`; do
-	a=$($top_builddir/docparse/docparse "$test")
+	a=$($top_builddir/docparse/docparse -Iinclude -Itestcases/kernel/syscalls/utils/ "$test")
 	if [ -n "$a" ]; then
 		if [ -z "$first" ]; then
 			echo ','
diff --git a/docparse/tests/array_size01.c b/docparse/tests/array_size01.c
new file mode 100644
index 000000000..5f182bc7c
--- /dev/null
+++ b/docparse/tests/array_size01.c
@@ -0,0 +1,5 @@
+static int variants[] = {1};
+
+static struct tst_test test = {
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/docparse/tests/array_size01.c.json b/docparse/tests/array_size01.c.json
new file mode 100644
index 000000000..ec364be12
--- /dev/null
+++ b/docparse/tests/array_size01.c.json
@@ -0,0 +1,4 @@
+  "array_size01": {
+   "test_variants": 1,
+   "fname": "array_size01.c"
+  }
\ No newline at end of file
diff --git a/docparse/tests/array_size02.c b/docparse/tests/array_size02.c
new file mode 100644
index 000000000..ffa37a5c6
--- /dev/null
+++ b/docparse/tests/array_size02.c
@@ -0,0 +1,9 @@
+struct foo {
+	int val;
+};
+
+static struct foo variants[] = {{1}, {2}, {3}};
+
+static struct tst_test test = {
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/docparse/tests/array_size02.c.json b/docparse/tests/array_size02.c.json
new file mode 100644
index 000000000..122686952
--- /dev/null
+++ b/docparse/tests/array_size02.c.json
@@ -0,0 +1,4 @@
+  "array_size02": {
+   "test_variants": 3,
+   "fname": "array_size02.c"
+  }
\ No newline at end of file
diff --git a/docparse/tests/array_size03.c b/docparse/tests/array_size03.c
new file mode 100644
index 000000000..9058db813
--- /dev/null
+++ b/docparse/tests/array_size03.c
@@ -0,0 +1,10 @@
+static struct foo variants[] = {
+#ifdef FOO
+	{.bar = 11},
+#endif
+	{.bar = 10},
+};
+
+static struct tst_test test = {
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/docparse/tests/array_size03.c.json b/docparse/tests/array_size03.c.json
new file mode 100644
index 000000000..bb690c9f5
--- /dev/null
+++ b/docparse/tests/array_size03.c.json
@@ -0,0 +1,4 @@
+  "array_size03": {
+   "test_variants": 2,
+   "fname": "array_size03.c"
+  }
\ No newline at end of file
diff --git a/docparse/tests/array_size04.c b/docparse/tests/array_size04.c
new file mode 100644
index 000000000..5f1d9986e
--- /dev/null
+++ b/docparse/tests/array_size04.c
@@ -0,0 +1,5 @@
+#include "include.h"
+
+static struct tst_test test = {
+	.test_variants = ARRAY_SIZE(variants),
+};
diff --git a/docparse/tests/array_size04.c.json b/docparse/tests/array_size04.c.json
new file mode 100644
index 000000000..6b8d41792
--- /dev/null
+++ b/docparse/tests/array_size04.c.json
@@ -0,0 +1,4 @@
+  "array_size04": {
+   "test_variants": 3,
+   "fname": "array_size04.c"
+  }
\ No newline at end of file
diff --git a/docparse/tests/include.h b/docparse/tests/include.h
index efa11d24f..fbc69a561 100644
--- a/docparse/tests/include.h
+++ b/docparse/tests/include.h
@@ -1 +1,7 @@
 #define TEST_VARIANTS 10
+
+static struct variants[] = {
+	{.bar = 10},
+	{.bar = 11},
+	{.bar = 12}
+};
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
