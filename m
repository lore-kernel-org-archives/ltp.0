Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54539CCD185
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 10:48:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B7D813CE9DA
	for <ltp@archiver.kernel.org>; Fri, 10 Oct 2025 12:48:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F241E3CE8B3
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 12:48:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7BA51200089
 for <ltp@lists.linux.it>; Fri, 10 Oct 2025 12:48:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8F0D21959;
 Fri, 10 Oct 2025 10:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760093295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rPbZt9rVOeUbF27AdfMyBG1A4tba1TGcq5PCrB3FlQA=;
 b=owf2Mhreasvm0VHECzfGwPV7cKKwAMZpLrKSARgAvz6iC56Sw5XSBs+TbljlYKLFQH/fZN
 n7IVaKL3iwStqwalhNnwBiIiABAf1mKyE8W3l6YRrh3yXxlE5F0fXPbkgmayI92xVwubhg
 ghkZFGpV7dlPPwrVn+NtiIS/zuPvo+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760093295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rPbZt9rVOeUbF27AdfMyBG1A4tba1TGcq5PCrB3FlQA=;
 b=VGjDnE9QYYL6hSRuWycHJwrzpA+E49J7kIxKC+LydjsBYdtctFrXFvozcXvoWnL7+aVqrq
 yD5ZaolNOw4aV9BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=owf2Mhre;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VGjDnE9Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1760093295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rPbZt9rVOeUbF27AdfMyBG1A4tba1TGcq5PCrB3FlQA=;
 b=owf2Mhreasvm0VHECzfGwPV7cKKwAMZpLrKSARgAvz6iC56Sw5XSBs+TbljlYKLFQH/fZN
 n7IVaKL3iwStqwalhNnwBiIiABAf1mKyE8W3l6YRrh3yXxlE5F0fXPbkgmayI92xVwubhg
 ghkZFGpV7dlPPwrVn+NtiIS/zuPvo+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1760093295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rPbZt9rVOeUbF27AdfMyBG1A4tba1TGcq5PCrB3FlQA=;
 b=VGjDnE9QYYL6hSRuWycHJwrzpA+E49J7kIxKC+LydjsBYdtctFrXFvozcXvoWnL7+aVqrq
 yD5ZaolNOw4aV9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F93C13A40;
 Fri, 10 Oct 2025 10:48:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q/eZIW/k6GjaQAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 10 Oct 2025 10:48:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 10 Oct 2025 12:47:29 +0200
MIME-Version: 1.0
Message-Id: <20251010-file_attr_eopnotsupp-v1-1-a93df1980ac7@suse.com>
X-B4-Tracking: v=1; b=H4sIAEHk6GgC/x3MQQqAIBBA0avErBNUqKSrRIjZWAOhohZBdPek5
 Vv8/0DGRJhhbB5IeFGm4CtE24Ddjd+Q0VoNkstOcMGZowO1KSVpDNGHks8YWad66xZpB7UqqGl
 M6Oj+t9P8vh/TJI9BZgAAAA==
X-Change-ID: 20251010-file_attr_eopnotsupp-586cfb2c78d8
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760093295; l=3284;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=HWMKLg2TOHSwDYtD0SjGT6GHSktQ3M8AYuLG6Fq/0OY=;
 b=mC/IHF9qoVyKXsNC9tHZCKK96/sSUW5X/iPNhpSrvmvhMtlebvOqS0sjjPYDENQ0L0+OZ21C0
 NDeoyiBXDPgAX3YDkkHcQYaEQUrw47FCTPFek6F1+RikEdt8TTdIH7A
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
X-Rspamd-Queue-Id: A8F0D21959
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:mid, suse.com:email]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls: add file_attr05 test
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
index 000000000..127ca35ae
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
+#define BLOCKS 1024
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
+	int block_size;
+
+	SAFE_TOUCH(FILEPATH, 0777, NULL);
+
+	block_size = tst_dev_block_size(MNTPOINT);
+
+	attr_set->fa_xflags |= FS_XFLAG_EXTSIZE;
+	attr_set->fa_xflags |= FS_XFLAG_COWEXTSIZE;
+	attr_set->fa_extsize = BLOCKS * block_size;
+	attr_set->fa_cowextsize = BLOCKS * block_size;
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
base-commit: d2550ffbbcfe163212cd7e9c132db65ae0fa06ed
change-id: 20251010-file_attr_eopnotsupp-586cfb2c78d8

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
