Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96756CD98F2
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 12:10:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 477FD3E69B2
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 14:10:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98E233E697A
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 14:10:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D0032600740
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 14:10:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1860D707C8;
 Mon, 22 Jun 2026 12:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782130230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7Fuc7q5bQHNsTQlqW6r3dUBV6JpDpDnU489e04AeLB8=;
 b=oPm5utLlsYisilzjMLTtuhelfaVu8iK9rXtSlGsvSHh0tBwPzwb/N/M/4qXsZC7zwDkIiH
 qdjiO+xhYXurzoeKRpUaP300ZheKMLaHNl0gYLuDUpSvd1cSKGuD0FmgrEP36yU+euHGws
 nQ0ADkhAxJLWb6gOv5qIthLHM/3Yy6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782130230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7Fuc7q5bQHNsTQlqW6r3dUBV6JpDpDnU489e04AeLB8=;
 b=5X1l/jSz9nWHnD6sZvXVZrX5yeMeZx9aeVCXlIv3Kqvq5c3Ko6DzzZIjk8y72xWP0QqtJ1
 N5cn+/uLq5xCSYBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oPm5utLl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="5X1l/jSz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782130230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7Fuc7q5bQHNsTQlqW6r3dUBV6JpDpDnU489e04AeLB8=;
 b=oPm5utLlsYisilzjMLTtuhelfaVu8iK9rXtSlGsvSHh0tBwPzwb/N/M/4qXsZC7zwDkIiH
 qdjiO+xhYXurzoeKRpUaP300ZheKMLaHNl0gYLuDUpSvd1cSKGuD0FmgrEP36yU+euHGws
 nQ0ADkhAxJLWb6gOv5qIthLHM/3Yy6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782130230;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7Fuc7q5bQHNsTQlqW6r3dUBV6JpDpDnU489e04AeLB8=;
 b=5X1l/jSz9nWHnD6sZvXVZrX5yeMeZx9aeVCXlIv3Kqvq5c3Ko6DzzZIjk8y72xWP0QqtJ1
 N5cn+/uLq5xCSYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3C00779A8;
 Mon, 22 Jun 2026 12:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uC32OTUmOWrSVQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 22 Jun 2026 12:10:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 22 Jun 2026 14:10:23 +0200
MIME-Version: 1.0
Message-Id: <20260622-metadata_cve-v1-1-c8d43e0db19e@suse.com>
X-B4-Tracking: v=1; b=H4sIAC4mOWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyMj3dzUksSUxJLE+OSyVF0j0+Q0E6MkkzRjixQloJaCotS0zAqwcdG
 xtbUA/pUaKV4AAAA=
X-Change-ID: 20260622-metadata_cve-25cf42b4f38d
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782130229; l=4281;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=orFTfPHvY9iHdywcbIQFsveV7SvOru3EjQjN9iWAzGQ=;
 b=q48BMM5HRFGPRhMTGvF7QlHnAVo3iCs1gTEHtHgr6+Islq/BuQOEhj9xfPBaPh/Lixv/zDjQO
 knATydt74qwDcvL6BQ5LO3eWtO13S2DipXD7ZTpPMkTP49oOzmNdPGm
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1860D707C8
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] metadata: automatically detect CVE via tags
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

Automatically assign a 'cve' group to test metadata when we are tagging
it with a CVE number.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 metadata/metaparse.c      | 43 ++++++++++++++++++++++++++++++++++++++-----
 metadata/tests/cve.c      | 12 ++++++++++++
 metadata/tests/cve.c.json | 15 +++++++++++++++
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index a0f94511db36e42e6174774dfa8340cb4dce113a..ce9729122e40503b4bc6318f03e6b861f9d38a5c 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -52,12 +52,14 @@ static char *eat_asterisk_space(char *c)
 }
 
 /*
- * Add a group to the groups array, skipping 'kernel' as it's too generic.
- * Returns 0 if no group was added, 1 otherwise.
+ * Add a group to the groups array, skipping path components that are too
+ * generic ('kernel') or assigned from a more reliable source ('cve', which
+ * is derived from the CVE tag instead). Returns 0 if no group was added,
+ * 1 otherwise.
  */
 static int add_group(struct data_node *groups, const char *name)
 {
-	if (name && strcmp(name, "kernel")) {
+	if (name && strcmp(name, "kernel") && strcmp(name, "cve")) {
 		data_node_array_add(groups, data_node_string(name));
 		return 1;
 	}
@@ -971,11 +973,11 @@ static void load_internal_macros(void)
  * Add groups derived from the source file path.
  *
  * Groups are the two nearest parent directories (immediate parent
- * first), skipping 'kernel' as it's too generic:
+ * first), skipping 'kernel' (too generic) and 'cve' (assigned from the
+ * CVE tag instead, see add_tag_groups()):
  *
  *   testcases/kernel/syscalls/clone/clone01.c  -> clone, syscalls
  *   testcases/kernel/kvm/kvm_pagefault01.c     -> kvm
- *   testcases/cve/cve-2017-16939.c             -> cve
  */
 static void add_path_groups(struct data_node *groups, const char *fname)
 {
@@ -1010,6 +1012,35 @@ static void add_path_groups(struct data_node *groups, const char *fname)
 	free(buf);
 }
 
+/*
+ * Add group to specific test tags.
+ */
+static void add_tag_groups(struct data_node *groups, struct data_node *res)
+{
+	struct data_node *tags = data_node_hash_get(res, "tags");
+	unsigned int i;
+
+	if (!tags || tags->type != DATA_ARRAY)
+		return;
+
+	for (i = 0; i < data_node_array_len(tags); i++) {
+		struct data_node *tag = tags->array.array[i];
+		struct data_node *name;
+
+		if (tag->type != DATA_ARRAY || !data_node_array_len(tag))
+			continue;
+
+		name = tag->array.array[0];
+		if (name->type != DATA_STRING)
+			continue;
+
+		if (!strcmp(name->string.val, "CVE")) {
+			data_node_array_add(groups, data_node_string("cve"));
+			return;
+		}
+	}
+}
+
 static struct data_node *parse_file(const char *fname)
 {
 	int state = 0, found = 0;
@@ -1064,6 +1095,8 @@ static struct data_node *parse_file(const char *fname)
 		data_node_free(doc);
 	}
 
+	add_tag_groups(groups, res);
+
 	/*
 	 * Always emit groups, even when empty: tests outside testcases/
 	 * and files whose only parent dir is 'kernel' produce no groups.
diff --git a/metadata/tests/cve.c b/metadata/tests/cve.c
new file mode 100644
index 0000000000000000000000000000000000000000..c2b0e551f111ae87f3c6dcb50ef25c66967443f4
--- /dev/null
+++ b/metadata/tests/cve.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*\
+ * Test for cve group derived from the CVE tag.
+ */
+
+static struct tst_test test = {
+	.tags = (const struct tst_tag[]) {
+		{"CVE", "2017-16939"},
+		{}
+	}
+};
diff --git a/metadata/tests/cve.c.json b/metadata/tests/cve.c.json
new file mode 100644
index 0000000000000000000000000000000000000000..543d9e58a3e78d296cc4247659d1b26f2a103245
--- /dev/null
+++ b/metadata/tests/cve.c.json
@@ -0,0 +1,15 @@
+  "cve": {
+   "tags": [
+    [
+     "CVE",
+     "2017-16939"
+    ]
+   ],
+   "doc": [
+    "Test for cve group derived from the CVE tag."
+   ],
+   "groups": [
+    "cve"
+   ],
+   "fname": "cve.c"
+  }
\ No newline at end of file

---
base-commit: b2184c0f2debb976414b294b8527298bdac0a877
change-id: 20260622-metadata_cve-25cf42b4f38d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
