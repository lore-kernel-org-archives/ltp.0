Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B53EB64D8
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:02:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A74D63CC497
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 14:02:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B7B03CACC1
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:02:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3E668600665
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:02:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A8BF218B0;
 Tue, 20 Jun 2023 12:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687262523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHlPpeT4lqkF7u0R6oL6jjMgCfgDIAb4svty8/qd5sE=;
 b=l1Mv4BEueJ1gqLte0WqNhZRgZR8KJOZ1tpSUEk92iTwxhDu95MihjFoeN3ZwS6bgRykAdt
 OXfEJu7Qj0SqzAue8nSO86MBJ3f7qhly/Vf+RoZ0mPxjYlFw1atfmgGuY87KBz4v0KVU6o
 DAzap8ms83ugJGiwKaQYXSIdTdqC/58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687262523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yHlPpeT4lqkF7u0R6oL6jjMgCfgDIAb4svty8/qd5sE=;
 b=va7p++M8lamkbOvRvJyEFU5aa/zwSLIDv1v137J3CBsrYhzY/hZt8EnUvNexPuUI29nYJW
 SWyYkp8XZAldRrBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 088E1133A9;
 Tue, 20 Jun 2023 12:02:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8I+dADuVkWSQDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 20 Jun 2023 12:02:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 20 Jun 2023 14:01:57 +0200
Message-Id: <20230620120159.320052-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620120159.320052-1-pvorel@suse.cz>
References: <20230620120159.320052-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] ioprio: Move fallback constants and structs to
 LAPI header
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Originally lapi headers were only for common headers, for fallback
constants and structs usable only in test for particular subsystem,
we mix them together with other helper functions in header placed in the
test directory. But later we started to move to lapi also these
fallbacks (e.g. fanotify.h in a05dbc4fa).

+ Remove unused headers in the tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/lapi/ioprio.h                         | 47 +++++++++++++++++++
 testcases/kernel/syscalls/ioprio/ioprio.h     | 42 ++---------------
 .../kernel/syscalls/ioprio/ioprio_get01.c     |  3 --
 .../kernel/syscalls/ioprio/ioprio_set01.c     |  3 --
 .../kernel/syscalls/ioprio/ioprio_set02.c     |  3 --
 .../kernel/syscalls/ioprio/ioprio_set03.c     |  3 --
 6 files changed, 51 insertions(+), 50 deletions(-)
 create mode 100644 include/lapi/ioprio.h

diff --git a/include/lapi/ioprio.h b/include/lapi/ioprio.h
new file mode 100644
index 000000000..871aa0278
--- /dev/null
+++ b/include/lapi/ioprio.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2019 Linus Walleij <linus.walleij@linaro.org>
+ */
+
+#ifndef LAPI_IOPRIO_H__
+#define LAPI_IOPRIO_H__
+
+#include "config.h"
+
+#ifdef HAVE_LINUX_IOPRIO_H
+# include <linux/ioprio.h>
+#else
+
+enum {
+	IOPRIO_CLASS_NONE = 0,
+	IOPRIO_CLASS_RT,
+	IOPRIO_CLASS_BE,
+	IOPRIO_CLASS_IDLE,
+};
+
+enum {
+	IOPRIO_WHO_PROCESS = 1,
+	IOPRIO_WHO_PGRP,
+	IOPRIO_WHO_USER,
+};
+
+# define IOPRIO_CLASS_SHIFT	(13)
+# define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
+
+# define IOPRIO_PRIO_CLASS(data)	((data) >> IOPRIO_CLASS_SHIFT)
+# define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
+
+#endif
+
+/* The RT and BE I/O priority classes have 8 priority levels 0..7 */
+#ifdef IOPRIO_NR_LEVELS
+# define IOPRIO_PRIO_NUM		IOPRIO_NR_LEVELS
+#else
+# define IOPRIO_PRIO_NUM		8
+#endif
+
+#ifndef IOPRIO_PRIO_LEVEL
+# define IOPRIO_PRIO_LEVEL(data)	((data) & IOPRIO_PRIO_MASK)
+#endif
+
+#endif /* LAPI_IOPRIO_H__ */
diff --git a/testcases/kernel/syscalls/ioprio/ioprio.h b/testcases/kernel/syscalls/ioprio/ioprio.h
index 4d4828807..dbe27c15f 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio.h
+++ b/testcases/kernel/syscalls/ioprio/ioprio.h
@@ -1,48 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
  * Copyright (c) 2019 Linus Walleij <linus.walleij@linaro.org>
+ * Copyright (c) 2023 Linux Test Project
  */
 
 #ifndef LTP_IOPRIO_H
 #define LTP_IOPRIO_H
 
-#include "config.h"
-
-#ifdef HAVE_LINUX_IOPRIO_H
-# include <linux/ioprio.h>
-#else
-
-enum {
-	IOPRIO_CLASS_NONE = 0,
-	IOPRIO_CLASS_RT,
-	IOPRIO_CLASS_BE,
-	IOPRIO_CLASS_IDLE,
-};
-
-enum {
-	IOPRIO_WHO_PROCESS = 1,
-	IOPRIO_WHO_PGRP,
-	IOPRIO_WHO_USER,
-};
-
-# define IOPRIO_CLASS_SHIFT	(13)
-# define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)
-
-# define IOPRIO_PRIO_CLASS(data)	((data) >> IOPRIO_CLASS_SHIFT)
-# define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT) | data)
-
-#endif
-
-/* The RT and BE I/O priority classes have 8 priority levels 0..7 */
-#ifdef IOPRIO_NR_LEVELS
-# define IOPRIO_PRIO_NUM		IOPRIO_NR_LEVELS
-#else
-# define IOPRIO_PRIO_NUM		8
-#endif
-
-#ifndef IOPRIO_PRIO_LEVEL
-# define IOPRIO_PRIO_LEVEL(data)	((data) & IOPRIO_PRIO_MASK)
-#endif
+#include "lapi/ioprio.h"
+#include "lapi/syscalls.h"
 
 static const char * const to_class_str[] = {
 	[IOPRIO_CLASS_NONE] = "NONE",
@@ -106,4 +72,4 @@ static inline void ioprio_check_setting(int class, int prio, int report)
 			newprio);
 }
 
-#endif
+#endif /* LTP_IOPRIO_H */
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_get01.c b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
index 6e822434e..ceac5a758 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_get01.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_get01.c
@@ -6,11 +6,8 @@
  * Basic ioprio_get() test. Gets the current process I/O priority and
  * checks that the values are sane.
  */
-#include <sys/types.h>
-#include <sys/syscall.h>
 
 #include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "ioprio.h"
 
 static void run(void)
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set01.c b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
index 19953ba36..243337bd2 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set01.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set01.c
@@ -7,11 +7,8 @@
  * bumps it up one notch, then down two notches and checks that the
  * new priority is reported back correctly.
  */
-#include <sys/types.h>
-#include <sys/syscall.h>
 
 #include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "ioprio.h"
 
 static int orig_class;
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set02.c b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
index 328a130cb..0faf03767 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set02.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set02.c
@@ -7,11 +7,8 @@
  * Tests to set all 8 priority levels for best effort priority, then
  * switches to test all 8 priority levels for idle priority.
  */
-#include <sys/types.h>
-#include <sys/syscall.h>
 
 #include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "ioprio.h"
 
 static void run(void)
diff --git a/testcases/kernel/syscalls/ioprio/ioprio_set03.c b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
index d6b44df85..b67887205 100644
--- a/testcases/kernel/syscalls/ioprio/ioprio_set03.c
+++ b/testcases/kernel/syscalls/ioprio/ioprio_set03.c
@@ -6,11 +6,8 @@
  * Negative ioprio_set() test. Test some non-working priorities to make
  * sure they don't work.
  */
-#include <sys/types.h>
-#include <sys/syscall.h>
 
 #include "tst_test.h"
-#include "lapi/syscalls.h"
 #include "ioprio.h"
 
 static void run(void)
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
