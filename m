Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9541FCCD187
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 07:58:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E71453CEC33
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 09:58:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1C9C3C2B90
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 09:58:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0D4BA1A00706
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 09:58:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 84DBA219E6;
 Tue, 14 Oct 2025 07:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760428709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h+6H42elCVOP8m6ouvg0z+5EFmTGlPkwgCxsIxSvw/U=;
 b=iF0njohA+TDBrUG2r4rKlK3JAnupjqBl4RqMfVm3VBwBpI3D6n1HvtGD3UePIjSvhKg6+x
 HOdAR1pManIGuthhTZP201q5MCwb5sKKeZU+ouxMrqW75Fz04+imuMsAmeLMZd8N71aRl4
 G4uP4Zh1k1vCS4TDvgqg5BQJxPtvHBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760428709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h+6H42elCVOP8m6ouvg0z+5EFmTGlPkwgCxsIxSvw/U=;
 b=hbnYDx+Qkx8PdD2XmYA+djjrtEWJK/mI6Msg3T7L4vOQrqV0Y8B2aTMnnOCrYOjZ8oc4QV
 BUKQ2GsJlHPqsICA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iF0njohA;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hbnYDx+Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760428709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h+6H42elCVOP8m6ouvg0z+5EFmTGlPkwgCxsIxSvw/U=;
 b=iF0njohA+TDBrUG2r4rKlK3JAnupjqBl4RqMfVm3VBwBpI3D6n1HvtGD3UePIjSvhKg6+x
 HOdAR1pManIGuthhTZP201q5MCwb5sKKeZU+ouxMrqW75Fz04+imuMsAmeLMZd8N71aRl4
 G4uP4Zh1k1vCS4TDvgqg5BQJxPtvHBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760428709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=h+6H42elCVOP8m6ouvg0z+5EFmTGlPkwgCxsIxSvw/U=;
 b=hbnYDx+Qkx8PdD2XmYA+djjrtEWJK/mI6Msg3T7L4vOQrqV0Y8B2aTMnnOCrYOjZ8oc4QV
 BUKQ2GsJlHPqsICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6ABE2139B0;
 Tue, 14 Oct 2025 07:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BohsGKUC7mi0dAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 14 Oct 2025 07:58:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Oct 2025 09:58:28 +0200
MIME-Version: 1.0
Message-Id: <20251014-file_attr_eopnotsupp-v2-1-c9827c8d8127@suse.com>
X-B4-Tracking: v=1; b=H4sIAKMC7mgC/4WNQQ6CMBBFr0JmbU1bgxRX3sMQUstUJlHadArRE
 O5u5QIu30v++yswJkKGS7VCwoWYwlRAHypwo50eKGgoDFrqWkklhacn9jbn1GOIU8g8xyhqc3b
 +rl1jBgNlGhN6eu/ZW1d4JM4hffaXRf3sn+CihBK2PQ1etUZa11x5Zjy68IJu27YvVzNBZ7cAA
 AA=
X-Change-ID: 20251010-file_attr_eopnotsupp-586cfb2c78d8
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760428709; l=3490;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=mLEtmlUz6hZVA6fXnwvkYKBNcYM9OSQdb1inSxpcxXM=;
 b=tE6A2urPb9y7Z2zTvz/HxarrM/o4ap1AxJXnIkc0+ddnkRsakxFJZzhHkZnNNg+eReki+8HXW
 vHeztKC0u1WCoufFlWsZHsv8jnE29CedVNu5QNTeDGPRb8cCgqMJ+FJ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: 84DBA219E6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls: add file_attr05 test
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

Verify that `file_getattr` and `file_setattr` are correctly raising
EOPNOTSUPP when filesystem doesn't support them.

Regression test for "474b155adf39 - fs: make vfs_fileattr_[get|set]
return -EOPNOTSUPP".

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- use f4af1fb44161d719695c3ce1bcad61d6f3638ba8 as reference for block
  size
- Link to v1: https://lore.kernel.org/r/20251010-file_attr_eopnotsupp-v1-1-a93df1980ac7@suse.com
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/file_attr/.gitignore    |  1 +
 testcases/kernel/syscalls/file_attr/file_attr05.c | 64 +++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 4b284f279..b8a1988e1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -250,6 +250,7 @@ file_attr01 file_attr01
 file_attr02 file_attr02
 file_attr03 file_attr03
 file_attr04 file_attr04
+file_attr05 file_attr05
 
 #posix_fadvise test cases
 posix_fadvise01                      posix_fadvise01
diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
index 3fcb9004d..42f830a7e 100644
--- a/testcases/kernel/syscalls/file_attr/.gitignore
+++ b/testcases/kernel/syscalls/file_attr/.gitignore
@@ -2,3 +2,4 @@ file_attr01
 file_attr02
 file_attr03
 file_attr04
+file_attr05
diff --git a/testcases/kernel/syscalls/file_attr/file_attr05.c b/testcases/kernel/syscalls/file_attr/file_attr05.c
new file mode 100644
index 000000000..087d269a4
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/file_attr05.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that `file_getattr` and `file_setattr` are correctly raising
+ * EOPNOTSUPP when filesystem doesn't support them.
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
+static struct file_attr *attr_get;
+
+static void run(void)
+{
+	TST_EXP_FAIL(file_setattr(AT_FDCWD, FILEPATH,
+			   attr_set, FILE_ATTR_SIZE_LATEST, 0), EOPNOTSUPP);
+
+	TST_EXP_FAIL(file_getattr(AT_FDCWD, FILEPATH,
+			   attr_get, FILE_ATTR_SIZE_LATEST, 0), EOPNOTSUPP);
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
+	.filesystems = (struct tst_fs []) {
+		{.type = "vfat"},
+		{}
+	},
+	.bufs = (struct tst_buffers []) {
+		{&attr_set, .size = sizeof(struct file_attr)},
+		{&attr_get, .size = sizeof(struct file_attr)},
+		{}
+	}
+};

---
base-commit: cc420865c291c04c902957a6f3375c8017239e52
change-id: 20251010-file_attr_eopnotsupp-586cfb2c78d8

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
