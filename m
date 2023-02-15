Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23A0C61DA4
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 02:36:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 002D03CC960
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 03:36:34 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD0CE3CBF90
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 03:36:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B7E31400B8B
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 03:36:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 067DE1F74B;
 Wed, 15 Feb 2023 02:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1676428580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=25Y+F9Box8HadZemax1YZ4Bc4zfQ6uu+mWAAxdlG1Xk=;
 b=h5GlwUN5HGDazp1wiKxo1KvLI9PWlb6YYG1srt1Mer7BNTHB0k6agAjT+NvkAYRUCmb5u7
 cVpPrx3TqZYXwC0rcYLAvB/bZfZnzSAhYK5D6LjrEI49nNCWR9SrkodrlFWSA3EbJIQJTH
 57trbD1IjGBT7cRGxGxQIaoIIzNdqW0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6511C138E3;
 Wed, 15 Feb 2023 02:36:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7T3cDiNF7GPuZQAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 15 Feb 2023 02:36:19 +0000
To: ltp@lists.linux.it
Date: Tue, 14 Feb 2023 21:34:39 -0500
Message-Id: <20230215023438.11370-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230213134619.27486-1-wegao@suse.com>
References: <20230213134619.27486-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] rseq01: basic test rseq
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

Add basic check for the newly added glibc API in LTP.
This test references the glibc test case tst-rseq.c.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 configure.ac                              |  1 +
 include/lapi/rseq.h                       | 57 +++++++++++++++++++++++
 runtest/syscalls                          |  2 +
 testcases/kernel/syscalls/rseq/.gitignore |  1 +
 testcases/kernel/syscalls/rseq/Makefile   |  7 +++
 testcases/kernel/syscalls/rseq/rseq01.c   | 28 +++++++++++
 6 files changed, 96 insertions(+)
 create mode 100644 include/lapi/rseq.h
 create mode 100644 testcases/kernel/syscalls/rseq/.gitignore
 create mode 100644 testcases/kernel/syscalls/rseq/Makefile
 create mode 100644 testcases/kernel/syscalls/rseq/rseq01.c

diff --git a/configure.ac b/configure.ac
index c2b0f48e7..43b9ca3ce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -80,6 +80,7 @@ AC_CHECK_HEADERS_ONCE([ \
     sys/utsname.h \
     sys/xattr.h \
     xfs/xqm.h \
+    sys/rseq.h \
 ])
 AC_CHECK_HEADERS(fts.h, [have_fts=1])
 AC_SUBST(HAVE_FTS_H, $have_fts)
diff --git a/include/lapi/rseq.h b/include/lapi/rseq.h
new file mode 100644
index 000000000..7f4834f2c
--- /dev/null
+++ b/include/lapi/rseq.h
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021-2023 Free Software Foundation, Inc.
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+#ifndef LAPI_RSEQ_H__
+#define LAPI_RSEQ_H__
+
+#include <errno.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <syscall.h>
+#include "config.h"
+#include "tst_test.h"
+
+
+#if defined(HAVE_SYS_RSEQ_H)
+# include <sys/rseq.h>
+#endif
+
+
+#if defined(HAVE_SYS_RSEQ_H) && defined(RSEQ_SIG)
+static int sys_rseq(struct rseq *rseq_abi, uint32_t rseq_len, int flags, uint32_t sig)
+{
+	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
+}
+
+static void check_rseq_available(void)
+{
+	int rc;
+
+	rc = sys_rseq(NULL, 0, 0, 0);
+	if (rc != -1)
+		tst_brk(TFAIL | TTERRNO, "Unexpected rseq return value %d ", rc);
+	switch (errno) {
+	case ENOSYS:
+		tst_brk(TCONF,
+				"kernel does not support rseq, skipping test");
+	case EINVAL:
+		/* rseq is implemented, but detected an invalid rseq_len parameter.  */
+		break;
+	default:
+		tst_brk(TFAIL | TTERRNO, "Unexpected rseq error ");
+	}
+}
+#else /* HAVE_SYS_RSEQ_H && RSEQ_SIG */
+static void check_rseq_available(void)
+{
+	tst_brk(TCONF,
+		"glibc does not support rseq, skipping test");
+}
+#endif /* HAVE_SYS_RSEQ_H && RSEQ_SIG */
+
+#endif /* LAPI_RSEQ_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index ae37a1192..f46950b27 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1752,6 +1752,8 @@ copy_file_range01 copy_file_range01
 copy_file_range02 copy_file_range02
 copy_file_range03 copy_file_range03
 
+rseq01 rseq01
+
 statx01 statx01
 statx02 statx02
 statx03 statx03
diff --git a/testcases/kernel/syscalls/rseq/.gitignore b/testcases/kernel/syscalls/rseq/.gitignore
new file mode 100644
index 000000000..8a6c7ee36
--- /dev/null
+++ b/testcases/kernel/syscalls/rseq/.gitignore
@@ -0,0 +1 @@
+/rseq01
diff --git a/testcases/kernel/syscalls/rseq/Makefile b/testcases/kernel/syscalls/rseq/Makefile
new file mode 100644
index 000000000..159d5651c
--- /dev/null
+++ b/testcases/kernel/syscalls/rseq/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#  Copyright (C) 2012 Linux Test Project, Inc.
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/rseq/rseq01.c b/testcases/kernel/syscalls/rseq/rseq01.c
new file mode 100644
index 000000000..6f3e7ff97
--- /dev/null
+++ b/testcases/kernel/syscalls/rseq/rseq01.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021-2023 Free Software Foundation, Inc.
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
+ */
+
+/*\
+ * [Description]
+ *
+ * Restartable Sequences basic tests.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <sched.h>
+#include "lapi/rseq.h"
+
+static void run(void)
+{
+	check_rseq_available();
+
+	TST_EXP_PASS(!(sched_getcpu() >= 0));
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
