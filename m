Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A547CC28CF5
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 12:36:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EE403C96E4
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 13:36:28 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E4D13C95FF
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 01629200C63
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6CE921F3B0;
 Wed, 26 Jan 2022 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643200556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZBL8dSdf1ie6uOHZhoCrXwEKXu4QNHmvW0+MUYY18s=;
 b=MU06LYllozRMt7zV0hPwsJYOAJfi/r80T+LPvq/tjRnt/YFzvTAVFjDXFnYE6FaRWmlV0O
 DKa04/ErKfljRSaPY/bnIGArmuCOrFRtHO+ExMJepfNsyRf6/oGWbWn3cmfmCGOfB1ZnVM
 nO+U3/F8Hov9tKUU8qWMAICxiwcKieE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643200556;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZBL8dSdf1ie6uOHZhoCrXwEKXu4QNHmvW0+MUYY18s=;
 b=RHPJKIjB2+iiQBB1LyY/zQD6FLUYW3umDqr1HlvilDoDZ971odUfNZKh5Yljcj9QAZOYb9
 p+NE6Z+qR9QGTxAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45E5A13BB5;
 Wed, 26 Jan 2022 12:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kDaTDyxA8WGkOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 12:35:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 13:35:43 +0100
Message-Id: <20220126123547.13298-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126123547.13298-1-pvorel@suse.cz>
References: <20220126123547.13298-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v2 3/7] m4: Remove check for struct perf_event_attr
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It was added by Ingo Molnar in 2009 to perf_event_open01.c after his
change to in v2.6.32-rc1 cdd6c482c9ff ("perf: Do the big rename:
Performance Counters -> Performance Events"), where he renamed struct
perf_counter_attr to struct perf_event_attr and rename header where
defined from include/linux/perf_counter.h to include/linux/perf_event.h.

It was safe to remove the check long time ago. Not checking for
linux/perf_event.h because although we check for some kernel headers
presence, we expect kernel headers to be installed.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2

 configure.ac                                     |  1 -
 m4/ltp-perf_event_open.m4                        | 16 ----------------
 testcases/cve/cve-2015-3290.c                    |  7 ++++---
 .../syscalls/perf_event_open/perf_event_open01.c | 16 ++--------------
 .../syscalls/perf_event_open/perf_event_open02.c |  8 +-------
 .../syscalls/perf_event_open/perf_event_open03.c |  7 +------
 6 files changed, 8 insertions(+), 47 deletions(-)
 delete mode 100644 m4/ltp-perf_event_open.m4

diff --git a/configure.ac b/configure.ac
index 8becd74c2c..6ff761837a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -376,7 +376,6 @@ fi
 AC_DEFINE_UNQUOTED(NUMA_ERROR_MSG, ["$numa_error_msg"], [Error message when no NUMA support])
 
 
-LTP_CHECK_SYSCALL_PERF_EVENT_OPEN
 LTP_CHECK_SYSCALL_SIGNALFD
 LTP_CHECK_SYSCALL_UTIMENSAT
 LTP_CHECK_TASKSTATS
diff --git a/m4/ltp-perf_event_open.m4 b/m4/ltp-perf_event_open.m4
deleted file mode 100644
index 6966cf2708..0000000000
--- a/m4/ltp-perf_event_open.m4
+++ /dev/null
@@ -1,16 +0,0 @@
-dnl SPDX-License-Identifier: GPL-2.0-or-later
-dnl Copyright (c) 2014 Fujitsu Ltd.
-dnl Copyright (c) 2014 Cyril Hrubis <chrubis@suse.cz>
-dnl Author: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
-
-AC_DEFUN([LTP_CHECK_SYSCALL_PERF_EVENT_OPEN],[
-AH_TEMPLATE(HAVE_PERF_EVENT_ATTR,
-[Define to 1 if you have struct perf_event_attr])
-AC_MSG_CHECKING([for perf_event_attr in linux/perf_event.h])
-AC_TRY_COMPILE([#include <unistd.h>
-		#include <linux/perf_event.h>],
-		[
-			struct perf_event_attr pe;
-		],
-		AC_DEFINE(HAVE_PERF_EVENT_ATTR) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
-])
diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index 6c4fd57acc..fd1abe136d 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2017 Pavel Boldin <pboldin@cloudlinux.com>
+ * Copyright (c) 2018-2022 Linux Test Project
  */
 
 /*
@@ -117,7 +118,7 @@ perhaps unsurprisingly.)
 #include "tst_test.h"
 #include "tst_timer.h"
 
-#if HAVE_PERF_EVENT_ATTR && (defined(__x86_64__) || defined(__i386__))
+#if defined(__x86_64__) || defined(__i386__)
 
 #include <stdlib.h>
 #include <stdio.h>
@@ -476,8 +477,8 @@ static struct tst_test test = {
 	}
 };
 
-#else /* HAVE_PERF_EVENT_ATTR && (defined(__x86_64__) || defined(__i386__)) */
+#else /* defined(__x86_64__) || defined(__i386__) */
 
-TST_TEST_TCONF("no perf_event_attr or not (i386 or x86_64)");
+TST_TEST_TCONF("not (i386 or x86_64)");
 
 #endif
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
index 3807b2df10..30c0d7594f 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
@@ -1,6 +1,7 @@
 /******************************************************************************/
 /*                                                                            */
 /* Ingo Molnar <mingo@elte.hu>, 2009                                          */
+/* Copyright (c) Linux Test Project, 2014-2022                                */
 /*                                                                            */
 /* This program is free software;  you can redistribute it and/or modify      */
 /* it under the terms of the GNU General Public License as published by       */
@@ -38,9 +39,7 @@
 #include <fcntl.h>
 #include <stdint.h>
 #include "config.h"
-#if HAVE_PERF_EVENT_ATTR
-# include <linux/perf_event.h>
-#endif
+#include <linux/perf_event.h>
 
 #include "test.h"
 #include "lapi/syscalls.h"
@@ -48,7 +47,6 @@
 
 char *TCID = "perf_event_open01";
 
-#if HAVE_PERF_EVENT_ATTR
 static void setup(void);
 static void cleanup(void);
 
@@ -198,13 +196,3 @@ static void verify(struct test_case_t *tc)
 static void cleanup(void)
 {
 }
-
-#else
-
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "This system doesn't have "
-		 "header file:<linux/perf_event.h> or "
-		 "no struct perf_event_attr defined");
-}
-#endif
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 0335a296e8..618a270160 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2009 Paul Mackerras <paulus@samba.org>
- * Copyright (c) 2019 Linux Test Project
+ * Copyright (c) 2014-2022 Linux Test Project
  */
 /*
  * Here's a little test program that checks whether software counters
@@ -45,7 +45,6 @@
 #include "lapi/cpuset.h"
 #include "lapi/syscalls.h"
 
-#if HAVE_PERF_EVENT_ATTR
 #include "perf_event_open.h"
 
 #define MAX_CTRS	1000
@@ -336,8 +335,3 @@ static struct tst_test test = {
 	.test_all = verify,
 	.needs_root = 1,
 };
-
-#else /* HAVE_PERF_EVENT_ATTR */
-TST_TEST_TCONF("This system doesn't have <linux/perf_event.h> or "
-	"struct perf_event_attr is not defined.");
-#endif
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
index f58bea79e8..dcb7096277 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2021 SUSE LLC <mdoucha@suse.cz>
+ * Copyright (c) 2022 Linux Test Project
  *
  * CVE-2020-25704
  *
@@ -17,7 +18,6 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
-#if HAVE_PERF_EVENT_ATTR
 #include "perf_event_open.h"
 
 #define INTEL_PT_PATH "/sys/bus/event_source/devices/intel_pt/type"
@@ -77,8 +77,3 @@ static struct tst_test test = {
 		{}
 	}
 };
-
-#else /* HAVE_PERF_EVENT_ATTR */
-TST_TEST_TCONF("This system doesn't have <linux/perf_event.h> or "
-	"struct perf_event_attr is not defined.");
-#endif
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
