Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBCBCDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 09:23:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51CDB3C0302
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 11:23:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDD803E56BA
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 327696009F7
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 11:19:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1FA107147A
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HtLcuPYP+S2BbunWkX9cyWpvbbpYHrdX4QrUXmasSpg=;
 b=JF/kiILvIYm4xg07IOMXedh2zFjkAbQB+6pmAlctzFYB5v/67F7xz/zYJw6B4Jes1YaIDp
 yvBVFQ5x9S76yJ/DvbNkfKStbEMshOvf4RVYhBVgnvaPLsszkpRPWjXWYBCd/8U1VvNqsY
 f9SOWuBoUgatDyEV0zacMKfrzHl4Iac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HtLcuPYP+S2BbunWkX9cyWpvbbpYHrdX4QrUXmasSpg=;
 b=IFy1dLZIm+LtGqavxravAh5H5vq6U4OpYOT2LnUEhRNgkeqselSFyn2/RYEO1ssG++58bP
 w3tivzkoTYbZFpBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782292750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HtLcuPYP+S2BbunWkX9cyWpvbbpYHrdX4QrUXmasSpg=;
 b=ZAncUvx1rnoY2d7oM7ZNA5NWczUDo0WCshTbzFRTmMgBQzTKtVvvlbruPS3iBCfYl/F+95
 nnD9qNZxHGcNuANuNx5jX3+Zim1EW60YptH0c0N3y0Y7OI17cVSOZLIOQ8ZkDc6O90khPP
 K623xpv85Q5jDere6FgT1T4FX6kjYGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782292750;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HtLcuPYP+S2BbunWkX9cyWpvbbpYHrdX4QrUXmasSpg=;
 b=ERjNG6lwafcUWfDVmcXyPijf6zh8tteMaeg5BehaUzck3f+wynkydck/kO/nHNJEM2ljtl
 iE0TpOIQifnR7AAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06B8E779A8
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VQlzOw2hO2poAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 09:19:09 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Jun 2026 11:19:00 +0200
Message-ID: <20260624091900.4107041-14-chrubis@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624091900.4107041-1-chrubis@suse.cz>
References: <20260624091900.4107041-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[val.id:url,keyctl01.sh:url,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 13/13] metadata: Add runtest file generator
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

Now just for the runtest/cve file.

The changes in the file are:

- request_key03 is executed once and checks for both CVEs
  (we have many tests that check for more than one CVE and we execute
   rest of them once as well)

- if we have more than one test per CVE the suffixes are now numbered
  (it was random before)

- if test checks for more than one CVE the test tag is the oldest one
  (the crypto_user01 test jumps up in the runtest file, but again this
   makes it more consistent)

- kvm CVE tests are included, I do not see a reason to filter them out
  but we can add that filter if deemed necessary

- the file also includes landlock07 that should have been included but
  wasn't

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/.gitignore   |   1 +
 metadata/Makefile     |  10 +-
 metadata/genruntest.c | 292 ++++++++++++++++++++++++++++++++++++++++++
 runtest/.gitignore    |   1 +
 runtest/cve           | 100 ---------------
 5 files changed, 302 insertions(+), 102 deletions(-)
 create mode 100644 metadata/genruntest.c
 create mode 100644 runtest/.gitignore
 delete mode 100644 runtest/cve

diff --git a/metadata/.gitignore b/metadata/.gitignore
index bb6399e5c..ae33412a6 100644
--- a/metadata/.gitignore
+++ b/metadata/.gitignore
@@ -1,3 +1,4 @@
 metaparse
 metaparse-sh
+genruntest
 ltp.json
diff --git a/metadata/Makefile b/metadata/Makefile
index 6939b9f76..fcd63f385 100644
--- a/metadata/Makefile
+++ b/metadata/Makefile
@@ -6,15 +6,21 @@ top_srcdir		?= ..
 include $(top_srcdir)/include/mk/env_pre.mk
 include $(top_srcdir)/include/mk/functions.mk
 
-MAKE_TARGETS		:= ltp.json
-HOST_MAKE_TARGETS	:= metaparse metaparse-sh
+MAKE_TARGETS		:= ltp.json ../runtest/cve
+HOST_MAKE_TARGETS	:= metaparse metaparse-sh genruntest
 INSTALL_DIR		= metadata
 
+genruntest: genruntest.c $(addprefix $(top_srcdir)/libs/ujson/, ujson_reader.c ujson_common.c ujson_utf.c)
+genruntest: HOST_CFLAGS+=-I$(top_srcdir)/include/
+
 .PHONY: ltp.json
 
 ltp.json: metaparse metaparse-sh
 	$(abs_srcdir)/parse.sh > ltp.json
 
+../runtest/cve: ltp.json genruntest
+	${top_builddir}/metadata/genruntest ltp.json cve > ../runtest/cve
+
 test:
 	$(MAKE) -C $(abs_srcdir)/tests/ test
 
diff --git a/metadata/genruntest.c b/metadata/genruntest.c
new file mode 100644
index 000000000..193c7fa50
--- /dev/null
+++ b/metadata/genruntest.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ *
+ * Generate LTP runtest files from ltp.json metadata.
+ *
+ * Usage: genruntest ltp.json cve
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <ujson.h>
+
+struct cve_entry {
+	char name[128];
+	char binary[128];
+	int cve_year;
+	int cve_seq;
+	int may_kmemleak;
+};
+
+static struct cve_entry *entries;
+static unsigned int entry_cnt;
+static unsigned int entry_size;
+
+static void add_entry(const char *cve_id, const char *binary,
+                      int may_kmemleak)
+{
+	const char *id = cve_id;
+
+	if (entry_cnt >= entry_size) {
+		entry_size = entry_size ? entry_size * 2 : 128;
+		entries = realloc(entries, entry_size * sizeof(*entries));
+		if (!entries) {
+			fprintf(stderr, "Out of memory\n");
+			exit(1);
+		}
+	}
+
+	struct cve_entry *e = &entries[entry_cnt++];
+
+	snprintf(e->name, sizeof(e->name), "cve-%s", id);
+	snprintf(e->binary, sizeof(e->binary), "%s", binary);
+	e->may_kmemleak = may_kmemleak;
+
+	if (sscanf(id, "%d-%d", &e->cve_year, &e->cve_seq) != 2) {
+		fprintf(stderr, "ERROR: Invalid CVE id '%s' should be 'year-seq'\n", cve_id);
+		exit(1);
+	}
+}
+
+static int cmp_entries(const void *a, const void *b)
+{
+	const struct cve_entry *ea = a;
+	const struct cve_entry *eb = b;
+
+	if (ea->cve_year != eb->cve_year)
+		return ea->cve_year - eb->cve_year;
+
+	if (ea->cve_seq != eb->cve_seq)
+		return ea->cve_seq - eb->cve_seq;
+
+	return strcmp(ea->binary, eb->binary);
+}
+
+/*
+ * Count how many entries share the same CVE name.
+ */
+static int count_same(unsigned int idx)
+{
+	int cnt = 1;
+
+	while (idx + cnt < entry_cnt &&
+	       !strcmp(entries[idx].name, entries[idx + cnt].name))
+		cnt++;
+
+	return cnt;
+}
+
+static void print_entries(int kmemleak)
+{
+	unsigned int i;
+
+	for (i = 0; i < entry_cnt;) {
+		int cnt = count_same(i);
+		int j;
+
+		for (j = 0; j < cnt; j++) {
+			struct cve_entry *e = &entries[i + j];
+
+			if (e->may_kmemleak != kmemleak)
+				continue;
+
+			if (cnt > 1)
+				printf("%s-%02d %s\n", e->name, j + 1, e->binary);
+			else
+				printf("%s %s\n", e->name, e->binary);
+		}
+
+		i += cnt;
+	}
+}
+
+enum test_attr_ids {
+	ATTR_MAY_KMEMLEAK,
+	ATTR_TAGS,
+};
+
+static ujson_obj_attr test_attrs[] = {
+	UJSON_OBJ_ATTR_IDX(ATTR_MAY_KMEMLEAK, "may_kmemleak", UJSON_BOOL),
+	UJSON_OBJ_ATTR_IDX(ATTR_TAGS, "tags", UJSON_ARR),
+};
+
+static ujson_obj test_obj = {
+	.attrs = test_attrs,
+	.attr_cnt = UJSON_ARRAY_SIZE(test_attrs),
+};
+
+static int parse_cve_tags(ujson_reader *reader, const char *binary,
+                          int may_kmemleak, int do_add)
+{
+	char buf[256];
+	ujson_val val = UJSON_VAL_INIT(buf, sizeof(buf));
+	int cnt = 0;
+	char *oldest_id = NULL;
+	int oldest_year = 0, oldest_seq = 0;
+
+	UJSON_ARR_FOREACH(reader, &val) {
+		char *name = NULL;
+		char *value = NULL;
+
+		if (val.type != UJSON_ARR) {
+			ujson_arr_skip(reader);
+			continue;
+		}
+
+		UJSON_ARR_FOREACH(reader, &val) {
+			if (val.type != UJSON_STR)
+				continue;
+
+			if (!name)
+				name = strdup(val.val_str);
+			else if (!value)
+				value = strdup(val.val_str);
+		}
+
+		if (name && value && !strcmp(name, "CVE")) {
+			if (do_add) {
+				const char *id = value;
+				int year, seq;
+
+				if (!strncmp(id, "CVE-", 4))
+					id += 4;
+
+				if (sscanf(id, "%d-%d", &year, &seq) == 2) {
+					if (!oldest_id ||
+					    year < oldest_year ||
+					    (year == oldest_year && seq < oldest_seq)) {
+						free(oldest_id);
+						oldest_id = strdup(value);
+						oldest_year = year;
+						oldest_seq = seq;
+					}
+				}
+			}
+			cnt++;
+		}
+
+		free(name);
+		free(value);
+	}
+
+	if (do_add && oldest_id)
+		add_entry(oldest_id, binary, may_kmemleak);
+
+	free(oldest_id);
+
+	return cnt;
+}
+
+static void parse_test(ujson_reader *reader, const char *binary)
+{
+	char buf[256];
+	ujson_val val = UJSON_VAL_INIT(buf, sizeof(buf));
+	int may_kmemleak = 0;
+	int cve_cnt = 0;
+
+	ujson_reader_state obj_state = ujson_reader_state_save(reader);
+
+	UJSON_OBJ_FOREACH_FILTER(reader, &val, &test_obj, NULL) {
+		switch ((enum test_attr_ids)val.idx) {
+		case ATTR_MAY_KMEMLEAK:
+			may_kmemleak = val.val_bool;
+		break;
+		case ATTR_TAGS:
+			cve_cnt = parse_cve_tags(reader, NULL, 0, 0);
+		break;
+		}
+	}
+
+	if (!cve_cnt)
+		return;
+
+	ujson_reader_state_load(reader, obj_state);
+
+	UJSON_OBJ_FOREACH_FILTER(reader, &val, &test_obj, NULL) {
+		switch ((enum test_attr_ids)val.idx) {
+		case ATTR_MAY_KMEMLEAK:
+		break;
+		case ATTR_TAGS:
+			parse_cve_tags(reader, binary, may_kmemleak, 1);
+		break;
+		}
+	}
+}
+
+enum top_attr_ids {
+	TOP_TESTS,
+};
+
+static ujson_obj_attr top_attrs[] = {
+	UJSON_OBJ_ATTR_IDX(TOP_TESTS, "tests", UJSON_OBJ),
+};
+
+static ujson_obj top_obj = {
+	.attrs = top_attrs,
+	.attr_cnt = UJSON_ARRAY_SIZE(top_attrs),
+};
+
+static void gen_cve(ujson_reader *reader)
+{
+	char buf[256];
+	ujson_val val = UJSON_VAL_INIT(buf, sizeof(buf));
+
+	UJSON_OBJ_FOREACH_FILTER(reader, &val, &top_obj, NULL) {
+		if (val.idx != TOP_TESTS)
+			continue;
+
+		UJSON_OBJ_FOREACH(reader, &val) {
+			char binary[128];
+
+			snprintf(binary, sizeof(binary), "%s", val.id);
+
+			if (val.type == UJSON_OBJ)
+				parse_test(reader, binary);
+			else
+				ujson_obj_skip(reader);
+		}
+	}
+
+	if (ujson_reader_err(reader)) {
+		ujson_err_print(reader);
+		exit(1);
+	}
+
+	qsort(entries, entry_cnt, sizeof(*entries), cmp_entries);
+
+	printf("# Tests which check for vulnerabilities by CVE number\n");
+	print_entries(0);
+	printf("# Tests below may cause kernel memory leak\n");
+	print_entries(1);
+}
+
+int main(int argc, char *argv[])
+{
+	ujson_reader *reader;
+
+	if (argc != 3) {
+		fprintf(stderr, "Usage: %s ltp.json runtest_name\n", argv[0]);
+		return 1;
+	}
+
+	if (strcmp(argv[2], "cve")) {
+		fprintf(stderr, "Unknown runtest: %s\n", argv[2]);
+		return 1;
+	}
+
+	reader = ujson_reader_load(argv[1]);
+	if (!reader) {
+		fprintf(stderr, "Failed to load '%s'\n", argv[1]);
+		return 1;
+	}
+
+	gen_cve(reader);
+
+	ujson_reader_free(reader);
+	free(entries);
+
+	return 0;
+}
diff --git a/runtest/.gitignore b/runtest/.gitignore
new file mode 100644
index 000000000..290696707
--- /dev/null
+++ b/runtest/.gitignore
@@ -0,0 +1 @@
+cve
diff --git a/runtest/cve b/runtest/cve
deleted file mode 100644
index 5f29d1686..000000000
--- a/runtest/cve
+++ /dev/null
@@ -1,100 +0,0 @@
-# Tests which check for vulnerabilities by CVE number
-cve-2011-0999 thp01
-cve-2011-2183 ksm05
-cve-2011-2496 vma03
-cve-2012-0957 uname04
-cve-2014-0196 cve-2014-0196
-cve-2015-0235 gethostbyname_r01
-cve-2015-3290 cve-2015-3290
-cve-2015-7550 keyctl02
-cve-2016-4470 keyctl01.sh
-cve-2016-4997 setsockopt03
-cve-2016-5195 dirtyc0w
-cve-2016-7042 cve-2016-7042
-cve-2016-7117 cve-2016-7117
-cve-2016-8655 setsockopt06
-cve-2016-9604 keyctl08
-cve-2016-9793 setsockopt04
-cve-2016-10044 cve-2016-10044
-cve-2017-2618 cve-2017-2618
-cve-2017-2636 pty05
-cve-2017-2671 cve-2017-2671
-cve-2017-5754 meltdown
-cve-2017-6951 request_key05
-cve-2017-7308 setsockopt02
-cve-2017-7472 keyctl04
-cve-2017-7616 set_mempolicy05
-cve-2017-8890 accept02
-cve-2017-10661 timerfd_settime02
-cve-2017-12192 keyctl07
-cve-2017-12193 add_key04
-cve-2017-15274 add_key02
-cve-2017-15299 request_key03 -b cve-2017-15299
-cve-2017-15537 ptrace07
-cve-2017-15649 fanout01
-cve-2017-15951 request_key03 -b cve-2017-15951
-cve-2017-16939 cve-2017-16939
-cve-2017-16995 bpf_prog03
-cve-2017-17052 cve-2017-17052
-cve-2017-17053 cve-2017-17053
-cve-2017-17712 sendmsg03
-cve-2017-17805 af_alg02
-cve-2017-17806 af_alg01
-cve-2017-17807 request_key04
-cve-2017-18075 pcrypt_aead01
-cve-2017-18344 timer_create03
-cve-2017-1000111 setsockopt07
-cve-2017-1000112 setsockopt05
-cve-2017-1000364 stack_clash
-cve-2017-1000380 snd_timer01
-cve-2017-1000405 thp04
-cve-2018-5803 sctp_big_chunk
-cve-2018-6927 futex_cmp_requeue02
-cve-2018-7566 snd_seq01
-cve-2018-8897 ptrace09
-cve-2018-9568 connect02
-cve-2018-10124 kill13
-cve-2018-11508 adjtimex03
-cve-2018-12896 timer_settime03
-cve-2018-13405 creat09
-cve-2018-18445 bpf_prog04
-cve-2018-18559 bind06
-cve-2018-18955 userns08
-cve-2018-19854 crypto_user01
-cve-2018-1000001 realpath01
-cve-2018-1000199 ptrace08
-cve-2018-1000204 ioctl_sg01
-cve-2019-8912 af_alg07
-cve-2020-11494 pty04
-cve-2020-14386 sendto03
-cve-2020-14416 pty03
-cve-2020-25705 icmp_rate_limit01
-cve-2020-29373 io_uring02
-cve-2020-36557 pty06
-cve-2021-3444 bpf_prog05
-cve-2021-3609 can_bcm01
-cve-2021-4034 execve06
-cve-2021-4197_1 cgroup_core01
-cve-2021-4197_2 cgroup_core02
-cve-2021-4204 bpf_prog06
-cve-2021-22555 setsockopt08
-cve-2021-26708 vsock01
-cve-2021-22600 setsockopt09
-cve-2021-38604 mq_notify03
-cve-2022-0847 dirtypipe
-cve-2022-2590 dirtyc0w_shmem
-cve-2022-23222 bpf_prog07
-cve-2023-1829 tcindex01
-cve-2023-0461 setsockopt10
-cve-2023-31248 nft02
-# Tests below may cause kernel memory leak
-cve-2020-25704 perf_event_open03
-cve-2022-0185 fsconfig03
-cve-2022-4378 cve-2022-4378
-cve-2025-38236 cve-2025-38236
-cve-2025-21756 cve-2025-21756
-cve-2026-31431 af_alg08
-cve-2026-43284 xfrm01
-cve-2026-43494 io_uring04
-cve-2026-46300 xfrm02
-cve-2026-46300-skb-segment xfrm03
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
