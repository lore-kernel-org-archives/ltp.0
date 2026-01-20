Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00674D2ECF7
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 10:52:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E84CA3CAE1B
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 11:52:25 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99AB73CA689
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 11:52:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 134181400BF8
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 11:52:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 73EA15BCE4;
 Tue, 20 Jan 2026 10:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768906320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g891cwK8EdIIvdX9tf5K+XhW0t0O/lngsC/lzkwgC4I=;
 b=miEH84uehkFNM1ANudRGPiyMqUbM7s38Zmxr5GLenuONo6n3VD56qX1wOlezaXhpRjTd0T
 PCa+KDMxKkGw20wDupmmdbap0bsrrKOTa6hjwzYba9DR1yuLvPIlcFQswhfdGIfcb5qU0P
 8/P4tAM0MvFNhIK4BefGZjhjHPoOBnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768906320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g891cwK8EdIIvdX9tf5K+XhW0t0O/lngsC/lzkwgC4I=;
 b=abbIls7csZgu2sUHTH+S4L5vtMJKzIWN1esaUGkrEKZYeO1Iyg9XW0lOm8PAQBaauuP4kn
 3z9Yrj38CDbJcOAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768906320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g891cwK8EdIIvdX9tf5K+XhW0t0O/lngsC/lzkwgC4I=;
 b=miEH84uehkFNM1ANudRGPiyMqUbM7s38Zmxr5GLenuONo6n3VD56qX1wOlezaXhpRjTd0T
 PCa+KDMxKkGw20wDupmmdbap0bsrrKOTa6hjwzYba9DR1yuLvPIlcFQswhfdGIfcb5qU0P
 8/P4tAM0MvFNhIK4BefGZjhjHPoOBnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768906320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g891cwK8EdIIvdX9tf5K+XhW0t0O/lngsC/lzkwgC4I=;
 b=abbIls7csZgu2sUHTH+S4L5vtMJKzIWN1esaUGkrEKZYeO1Iyg9XW0lOm8PAQBaauuP4kn
 3z9Yrj38CDbJcOAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59E523EA63;
 Tue, 20 Jan 2026 10:52:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Rd1KFFBeb2nTBQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Jan 2026 10:52:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Jan 2026 11:51:57 +0100
MIME-Version: 1.0
Message-Id: <20260120-file_attr05-v3-1-c3fd9fc0fcce@suse.com>
X-B4-Tracking: v=1; b=H4sIAExeb2kC/0XMTQqDMBBA4avIrDslk/oTu+o9ShGNYw3UJCRRC
 uLdGwqly2/x3g6Rg+EI12KHwJuJxtmMy6kAPff2yWjGbJBC1oKoxcm8uOtTCqJC5kFrRUM7ljX
 kwgeezPt7uz+yp+AWTHPg/veoSFD5f3TsvHUprt7jJpFQt0o2Wo2KZHOLa+Szdgscxwf6zyrwq
 AAAAA==
X-Change-ID: 20260119-file_attr05-eebcc81b9d46
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768906320; l=3415;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=1qHuSFHR4Y+rAhNKFveeNw1awYfXqHLL7Ymfkn6wtQE=;
 b=Hzi8/5RKvzeDXvvRBMAuhtRxDPHqKdgSDSE3RXZZSAgdNyL75buECTk64e399l9fLzIs7PrQO
 SE46/fcxJjSB20oSI/czL4bsHsIfbBtOthGvAIMDWL/hzIU9C8MZ0fK
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] syscalls: add file_attr05 test
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

Verify that `file_setattr` is correctly raising EOPNOTSUPP when
filesystem doesn't support FSX operations.

Regression test for "474b155adf39 - fs: make vfs_fileattr_[get|set]
return -EOPNOTSUPP".

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/file_attr/.gitignore    |  1 +
 testcases/kernel/syscalls/file_attr/file_attr05.c | 63 +++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index a1ef7548b58a1a8d51d8eec347d5772edbf0a953..12b4f3949c794b8747ccc827a1a66b6332e44673 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -253,6 +253,7 @@ file_attr01 file_attr01
 file_attr02 file_attr02
 file_attr03 file_attr03
 file_attr04 file_attr04
+file_attr05 file_attr05
 
 #posix_fadvise test cases
 posix_fadvise01                      posix_fadvise01
diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
index 3fcb9004dd301ef4ee8cc1067c6a3763acb8d299..42f830a7e477cf42a967f5b14b7e4b6902c4f0e3 100644
--- a/testcases/kernel/syscalls/file_attr/.gitignore
+++ b/testcases/kernel/syscalls/file_attr/.gitignore
@@ -2,3 +2,4 @@ file_attr01
 file_attr02
 file_attr03
 file_attr04
+file_attr05
diff --git a/testcases/kernel/syscalls/file_attr/file_attr05.c b/testcases/kernel/syscalls/file_attr/file_attr05.c
new file mode 100644
index 0000000000000000000000000000000000000000..44d803ed8731a339ceeda18d1fffcfd775061c05
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/file_attr05.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that `file_setattr` is correctly raising EOPNOTSUPP when filesystem
+ * doesn't support FSX operations.
+ *
+ * Regression test for "474b155adf39 - fs: make vfs_fileattr_[get|set] return
+ * -EOPNOTSUPP".
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "mntpoint"
+#define FILEPATH (MNTPOINT "/ltp_file")
+#define BLOCKS 128
+#define PROJID 16
+
+static struct file_attr *attr_set;
+
+static void run(void)
+{
+	TST_EXP_FAIL(file_setattr(AT_FDCWD, FILEPATH,
+			   attr_set, FILE_ATTR_SIZE_LATEST, 0), EOPNOTSUPP);
+}
+
+static void setup(void)
+{
+	struct stat statbuf;
+
+	SAFE_TOUCH(FILEPATH, 0777, NULL);
+
+	SAFE_STAT(MNTPOINT, &statbuf);
+
+	attr_set->fa_xflags |= FS_XFLAG_EXTSIZE;
+	attr_set->fa_xflags |= FS_XFLAG_COWEXTSIZE;
+	attr_set->fa_extsize = BLOCKS * statbuf.st_blksize;
+	attr_set->fa_cowextsize = BLOCKS * statbuf.st_blksize;
+	attr_set->fa_projid = PROJID;
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.mntpoint = MNTPOINT,
+	.needs_root = 1,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.format_device = 1,
+	.skip_filesystems = (const char *const []) {
+		"xfs",
+		"fuse", /* EINVAL is raised before EOPNOTSUPP */
+		"vfat", /* vfat is not implementing file_[set|get]attr */
+		NULL,
+	},
+	.bufs = (struct tst_buffers []) {
+		{&attr_set, .size = sizeof(struct file_attr)},
+		{}
+	}
+};

---
base-commit: 36b915cef08adaa833af79301780cdd45a38f0e2
change-id: 20260119-file_attr05-eebcc81b9d46

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
