Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161EFC531E7
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 22:50:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5074D3D0763
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 23:50:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB5193D074E
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 23:50:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3C1D860072A
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 23:50:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A265C5BCEC;
 Thu, 19 Feb 2026 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771541422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aN1/WW3QUhte1HCjsXcLZkmT/XC9da+jtY+cXkVEGDs=;
 b=F8txdJV+HSxacB7Bq09WWeCj9/limcYp/7NNKtiPI7cUTZ9rMkaQcNAo8HU2+zLL54ZUh6
 FYJ0uODjoOb+2s4uxrMe+0W9/5SqNGN1E/8kz/c8n31FJXI717Xg0X/LzaDakzRteQWisf
 2Jadca/PTY18xJyTvkUgFi6t4oBkxp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771541422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aN1/WW3QUhte1HCjsXcLZkmT/XC9da+jtY+cXkVEGDs=;
 b=yJDESl9y/oHgh5+8+9fMXKug5TAdUv//lLMFIFpOY9F76dDfzRQFlkuQ32BFSuFUkgwEN2
 lr7yIsHltDZJtkDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=F8txdJV+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yJDESl9y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1771541422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aN1/WW3QUhte1HCjsXcLZkmT/XC9da+jtY+cXkVEGDs=;
 b=F8txdJV+HSxacB7Bq09WWeCj9/limcYp/7NNKtiPI7cUTZ9rMkaQcNAo8HU2+zLL54ZUh6
 FYJ0uODjoOb+2s4uxrMe+0W9/5SqNGN1E/8kz/c8n31FJXI717Xg0X/LzaDakzRteQWisf
 2Jadca/PTY18xJyTvkUgFi6t4oBkxp4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1771541422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=aN1/WW3QUhte1HCjsXcLZkmT/XC9da+jtY+cXkVEGDs=;
 b=yJDESl9y/oHgh5+8+9fMXKug5TAdUv//lLMFIFpOY9F76dDfzRQFlkuQ32BFSuFUkgwEN2
 lr7yIsHltDZJtkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CBD53EA65;
 Thu, 19 Feb 2026 22:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tDmYDK6Tl2n/bwAAD6G6ig
 (envelope-from <rbranco@suse.de>); Thu, 19 Feb 2026 22:50:22 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Thu, 19 Feb 2026 23:50:06 +0100
Message-ID: <20260219225007.218697-1-rbranco@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A265C5BCEC
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] userfaultfd: Add test using UFFDIO_POISON
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

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 configure.ac                                  |   1 +
 include/lapi/userfaultfd.h                    |  13 ++
 .../kernel/syscalls/userfaultfd/.gitignore    |   1 +
 .../kernel/syscalls/userfaultfd/Makefile      |   1 +
 .../syscalls/userfaultfd/userfaultfd06.c      | 137 ++++++++++++++++++
 5 files changed, 153 insertions(+)
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd06.c

diff --git a/configure.ac b/configure.ac
index 7fa614dcb..94bcbcc98 100644
--- a/configure.ac
+++ b/configure.ac
@@ -278,6 +278,7 @@ AC_CHECK_TYPES([struct sockaddr_vm],,,[
 ])
 
 AC_CHECK_TYPES([struct uffdio_move],,,[#include <linux/userfaultfd.h>])
+AC_CHECK_TYPES([struct uffdio_poison],,,[#include <linux/userfaultfd.h>])
 AC_CHECK_TYPES([struct uffdio_writeprotect],,,[#include <linux/userfaultfd.h>])
 
 # Tools knobs
diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
index 0c9e34c84..aab3890b7 100644
--- a/include/lapi/userfaultfd.h
+++ b/include/lapi/userfaultfd.h
@@ -233,6 +233,19 @@ struct uffdio_writeprotect {
 };
 #endif	/* HAVE_STRUCT_UFFDIO_WRITEPROTECT */
 
+#ifndef HAVE_STRUCT_UFFDIO_POISON
+#define UFFD_FEATURE_POISON			(1<<14)
+#define _UFFDIO_POISON				(0x08)
+#define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
+				      struct uffdio_poison)
+struct uffdio_poison {
+        struct uffdio_range range;
+#define UFFDIO_POISON_MODE_DONTWAKE		((__u64)1<<0)
+        __u64 mode;
+        __s64 updated;
+};
+#endif	/* HAVE_STRUCT_UFFDIO_POISON */
+
 #define SAFE_USERFAULTFD(flags, retry) \
 	safe_userfaultfd(__FILE__, __LINE__, (flags), (retry))
 
diff --git a/testcases/kernel/syscalls/userfaultfd/.gitignore b/testcases/kernel/syscalls/userfaultfd/.gitignore
index fb2ae243b..bc32fdf3b 100644
--- a/testcases/kernel/syscalls/userfaultfd/.gitignore
+++ b/testcases/kernel/syscalls/userfaultfd/.gitignore
@@ -3,3 +3,4 @@
 /userfaultfd03
 /userfaultfd04
 /userfaultfd05
+/userfaultfd06
diff --git a/testcases/kernel/syscalls/userfaultfd/Makefile b/testcases/kernel/syscalls/userfaultfd/Makefile
index 96650a65a..3252e47df 100644
--- a/testcases/kernel/syscalls/userfaultfd/Makefile
+++ b/testcases/kernel/syscalls/userfaultfd/Makefile
@@ -16,3 +16,4 @@ userfaultfd02: CFLAGS += -pthread
 userfaultfd03: CFLAGS += -pthread
 userfaultfd04: CFLAGS += -pthread
 userfaultfd05: CFLAGS += -pthread
+userfaultfd06: CFLAGS += -pthread
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
new file mode 100644
index 000000000..1f132d4d5
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd06.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different thread testing UFFDIO_POISON.
+ */
+
+#include "config.h"
+#include <poll.h>
+#include <setjmp.h>
+#include <signal.h>
+#include <unistd.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_safe_pthread.h"
+#include "lapi/userfaultfd.h"
+
+static int page_size;
+static char *page;
+static int uffd;
+static int poison_fault_seen;
+static volatile int sigbus_seen;
+static sigjmp_buf jmpbuf;
+
+static void sigbus_handler(int sig)
+{
+	if (sig == SIGBUS) {
+		sigbus_seen = 1;
+		siglongjmp(jmpbuf, 1);
+	}
+}
+
+static void set_pages(void)
+{
+	page_size = sysconf(_SC_PAGE_SIZE);
+	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+}
+
+static void cleanup(void)
+{
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
+}
+
+static void *handle_thread(void)
+{
+	static struct uffd_msg msg;
+	struct uffdio_poison uffdio_poison = {};
+	struct pollfd pollfd;
+	int nready;
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
+	tst_atomic_store(1, &poison_fault_seen);
+
+	/* Poison the page that triggered the fault */
+	uffdio_poison.range.start = msg.arg.pagefault.address & ~(page_size - 1);
+	uffdio_poison.range.len = page_size;
+
+	SAFE_IOCTL(uffd, UFFDIO_POISON, &uffdio_poison);
+
+	close(uffd);
+	return NULL;
+}
+
+static void run(void)
+{
+	pthread_t thr;
+	struct uffdio_api uffdio_api = {};
+	struct uffdio_register uffdio_register;
+	struct sigaction sa = {};
+	volatile char dummy;
+
+	sa.sa_handler = sigbus_handler;
+	sigemptyset(&sa.sa_mask);
+	SAFE_SIGACTION(SIGBUS, &sa, NULL);
+
+	set_pages();
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = UFFD_FEATURE_POISON;
+
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	if (!(uffdio_api.features & UFFD_FEATURE_POISON))
+		tst_brk(TCONF, "UFFD_FEATURE_POISON not supported");
+
+	uffdio_register.range.start = (unsigned long) page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
+
+	/* Try to read from the page: should trigger fault, get poisoned, then SIGBUS */
+	if (sigsetjmp(jmpbuf, 1) == 0) {
+		dummy = page[0];
+		(void)dummy;
+	}
+
+	SAFE_PTHREAD_JOIN(thr, NULL);
+
+	int poisoned = tst_atomic_load(&poison_fault_seen);
+
+	if (poisoned && sigbus_seen)
+		tst_res(TPASS, "POISON successfully triggered SIGBUS");
+	else if (poison_fault_seen && !sigbus_seen)
+		tst_res(TFAIL, "POISON fault seen but no SIGBUS received");
+	else if (!poison_fault_seen && sigbus_seen)
+		tst_res(TFAIL, "SIGBUS received but no poison fault seen");
+	else
+		tst_res(TFAIL, "No poison fault or SIGBUS observed");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.cleanup = cleanup,
+};
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
