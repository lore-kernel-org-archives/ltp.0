Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7E1C433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 14:22:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92EB03C98A7
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 15:22:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D51F43C97E2
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 15:22:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8945420038B
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 15:22:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBCD0210FB;
 Tue,  1 Feb 2022 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643725352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sRg8UJMWYiJgvQNF+EmXqzh3AdOPZ4rd/lIeKAO63sk=;
 b=fXZCmhKmlXClakrWqs9Yz8aiSbvl2ZR+ayxbt0alvjw2uNy8sFh/ZXwEFiOCzAO8WWrb9V
 KyTW3qvM0iz35cJMZi2BTIXPJgxzYOEa7QVzkZcLU9jXVGKRpHeEU8tHIUVaXidQE6xffd
 TSY8Kt0QXbyaxquCD/a+3FIrk+3PxP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643725352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sRg8UJMWYiJgvQNF+EmXqzh3AdOPZ4rd/lIeKAO63sk=;
 b=+r8QmEJI77SyKUXxn8Kg7ZTU1eg9jfnEDVa6toyh89Qrg8UWKB21Pdp3MzvLuw8+qrhicQ
 DomR2VJ9HysQA2CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B452A13D7B;
 Tue,  1 Feb 2022 14:22:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 57fiKShC+WGVDgAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Tue, 01 Feb 2022 14:22:32 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Tue,  1 Feb 2022 15:22:30 +0100
Message-Id: <20220201142230.20243-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Extract libclone from testcases/kernel/containers
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

libclone has been added to the libs folder and updated with the new
LTP API. This library will be used by containers tests, which will be
updated to the new LTP API as well.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
---
 include/libclone.h          |  61 ++++++++++++++
 libs/libltpclone/Makefile   |  12 +++
 libs/libltpclone/libclone.c | 155 ++++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 include/libclone.h
 create mode 100644 libs/libltpclone/Makefile
 create mode 100644 libs/libltpclone/libclone.c

diff --git a/include/libclone.h b/include/libclone.h
new file mode 100644
index 000000000..9ffa35165
--- /dev/null
+++ b/include/libclone.h
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2007
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#ifndef __LIBCLONE_H
+#define __LIBCLONE_H
+
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/namespaces_constants.h"
+
+#define T_UNSHARE 0
+#define T_CLONE 1
+#define T_NONE 2
+
+#ifndef SYS_unshare
+#ifdef __NR_unshare
+#define SYS_unshare __NR_unshare
+#elif __i386__
+#define SYS_unshare 310
+#elif __ia64__
+#define SYS_unshare 1296
+#elif __x86_64__
+#define SYS_unshare 272
+#elif __s390x__ || __s390__
+#define SYS_unshare 303
+#elif __powerpc__
+#define SYS_unshare 282
+#else
+#error "unshare not supported on this architecure."
+#endif
+#endif
+
+#ifndef __NR_unshare
+#define __NR_unshare SYS_unshare
+#endif
+
+/*
+ * Run fn1 in a unshared environmnent, and fn2 in the original context
+ * Fn2 may be NULL.
+ */
+
+int tst_clone_tests(unsigned long clone_flags, int (*fn1)(void *arg),
+		    void *arg1, int (*fn2)(void *arg), void *arg2);
+
+int tst_unshare_tests(unsigned long clone_flags, int (*fn1)(void *arg),
+		      void *arg1, int (*fn2)(void *arg), void *arg2);
+
+int tst_fork_tests(int (*fn1)(void *arg), void *arg1, int (*fn2)(void *arg),
+		   void *arg2);
+
+int tst_clone_unshare_test(int use_clone, unsigned long clone_flags,
+			   int (*fn1)(void *arg), void *arg1);
+
+int tst_clone_unshare_tests(int use_clone, unsigned long clone_flags,
+			    int (*fn1)(void *arg), void *arg1,
+			    int (*fn2)(void *arg), void *arg2);
+
+#endif
diff --git a/libs/libltpclone/Makefile b/libs/libltpclone/Makefile
new file mode 100644
index 000000000..c869f6cf8
--- /dev/null
+++ b/libs/libltpclone/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) International Business Machines  Corp., 2007
+# Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+
+top_srcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+INTERNAL_LIB		= libltpclone.a
+
+include $(top_srcdir)/include/mk/lib.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/libs/libltpclone/libclone.c b/libs/libltpclone/libclone.c
new file mode 100644
index 000000000..869e8ac63
--- /dev/null
+++ b/libs/libltpclone/libclone.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) International Business Machines Corp., 2007
+ * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sched.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <libgen.h>
+#include <signal.h>
+
+#define TST_NO_DEFAULT_MAIN
+
+#include "libclone.h"
+#include "tst_test.h"
+#include "lapi/syscalls.h"
+#include "lapi/namespaces_constants.h"
+
+int tst_clone_tests(unsigned long clone_flags, int (*fn1)(void *arg),
+		    void *arg1, int (*fn2)(void *arg), void *arg2)
+{
+	int ret;
+
+	ret = ltp_clone_quick(clone_flags | SIGCHLD, fn1, arg1);
+
+	if (ret == -1) {
+		return -1;
+	}
+	if (fn2)
+		ret = fn2(arg2);
+	else
+		ret = 0;
+
+	return ret;
+}
+
+int tst_unshare_tests(unsigned long clone_flags, int (*fn1)(void *arg),
+		      void *arg1, int (*fn2)(void *arg), void *arg2)
+{
+	int pid, ret = 0;
+	int retpipe[2];
+	char buf[2];
+
+	SAFE_PIPE(retpipe);
+
+	pid = fork();
+	if (pid < 0) {
+		SAFE_CLOSE(retpipe[0]);
+		SAFE_CLOSE(retpipe[1]);
+		tst_brk(TBROK, "fork");
+	}
+
+	if (!pid) {
+		SAFE_CLOSE(retpipe[0]);
+
+		ret = tst_syscall(SYS_unshare, clone_flags);
+		if (ret == -1) {
+			SAFE_WRITE(1, retpipe[1], "0", 2);
+			SAFE_CLOSE(retpipe[1]);
+			exit(1);
+		} else {
+			SAFE_WRITE(1, retpipe[1], "1", 2);
+		}
+
+		SAFE_CLOSE(retpipe[1]);
+
+		ret = fn1(arg1);
+		exit(ret);
+	}
+
+	SAFE_CLOSE(retpipe[1]);
+	SAFE_READ(1, retpipe[0], &buf, 2);
+	SAFE_CLOSE(retpipe[0]);
+
+	if (*buf == '0')
+		return -1;
+
+	if (fn2)
+		ret = fn2(arg2);
+
+	return ret;
+}
+
+int tst_plain_tests(int (*fn1)(void *arg), void *arg1, int (*fn2)(void *arg),
+		    void *arg2)
+{
+	int ret = 0, pid;
+
+	pid = SAFE_FORK();
+	if (!pid)
+		exit(fn1(arg1));
+
+	if (fn2)
+		ret = fn2(arg2);
+
+	return ret;
+}
+
+int tst_clone_unshare_test(int use_clone, unsigned long clone_flags,
+			   int (*fn1)(void *arg), void *arg1)
+{
+	int ret = 0;
+
+	switch (use_clone) {
+	case T_NONE:
+		ret = tst_plain_tests(fn1, arg1, NULL, NULL);
+		break;
+	case T_CLONE:
+		ret = tst_clone_tests(clone_flags, fn1, arg1, NULL, NULL);
+		break;
+	case T_UNSHARE:
+		ret = tst_unshare_tests(clone_flags, fn1, arg1, NULL, NULL);
+		break;
+	default:
+		ret = -1;
+		tst_brk(TBROK, "%s: bad use_clone option: %d", __FUNCTION__,
+			use_clone);
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Run fn1 in a unshared environmnent, and fn2 in the original context
+ */
+int tst_clone_unshare_tests(int use_clone, unsigned long clone_flags,
+			    int (*fn1)(void *arg), void *arg1,
+			    int (*fn2)(void *arg), void *arg2)
+{
+	int ret = 0;
+
+	switch (use_clone) {
+	case T_NONE:
+		ret = tst_plain_tests(fn1, arg1, fn2, arg2);
+		break;
+	case T_CLONE:
+		ret = tst_clone_tests(clone_flags, fn1, arg1, fn2, arg2);
+		break;
+	case T_UNSHARE:
+		ret = tst_unshare_tests(clone_flags, fn1, arg1, fn2, arg2);
+		break;
+	default:
+		ret = -1;
+		tst_brk(TBROK, "%s: bad use_clone option: %d", __FUNCTION__,
+			use_clone);
+		break;
+	}
+
+	return ret;
+}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
