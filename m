Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A824C25B78
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 12:31:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D8E73CF9E6
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 14:31:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F41D03CF981
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:37 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F199D1001133
 for <ltp@lists.linux.it>; Thu, 16 May 2024 14:29:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF28834927
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wsrn1Mz28skBQ9t974KocbnFS1Gshe2mMfHizCv6hxQ=;
 b=rc2YJZNuoccVNLEnpI6XbStDweoCv444QbZ3uktz9yTo5A0W+8OJZnLQClnlWiuDYT3hbf
 Q3P7BT/wgIZjvjuRbiVRRRvDBrzFf+My7957FNBq7FAj3ZJJIAyrsUiJ3yIjKiTpPCCyYK
 /B1LIL4VQcCog7e6ALj9XhcZa2vdIkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wsrn1Mz28skBQ9t974KocbnFS1Gshe2mMfHizCv6hxQ=;
 b=ntPe/YpXyPycMKNSQVURDYR1KVcQfgwA5h8rk+ByFzlTq1O4HmlO4kYFQI9ACHgCnptgl9
 RYiTWCI6j+UgPIDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rc2YJZNu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="ntPe/YpX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715862575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wsrn1Mz28skBQ9t974KocbnFS1Gshe2mMfHizCv6hxQ=;
 b=rc2YJZNuoccVNLEnpI6XbStDweoCv444QbZ3uktz9yTo5A0W+8OJZnLQClnlWiuDYT3hbf
 Q3P7BT/wgIZjvjuRbiVRRRvDBrzFf+My7957FNBq7FAj3ZJJIAyrsUiJ3yIjKiTpPCCyYK
 /B1LIL4VQcCog7e6ALj9XhcZa2vdIkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715862575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wsrn1Mz28skBQ9t974KocbnFS1Gshe2mMfHizCv6hxQ=;
 b=ntPe/YpXyPycMKNSQVURDYR1KVcQfgwA5h8rk+ByFzlTq1O4HmlO4kYFQI9ACHgCnptgl9
 RYiTWCI6j+UgPIDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF473137C3
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CE1VLS/8RWbOfwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 16 May 2024 12:29:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 May 2024 14:29:19 +0200
MIME-Version: 1.0
Message-Id: <20240516-listmount_statmount-v3-11-2ff4ba29bba7@suse.com>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
In-Reply-To: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2925;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=YYtTebon1mlmlY/LLpvgcGSp2zVrLWw6tTxaB5ISSWA=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmRfwuvBWgITfUgcq7RTe1lAJ1IkKw9HqcRjfym
 1Fswz3+6ZiJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZkX8LgAKCRDLzBqyILPm
 Rv3nC/9ekj0oFRl6/C2oifeUtKETGEhH3+1R3dYVKQQ1J3RyfLOor16jo6RzTheJIbg1vZjXtG7
 /TGfm60Pg/UYX3G8nvf8+fp4rQ3aAA/3NKAA7X+lfco6gdfSa3Jn0+eD87BDMNwkuykZEWb0lVo
 K7XnDO114gpziBt/32l6JeMAZHMNYH4c/nEGk0hDW5b7EhslMfXMcqM1zz7ee5OhpBi1TvPacW8
 LZDuC7Ecbs+DJXyfIbUIpgvRdDpQplBGg4+1H9H2dMnrPay5lvXvjf7LicYONKB97OOFi0aRwpM
 LlzUfGj75KOsV5dfjZUGD/osNi2eQ7OIgCY1NKGR813PnnnaJDTfuQwgy5nNn96GIXbDUWAXDko
 BCAqA2s4hOVmYdUrgIyoVS/hYmRdB2zQZo9R89A1/bkBQyWxU2pN9xchom5LJCDLVwvRLASudqS
 AvKBZegCaCZf8gr40BRQN2syd6/9NTQiZkYak3mR5ZsDNmAWTnKn7sgqTLYh6dh+sN4MI=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CF28834927
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; RCPT_COUNT_ONE(0.00)[1];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 11/11] Add statmount06 test
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
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/statmount/.gitignore    |  1 +
 testcases/kernel/syscalls/statmount/statmount06.c | 72 +++++++++++++++++++++++
 3 files changed, 74 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index b04aabc6f..a3546b155 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1543,6 +1543,7 @@ statmount02 statmount02
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
index 000000000..2f5fc870f
--- /dev/null
+++ b/testcases/kernel/syscalls/statmount/statmount06.c
@@ -0,0 +1,72 @@
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
