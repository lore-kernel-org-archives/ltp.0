Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1CBC25B78
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 07:16:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F3733D06F4
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 09:16:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69CE13D0185
 for <ltp@lists.linux.it>; Thu, 30 May 2024 09:15:53 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 36C0C100C1F2
 for <ltp@lists.linux.it>; Thu, 30 May 2024 09:15:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0582320721;
 Thu, 30 May 2024 07:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717053351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kuni52Xz/iT72yH2mbxDDOGQDII4zEKCuDLTWyPFKY0=;
 b=rDRM1KADnb6jKaDbDr6rN/8fF1SwTraldpNPhUO+k2Yf7tn2ZwXsibNQeDE3KKVSNhCSAY
 p2qp+SJcq/t1E3Vs2YYxTsCzLAGXTv625vmpFrtLru5f+2JpsYqK8r+VVQOBYKkvLR1jj4
 vl3OQuW6KLasXwXYxN7LR31qs/0ANIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717053351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kuni52Xz/iT72yH2mbxDDOGQDII4zEKCuDLTWyPFKY0=;
 b=GCMaB4yzZy1D9zf97kTQpffIOoLdjjlSK7mGGzto6k/n4gltTldSglvs/z0Rq+cQewPCY0
 GAezAz1FOAGQCRCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rDRM1KAD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GCMaB4yz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717053351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kuni52Xz/iT72yH2mbxDDOGQDII4zEKCuDLTWyPFKY0=;
 b=rDRM1KADnb6jKaDbDr6rN/8fF1SwTraldpNPhUO+k2Yf7tn2ZwXsibNQeDE3KKVSNhCSAY
 p2qp+SJcq/t1E3Vs2YYxTsCzLAGXTv625vmpFrtLru5f+2JpsYqK8r+VVQOBYKkvLR1jj4
 vl3OQuW6KLasXwXYxN7LR31qs/0ANIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717053351;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kuni52Xz/iT72yH2mbxDDOGQDII4zEKCuDLTWyPFKY0=;
 b=GCMaB4yzZy1D9zf97kTQpffIOoLdjjlSK7mGGzto6k/n4gltTldSglvs/z0Rq+cQewPCY0
 GAezAz1FOAGQCRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4BAE13A8F;
 Thu, 30 May 2024 07:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mNyVNqYnWGYfdwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 May 2024 07:15:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 May 2024 09:15:22 +0200
MIME-Version: 1.0
Message-Id: <20240530-ioctl_ficlone-v1-3-fa96f07d0fca@suse.com>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
In-Reply-To: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3844;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=I+OEZb+Z+o28gbfP/N8MJiXWrtzAZ1owx0+2Nip5b1Q=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmWCemkyEdiv1gNT/q1+KU6QCogIjYLP1TpvW8A
 z5nWlozkeKJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZlgnpgAKCRDLzBqyILPm
 Rh3MC/45zFtNi4gNr6LD/iQFpqjpc+uaRvILupxAUO97vcc5cUsjjw9s5/JttAnzdengd1UjJZA
 3BnP5/Iw3tSqgxwxwMo6sWXR7nAgiNM0uRwL/xsKYPSb9iXORcGnSpws2t8qv6YJJmruXvqDvji
 EYdr6OPp5yIxW4YOnj/itGBieao3xdl16vTqvYJ1PPUTnWVGnpaIG/FGzhLr9op+XB6J9BVhqDH
 2AEqT3dRz8qBlLS/75nO2YZOzu9c51tVCoU8Dln24c1USuwJT09sQVGSNsPf9oNuTuzVKXzWN8b
 jFe6Ag+8WGHvOSeS8tbIBfQ0XkSNNP65glWLw8j5Gb9VQ4qCBXLEFPkl9sFoIbGWZeCJcIvomYe
 YH1yWBoR1X4pyOhcTHxUoU/DlHrUZF2Mc+lIGLHjaQwP5Z7j2Gjd5u6OA1pJeOd1oN0Uv8neU5y
 gCgmukCSTu2M6oYUt8eW8mTZ8J8xZUK2YC1qgfw9DjNUAhwYS4BK8x2FtjNhpq5VrTucs=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0582320721
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] Add ioctl_ficlone03 test
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

This test verifies that ioctl() FICLONE feature correctly raises
exceptions when it's supposed to.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |  1 +
 testcases/kernel/syscalls/ioctl/.gitignore        |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c | 96 +++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index b049530d3..452a7a071 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -593,6 +593,7 @@ ioctl_sg01 ioctl_sg01
 
 ioctl_ficlone01 ioctl_ficlone01
 ioctl_ficlone02 ioctl_ficlone02
+ioctl_ficlone03 ioctl_ficlone03
 
 inotify_init1_01 inotify_init1_01
 inotify_init1_02 inotify_init1_02
diff --git a/testcases/kernel/syscalls/ioctl/.gitignore b/testcases/kernel/syscalls/ioctl/.gitignore
index 3d25fdfb2..d0b470714 100644
--- a/testcases/kernel/syscalls/ioctl/.gitignore
+++ b/testcases/kernel/syscalls/ioctl/.gitignore
@@ -24,3 +24,4 @@
 /ioctl_sg01
 /ioctl_ficlone01
 /ioctl_ficlone02
+/ioctl_ficlone03
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
new file mode 100644
index 000000000..c6f9806a3
--- /dev/null
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
+ */
+
+/*\
+ * [Description]
+ *
+ * This test verifies that ioctl() FICLONE feature correctly raises exceptions
+ * when it's supposed to.
+ */
+
+#include "tst_test.h"
+#include "lapi/fs.h"
+
+#define MNTPOINT "mnt"
+
+static int invalid_fd = -1;
+static int rw_file = -1;
+static int ro_file = -1;
+static int wo_file = -1;
+static int dir_fd = -1;
+static int immut_fd = -1;
+static int mnt_file = -1;
+
+static struct tcase {
+	int *src_fd;
+	int *dst_fd;
+	int errno_exp;
+	char *msg;
+} tcases[] = {
+	{&invalid_fd, &rw_file, EBADF, "invalid source"},
+	{&rw_file, &invalid_fd, EBADF, "invalid destination"},
+	{&rw_file, &ro_file, EBADF, "read-only destination"},
+	{&wo_file, &rw_file, EBADF, "write-only source"},
+	{&rw_file, &dir_fd, EISDIR, "source is a directory"},
+	{&dir_fd, &rw_file, EISDIR, "destination is a directory"},
+	{&rw_file, &immut_fd, EPERM, "destination is immutable"},
+	{&rw_file, &mnt_file, EXDEV, "destination is on a different mount"},
+	{&mnt_file, &rw_file, EXDEV, "source is on a different mount"},
+};
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	TST_EXP_FAIL(ioctl(*tc->dst_fd, FICLONE, *tc->src_fd),
+		tc->errno_exp,
+		"%s", tc->msg);
+}
+
+static void setup(void)
+{
+	int attr;
+
+	rw_file = SAFE_OPEN("ok_only", O_CREAT | O_RDWR, 0640);
+	ro_file = SAFE_OPEN("rd_only", O_CREAT | O_RDONLY, 0640);
+	wo_file = SAFE_OPEN("rw_only", O_CREAT | O_WRONLY, 0640);
+
+	SAFE_MKDIR("mydir", 0640);
+	dir_fd = SAFE_OPEN("mydir", O_DIRECTORY, 0640);
+
+	attr = FS_IMMUTABLE_FL;
+	immut_fd = SAFE_OPEN("immutable", O_CREAT | O_RDWR, 0640);
+	SAFE_IOCTL(immut_fd, FS_IOC_SETFLAGS, &attr);
+
+	mnt_file = SAFE_OPEN(MNTPOINT"/file", O_CREAT | O_RDWR, 0640);
+}
+
+static void cleanup(void)
+{
+	int attr;
+
+	SAFE_IOCTL(immut_fd, FS_IOC_GETFLAGS, &attr);
+	attr &= ~FS_IMMUTABLE_FL;
+	SAFE_IOCTL(immut_fd, FS_IOC_SETFLAGS, &attr);
+	SAFE_CLOSE(immut_fd);
+
+	SAFE_CLOSE(rw_file);
+	SAFE_CLOSE(ro_file);
+	SAFE_CLOSE(wo_file);
+	SAFE_CLOSE(dir_fd);
+	SAFE_CLOSE(mnt_file);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "4.5",
+	.needs_root = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
+	.dev_fs_type = "btrfs",
+};

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
