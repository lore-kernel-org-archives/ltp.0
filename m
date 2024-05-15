Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0D6C25B78
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 09:34:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 051113CF721
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 11:34:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 751263CD986
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:33:57 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C83F61A0BC2C
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:33:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 58473339F2;
 Wed, 15 May 2024 09:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715765636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7t6HtRml77kFvTFKI6ZlzSMqN0i1+8wET235ZCa8dnw=;
 b=StPS7ZHAJxZc335wpFDmxNpxM4ZlDWghpdbBQ6wCqNnGmaiA1xin0YhwaGj6qk1cLT3nt4
 Y3cKq5EngXCG843ssf2KZFDxcySMYA3QS9s0ogbi6gRFJoI6IqEFBeLx3vZkyCSE04nRf9
 32nJnTJghYHd8fthx7U6lTc0XtUwYNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715765636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7t6HtRml77kFvTFKI6ZlzSMqN0i1+8wET235ZCa8dnw=;
 b=lkMYKAfaNlPF7ALyUYC2whbIMnXL1lTwRvYtALy/C6c/EUVrLjyWQ1J+AxPzf+hJ8XphE6
 I+5nuHSI2ZAOfVCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=StPS7ZHA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lkMYKAfa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715765636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7t6HtRml77kFvTFKI6ZlzSMqN0i1+8wET235ZCa8dnw=;
 b=StPS7ZHAJxZc335wpFDmxNpxM4ZlDWghpdbBQ6wCqNnGmaiA1xin0YhwaGj6qk1cLT3nt4
 Y3cKq5EngXCG843ssf2KZFDxcySMYA3QS9s0ogbi6gRFJoI6IqEFBeLx3vZkyCSE04nRf9
 32nJnTJghYHd8fthx7U6lTc0XtUwYNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715765636;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7t6HtRml77kFvTFKI6ZlzSMqN0i1+8wET235ZCa8dnw=;
 b=lkMYKAfaNlPF7ALyUYC2whbIMnXL1lTwRvYtALy/C6c/EUVrLjyWQ1J+AxPzf+hJ8XphE6
 I+5nuHSI2ZAOfVCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31CF513A62;
 Wed, 15 May 2024 09:33:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KF83CoSBRGb1TwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 15 May 2024 09:33:56 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 15 May 2024 11:33:43 +0200
Message-Id: <20240515093349.7347-5-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240515093349.7347-1-andrea.cervesato@suse.de>
References: <20240515093349.7347-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 58473339F2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 04/10] Add listmount02 test
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

This test verifies that listmount() is properly reading groups of
mount IDs.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/listmount/.gitignore      |   1 +
 .../kernel/syscalls/listmount/listmount02.c   | 106 ++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 testcases/kernel/syscalls/listmount/listmount02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 8fd4a9a0a..355c182f8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -707,6 +707,7 @@ linkat02 linkat02
 listen01 listen01
 
 listmount01 listmount01
+listmount02 listmount02
 
 listxattr01 listxattr01
 listxattr02 listxattr02
diff --git a/testcases/kernel/syscalls/listmount/.gitignore b/testcases/kernel/syscalls/listmount/.gitignore
index 5257b298c..30bbf9f02 100644
--- a/testcases/kernel/syscalls/listmount/.gitignore
+++ b/testcases/kernel/syscalls/listmount/.gitignore
@@ -1 +1,2 @@
 listmount01
+listmount02
diff --git a/testcases/kernel/syscalls/listmount/listmount02.c b/testcases/kernel/syscalls/listmount/listmount02.c
new file mode 100644
index 000000000..712f17a50
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/listmount02.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/**
+ * [Description]
+ *
+ * This test verifies that listmount() is properly reading groups of mount IDs.
+ *
+ * [Algorithm]
+ *
+ * * move into a new unshared namespace
+ * * mount() our new root inside temporary folder
+ * * generate a full mounts tree inside root folder
+ * * read the full list of mounted IDs using listmount(LSMT_ROOT, ..)
+ * * read the list of mounted IDs using groups of fixed size
+ * * compare the first mount list with the second mount list
+ */
+
+#include "listmount.h"
+#include "lapi/sched.h"
+
+#define MNTPOINT "mntpoint"
+#define BIND_MOUNTS 7
+#define GROUPS_SIZE 3
+#define LISTSIZE (1 << BIND_MOUNTS)
+
+static void run(void)
+{
+	ssize_t ret;
+	size_t id, tot_ids, count = 0;
+	uint64_t mount_ids[LISTSIZE];
+	uint64_t list[LISTSIZE];
+
+	for (int i = 0; i < BIND_MOUNTS; i++)
+		SAFE_MOUNT("/", "/", NULL, MS_BIND, NULL);
+
+	tst_res(TINFO, "Reading all %d mount IDs in once", LISTSIZE);
+
+	TST_EXP_POSITIVE(listmount(LSMT_ROOT, 0, mount_ids, LISTSIZE, 0));
+	if (TST_RET == -1)
+		goto end;
+
+	tot_ids = (size_t)TST_RET;
+
+	if (tot_ids != LISTSIZE) {
+		tst_res(TFAIL, "listmount() returned %lu but %d was expected",
+			tot_ids, LISTSIZE);
+		goto end;
+	}
+
+	tst_res(TINFO, "Reading groups of %d mount IDs", GROUPS_SIZE);
+
+	while (count < LISTSIZE) {
+		id = count ? list[count - 1] : 0;
+		ret = listmount(LSMT_ROOT, id, list + count, GROUPS_SIZE, 0);
+
+		tst_res(TDEBUG, "listmount(LSMT_ROOT, %lu, list + %lu, %d, 0)",
+			id, count, GROUPS_SIZE);
+
+		if (ret == -1) {
+			tst_res(TFAIL, "listmount() failed with %s", tst_strerrno(errno));
+			goto end;
+		}
+
+		count += ret;
+
+		if (TST_RET < GROUPS_SIZE)
+			break;
+	}
+
+	for (size_t i = 0; i < LISTSIZE; i++) {
+		if (mount_ids[i] != list[i]) {
+			tst_res(TFAIL, "Mount ID differs at %ld index", i);
+			goto end;
+		}
+	}
+
+	tst_res(TPASS, "All mount IDs have been correctly read");
+
+end:
+	SAFE_UMOUNT("/");
+}
+
+static void setup(void)
+{
+	SAFE_UNSHARE(CLONE_NEWNS);
+	SAFE_CHROOT(MNTPOINT);
+
+	SAFE_MOUNT("", "/", NULL, MS_REC | MS_SHARED, NULL);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.forks_child = 1,
+	.min_kver = "6.8",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		NULL
+	},
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
