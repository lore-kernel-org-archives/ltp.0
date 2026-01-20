Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138C4D2ECE9
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 13:27:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 903053CB032
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 14:27:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20C773CAE57
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 14:26:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8C28B200243
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 14:26:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 02190337DC;
 Tue, 20 Jan 2026 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768915604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fEOBLOrJggR/Eeyir9hJRyU78Nt6GpjqHynyqf9PMpI=;
 b=zTD5X1crvY8qlGo4AJ3yHcKnb3ofiWfTdmrBG4JXGEM6gYAofO2TAP2FBV4eFaP4UR0XPp
 KF0MlYs5o2HY5rYT9fw2mQ+Vo8USqrst8ApVzmlAjz5N+fb49vxIrGk8GM8E20eVF4IIF4
 KcBjbt0Y61LcUptNRejVsLK+oHBw0RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768915604;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fEOBLOrJggR/Eeyir9hJRyU78Nt6GpjqHynyqf9PMpI=;
 b=CZto7/3JRzjh/TBbTGNGMQHqvl1QefxeC97SaH6gAdGslo4w/w6LaZhbgRfvbqFTzozYt7
 Yui5zltkpmhVMhBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LCA5Sk9Z;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=86kK6BgR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768915603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fEOBLOrJggR/Eeyir9hJRyU78Nt6GpjqHynyqf9PMpI=;
 b=LCA5Sk9ZsBLco0zxTmOmjC1yJMhSSYM238P/O59d3TqHHz/J2Pr+kxUYJVru5Z4ckPIwHb
 YVluV/WauCfwGr3UU5UfyzKlz/gfKdM7oDO2naCnrwMcuMlwvoNzLCGlBlLTFVycAZ76R1
 BWn9HIW4rlJs6JCAevcPle7Ry6NzQwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768915603;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fEOBLOrJggR/Eeyir9hJRyU78Nt6GpjqHynyqf9PMpI=;
 b=86kK6BgRgp/6lygTgIZRwji9ed60zMm87hKM+LBVx93t9WynTT8fgXel3S9SZMyYeDHdFl
 b/F2TNkcnqsTVkDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE1843EA63;
 Tue, 20 Jan 2026 13:26:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sxieNJKCb2lZIQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 20 Jan 2026 13:26:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 20 Jan 2026 14:26:42 +0100
MIME-Version: 1.0
Message-Id: <20260120-file_attr05-v4-1-7cf444e3c7ea@suse.com>
X-B4-Tracking: v=1; b=H4sIAJGCb2kC/1XOTQ6CMBCG4auYrq1py29deQ9DCAxTaSK0aQvRE
 O5uIRri8lvMM+9CPDqNnlxPC3E4a6/NGEd6PhHom/GBVHdxE8FEzjiXVOkn1k0IjmUUsQUoeSu
 7NCfxwjpU+rVr9ypu5cxAQ++w+RkZZzw9jBqNHU3wk7V0FpRTkKUooOxKLoqbnzxewAwb3Wsfj
 HvvnXOyPfgmCfaXNCebkqhOKmAKAA+lWtf1A7BAaRfwAAAA
X-Change-ID: 20260119-file_attr05-eebcc81b9d46
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768915602; l=3557;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=OzuV4G3lnhC3SXHAeL2YHhLB4IaXCOkYOBQWN0xwd0E=;
 b=YMqb1/86c3vOKPwiJGt9UerbETmzyaINQWwWjcs4sLRhzm8KanKuqVTC/V0cFfUjWajEW5MOf
 IVbL6wHb69fAC/jheRmM9GHXrH52gH7QP94gs1xKYn+v+IqwrAtlzfC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 02190337DC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] syscalls: add file_attr05 test
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

Regression test for 474b155adf392 ("fs: make vfs_fileattr_[get|set]
return -EOPNOTSUPP").

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- use tag for the linux commit that is tested
- Link to v3: https://lore.kernel.org/r/20260120-file_attr05-v3-1-c3fd9fc0fcce@suse.com
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/file_attr/.gitignore    |  1 +
 testcases/kernel/syscalls/file_attr/file_attr05.c | 64 +++++++++++++++++++++++
 3 files changed, 66 insertions(+)

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
index 0000000000000000000000000000000000000000..d2fadf5217117975d8be5f775050db532b75a4f2
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/file_attr05.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that `file_setattr` is correctly raising EOPNOTSUPP when filesystem
+ * doesn't support FSX operations.
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
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "474b155adf392"},
+		{},
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
