Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4191061B18
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 18:58:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDB163E9313
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 20:58:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEF1A3CBAA9
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 20:58:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AF2781A009BB
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 20:58:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DFBF5BCE2;
 Mon, 30 Mar 2026 18:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774897082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OtDwTuOQY3rO4KlYTTCWXdynaxmA5xwPL3kTkB7Yi68=;
 b=sOznIKFifTMvV8faYhgokYYObeccHIZRFE35Ji9Nt2bhLxUeQEhWoW9qNtaQnPTgjhe+gJ
 7zvdRN54NaqzDRyoXMFK3nRu5sbR2x460zAaOVQEjH3wKTJH6yJzbnaAd90Nso5S8G0YTu
 Nyta8+OY5F3OoX04HxgRRxftaE2Qsrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774897082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OtDwTuOQY3rO4KlYTTCWXdynaxmA5xwPL3kTkB7Yi68=;
 b=2Ge68e7LmGpUPS1v3OEREFBYtAHkPPQG6pQ0k9FLvDh83ks4Vr9GFExWJJyfBx/JVPwkPu
 qaAl40yy8lCPOxCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sOznIKFi;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2Ge68e7L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774897082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OtDwTuOQY3rO4KlYTTCWXdynaxmA5xwPL3kTkB7Yi68=;
 b=sOznIKFifTMvV8faYhgokYYObeccHIZRFE35Ji9Nt2bhLxUeQEhWoW9qNtaQnPTgjhe+gJ
 7zvdRN54NaqzDRyoXMFK3nRu5sbR2x460zAaOVQEjH3wKTJH6yJzbnaAd90Nso5S8G0YTu
 Nyta8+OY5F3OoX04HxgRRxftaE2Qsrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774897082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=OtDwTuOQY3rO4KlYTTCWXdynaxmA5xwPL3kTkB7Yi68=;
 b=2Ge68e7LmGpUPS1v3OEREFBYtAHkPPQG6pQ0k9FLvDh83ks4Vr9GFExWJJyfBx/JVPwkPu
 qaAl40yy8lCPOxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C2DD4A0A2;
 Mon, 30 Mar 2026 18:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NocKCbrHymlubgAAD6G6ig
 (envelope-from <rbranco@suse.de>); Mon, 30 Mar 2026 18:58:02 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Mon, 30 Mar 2026 20:57:57 +0200
Message-ID: <20260330185759.398559-1-rbranco@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,suse.com:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4DFBF5BCE2
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] userfaultfd: Add new test using UFFDIO_CONTINUE
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

We test it with UFFD_PAGEFAULT_FLAG_MINOR.

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 include/lapi/userfaultfd.h                    |   1 +
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/userfaultfd/.gitignore    |   1 +
 .../kernel/syscalls/userfaultfd/Makefile      |   1 +
 .../syscalls/userfaultfd/userfaultfd07.c      | 161 ++++++++++++++++++
 5 files changed, 165 insertions(+)
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd07.c

diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
index aab3890b7..c05b8dbf5 100644
--- a/include/lapi/userfaultfd.h
+++ b/include/lapi/userfaultfd.h
@@ -171,6 +171,7 @@ struct uffdio_zeropage {
 #ifndef UFFD_PAGEFAULT_FLAG_MINOR
 #define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
 #define UFFDIO_REGISTER_MODE_MINOR	((__u64)1<<2)
+#define UFFD_PAGEFAULT_FLAG_MINOR	(1<<2)
 
 #define _UFFDIO_CONTINUE		(0x07)
 #define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
diff --git a/runtest/syscalls b/runtest/syscalls
index 6ba0227a8..534140f42 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1780,6 +1780,7 @@ userfaultfd03 userfaultfd03
 userfaultfd04 userfaultfd04
 userfaultfd05 userfaultfd05
 userfaultfd06 userfaultfd06
+userfaultfd07 userfaultfd07
 
 ustat01 ustat01
 ustat02 ustat02
diff --git a/testcases/kernel/syscalls/userfaultfd/.gitignore b/testcases/kernel/syscalls/userfaultfd/.gitignore
index bc32fdf3b..3478a162e 100644
--- a/testcases/kernel/syscalls/userfaultfd/.gitignore
+++ b/testcases/kernel/syscalls/userfaultfd/.gitignore
@@ -4,3 +4,4 @@
 /userfaultfd04
 /userfaultfd05
 /userfaultfd06
+/userfaultfd07
diff --git a/testcases/kernel/syscalls/userfaultfd/Makefile b/testcases/kernel/syscalls/userfaultfd/Makefile
index 3252e47df..257249e88 100644
--- a/testcases/kernel/syscalls/userfaultfd/Makefile
+++ b/testcases/kernel/syscalls/userfaultfd/Makefile
@@ -17,3 +17,4 @@ userfaultfd03: CFLAGS += -pthread
 userfaultfd04: CFLAGS += -pthread
 userfaultfd05: CFLAGS += -pthread
 userfaultfd06: CFLAGS += -pthread
+userfaultfd07: CFLAGS += -pthread
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
new file mode 100644
index 000000000..644e7724e
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different thread testing UFFDIO_CONTINUE.
+ */
+
+#include "config.h"
+#include <poll.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_safe_prw.h"
+#include "tst_safe_pthread.h"
+#include "lapi/memfd.h"
+#include "lapi/userfaultfd.h"
+#include "lapi/syscalls.h"
+
+static long page_size;
+static char *page;
+static int uffd = -1;
+static int memfd = -1;
+
+static int sys_memfd_create(const char *name, unsigned int flags)
+{
+	return tst_syscall(__NR_memfd_create, name, flags);
+}
+
+static void set_pages(void)
+{
+	char ch = 'A';
+
+	page_size = sysconf(_SC_PAGE_SIZE);
+
+	memfd = sys_memfd_create("ltp-uffd-continue", MFD_CLOEXEC);
+	if (memfd < 0)
+		tst_brk(TBROK | TERRNO, "memfd_create failed");
+
+	SAFE_FTRUNCATE(memfd, page_size);
+
+	/*
+	 * Populate page cache so that after MADV_DONTNEED the next access
+	 * can generate a MINOR fault rather than a MISSING fault.
+	 */
+	SAFE_PWRITE(1, memfd, &ch, 1, 0);
+
+	page = SAFE_MMAP(NULL, page_size, PROT_READ, MAP_SHARED, memfd, 0);
+}
+
+static void reset_pages(void)
+{
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
+
+	if (memfd != -1) {
+		SAFE_CLOSE(memfd);
+		memfd = -1;
+	}
+
+	if (uffd != -1) {
+		SAFE_CLOSE(uffd);
+		uffd = -1;
+	}
+}
+
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	static struct uffd_msg msg;
+	struct uffdio_continue uffdio_continue = {};
+	struct pollfd pollfd;
+	int nready;
+	char z = 'Z';
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+	nready = poll(&pollfd, 1, -1);
+	if (nready == -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
+
+	SAFE_READ(1, uffd, &msg, sizeof(msg));
+
+	if (msg.event != UFFD_EVENT_PAGEFAULT)
+		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	if (!(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_MINOR)) {
+		tst_brk(TBROK, "expected MINOR fault, got flags=0x%llx",
+			(unsigned long long)msg.arg.pagefault.flags);
+	}
+
+	/* Update the shmem page in page cache before resuming the fault. */
+	SAFE_PWRITE(1, memfd, &z, 1, 0);
+
+	uffdio_continue.range.start =
+		msg.arg.pagefault.address & ~((unsigned long)page_size - 1);
+	uffdio_continue.range.len = page_size;
+
+	SAFE_IOCTL(uffd, UFFDIO_CONTINUE, &uffdio_continue);
+
+	SAFE_CLOSE(uffd);
+	return NULL;
+}
+
+static void run(void)
+{
+	pthread_t thr;
+	struct uffdio_api uffdio_api = {};
+	struct uffdio_register uffdio_register;
+
+	set_pages();
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, true);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = UFFD_FEATURE_MINOR_SHMEM;
+
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	if (!(uffdio_api.features & UFFD_FEATURE_MINOR_SHMEM))
+		tst_brk(TCONF, "UFFD_FEATURE_MINOR_SHMEM not supported");
+
+	uffdio_register.range.start = (unsigned long) page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	/*
+	 * Drop PTEs while retaining the cached shmem page so the next access
+	 * faults in MINOR mode.
+	 */
+	if (madvise(page, page_size, MADV_DONTNEED) < 0)
+		tst_brk(TBROK | TERRNO, "madvise MADV_DONTNEED failed");
+
+	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
+
+	char c = page[0];
+
+	if (c == 'Z')
+		tst_res(TPASS, "Pagefault handled via UFFDIO_CONTINUE");
+	else
+		tst_res(TFAIL, "pagefault not handled via UFFDIO_CONTINUE, got '%c'", c);
+
+	SAFE_PTHREAD_JOIN(thr, NULL);
+	reset_pages();
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	/*
+	 * UFFDIO_CONTINUE is available since 5.13 but
+	 * UFFD_FEATURE_MINOR_SHMEM appeared in 5.14
+	 */
+	.min_kver = "5.14",
+	.cleanup = reset_pages,
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
