Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139ACCAC5B0
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 06:50:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A83A3CE33C
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 08:50:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D90A93CE1B5
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 46356600850
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 08:47:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A1711F452;
 Tue,  7 Oct 2025 06:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yu7Xx0y3ulwlUyIZn5mX08gpbbX4O+AqgBjCWlrASDg=;
 b=dhWx3adc5ypdD16rYJ1IqBdI20k7QLxkp9Gp4YHBgflzDjFl+bnkf7MnfgDBmrDSeiPOsz
 runQMvgu647fzOUztbAimlEs2zWQWVAiug3ULPc2V3rGgGpJ6YjkedzoF4aFBtMfl1Zqcu
 PcT1UFaLFe8Cd7p8f5Mvi78ZZcBHeSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yu7Xx0y3ulwlUyIZn5mX08gpbbX4O+AqgBjCWlrASDg=;
 b=WVCyjUllzmqJtMQEEfIV+hvlIJm/JpZfDepibgY6UYb1D8QHFqFD1ti7HJun5GrYHaGSIH
 hn05NSjajWZ0HXBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759819638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yu7Xx0y3ulwlUyIZn5mX08gpbbX4O+AqgBjCWlrASDg=;
 b=dhWx3adc5ypdD16rYJ1IqBdI20k7QLxkp9Gp4YHBgflzDjFl+bnkf7MnfgDBmrDSeiPOsz
 runQMvgu647fzOUztbAimlEs2zWQWVAiug3ULPc2V3rGgGpJ6YjkedzoF4aFBtMfl1Zqcu
 PcT1UFaLFe8Cd7p8f5Mvi78ZZcBHeSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759819638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yu7Xx0y3ulwlUyIZn5mX08gpbbX4O+AqgBjCWlrASDg=;
 b=WVCyjUllzmqJtMQEEfIV+hvlIJm/JpZfDepibgY6UYb1D8QHFqFD1ti7HJun5GrYHaGSIH
 hn05NSjajWZ0HXBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A15C913AAC;
 Tue,  7 Oct 2025 06:47:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MAtGGnW35Gj1GgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 07 Oct 2025 06:47:17 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 07 Oct 2025 08:47:02 +0200
MIME-Version: 1.0
Message-Id: <20251007-xattrat-v2-10-bf458fa66358@suse.com>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
In-Reply-To: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759819626; l=3691;
 i=andrea.cervesato@suse.com; s=20250922; h=from:subject:message-id;
 bh=Us3bCmZjvBWr/V8P/hfsa6t9V52h7BCLzMmRW+LZYIs=;
 b=8fz6c2Ok4Ly1Qi2Jz+AxBwOL4lksUb7NnRQZ3wMYWr52zMQ0hpQNHI3XIwuQB0BsLdPxLoUN8
 0XnqAxF2ID7DjqCpq05YFjXoPmJedHajqMmX74pfeinZp8gT/m1Nqkp
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=+8M3XgViLdcdNBM+Jdd90m3pV4jCw2tNsGCy5Rd+qHk=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 10/10] Add setxattrat02 test
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

Test if setxattrat() syscall is correctly raising errors when giving
invalid inputs.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/setxattrat/.gitignore    |   1 +
 .../kernel/syscalls/setxattrat/setxattrat02.c      | 126 +++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/testcases/kernel/syscalls/setxattrat/.gitignore b/testcases/kernel/syscalls/setxattrat/.gitignore
index e636401d7..9d007a44d 100644
--- a/testcases/kernel/syscalls/setxattrat/.gitignore
+++ b/testcases/kernel/syscalls/setxattrat/.gitignore
@@ -1 +1,2 @@
 setxattrat01
+setxattrat02
diff --git a/testcases/kernel/syscalls/setxattrat/setxattrat02.c b/testcases/kernel/syscalls/setxattrat/setxattrat02.c
new file mode 100644
index 000000000..8092fef26
--- /dev/null
+++ b/testcases/kernel/syscalls/setxattrat/setxattrat02.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Test if setxattrat() syscall is correctly raising errors when giving invalid
+ * inputs.
+ */
+
+#include "tst_test.h"
+#include "lapi/xattr.h"
+#include "lapi/syscalls.h"
+
+#include <sys/xattr.h>
+
+#define FNAME "ltp_file"
+#define XATTR_TEST_KEY "trusted.ltptestkey"
+#define XATTR_TEST_VALUE "ltprulez"
+#define XATTR_TEST_VALUE_SIZE 8
+
+static struct xattr_args *args;
+static struct xattr_args *null_args;
+static int invalid_fd = -1;
+static int tmpdir_fd = -1;
+
+static struct tcase {
+	int *dfd;
+	int at_flags;
+	struct xattr_args **args;
+	size_t args_size;
+	int exp_errno;
+	char *reason;
+} tcases[] = {
+	{
+		.dfd = &invalid_fd,
+		.args = &args,
+		.args_size = sizeof(struct xattr_args),
+		.exp_errno = EBADF,
+		.reason = "Invalid directory file descriptor",
+	},
+	{
+		.dfd = &tmpdir_fd,
+		.at_flags = -1,
+		.args = &args,
+		.args_size = sizeof(struct xattr_args),
+		.exp_errno = EINVAL,
+		.reason = "Invalid AT flags",
+	},
+	{
+		.dfd = &tmpdir_fd,
+		.at_flags = AT_SYMLINK_NOFOLLOW + 1,
+		.args = &args,
+		.args_size = sizeof(struct xattr_args),
+		.exp_errno = EINVAL,
+		.reason = "Out of bound AT flags",
+	},
+	{
+		.dfd = &tmpdir_fd,
+		.args = &null_args,
+		.args_size = sizeof(struct xattr_args),
+		.exp_errno = EINVAL,
+		.reason = "Invalid arguments",
+	},
+	{
+		.dfd = &tmpdir_fd,
+		.args = &args,
+		.args_size = SIZE_MAX,
+		.exp_errno = E2BIG,
+		.reason = "Arguments size is too big",
+	},
+	{
+		.dfd = &tmpdir_fd,
+		.args = &args,
+		.args_size = sizeof(struct xattr_args) - 1,
+		.exp_errno = EINVAL,
+		.reason = "Invalid arguments size",
+	},
+};
+
+static void run(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	args->flags = XATTR_CREATE;
+	args->value = (uint64_t)XATTR_TEST_VALUE;
+	args->size = XATTR_TEST_VALUE_SIZE;
+
+	TST_EXP_FAIL(tst_syscall(__NR_setxattrat,
+		tc->dfd, FNAME, tc->at_flags, XATTR_TEST_KEY,
+		tc->args, tc->args_size),
+		tc->exp_errno, "%s", tc->reason);
+}
+
+static void setup(void)
+{
+	char *tmpdir;
+
+	tmpdir = tst_tmpdir_path();
+	tmpdir_fd = SAFE_OPEN(tmpdir, O_DIRECTORY);
+
+	SAFE_TOUCH(FNAME, 0777, NULL);
+}
+
+static void cleanup(void)
+{
+	if (tmpdir_fd != -1)
+		SAFE_CLOSE(tmpdir_fd);
+
+	SAFE_UNLINK(FNAME);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(struct xattr_args)},
+		{},
+	}
+};

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
