Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F69CED62A
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 08:33:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19EFF3C4C11
	for <ltp@archiver.kernel.org>; Wed,  9 Oct 2024 10:33:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E37693C27A9
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 36F421A00EBA
 for <ltp@lists.linux.it>; Wed,  9 Oct 2024 10:29:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EDE511F785;
 Wed,  9 Oct 2024 08:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLYXI549Kdlq2BJIP8uJtJfgf55EnGIN196e1a2Z+sw=;
 b=unax1BaJI4c4J97qqErctUnP/bcmAPTKXHB066pSG6H95clXL6wAr962kOhdfjqzRnm6kh
 HA2SA54ZX2yiz3XPjTrhI/nI8vld95sXiNy3Vvhrh8acm9ptJxYxqqFDtPk1I4nY8ZPoe/
 DGa1a9DTgwK9TZVnnR01kq2ti+B6PXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLYXI549Kdlq2BJIP8uJtJfgf55EnGIN196e1a2Z+sw=;
 b=o/wxT/pyoDknIFMEg3JihHZb3i1SGTyjLsJBanjtNiN/i3pTv1OI44juLPLTfqEa9bo2n0
 f+Au0pecmM+iMSBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728462564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLYXI549Kdlq2BJIP8uJtJfgf55EnGIN196e1a2Z+sw=;
 b=kkg4EZD/c6OmbVRJKYvsnlVpiZKK5jjAaDdmizlQRsFXnbVLu2rEBnCrbKr4kTtFbCO1mT
 tUfDOgaOeymLGPlu6iA8GkF+SZad/0SzXv3oe1m8PL49CAq8O5tnrj5BMcKnGERx9gthN3
 /rmQ6eqDghjavrFG1M3wshs58OON6dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728462564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLYXI549Kdlq2BJIP8uJtJfgf55EnGIN196e1a2Z+sw=;
 b=bmYrL9ktv/y+sgggCXS/kRIw278AH8cFnyvtaFIbrED57Aglj77jpE0WvImAyFxgLrAoAv
 +2rtA5weACmURmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8038136BA;
 Wed,  9 Oct 2024 08:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KG1kEOM+BmeeTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 09 Oct 2024 08:29:23 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 09 Oct 2024 10:29:14 +0200
MIME-Version: 1.0
Message-Id: <20241009-listmount_statmount-v7-12-d5ad31d47f68@suse.com>
References: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
In-Reply-To: <20241009-listmount_statmount-v7-0-d5ad31d47f68@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728462547; l=2931;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=3jfCRI2/1TABZTowNzaQN3Tco1s9VE27JRY5aXLZPr8=;
 b=I+JFPLn0+nYlAXVvy0+i7SCNwlJX/sEdnSr4zT1AgjkduJgUbv+yNs7vD8NL1A4Y14cxvNC33
 j8IfI0wbfirBcgmp0o7LdDWaeDFyvWV/kGdd7K8sAv1f1BWoZgff1Z0
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 12/16] Add statmount06 test
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

This test verifies that statmount() is correctly reading name of the
filesystem type using STATMOUNT_FS_TYPE.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/statmount06.c | 68 +++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 97c7049a2..a742e405b 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1579,6 +1579,7 @@ statmount02 statmount02
 statmount03 statmount03
 statmount04 statmount04
 statmount05 statmount05
+statmount06 statmount06
 
 statfs01 statfs01
 statfs01_64 statfs01_64
diff --git a/testcases/kernel/syscalls/statmount/.gitignore b/testcases/kernel/syscalls/statmount/.gitignore
index f64763242..03a75bd40 100644
--- a/testcases/kernel/syscalls/statmount/.gitignore
+++ b/testcases/kernel/syscalls/statmount/.gitignore
@@ -3,3 +3,4 @@ statmount02
 statmount03
 statmount04
 statmount05
+statmount06
diff --git a/testcases/kernel/syscalls/statmount/statmount06.c b/testcases/kernel/syscalls/statmount/statmount06.c
new file mode 100644
index 000000000..73740407e
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount06.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that statmount() is correctly reading name of the
+ * filesystem type using STATMOUNT_FS_TYPE.
+ *
+ * [Algorithm]
+ *
+ * - create a mount point
+ * - run statmount() on the mount point using STATMOUNT_FS_TYPE
+ * - read results and check if contain the name of the filesystem
+ */
+
+#define _GNU_SOURCE
+
+#include "statmount.h"
+#include "lapi/stat.h"
+#include "lapi/sched.h"
+
+#define MNTPOINT "mntpoint"
+#define SM_SIZE (1 << 10)
+
+static uint64_t root_id;
+static struct statmount *st_mount;
+
+static void run(void)
+{
+	memset(st_mount, 0, SM_SIZE);
+
+	TST_EXP_PASS(statmount(root_id,	STATMOUNT_FS_TYPE, st_mount,
+		SM_SIZE, 0));
+
+	if (!TST_PASS)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_FS_TYPE);
+	TST_EXP_EQ_STR(st_mount->str + st_mount->fs_type, tst_device->fs_type);
+}
+
+static void setup(void)
+{
+	struct ltp_statx sx;
+
+	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, &sx);
+	root_id = sx.data.stx_mnt_id;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.8",
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.all_filesystems = 1,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&st_mount, .size = SM_SIZE},
+		{}
+	}
+};

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
