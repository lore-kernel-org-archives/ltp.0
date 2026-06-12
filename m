Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077F7CD98CE
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 16:29:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9641A3E6A55
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 18:29:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DC403E5FC8
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 18:28:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0B4EE1000B70
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 18:28:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A1AAC76F0E;
 Fri, 12 Jun 2026 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781272455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cY1rCgvqJE5cqL+Uea6EtWxiMb9E4Qg/zEbmcS+dSY=;
 b=o+4IZZMJAljlnjv6+ZhV7FkdzISn/ankrM+PqdH24MEyovpuWfDGr0KJwexpMmz+bDgTLD
 42JCU0NeVN3NLKMYNtXckdd7n7lC5aO5HD+WFZhcn3CPVlmJHvxSQCYknPWiRORHDEamiv
 dWmAO1+MByRftJKZ8yLongiGOwvVj94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781272455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cY1rCgvqJE5cqL+Uea6EtWxiMb9E4Qg/zEbmcS+dSY=;
 b=DVnYRVAh+ExHZTNmTbzhK4dOibAPbVb4z63zOK1upT6dp+jzIaC5T1bwv9ooK6uGar1nQ9
 AHL7WZxiPlO2R6AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781272455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cY1rCgvqJE5cqL+Uea6EtWxiMb9E4Qg/zEbmcS+dSY=;
 b=o+4IZZMJAljlnjv6+ZhV7FkdzISn/ankrM+PqdH24MEyovpuWfDGr0KJwexpMmz+bDgTLD
 42JCU0NeVN3NLKMYNtXckdd7n7lC5aO5HD+WFZhcn3CPVlmJHvxSQCYknPWiRORHDEamiv
 dWmAO1+MByRftJKZ8yLongiGOwvVj94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781272455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0cY1rCgvqJE5cqL+Uea6EtWxiMb9E4Qg/zEbmcS+dSY=;
 b=DVnYRVAh+ExHZTNmTbzhK4dOibAPbVb4z63zOK1upT6dp+jzIaC5T1bwv9ooK6uGar1nQ9
 AHL7WZxiPlO2R6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 885E0779A9;
 Fri, 12 Jun 2026 13:54:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4DS8H4cPLGrGfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 12 Jun 2026 13:54:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 12 Jun 2026 15:54:14 +0200
MIME-Version: 1.0
Message-Id: <20260612-metadata_groups-v1-1-d7a24a7ac7a8@suse.com>
References: <20260612-metadata_groups-v1-0-d7a24a7ac7a8@suse.com>
In-Reply-To: <20260612-metadata_groups-v1-0-d7a24a7ac7a8@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781272455; l=4509;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=32r9drCTKqUZPZMuwmaUrBrql7FSNLwY9L4IwBJ9nvs=;
 b=zyjR9U1/OChVT3xQ4txXoKaCOPuK6KLtTjJ3gues4/wztH4+Tr9xRc0KsIO5XVFADkSBoeyMe
 aWd81QfbzSWDQCNEGVAmfuj8qlx0foO/cF7M56EaUtys2e0E2CB92dV
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] metadata: add tests grouping support
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

2. @group tags in the doc comment block, e.g.:
   /*    * Test description.
    *
    * @group stress
    */

Add test case for @group tag parsing.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 metadata/metaparse.c         | 88 ++++++++++++++++++++++++++++++++++++++++++++
 metadata/tests/groups.c      | 11 ++++++
 metadata/tests/groups.c.json | 13 +++++++
 3 files changed, 112 insertions(+)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 561cbb9d2d54689988c9aa49d591628696bcf847..6bc4b7af60c7449d4b60a1252fa58fed77e03066 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -1168,6 +1168,92 @@ static void print_help(const char *prgname)
 	exit(0);
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
+	char buf[256];
+	int offsets[8];
+	int ndirs = 0;
+	int ngroups = 0;
+	char *p;
+
+	if (strncmp(fname, "testcases/", 10))
+		return;
+
+	snprintf(buf, sizeof(buf), "%s", fname + 10);
+
+	p = strtok(buf, "/");
+	while (p && ndirs < 8) {
+		offsets[ndirs++] = p - buf;
+		p = strtok(NULL, "/");
+	}
+
+	/* Last element is the filename, skip it */
+	ndirs--;
+
+	for (int j = ndirs - 1; j >= 0 && ngroups < 2; j--) {
+		if (!strcmp(buf + offsets[j], "kernel"))
+			continue;
+
+		data_node_array_add(groups, data_node_string(buf + offsets[j]));
+		ngroups++;
+	}
+}
+
+/*
+ * Add groups from @group tags in the doc comment block.
+ */
+static void add_doc_groups(struct data_node *groups, struct data_node *doc)
+{
+	if (!doc || doc->type != DATA_ARRAY)
+		return;
+
+	for (unsigned int i = 0; i < data_node_array_len(doc); i++) {
+		struct data_node *line = doc->array.array[i];
+		const char *s;
+
+		if (line->type != DATA_STRING)
+			continue;
+
+		s = line->string.val;
+
+		while (*s && (*s == ' ' || *s == '\t'))
+			s++;
+
+		if (strncmp(s, "@group ", 7))
+			continue;
+
+		s += 7;
+		while (*s && (*s == ' ' || *s == '\t'))
+			s++;
+
+		if (*s)
+			data_node_array_add(groups, data_node_string(s));
+	}
+}
+
+static void build_groups(struct data_node *res, const char *fname)
+{
+	struct data_node *groups = data_node_array();
+
+	add_path_groups(groups, fname);
+	add_doc_groups(groups, data_node_hash_get(res, "doc"));
+
+	if (data_node_array_len(groups))
+		data_node_hash_add(res, "groups", groups);
+	else
+		data_node_free(groups);
+}
+
 int main(int argc, char *argv[])
 {
 	unsigned int i, j;
@@ -1238,6 +1324,8 @@ int main(int argc, char *argv[])
 	}
 
 	data_node_hash_add(res, "fname", data_node_string(argv[optind]));
+	build_groups(res, argv[optind]);
+
 	printf("  \"%s\": ", strip_name(argv[optind]));
 	data_to_json(res, stdout, 2);
 	data_node_free(res);
diff --git a/metadata/tests/groups.c b/metadata/tests/groups.c
new file mode 100644
index 0000000000000000000000000000000000000000..82f07111c1506c634f13822ee6aa95f574eb19a5
--- /dev/null
+++ b/metadata/tests/groups.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*\
+ * Test for @group tag parsing.
+ *
+ * @group stress
+ * @group regression
+ */
+
+static struct tst_test test = {
+};
diff --git a/metadata/tests/groups.c.json b/metadata/tests/groups.c.json
new file mode 100644
index 0000000000000000000000000000000000000000..4683e6cf07eeebc60faefb9aead9370dc3f631aa
--- /dev/null
+++ b/metadata/tests/groups.c.json
@@ -0,0 +1,13 @@
+  "groups": {
+   "doc": [
+    "Test for @group tag parsing.",
+    "",
+    "@group stress",
+    "@group regression"
+   ],
+   "fname": "groups.c",
+   "groups": [
+    "stress",
+    "regression"
+   ]
+  }
\ No newline at end of file

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
