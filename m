Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFCEC4332F
	for <ltp@archiver.kernel.org>; Fri, 10 Nov 2023 11:58:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDE623CE75A
	for <ltp@archiver.kernel.org>; Fri, 10 Nov 2023 12:58:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50E7F3C9792
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 12:58:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8EC7B1402E34
 for <ltp@lists.linux.it>; Fri, 10 Nov 2023 12:58:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 87BD7219C1;
 Fri, 10 Nov 2023 11:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1699617523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=o7ivBlbw4+9/0teC3zvVLaoINUaT61HXDuyUJEmq+Ck=;
 b=G41afYBOizrx7gEwsT9l8GWBN8gSWBd7FNrzb+Y7bLNnhocyqTtWhOHXDl4l1sYT7Hpoqb
 t09x+GAktdOO4Lql9z7smVkg45VYrnrfqao0s/3ZzNowQmo9e0FViSZHpZafm/ualAUR0Z
 fMgK04VwfjWZN1hfzASYy/ww9KUbz9E=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE9A313398;
 Fri, 10 Nov 2023 11:58:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BnjtHfIaTmWsDwAAMHmgww
 (envelope-from <wegao@suse.com>); Fri, 10 Nov 2023 11:58:42 +0000
To: ltp@lists.linux.it
Date: Fri, 10 Nov 2023 06:58:30 -0500
Message-Id: <20231110115830.19664-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] io_submit05.c: Add test case for RWF_APPEND flag
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/io_submit/.gitignore      |   1 +
 .../kernel/syscalls/io_submit/io_submit05.c   | 123 ++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_submit/io_submit05.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c7a0b2301..15a54f2d3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -656,6 +656,7 @@ io_setup02 io_setup02
 io_submit01 io_submit01
 io_submit02 io_submit02
 io_submit03 io_submit03
+io_submit05 io_submit05
 
 keyctl01 keyctl01
 keyctl02 keyctl02
diff --git a/testcases/kernel/syscalls/io_submit/.gitignore b/testcases/kernel/syscalls/io_submit/.gitignore
index 60b07970a..cf0d4c6df 100644
--- a/testcases/kernel/syscalls/io_submit/.gitignore
+++ b/testcases/kernel/syscalls/io_submit/.gitignore
@@ -1,3 +1,4 @@
 /io_submit01
 /io_submit02
 /io_submit03
+/io_submit05
diff --git a/testcases/kernel/syscalls/io_submit/io_submit05.c b/testcases/kernel/syscalls/io_submit/io_submit05.c
new file mode 100644
index 000000000..32f4379e1
--- /dev/null
+++ b/testcases/kernel/syscalls/io_submit/io_submit05.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * This is a basic test for io_submit RWF_APPEND flag.
+ *
+ */
+
+#include <linux/aio_abi.h>
+
+#include "config.h"
+#include "tst_test.h"
+#include "tst_safe_pthread.h"
+#include "lapi/syscalls.h"
+
+#define TEST_FILE "test_file"
+#define MODE 0777
+#define BUF_LEN 10
+#define MNTPOINT "mntpoint"
+
+static char *init_buf;
+static char *update_buf;
+static char *tmp_buf;
+static int fd;
+static aio_context_t ctx;
+static struct iocb iocb;
+static struct iocb *iocbs[] = {&iocb};
+static volatile int stop;
+
+static inline void io_prep_option(struct iocb *cb, int fd, void *buf,
+			size_t count, long long offset, unsigned int opcode)
+{
+	memset(cb, 0, sizeof(*cb));
+	cb->aio_fildes = fd;
+	cb->aio_lio_opcode = opcode;
+	cb->aio_buf = (uint64_t)buf;
+	cb->aio_offset = offset;
+	cb->aio_nbytes = count;
+	cb->aio_rw_flags = RWF_APPEND;
+}
+
+static unsigned int io_submit(void)
+{
+	struct io_event evbuf;
+	struct timespec timeout = { .tv_sec = 1 };
+
+	TST_EXP_VAL_SILENT(tst_syscall(__NR_io_submit, ctx, 1, iocbs), 1);
+	TST_EXP_VAL_SILENT(tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf,
+			&timeout), 1);
+}
+
+static void setup(void)
+{
+
+	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, MODE);
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+
+	memset(init_buf, 0x62, BUF_LEN);
+	memset(update_buf, 0x61, BUF_LEN);
+	memset(tmp_buf, 0, BUF_LEN);
+
+	io_prep_option(&iocb, fd, update_buf, BUF_LEN, 1, IOCB_CMD_PWRITE);
+}
+
+static void cleanup(void)
+{
+	if (fd > 0)
+		SAFE_CLOSE(fd);
+
+	if (tst_syscall(__NR_io_destroy, ctx))
+		tst_brk(TBROK | TERRNO, "io_destroy() failed");
+}
+
+
+static void run(void)
+{
+	int i;
+
+	SAFE_WRITE(0, fd, init_buf, BUF_LEN);
+	io_submit();
+	SAFE_LSEEK(fd, BUF_LEN, SEEK_SET);
+	SAFE_READ(1, fd, tmp_buf, BUF_LEN);
+	for (i = 0; i < BUF_LEN; i++) {
+		if (tmp_buf[i] != 0x61)
+			break;
+	}
+
+	if (i != BUF_LEN) {
+		tst_res(TFAIL, "buffer wrong at %i have %c expected 'a'",
+				i, tmp_buf[i]);
+		return;
+	}
+
+	tst_res(TPASS, "io_submit wrote %zi bytes successfully "
+			"with content 'a' expectedly ", BUF_LEN);
+}
+
+static struct tst_test test = {
+	.needs_tmpdir = 1,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_AIO=y",
+		NULL
+	},
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.max_runtime = 60,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.all_filesystems = 1,
+	.bufs = (struct tst_buffers []) {
+		{&init_buf, .size = BUF_LEN},
+		{&update_buf, .size = BUF_LEN},
+		{&tmp_buf, .size = BUF_LEN},
+		{}
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
