Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15180CFB45B
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 15:01:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 842E13C1D0B
	for <ltp@archiver.kernel.org>; Tue,  8 Oct 2024 17:01:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B6CA3C1D06
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:00:12 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 49B6D200CF9
 for <ltp@lists.linux.it>; Tue,  8 Oct 2024 17:00:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2196321D30;
 Tue,  8 Oct 2024 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728399610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsH2qZcdSW6GrHHgncpb8+BtIYIId1JMt/h99O2g7FI=;
 b=PFXpniMBXShmdT7q3iXrT/Z6oGk/qflO9CLLBB4IzM2sWRHore3nNhuTXwLBCfiRwd44LT
 XzpE+2RsxJqwMMB4dVJx1dGPwNZMlFWX1s13Kbe8nX12/dZLBmkUqQiGc4YZECQJVUJbS7
 +vbn6zkcOsUTn9OqJeyBXdtvh6TZd0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728399610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsH2qZcdSW6GrHHgncpb8+BtIYIId1JMt/h99O2g7FI=;
 b=JkQPapYJJkVExWEA4NV+8uvCnAb0Y9qJqaKgabtKCCBhAZ8Rcm1PFO3QBmQUqjdQ80LgvG
 IxDx1FBzSqzMReCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PFXpniMB;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JkQPapYJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728399610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsH2qZcdSW6GrHHgncpb8+BtIYIId1JMt/h99O2g7FI=;
 b=PFXpniMBXShmdT7q3iXrT/Z6oGk/qflO9CLLBB4IzM2sWRHore3nNhuTXwLBCfiRwd44LT
 XzpE+2RsxJqwMMB4dVJx1dGPwNZMlFWX1s13Kbe8nX12/dZLBmkUqQiGc4YZECQJVUJbS7
 +vbn6zkcOsUTn9OqJeyBXdtvh6TZd0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728399610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JsH2qZcdSW6GrHHgncpb8+BtIYIId1JMt/h99O2g7FI=;
 b=JkQPapYJJkVExWEA4NV+8uvCnAb0Y9qJqaKgabtKCCBhAZ8Rcm1PFO3QBmQUqjdQ80LgvG
 IxDx1FBzSqzMReCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B94E7137CF;
 Tue,  8 Oct 2024 15:00:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OIduJ/lIBWf6KgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 08 Oct 2024 15:00:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 08 Oct 2024 17:00:01 +0200
MIME-Version: 1.0
Message-Id: <20241008-listmount_statmount-v6-6-0fd456b6b9bf@suse.com>
References: <20241008-listmount_statmount-v6-0-0fd456b6b9bf@suse.com>
In-Reply-To: <20241008-listmount_statmount-v6-0-0fd456b6b9bf@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728399605; l=3973;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=MR6twMM5f81ioajQ85Yzz189wTpSilYBu4YCc1VRv1k=;
 b=HmZ+YXYkEzQeXB2h0XustMM8YW2euZj3ypGtkSJ7Lqzf8/8mKWc/GDS3eUt5rZTE4PLrfqi+8
 lyzyfAjYXv6D3Twmyc9n/gGpeCsJGMeEyKo6oFGU1kwDi3WfdPnGX2k
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 2196321D30
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 06/16] Add listmount02 test
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

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   1 +
 testcases/kernel/syscalls/listmount/.gitignore    |   1 +
 testcases/kernel/syscalls/listmount/listmount02.c | 105 ++++++++++++++++++++++
 3 files changed, 107 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 09e3025a6..564066b2b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -732,6 +732,7 @@ linkat02 linkat02
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
index 000000000..4b831b615
--- /dev/null
+++ b/testcases/kernel/syscalls/listmount/listmount02.c
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that listmount() is properly reading groups of mount IDs,
+ * checking that both oneshoot and iterator API for listmount() return the same
+ * array.
+ *
+ * [Algorithm]
+ *
+ * - move into a new unshared namespace
+ * - mount() our new root inside temporary folder
+ * - generate a full mounts tree inside root folder, doubling the number of
+ *   mounted filesystems each bind mount
+ * - read the full list of mounted IDs using listmount(LSMT_ROOT, ..)
+ * - read the list of mounted IDs using groups of fixed size
+ * - compare the first mount list with the second mount list
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
+	if (!TST_PASS)
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
+	for (int i = 0; i < BIND_MOUNTS; i++)
+		SAFE_UMOUNT("/");
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
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
