Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E5DC87FCB
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 18:11:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59BE83CCFEB
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 20:11:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6793B3CCFF9
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:09:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C56DC20093A
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 20:09:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9091D21A84;
 Mon,  4 Aug 2025 18:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754330968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jos8lbi/GbQ7/xHvShBEl/dnkYXiLy80forz9XQDal4=;
 b=qf8QfeCsxJvLWTfKmmuwlJfcxhOLHZat+SKFHLZJCKtp41S6ym+3fy98DKy37zgBQMKMAo
 o6Nt55UJoFqj17IVsyjaxEFW61E8d8NGzT9EfKmI+bhXRmVuM0HFCGx2YJlvmWe3Xh3qp9
 S9xpRUoBZg6sOp2BQljUZTlA254hURI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754330968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jos8lbi/GbQ7/xHvShBEl/dnkYXiLy80forz9XQDal4=;
 b=n8NWu6IEzeMiRAIvS/HzQHXYlmTgDTD/uCnAlBew5h/kIJIRnlXBGTIUk7X+jwZOqEKllW
 iBRZAjVSUOKUCiBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qf8QfeCs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n8NWu6IE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754330968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jos8lbi/GbQ7/xHvShBEl/dnkYXiLy80forz9XQDal4=;
 b=qf8QfeCsxJvLWTfKmmuwlJfcxhOLHZat+SKFHLZJCKtp41S6ym+3fy98DKy37zgBQMKMAo
 o6Nt55UJoFqj17IVsyjaxEFW61E8d8NGzT9EfKmI+bhXRmVuM0HFCGx2YJlvmWe3Xh3qp9
 S9xpRUoBZg6sOp2BQljUZTlA254hURI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754330968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jos8lbi/GbQ7/xHvShBEl/dnkYXiLy80forz9XQDal4=;
 b=n8NWu6IEzeMiRAIvS/HzQHXYlmTgDTD/uCnAlBew5h/kIJIRnlXBGTIUk7X+jwZOqEKllW
 iBRZAjVSUOKUCiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68D43133D1;
 Mon,  4 Aug 2025 18:09:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aOTYFlj3kGjyJgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 Aug 2025 18:09:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 Aug 2025 20:09:22 +0200
MIME-Version: 1.0
Message-Id: <20250804-file_setattr_getattr-v1-4-6a43c3962c87@suse.com>
References: <20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com>
In-Reply-To: <20250804-file_setattr_getattr-v1-0-6a43c3962c87@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754330967; l=6431;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=mzYa9rjkwHSHpQgnOEmYqjpQQTbtaCeBtwCXylyx7r8=;
 b=UF2yGTk8Po+AgEdVO4PigOX/VGq75v0t1dhKp6TA5TlaPA9hQg8r66JQWjm/Ys8NGthkCEdhk
 jORwygo4ZCbBh68Zo1O0DYCnF/WnpAIHbdi4ZNUD1eD1P76mmXG26gw
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 9091D21A84
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/6] Add file_attr01 test
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

Verify that `file_getattr` and `file_setattr` syscalls are raising the
correct errors according to the invalid input arguments. In particular:

- EBADFD: Invalid file descriptor.
- ENOENT: File doesn't exist
- EFAULT: File name is NULL
- EFAULT: File attributes is NULL
- EINVAL: File attributes size is zero
- E2BIG: File attributes size is too big
- EINVAL: Invalid AT flags

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 runtest/syscalls                                  |   2 +
 testcases/kernel/syscalls/file_attr/.gitignore    |   1 +
 testcases/kernel/syscalls/file_attr/Makefile      |   8 +
 testcases/kernel/syscalls/file_attr/file_attr01.c | 171 ++++++++++++++++++++++
 4 files changed, 182 insertions(+)

diff --git a/runtest/syscalls b/runtest/syscalls
index 6a17a34f8b5fc1289947d4504b7a146f3d022f1c..fed17a38baf0586ec886876b58c04158fa11e8e0 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -246,6 +246,8 @@ fallocate06 fallocate06
 fsetxattr01 fsetxattr01
 fsetxattr02 fsetxattr02
 
+file_attr01 file_attr01
+
 #posix_fadvise test cases
 posix_fadvise01                      posix_fadvise01
 posix_fadvise01_64                posix_fadvise01_64
diff --git a/testcases/kernel/syscalls/file_attr/.gitignore b/testcases/kernel/syscalls/file_attr/.gitignore
new file mode 100644
index 0000000000000000000000000000000000000000..de06f204d34be482a6401f2a5e7931caa5e3ab12
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/.gitignore
@@ -0,0 +1 @@
+file_attr01
diff --git a/testcases/kernel/syscalls/file_attr/Makefile b/testcases/kernel/syscalls/file_attr/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..3b19b0ce6be00839038c405eea027b0102761e45
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/Makefile
@@ -0,0 +1,8 @@
+# Copyright (c) 2025 - Linaro Limited. All rights reserved.
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/file_attr/file_attr01.c b/testcases/kernel/syscalls/file_attr/file_attr01.c
new file mode 100644
index 0000000000000000000000000000000000000000..597ce31fbb11c47754a264eba394be3c233c8663
--- /dev/null
+++ b/testcases/kernel/syscalls/file_attr/file_attr01.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * Verify that `file_getattr` and `file_setattr` syscalls are raising the
+ * correct errors according to the invalid input arguments. In particular:
+ *
+ * - EBADFD: Invalid file descriptor.
+ * - ENOENT: File doesn't exist
+ * - EFAULT: File name is NULL
+ * - EFAULT: File attributes is NULL
+ * - EINVAL: File attributes size is zero
+ * - E2BIG: File attributes size is too big
+ * - EINVAL: Invalid AT flags
+ */
+
+#include <string.h>
+#include "tst_test.h"
+#include "lapi/fs.h"
+#include "lapi/fcntl.h"
+
+#define MNTPOINT "mntpoint"
+#define FILENAME "ltp_file"
+#define NO_FILENAME "ltp_file_doesnt_exist"
+
+static int valid_dfd = -1;
+static int invalid_dfd = -1;
+static char *valid_filename;
+static char *invalid_filename;
+static char *null_ptr;
+static size_t zero;
+static size_t valid_usize;
+static size_t big_usize;
+static struct file_attr *valid_file_attr;
+
+static struct tcase {
+	int *dfd;
+	char **filename;
+	struct file_attr **ufattr;
+	size_t *usize;
+	int at_flags;
+	int exp_errno;
+	char *msg;
+} tcases[] = {
+	{
+		.dfd = &invalid_dfd,
+		.filename = &valid_filename,
+		.ufattr = &valid_file_attr,
+		.usize = &valid_usize,
+		.exp_errno = EBADF,
+		.msg = "Invalid file descriptor",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &invalid_filename,
+		.ufattr = &valid_file_attr,
+		.usize = &valid_usize,
+		.exp_errno = ENOENT,
+		.msg = "File doesn't exist",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &null_ptr,
+		.ufattr = &valid_file_attr,
+		.usize = &valid_usize,
+		.exp_errno = EFAULT,
+		.msg = "Filename is NULL",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &valid_filename,
+		.ufattr = (struct file_attr **)(&null_ptr),
+		.usize = &valid_usize,
+		.exp_errno = EFAULT,
+		.msg = "File attributes is NULL",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &valid_filename,
+		.ufattr = &valid_file_attr,
+		.usize = &zero,
+		.exp_errno = EINVAL,
+		.msg = "File attributes size is zero",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &valid_filename,
+		.ufattr = &valid_file_attr,
+		.usize = &big_usize,
+		.exp_errno = E2BIG,
+		.msg = "File attributes size is too big",
+	},
+	{
+		.dfd = &valid_dfd,
+		.filename = &valid_filename,
+		.ufattr = &valid_file_attr,
+		.usize = &valid_usize,
+		.at_flags = -1,
+		.exp_errno = EINVAL,
+		.msg = "Invalid AT flags",
+	},
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	if (tst_variant) {
+		TST_EXP_FAIL(file_getattr(
+			*tc->dfd, *tc->filename,
+			*tc->ufattr, *tc->usize,
+			tc->at_flags),
+			tc->exp_errno,
+			"%s", tc->msg);
+	} else {
+		TST_EXP_FAIL(file_setattr(
+			*tc->dfd, *tc->filename,
+			*tc->ufattr, *tc->usize,
+			tc->at_flags),
+			tc->exp_errno,
+			"%s", tc->msg);
+	}
+}
+
+static void setup(void)
+{
+	valid_dfd = SAFE_OPEN(MNTPOINT, O_RDONLY);
+
+	SAFE_CHDIR(MNTPOINT);
+	SAFE_TOUCH(FILENAME, 0777, NULL);
+	SAFE_CHDIR("..");
+
+	memcpy(valid_filename, FILENAME, strlen(FILENAME));
+	memcpy(invalid_filename, NO_FILENAME, strlen(NO_FILENAME));
+
+	valid_usize = FILE_ATTR_SIZE_LATEST;
+	big_usize = sysconf(_SC_PAGESIZE) + 100;
+}
+
+static void cleanup(void)
+{
+	if (valid_dfd != -1)
+		SAFE_CLOSE(valid_dfd);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.mntpoint = MNTPOINT,
+	.needs_root = 1,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.test_variants = 2,
+	.skip_filesystems = (const char *const []) {
+		"fuse",
+		"ntfs",
+		"vfat",
+		"exfat",
+		NULL
+	},
+	.bufs = (struct tst_buffers []) {
+		{&valid_filename, .size = 32},
+		{&invalid_filename, .size = 32},
+		{&valid_file_attr, .size = sizeof(struct file_attr)},
+		{}
+	}
+};

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
