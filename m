Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A2D9C87FD1
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 13:05:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED88C3C324A
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 15:05:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84AC33C2EFA
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 15:03:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0C1441400BED
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 15:03:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 95E1C211A7;
 Tue,  5 Aug 2025 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754399002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2yX/Q7alf1TwWgLaBWC4vheJ4eaekpAhYCc079mBE8=;
 b=lrBeJY7GYqtFT+WlsxeLeWOK6bQ3C+MmifV5EOhsd42bcMW1D1GOLMytUMu4lj72ecxpFT
 OhwVjpD/PNNrfPFWc5qj6Ym93UVqmjkzW0kO+hdTYNqJ3QnWkFFwrAdzRf7fMZ9oppTuxm
 3a6kmuhIyQhmEGhae54UMpzO+gP0g00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754399002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2yX/Q7alf1TwWgLaBWC4vheJ4eaekpAhYCc079mBE8=;
 b=kq+ENz09Qs3GFqC7EmXor44vQ1hdWt0libcUzMl8vuVed+oMNW72sRljlLIgw+n+bJwUA0
 FUdMWkQMOwgWlQCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754399002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2yX/Q7alf1TwWgLaBWC4vheJ4eaekpAhYCc079mBE8=;
 b=lrBeJY7GYqtFT+WlsxeLeWOK6bQ3C+MmifV5EOhsd42bcMW1D1GOLMytUMu4lj72ecxpFT
 OhwVjpD/PNNrfPFWc5qj6Ym93UVqmjkzW0kO+hdTYNqJ3QnWkFFwrAdzRf7fMZ9oppTuxm
 3a6kmuhIyQhmEGhae54UMpzO+gP0g00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754399002;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H2yX/Q7alf1TwWgLaBWC4vheJ4eaekpAhYCc079mBE8=;
 b=kq+ENz09Qs3GFqC7EmXor44vQ1hdWt0libcUzMl8vuVed+oMNW72sRljlLIgw+n+bJwUA0
 FUdMWkQMOwgWlQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67C1013A50;
 Tue,  5 Aug 2025 13:03:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +OEZFhoBkmhpFAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 05 Aug 2025 13:03:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Aug 2025 15:03:18 +0200
MIME-Version: 1.0
Message-Id: <20250805-file_setattr_getattr-v4-5-08e23354abc8@suse.com>
References: <20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com>
In-Reply-To: <20250805-file_setattr_getattr-v4-0-08e23354abc8@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754399000; l=3849;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=RsmgnXCm5F19jZqMjvdaY4rpmPbQ+4NxE/20xEPJHIg=;
 b=2ECG7dDR/PZWDFSI8k0bqQIHcZKZjW6huAX6PYeKHt+rftvxw7swgloRIQxIV2o6fOYTvfHdg
 gKsEp1mcP0vAlGQ1V1DziNqKUKJn6O4WcZvV0J4bcsCZPfKJR90x8IC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 5/7] Add file_attr02 test
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

Verify that `file_getattr` is correctly reading filesystems additional
attributes. We are running test on XFS only, since it's the only filesystem
currently implementing the features we need.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/file_attr/.gitignore    |  1 +
 testcases/kernel/syscalls/file_attr/file_attr02.c | 92 +++++++++++++++++++++++
 3 files changed, 94 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index fed17a38baf0586ec886876b58c04158fa11e8e0..b69e474a6a596359bb1ace30312b55d6bf2b65cc 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -247,6 +247,7 @@ fsetxattr01 fsetxattr01
 fsetxattr02 fsetxattr02
 
 file_attr01 file_attr01
+file_attr02 file_attr02
 
 #posix_fadvise test cases
 posix_fadvise01                      posix_fadvise01
diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
index de06f204d34be482a6401f2a5e7931caa5e3ab12..afe9c2fc9a4218dc032f044c1d317355a784a525 100644
--- a/testcases/kernel/syscalls/file_attr/.gitignore
+++ b/testcases/kernel/syscalls/file_attr/.gitignore
@@ -1 +1,2 @@
 file_attr01
+file_attr02
diff --git a/testcases/kernel/syscalls/file_attr/file_attr02.c b/testcases/kernel/syscalls/file_attr/file_attr02.c
new file mode 100644
index 0000000000000000000000000000000000000000..4e0d87f0f3edc946bf9cd14e76cce9518bf928d0
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/file_attr02.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that `file_getattr` is correctly reading filesystems additional
+ * attributes. We are running test on XFS only, since it's the only filesystem
+ * currently implementing the features we need.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "mntpoint"
+#define FILENAME "ltp_file"
+#define BLOCKS 1024
+#define PROJID 16
+
+static int fd = -1;
+static int dfd = -1;
+static struct fsxattr xattr;
+static struct file_attr *attr;
+
+static void run(void)
+{
+	memset(attr, 0, sizeof(*attr));
+
+	TST_EXP_PASS(file_getattr(
+		dfd, FILENAME,
+		attr, FILE_ATTR_SIZE_LATEST,
+		0));
+
+	TST_EXP_EQ_LI(attr->fa_xflags, xattr.fsx_xflags);
+	TST_EXP_EQ_LI(attr->fa_extsize, xattr.fsx_extsize);
+	TST_EXP_EQ_LI(attr->fa_cowextsize, xattr.fsx_cowextsize);
+	TST_EXP_EQ_LI(attr->fa_nextents, xattr.fsx_nextents);
+	TST_EXP_EQ_LI(attr->fa_projid, PROJID);
+	TST_EXP_EQ_LI(attr->fa_projid, xattr.fsx_projid);
+}
+
+static void setup(void)
+{
+	int block_size;
+
+	block_size = tst_dev_block_size(MNTPOINT);
+
+	dfd = SAFE_OPEN(MNTPOINT, O_RDONLY);
+	fd = SAFE_CREAT(MNTPOINT "/" FILENAME, 0777);
+
+	SAFE_IOCTL(fd, FS_IOC_FSGETXATTR, &xattr);
+
+	xattr.fsx_xflags |= FS_XFLAG_EXTSIZE;
+	xattr.fsx_xflags |= FS_XFLAG_COWEXTSIZE;
+	xattr.fsx_extsize = BLOCKS * block_size;
+	xattr.fsx_cowextsize = BLOCKS * block_size;
+	xattr.fsx_projid = PROJID;
+
+	SAFE_IOCTL(fd, FS_IOC_FSSETXATTR, &xattr);
+
+	/* this will force at least one extent to be allocated */
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, "a", 1);
+
+	SAFE_IOCTL(fd, FS_IOC_FSGETXATTR, &xattr);
+	SAFE_CLOSE(fd);
+}
+
+static void cleanup(void)
+{
+	if (fd != -1)
+		SAFE_CLOSE(fd);
+
+	if (dfd != -1)
+		SAFE_CLOSE(dfd);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.mntpoint = MNTPOINT,
+	.needs_root = 1,
+	.mount_device = 1,
+	.filesystems = (struct tst_fs []) {
+		{.type = "xfs"},
+		{}
+	},
+	.bufs = (struct tst_buffers []) {
+		{&attr, .size = sizeof(struct file_attr)},
+		{}
+	}
+};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
