Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2986C606A31A
	for <ltp@archiver.kernel.org>; Sat, 24 Oct 2026 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L4WnNelh;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jbqYmyix;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IMnnTNnU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pAXhAKYV
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65A783CFD4A
	for <ltp@archiver.kernel.org>; Sat, 24 Oct 2026 14:08:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B23B3CB2EE
 for <ltp@lists.linux.it>; Sat, 24 Oct 2026 14:07:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6C5331400202
 for <ltp@lists.linux.it>; Sat, 24 Oct 2026 14:07:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E2F361FE26;
 Sat, 24 Oct 2026 12:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792843675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3yzuV9g4HILsijGQZctOEZPU538VOLZO/AnCrXJxhUY=;
 b=L4WnNelh6trw3qtXoD55AIQCxYzMOsAH6qFrJmydbwEQpMlFe9W7DeXkjbQ0Gklgwoy05N
 BqUwAVaDY7A2JvVV9GRl2ZZGgy/0WjdQ4y4KnOoc1T8UmhcqLXAcbmWVBIZ6z0yMDK+xCj
 imHuFIimmN3B6/KnV7JCRkjKa4h5etw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792843675;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3yzuV9g4HILsijGQZctOEZPU538VOLZO/AnCrXJxhUY=;
 b=jbqYmyixXWQXZ8d7pEumWmoetqKGEMEtMKBEZOQI6mAYhSdMTePbOz2j15pU3NDzG/J1IT
 atXXhDcXxCcFsVBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792843674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3yzuV9g4HILsijGQZctOEZPU538VOLZO/AnCrXJxhUY=;
 b=IMnnTNnUDc+vbvuGdo2T74s29gtW4Kwm2vG/QZR7UAJ8G5Pq3Sc+jks7pPtYuuXNfXz5Nx
 a/ZUDaXFmq/NGkjd9/k4fNO/5mB5yHZfk4TThi+bqwxAY7AokN1hpNh3K8+zE3zABOBAu3
 0Tb2MeuObf2ryg7E553A3dXQW8YSSHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792843674;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3yzuV9g4HILsijGQZctOEZPU538VOLZO/AnCrXJxhUY=;
 b=pAXhAKYVqRHEe3CTAxKydhpkPdZ4kIR4+MN1m2q50COIFFuNaLuujuDqkfuuXkIEv1qeHS
 5nSHBmGBkO8CL5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71DFE134EA;
 Sat, 24 Oct 2026 12:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EKrHD5qf3GrSPAAAD6G6ig
 (envelope-from <rbranco@suse.de>); Sat, 24 Oct 2026 12:07:54 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Sat, 24 Oct 2026 14:07:36 +0200
Message-ID: <20261024120743.583665-1-rbranco@suse.de>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] userfaultfd: Add tests for UFFDIO_RWPROTECT and
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

Add userfaultfd08 to exercise UFFDIO_RWPROTECT: a page is registered
with UFFDIO_REGISTER_MODE_RWP, protected with UFFDIO_RWPROTECT_MODE_RWP,
and a plain read from a second thread is verified to raise a
UFFD_PAGEFAULT_FLAG_RWP fault (without UFFD_PAGEFAULT_FLAG_WRITE) that
is resolved by clearing the RWP mode, preserving page contents.

Add userfaultfd09 to exercise UFFDIO_SET_MODE toggling
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
 runtest/syscalls                              |   2 +
 .../kernel/syscalls/userfaultfd/.gitignore    |   2 +
 .../kernel/syscalls/userfaultfd/Makefile      |   2 +
 .../syscalls/userfaultfd/userfaultfd08.c      | 147 ++++++++++++++
 .../syscalls/userfaultfd/userfaultfd09.c      | 179 ++++++++++++++++++
 7 files changed, 362 insertions(+)
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
 create mode 100644 testcases/kernel/syscalls/userfaultfd/userfaultfd09.c

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
index 2bdb4a9a2..e01c62d76 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1843,6 +1843,8 @@ userfaultfd04 userfaultfd04
 userfaultfd05 userfaultfd05
 userfaultfd06 userfaultfd06
 userfaultfd07 userfaultfd07
+userfaultfd08 userfaultfd08
+userfaultfd09 userfaultfd09
 
 ustat01 ustat01
 ustat02 ustat02
diff --git a/testcases/kernel/syscalls/userfaultfd/.gitignore b/testcases/kernel/syscalls/userfaultfd/.gitignore
index 3478a162e..7a9b2edb6 100644
--- a/testcases/kernel/syscalls/userfaultfd/.gitignore
+++ b/testcases/kernel/syscalls/userfaultfd/.gitignore
@@ -5,3 +5,5 @@
 /userfaultfd05
 /userfaultfd06
 /userfaultfd07
+/userfaultfd08
+/userfaultfd09
diff --git a/testcases/kernel/syscalls/userfaultfd/Makefile b/testcases/kernel/syscalls/userfaultfd/Makefile
index 257249e88..48fa533ad 100644
--- a/testcases/kernel/syscalls/userfaultfd/Makefile
+++ b/testcases/kernel/syscalls/userfaultfd/Makefile
@@ -18,3 +18,5 @@ userfaultfd04: CFLAGS += -pthread
 userfaultfd05: CFLAGS += -pthread
 userfaultfd06: CFLAGS += -pthread
 userfaultfd07: CFLAGS += -pthread
+userfaultfd08: CFLAGS += -pthread
+userfaultfd09: CFLAGS += -pthread
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
new file mode 100644
index 000000000..95fbffa1f
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd08.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different thread testing UFFDIO_RWPROTECT.
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
+}
+
+static void set_pages(void)
+{
+	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
+	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	memset(page, PAGE_BYTE, page_size);
+}
+
+static void reset_pages(void)
+{
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
+}
+
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	static struct uffd_msg msg;
+	struct uffdio_rwprotect uffdio_rwprotect = {};
+
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+	nready = poll(&pollfd, 1, -1);
+	if (nready == -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
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
+	/* The access below is a read, so WRITE must not be set. */
+	if (msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
+		tst_brk(TFAIL, "Unexpected WRITE flag on a read-only access");
+
+	rwp_fault_seen = 1;
+
+	/* Resolve the fault by clearing RWP so the reader can resume. */
+	uffdio_rwprotect.range.start =
+		msg.arg.pagefault.address & ~((unsigned long)page_size - 1);
+	uffdio_rwprotect.range.len = page_size;
+
+	SAFE_IOCTL(uffd, UFFDIO_RWPROTECT, &uffdio_rwprotect);
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
+	struct uffdio_rwprotect uffdio_rwprotect;
+	unsigned char val;
+
+	set_pages();
+	rwp_fault_seen = 0;
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = UFFD_FEATURE_RWP;
+
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start = (unsigned long)page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_RWP;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	uffdio_rwprotect.range.start = (unsigned long)page;
+	uffdio_rwprotect.range.len = page_size;
+	uffdio_rwprotect.mode = UFFDIO_RWPROTECT_MODE_RWP;
+
+	SAFE_IOCTL(uffd, UFFDIO_RWPROTECT, &uffdio_rwprotect);
+
+	SAFE_PTHREAD_CREATE(&thr, NULL, (void *)handle_thread, NULL);
+
+	/* Try to read the RWP-protected page. */
+	val = page[0];
+
+	SAFE_PTHREAD_JOIN(thr, NULL);
+	reset_pages();
+
+	if (!rwp_fault_seen) {
+		tst_res(TFAIL, "No RWPROTECT pagefault observed");
+		return;
+	}
+
+	if (val != PAGE_BYTE) {
+		tst_res(TFAIL, "Page content corrupted: got 0x%02x, expected 0x%02x",
+			val, PAGE_BYTE);
+		return;
+	}
+
+	tst_res(TPASS, "RWPROTECT pagefault handled!");
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = reset_pages,
+};
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c
new file mode 100644
index 000000000..244f4c532
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd09.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 SUSE LLC
+ * Author: Ricardo Branco <rbranco@suse.com>
+ */
+
+/*\
+ * Force a pagefault event and handle it using :manpage:`userfaultfd(2)`
+ * from a different thread testing UFFDIO_SET_MODE toggling
+ * UFFD_FEATURE_RWP_ASYNC at runtime.
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
+	CHECK_UFFD_FEATURE(UFFD_FEATURE_RWP_ASYNC);
+}
+
+static void set_pages(void)
+{
+	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
+	page = SAFE_MMAP(NULL, page_size, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	memset(page, PAGE_BYTE, page_size);
+}
+
+static void reset_pages(void)
+{
+	if (page) {
+		SAFE_MUNMAP(page, page_size);
+		page = NULL;
+	}
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
+}
+
+static void rwprotect_page(void)
+{
+	struct uffdio_rwprotect uffdio_rwprotect = {};
+
+	uffdio_rwprotect.range.start = (unsigned long)page;
+	uffdio_rwprotect.range.len = page_size;
+	uffdio_rwprotect.mode = UFFDIO_RWPROTECT_MODE_RWP;
+
+	SAFE_IOCTL(uffd, UFFDIO_RWPROTECT, &uffdio_rwprotect);
+}
+
+static void *handle_thread(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	static struct uffd_msg msg;
+	struct uffdio_rwprotect uffdio_rwprotect = {};
+
+	struct pollfd pollfd;
+	int nready;
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+	nready = poll(&pollfd, 1, -1);
+	if (nready == -1)
+		tst_brk(TBROK | TERRNO, "Error on poll");
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
+	/* The access below is a read, so WRITE must not be set. */
+	if (msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
+		tst_brk(TFAIL, "Unexpected WRITE flag on a read-only access");
+
+	rwp_fault_seen = 1;
+
+	uffdio_rwprotect.range.start =
+		msg.arg.pagefault.address & ~((unsigned long)page_size - 1);
+	uffdio_rwprotect.range.len = page_size;
+
+	SAFE_IOCTL(uffd, UFFDIO_RWPROTECT, &uffdio_rwprotect);
+
+	return NULL;
+}
+
+static void run(void)
+{
+	pthread_t thr;
+	struct uffdio_api uffdio_api = {};
+	struct uffdio_register uffdio_register;
+	struct uffdio_set_mode uffdio_set_mode = {};
+	struct pollfd pollfd;
+	unsigned char val;
+
+	set_pages();
+	rwp_fault_seen = 0;
+
+	uffd = SAFE_USERFAULTFD(O_CLOEXEC | O_NONBLOCK, false);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = UFFD_FEATURE_RWP | UFFD_FEATURE_RWP_ASYNC;
+
+	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
+
+	uffdio_register.range.start = (unsigned long)page;
+	uffdio_register.range.len = page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_RWP;
+
+	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
+
+	/* Phase 1: async mode is active, access must auto-resolve. */
+	rwprotect_page();
+
+	val = page[0];
+
+	if (val != PAGE_BYTE) {
+		tst_res(TFAIL, "Async access corrupted content: got 0x%02x, expected 0x%02x",
+			val, PAGE_BYTE);
+		goto out;
+	}
+
+	pollfd.fd = uffd;
+	pollfd.events = POLLIN;
+	if (poll(&pollfd, 1, 0) != 0) {
+		tst_res(TFAIL, "Unexpected pagefault message in async mode");
+		goto out;
+	}
+
+	/* Phase 2: switch to sync mode via UFFDIO_SET_MODE. */
+	uffdio_set_mode.disable = UFFD_FEATURE_RWP_ASYNC;
+
+	SAFE_IOCTL(uffd, UFFDIO_SET_MODE, &uffdio_set_mode);
+
+	rwprotect_page();
+
+	SAFE_PTHREAD_CREATE(&thr, NULL, (void *)handle_thread, NULL);
+
+	val = page[0];
+
+	SAFE_PTHREAD_JOIN(thr, NULL);
+
+	if (!rwp_fault_seen) {
+		tst_res(TFAIL, "No RWPROTECT pagefault observed after switching to sync mode");
+		goto out;
+	}
+
+	if (val != PAGE_BYTE) {
+		tst_res(TFAIL, "Sync access corrupted content: got 0x%02x, expected 0x%02x",
+			val, PAGE_BYTE);
+		goto out;
+	}
+
+	tst_res(TPASS, "UFFDIO_SET_MODE toggled RWP_ASYNC correctly!");
+
+out:
+	reset_pages();
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.test_all = run,
+	.cleanup = reset_pages,
+};
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
