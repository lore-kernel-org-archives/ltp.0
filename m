Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4700C25B7A
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 09:36:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7296B3CF7E7
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 11:36:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F28E3CF74A
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:33:59 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9A3EC1000CF5
 for <ltp@lists.linux.it>; Wed, 15 May 2024 11:33:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 970242048D;
 Wed, 15 May 2024 09:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715765637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViHSx8QjhJNj5eZ77Q/fbB6cgsOvS03qTHjZ4BxfxBM=;
 b=C3JueDK/RHWnixVdIkOV07itH0Aj/ARErXyWETu8XP+5E1Ncf4XN3QzBmd6ueKdC4ZXCXO
 L0QGA3hssDEINNauXLaR7WIMAy5DeGJrYTrAzIKTMUcarBUNRGmsZN9gPJsIr9P+rdY7iS
 51peZ20evIaPIxp4/VN19DNt+khp7MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715765637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViHSx8QjhJNj5eZ77Q/fbB6cgsOvS03qTHjZ4BxfxBM=;
 b=O+RM2rzusTcLwY0qib0YLTKsznDbR0KTRQW0RM4QRR8IAQJR9+BwBBjjsyfa/BjJxXNjrh
 DfryAqzWvjCNAODQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="C3JueDK/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=O+RM2rzu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715765637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViHSx8QjhJNj5eZ77Q/fbB6cgsOvS03qTHjZ4BxfxBM=;
 b=C3JueDK/RHWnixVdIkOV07itH0Aj/ARErXyWETu8XP+5E1Ncf4XN3QzBmd6ueKdC4ZXCXO
 L0QGA3hssDEINNauXLaR7WIMAy5DeGJrYTrAzIKTMUcarBUNRGmsZN9gPJsIr9P+rdY7iS
 51peZ20evIaPIxp4/VN19DNt+khp7MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715765637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViHSx8QjhJNj5eZ77Q/fbB6cgsOvS03qTHjZ4BxfxBM=;
 b=O+RM2rzusTcLwY0qib0YLTKsznDbR0KTRQW0RM4QRR8IAQJR9+BwBBjjsyfa/BjJxXNjrh
 DfryAqzWvjCNAODQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7076B13A62;
 Wed, 15 May 2024 09:33:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0FEuGYWBRGb1TwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 15 May 2024 09:33:57 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Wed, 15 May 2024 11:33:49 +0200
Message-Id: <20240515093349.7347-11-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240515093349.7347-1-andrea.cervesato@suse.de>
References: <20240515093349.7347-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 970242048D
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 10/10] Add statmount06 test
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/statmount/.gitignore      |  1 +
 .../kernel/syscalls/statmount/statmount06.c   | 73 +++++++++++++++++++
 3 files changed, 75 insertions(+)
 create mode 100644 testcases/kernel/syscalls/statmount/statmount06.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2984117e6..86e253f77 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1542,6 +1542,7 @@ statmount02 statmount02
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
index 000000000..5c9be9be9
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount06.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/**
+ * [Description]
+ *
+ * This test verifies that statmount() is correctly reading name of the
+ * filesystem type using STATMOUNT_FS_TYPE.
+ *
+ * [Algorithm]
+ *
+ * * create a mount point
+ * * run statmount() on the mount point using STATMOUNT_FS_TYPE
+ * * read results and check if contain the name of the filesystem
+ */
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
+	TST_EXP_PASS(statmount(
+		root_id,
+		STATMOUNT_FS_TYPE,
+		st_mount,
+		SM_SIZE,
+		0));
+
+	if (TST_RET == -1)
+		return;
+
+	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_FS_TYPE);
+	TST_EXP_EXPR(strcmp(st_mount->str + st_mount->fs_type, tst_device->fs_type) == 0,
+		"statmount() read '%s', expected '%s'",
+		st_mount->str + st_mount->fs_type, tst_device->fs_type);
+}
+
+static void setup(void)
+{
+	struct statx sx;
+
+	SAFE_STATX(AT_FDCWD, MNTPOINT, 0, STATX_MNT_ID_UNIQUE, &sx);
+	root_id = sx.stx_mnt_id;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.min_kver = "6.8",
+	.format_device = 1,
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
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
