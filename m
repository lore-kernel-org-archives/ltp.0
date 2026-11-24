Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F5C606A32C
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Q6/2B7eu;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=G557k+dJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qEvJyY3C;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wSbEFa9w
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E1D23E9EEE
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 19:02:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D8613CE1B0
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 19:01:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CCD581000991
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 19:01:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A9612202C;
 Tue, 24 Nov 2026 18:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795543315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxSDA6koqf9qI5fF5HM10ssyckV/0yGU3wyowSUtcEA=;
 b=Q6/2B7euIuXIYHj/XYAXhVQfC1NAER1js3hroVo6ehW1Ph2/iu+dhfarPmuK/NG10bi16/
 qYBkKOor8yAEHh/JuwWQ7MuoHUAr3kEAOj2Lr2M1/FkOiksHjepYvmYPATU5lXRQBEaM6N
 U1wLFsljzW7NJS6gwAuDBXXU6HQPhYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795543315;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxSDA6koqf9qI5fF5HM10ssyckV/0yGU3wyowSUtcEA=;
 b=G557k+dJ3A8jUYtvnuDESY58d5FfqBKTnQ7o2Us0WHa8xd6st2ppVdIV0hCk+Y0Lr0ETQZ
 vVuuQgdEHV+VwOAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qEvJyY3C;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wSbEFa9w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795543314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxSDA6koqf9qI5fF5HM10ssyckV/0yGU3wyowSUtcEA=;
 b=qEvJyY3CH5WpzpkXgzJn8bQmkUfR8maUnEfEyKnD8jCRxUTr3q7osX81RU8VzMyuocUG4x
 3b0LzuBlSjS1fJzbm6nWBeDeAltOx8QQAfwh2l7+YP0iVShZT8QE5ycxVA+u8ddEU7RFLj
 CuUwzaUyAEFtZwrNUOFN/a7PWHDKF0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795543314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nxSDA6koqf9qI5fF5HM10ssyckV/0yGU3wyowSUtcEA=;
 b=wSbEFa9wDDPWB51Mp3t6JHBhibROzGQCmbr1+kkDfGS7STFNFjbrKZ+RHsonx9/ZHwVCWm
 n0odw+R0HAxKiYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29F3613505;
 Tue, 24 Nov 2026 18:01:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Fc1MABLRBWvCCwAAD6G6ig
 (envelope-from <rbranco@suse.de>); Tue, 24 Nov 2026 18:01:54 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Tue, 24 Nov 2026 19:01:47 +0100
Message-ID: <20261124180149.614825-1-rbranco@suse.de>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7A9612202C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, configure.ac:url, anthropic.com:email,
 pollfd.events:url, suse.de:dkim, suse.de:email, suse.com:email]
X-Spam-Score: -12.01
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] userfaultfd: Add tests for UFFDIO_RWPROTECT and
 UFFDIO_SET_MODE
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: "Claude Opus 5.5" <noreply@anthropic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add userfaultfd08 with two variants to exercise UFFDIO_RWPROTECT and
UFFDIO_SET_MODE.

The first variant registers a page with UFFDIO_REGISTER_MODE_RWP,
protects it with UFFDIO_RWPROTECT_MODE_RWP, and verifies that a plain
read from a second thread raises a UFFD_PAGEFAULT_FLAG_RWP fault
(without UFFD_PAGEFAULT_FLAG_WRITE) that is resolved by clearing the
RWP mode, preserving page contents.

The second variant exercises UFFDIO_SET_MODE toggling
UFFD_FEATURE_RWP_ASYNC at runtime: with async mode enabled at
UFFDIO_API time, a protected page is accessed and auto-resolved with
no fault message delivered; UFFDIO_SET_MODE then disables async mode,
and the same access on a freshly protected page now blocks and is
delivered as a fault, handled from a second thread as above.

Add the UFFDIO_RWPROTECT and UFFDIO_SET_MODE ioctls, their associated
structs, and the UFFD_FEATURE_RWP/UFFD_FEATURE_RWP_ASYNC feature bits
to lapi/userfaultfd.h for systems whose kernel headers predate them.

Signed-off-by: Ricardo Branco <rbranco@suse.de>
Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
---
 configure.ac                                  |   2 +
 include/lapi/userfaultfd.h                    |  28 +++
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/userfaultfd/.gitignore    |   1 +
 .../kernel/syscalls/userfaultfd/Makefile      |   1 +
 .../syscalls/userfaultfd/userfaultfd08.c      | 183 ++++++++++++++++++
 6 files changed, 216 insertions(+)
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd08.c

diff --git a/configure.ac b/configure.ac
index d75e94162..359a584f5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -298,6 +298,8 @@ AC_CHECK_TYPES([struct sockaddr_vm],,,[
 
 AC_CHECK_TYPES([struct uffdio_move],,,[#include <linux/userfaultfd.h>])
 AC_CHECK_TYPES([struct uffdio_poison],,,[#include <linux/userfaultfd.h>])
+AC_CHECK_TYPES([struct uffdio_rwprotect],,,[#include <linux/userfaultfd.h>])
+AC_CHECK_TYPES([struct uffdio_set_mode],,,[#include <linux/userfaultfd.h>])
 AC_CHECK_TYPES([struct uffdio_writeprotect],,,[#include <linux/userfaultfd.h>])
 
 AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
index 4a25e7338..a4b3d0763 100644
--- a/include/lapi/userfaultfd.h
+++ b/include/lapi/userfaultfd.h
@@ -247,6 +247,34 @@ struct uffdio_poison {
 };
 #endif	/* HAVE_STRUCT_UFFDIO_POISON */
 
+#ifndef HAVE_STRUCT_UFFDIO_RWPROTECT
+#define UFFD_FEATURE_RWP			(1<<17)
+#define UFFD_FEATURE_RWP_ASYNC			(1<<18)
+#define UFFD_PAGEFAULT_FLAG_RWP			(1<<3)
+#define UFFDIO_REGISTER_MODE_RWP		((__u64)1<<3)
+#define _UFFDIO_RWPROTECT			(0x09)
+#define UFFDIO_RWPROTECT	_IOWR(UFFDIO, _UFFDIO_RWPROTECT, \
+				      struct uffdio_rwprotect)
+
+struct uffdio_rwprotect {
+	struct uffdio_range range;
+#define UFFDIO_RWPROTECT_MODE_RWP		((__u64)1<<0)
+#define UFFDIO_RWPROTECT_MODE_DONTWAKE		((__u64)1<<1)
+	__u64 mode;
+};
+#endif	/* HAVE_STRUCT_UFFDIO_RWPROTECT */
+
+#ifndef HAVE_STRUCT_UFFDIO_SET_MODE
+#define _UFFDIO_SET_MODE			(0x0A)
+#define UFFDIO_SET_MODE	_IOW(UFFDIO, _UFFDIO_SET_MODE, \
+				     struct uffdio_set_mode)
+
+struct uffdio_set_mode {
+	__u64 enable;
+	__u64 disable;
+};
+#endif	/* HAVE_STRUCT_UFFDIO_SET_MODE */
+
 #define SAFE_USERFAULTFD(flags, retry) \
 	safe_userfaultfd(__FILE__, __LINE__, (flags), (retry))
 
diff --git a/runtest/syscalls b/runtest/syscalls
index 7b6a7d376..dadf076f8 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1849,6 +1849,7 @@ userfaultfd04 userfaultfd04
 userfaultfd05 userfaultfd05
 userfaultfd06 userfaultfd06
 userfaultfd07 userfaultfd07
+userfaultfd08 userfaultfd08
 
 ustat01 ustat01
 ustat02 ustat02
diff --git a/testcases/kernel/syscalls/userfaultfd/.gitignore b/testcases/kernel/syscalls/userfaultfd/.gitignore
index 3478a162e..d5734bb68 100644
--- a/testcases/kernel/syscalls/userfaultfd/.gitignore
+++ b/testcases/kernel/syscalls/userfaultfd/.gitignore
@@ -5,3 +5,4 @@
 /userfaultfd05
 /userfaultfd06
 /userfaultfd07
+/userfaultfd08
diff --git a/testcases/kernel/syscalls/userfaultfd/Makefile b/testcases/kernel/syscalls/userfaultfd/Makefile
index 257249e88..8c757c030 100644
--- a/testcases/kernel/syscalls/userfaultfd/Makefile
+++ b/testcases/kernel/syscalls/userfaultfd/Makefile
@@ -18,3 +18,4 @@ userfaultfd04: CFLAGS += -pthread
 userfaultfd05: CFLAGS += -pthread
 userfaultfd06: CFLAGS += -pthread
 userfaultfd07: CFLAGS += -pthread
+userfaultfd08: CFLAGS += -pthread
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
new file mode 100644
index 000000000..23eff279c
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
@@ -0,0 +1,183 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different thread testing UFFDIO_RWPROTECT.
+ *
+ * - Sync: a read of an RWP-protected page blocks and is delivered as a fault.
+ * - Async: with UFFD_FEATURE_RWP_ASYNC the access resolves automatically,
+ *   then UFFDIO_SET_MODE disables async mode and the access is delivered
+ *   as a fault again.
+ */
+
+#include "config.h"
+#include <poll.h>
+#include "tst_test.h"
+#include "tst_safe_macros.h"
+#include "tst_safe_pthread.h"
+#include "lapi/userfaultfd.h"
+
+#define PAGE_BYTE 0x5a
+
+static long page_size;
+static char *page;
+static int uffd = -1;
+static volatile int rwp_fault_seen;
+
+static void setup(void)
+{
+	CHECK_UFFD_FEATURE(UFFD_FEATURE_RWP);
+	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
+}
+
+static void set_page(void)
+{
+	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	memset(page, PAGE_BYTE, page_size);
+}
+
+static void reset_page(void)
+{
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
+}
+
+static void rwprotect(unsigned long start, uint64_t mode)
+{
+	struct uffdio_rwprotect uffdio_rwprotect = {
+		.range.start = start,
+		.range.len = page_size,
+		.mode = mode,
+	};
+
+	SAFE_IOCTL(uffd, UFFDIO_RWPROTECT, &uffdio_rwprotect);
+}
+
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	static struct uffd_msg msg;
+	struct pollfd pollfd = {
+		.fd = uffd,
+		.events = POLLIN,
+	};
+
+	SAFE_POLL(&pollfd, 1, -1);
+
+	SAFE_READ(SAFE_READ_ALL, uffd, &msg, sizeof(msg));
+
+	if (msg.event != UFFD_EVENT_PAGEFAULT)
+		tst_brk(TFAIL, "Received unexpected UFFD_EVENT %d", msg.event);
+
+	if (!(msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_RWP)) {
+		tst_brk(TFAIL, "Expected RWP fault, got flags=0x%llx",
+			(unsigned long long)msg.arg.pagefault.flags);
+	}
+
+	/* The access is a read, so WRITE must not be set. */
+	if (msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
+		tst_brk(TFAIL, "Unexpected WRITE flag on a read-only access");
+
+	rwp_fault_seen = 1;
+
+	/* Resolve the fault by clearing RWP so the reader can resume. */
+	rwprotect(msg.arg.pagefault.address & ~((unsigned long)page_size - 1), 0);
+
+	return NULL;
+}
+
+static void run(unsigned int n)
+{
+	pthread_t thr;
+	struct uffdio_api uffdio_api = { .api = UFFD_API };
+	struct uffdio_register uffdio_register;
+	struct uffdio_set_mode uffdio_set_mode = {
+		.disable = UFFD_FEATURE_RWP_ASYNC,
+	};
+	struct pollfd pollfd;
+	unsigned char val;
+
+	uffdio_api.features = UFFD_FEATURE_RWP;
+	if (n) {
+		CHECK_UFFD_FEATURE(UFFD_FEATURE_RWP_ASYNC);
+		uffdio_api.features |= UFFD_FEATURE_RWP_ASYNC;
+	}
+
+	set_page();
+	rwp_fault_seen = 0;
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start = (unsigned long)page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_RWP;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	if (n) {
+		/* Async mode is active, access must auto-resolve. */
+		rwprotect((unsigned long)page, UFFDIO_RWPROTECT_MODE_RWP);
+
+		val = page[0];
+
+		if (val != PAGE_BYTE) {
+			tst_res(TFAIL, "Async access corrupted content: got 0x%02x, expected 0x%02x",
+				val, PAGE_BYTE);
+			goto out;
+		}
+
+		pollfd.fd = uffd;
+		pollfd.events = POLLIN;
+		if (SAFE_POLL(&pollfd, 1, 0) != 0) {
+			tst_res(TFAIL, "Unexpected pagefault message in async mode");
+			goto out;
+		}
+
+		/* Switch to sync mode via UFFDIO_SET_MODE. */
+		SAFE_IOCTL(uffd, UFFDIO_SET_MODE, &uffdio_set_mode);
+	}
+
+	rwprotect((unsigned long)page, UFFDIO_RWPROTECT_MODE_RWP);
+
+	SAFE_PTHREAD_CREATE(&thr, NULL, handle_thread, NULL);
+
+	/* Try to read the RWP-protected page. */
+	val = page[0];
+
+	SAFE_PTHREAD_JOIN(thr, NULL);
+
+	if (!rwp_fault_seen) {
+		tst_res(TFAIL, "No RWPROTECT pagefault observed");
+		goto out;
+	}
+
+	if (val != PAGE_BYTE) {
+		tst_res(TFAIL, "Page content corrupted: got 0x%02x, expected 0x%02x",
+			val, PAGE_BYTE);
+		goto out;
+	}
+
+	tst_res(TPASS, "RWPROTECT pagefault handled%s!",
+		n ? " after UFFDIO_SET_MODE disabled RWP_ASYNC" : "");
+
+out:
+	reset_page();
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test = run,
+	.tcnt = 2,
+	.cleanup = reset_page,
+};
-- 
2.56.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
