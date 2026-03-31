Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326D810F9304
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 22:04:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB1563E5BE2
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 00:04:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B83013C9314
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 00:03:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2C119200758
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 00:03:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6055E5BD35;
 Tue, 31 Mar 2026 22:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774994638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wgBw0PE5P5lWlIZh/iILgV1TIfWKVlTRbcyS5ZhweUM=;
 b=ZQvYq7mu3AGIy/4NBn2prHwoVhL2D8ZJ30TDN05/f500EK7DSSF1KvuiodXGuHKHqx6BTq
 RRMGk5YX0kdhir70rm4uNNRfLsYCLRbmog1Jzkxoc3eeXRJZuWpyVwFG1x2825y/abjJuu
 7i1spJAGNsFow3DsdxpxqHnz61p2k40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774994638;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wgBw0PE5P5lWlIZh/iILgV1TIfWKVlTRbcyS5ZhweUM=;
 b=esvZVzxDIEHVzYG8pPk2eqWE0JMTVriyzpdtpv+eiQfELb9kcwfipI2AbqPI2V38tzy1LQ
 Mui+J06zTVC8UNCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774994637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wgBw0PE5P5lWlIZh/iILgV1TIfWKVlTRbcyS5ZhweUM=;
 b=mqC1jp4sG8hoYxCCTD7k6dG7UhBGTq1adNzFGc3zYU+4IvYXW8CnXENkYIJwLezHl6+nVP
 QVtEMQeAPH7ueyWbNx9Nr3sBARcLIHyYEkM5JxM0FkPxRZxTz52ulP86rq9IGlcguLEuTp
 kDGSFoXHn1qxin+RTzuotFyBMmSDAyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774994637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wgBw0PE5P5lWlIZh/iILgV1TIfWKVlTRbcyS5ZhweUM=;
 b=aRgy7sRfD5NK27+SAPu0zC73rWzQQar6CzT222c9gfHuAsU+L95stFRRea9LhxoC2IcQC2
 KdHHrNp1q+LqmKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DE944A0A2;
 Tue, 31 Mar 2026 22:03:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QitbDc1EzGnXagAAD6G6ig
 (envelope-from <rbranco@suse.de>); Tue, 31 Mar 2026 22:03:57 +0000
From: Ricardo Branco <rbranco@suse.de>
To: ltp@lists.linux.it
Date: Wed,  1 Apr 2026 00:03:53 +0200
Message-ID: <20260331220354.297027-1-rbranco@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.995];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,pollfd.events:url];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] userfaultfd: Add new test using UFFDIO_CONTINUE
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

Add test to exercise UFFDIO_CONTINUE on a shared-memory mapping with
UFFD_PAGEFAULT_FLAG_MINOR. The test populates a memfd-backed page,
drops only the PTEs with MADV_DONTNEED, verifies that the resulting
fault is reported as MINOR, updates the page cache from the handler
thread, and resumes execution with UFFDIO_CONTINUE.

Signed-off-by: Ricardo Branco <rbranco@suse.de>
---
 include/lapi/userfaultfd.h                    |   1 +
 runtest/syscalls                              |   1 +
 .../kernel/syscalls/userfaultfd/.gitignore    |   1 +
 .../kernel/syscalls/userfaultfd/Makefile      |   1 +
 .../syscalls/userfaultfd/userfaultfd07.c      | 152 ++++++++++++++++++
 5 files changed, 156 insertions(+)
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
index 000000000..9d37589e8
--- /dev/null
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd07.c
@@ -0,0 +1,152 @@
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
+static void set_pages(void)
+{
+	char ch = 'A';
+
+	page_size = SAFE_SYSCONF(_SC_PAGE_SIZE);
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
+	if (memfd != -1)
+		memfd = -1;
+
+	if (uffd != -1)
+		SAFE_CLOSE(uffd);
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
