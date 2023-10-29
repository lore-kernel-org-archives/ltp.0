Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045B6C4332F
	for <ltp@archiver.kernel.org>; Sun, 29 Oct 2023 01:28:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB1AE3CBF43
	for <ltp@archiver.kernel.org>; Sun, 29 Oct 2023 02:28:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 514F63C8683
 for <ltp@lists.linux.it>; Sun, 29 Oct 2023 02:28:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7F3352009A2
 for <ltp@lists.linux.it>; Sun, 29 Oct 2023 02:28:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 28B5721B4F;
 Sun, 29 Oct 2023 01:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1698542881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oWVaCVS2fT9ab9d8WIN6d78BozwwabS0Qr0vzsD/ic4=;
 b=HjN/6vRKRgXL4zOeWxx0aqo4Sp2ThKFJcCYKnjxb6nnAZq6uWZhGGYZcvyNKGHQsoQFVyZ
 WoHiD6F0HqniU1aadDYgQGhDU47/pFXXpQHFlakgfS3ar7jEvCaONBLpTXJc7MXEFd2jZG
 Y5bi2v8rgKn1VcFqCAhPETSsYAhtT9U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C3691358C;
 Sun, 29 Oct 2023 01:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6qA1FCC1PWXjaAAAMHmgww
 (envelope-from <wegao@suse.com>); Sun, 29 Oct 2023 01:28:00 +0000
To: ltp@lists.linux.it
Date: Sat, 28 Oct 2023 21:27:55 -0400
Message-Id: <20231029012755.19969-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] io_submit04: Add test case for RWF_NOWAIT flag
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

Fixs: #467

Signed-off-by: Wei Gao <wegao@suse.com>
---
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/io_submit/.gitignore      |   1 +
 testcases/kernel/syscalls/io_submit/Makefile  |   1 +
 .../kernel/syscalls/io_submit/io_submit04.c   | 178 ++++++++++++++++++
 4 files changed, 181 insertions(+)
 create mode 100644 testcases/kernel/syscalls/io_submit/io_submit04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index c7a0b2301..5e7fa0403 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -656,6 +656,7 @@ io_setup02 io_setup02
 io_submit01 io_submit01
 io_submit02 io_submit02
 io_submit03 io_submit03
+io_submit04 io_submit04
 
 keyctl01 keyctl01
 keyctl02 keyctl02
diff --git a/testcases/kernel/syscalls/io_submit/.gitignore b/testcases/kernel/syscalls/io_submit/.gitignore
index 60b07970a..abe962e1c 100644
--- a/testcases/kernel/syscalls/io_submit/.gitignore
+++ b/testcases/kernel/syscalls/io_submit/.gitignore
@@ -1,3 +1,4 @@
 /io_submit01
 /io_submit02
 /io_submit03
+/io_submit04
diff --git a/testcases/kernel/syscalls/io_submit/Makefile b/testcases/kernel/syscalls/io_submit/Makefile
index ce4f13b72..c29d2060c 100644
--- a/testcases/kernel/syscalls/io_submit/Makefile
+++ b/testcases/kernel/syscalls/io_submit/Makefile
@@ -6,5 +6,6 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 LDLIBS			+= $(AIO_LIBS)
+LDFLAGS			+= -pthread
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/io_submit/io_submit04.c b/testcases/kernel/syscalls/io_submit/io_submit04.c
new file mode 100644
index 000000000..9622ff796
--- /dev/null
+++ b/testcases/kernel/syscalls/io_submit/io_submit04.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Similarily to the preadv2, this is a basic test for io_submit
+ * RWF_NOWAIT flag, we are attempting to force io_submit return
+ * EAGAIN with thread concurently running threads.
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
+#define BUF_LEN 1000000
+#define MNTPOINT "mntpoint"
+
+static char *w_buf;
+static char *r_buf;
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
+	cb->aio_buf = (uint64_t)r_buf;
+	cb->aio_offset = offset;
+	cb->aio_nbytes = count;
+	cb->aio_rw_flags = RWF_NOWAIT;
+}
+
+static void write_test(void)
+{
+	SAFE_LSEEK(fd, 0, SEEK_SET);
+	SAFE_WRITE(SAFE_WRITE_ALL, fd, r_buf, BUF_LEN);
+}
+
+static void *writer_thread(void *unused)
+{
+	while (!stop)
+		write_test();
+
+	return unused;
+}
+
+static void drop_caches(void)
+{
+	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
+}
+
+static void *cache_dropper(void *unused)
+{
+	unsigned int drop_cnt = 0;
+
+	while (!stop) {
+		drop_caches();
+		drop_cnt++;
+	}
+
+	tst_res(TINFO, "Cache dropped %u times", drop_cnt);
+
+	return unused;
+}
+
+static unsigned int io_submit(void)
+{
+	struct io_event evbuf;
+	struct timespec timeout = { .tv_sec = 1 };
+
+	TST_EXP_VAL_SILENT(tst_syscall(__NR_io_submit, ctx, 1, iocbs), 1);
+
+	TST_EXP_VAL_SILENT(tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf,
+			&timeout), 1);
+
+	if (evbuf.res == -EAGAIN)
+		return 1;
+	else
+		return 0;
+}
+
+static void *nowait_reader(void *unused LTP_ATTRIBUTE_UNUSED)
+{
+	unsigned int eagains_cnt = 0;
+
+	while (!stop) {
+		if (eagains_cnt >= 100)
+			stop = 1;
+		eagains_cnt = eagains_cnt + io_submit();
+	}
+
+	return (void *)(long)eagains_cnt;
+}
+
+static void setup(void)
+{
+
+	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
+
+	fd = SAFE_OPEN(TEST_FILE, O_RDWR | O_CREAT, MODE);
+
+	memset(w_buf, 'a', BUF_LEN);
+	memset(r_buf, 'b', BUF_LEN);
+
+	io_prep_option(&iocb, fd, r_buf, BUF_LEN, 0, IOCB_CMD_PREAD);
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
+
+	pthread_t reader, dropper, writer;
+	void *eagains;
+
+	stop = 0;
+
+	SAFE_PTHREAD_CREATE(&dropper, NULL, cache_dropper, NULL);
+	SAFE_PTHREAD_CREATE(&reader, NULL, nowait_reader, NULL);
+	SAFE_PTHREAD_CREATE(&writer, NULL, writer_thread, NULL);
+
+	while (!stop && tst_remaining_runtime())
+		usleep(100000);
+
+	stop = 1;
+
+	SAFE_PTHREAD_JOIN(reader, &eagains);
+	SAFE_PTHREAD_JOIN(dropper, NULL);
+	SAFE_PTHREAD_JOIN(writer, NULL);
+
+	if (eagains)
+		tst_res(TPASS, "Got some EAGAIN");
+	else
+		tst_res(TFAIL, "Haven't got EAGAIN");
+
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
+		{&w_buf, .size = BUF_LEN},
+		{&r_buf, .size = BUF_LEN},
+		{}
+	}
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
