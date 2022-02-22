Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC395C433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 08:41:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EED923CA1AF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 09:41:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02E673CA1BA
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:41:25 +0100 (CET)
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com
 [85.158.142.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ABACC20075C
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 09:41:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1645519283; i=@fujitsu.com;
 bh=sfkiSgRVEdumQ3d117BSxCiul1IAjxncLrRFxpPmxpo=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=TyRT+C5GpRofKj3SuJH1Pn5qnd/pqJKd1makezUzc+yynKsLH2bWAiKzpswKsFbLt
 espif7cHXF58gTFEC9cX1qK8LvfNbSgp65FioMlpMmbBldG0zIQ8JYY10RvcUPkAru
 80yx35FoL+Mf+fS07qgkv3rSq0m6h83CaVnzCKPoCGK9oXdRB6so19DkUp6E1qMjBn
 06SqriTyzWb84682k1UadgF4w8UYAY/JhYRiULib4NoVykwwIRgduV4YWhVgewHk+l
 Q82jPpekwI398qjDLTF0rlGXsiR/oUOTbNpL7qmdJGY24eGjQS10odHPieD84axVgG
 DhlZ171/+eGCA==
Received: from [100.115.69.48] (using TLSv1.2 with cipher
 DHE-RSA-AES256-GCM-SHA384 (256 bits))
 by server-2.bemta.az-a.eu-central-1.aws.ess.symcld.net id 78/C2-30582-3B1A4126;
 Tue, 22 Feb 2022 08:41:23 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRWlGSWpSXmKPExsViZ8ORqLtyoUi
 Swf2dkhYrvu9gdGD02Pd7HWsAYxRrZl5SfkUCa8bGfwtYC274VCxuusbUwPjauYuRi0NI4Cyj
 xKJlR5khnJ1MEq0X/7JCOHsYJX6evsTWxcjJwSagKfGscwEziC0iICHR0fCWHcRmFlCXWD7pF
 xOILSxgL/G98TpYnEVAVeLm6+9gvbwCHhIzp8xkBbElBBQkpjx8zwwRF5Q4OfMJC8QcCYmDL1
 4wQ9QoSlzq+MYIYVdIzJrVxgRhq0lcPbeJeQIj/ywk7bOQtC9gZFrFaJdUlJmeUZKbmJmja2h
 goGtoaKprZqZraGqql1ilm6iXWqqbnJpXUpQIlNZLLC/WSy0u1iuuzE3OSdHLSy3ZxAgMz5Ri
 p9k7GHf0/dQ7xCjJwaQkyvt1ikiSEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQnepfOAcoJFqempF
 WmZOcBYgUlLcPAoifBumQ2U5i0uSMwtzkyHSJ1iVJQS5xVYAJQQAElklObBtcHi8xKjrJQwLy
 MDA4MQT0FqUW5mCar8K0ZxDkYlYd6w+UBTeDLzSuCmvwJazAS0eEqWEMjikkSElFQDk67Jqym
 2ez73M145e/JCfdTfp/sCfh8o7amJ+dMc/cA/TGvCiTN3JaR3Te1dLJYbz8i9Q9UjSvu6xhb1
 3ZFmR68cLRDctkZ05ga/2W+T9P7HlWWZlCwzSn9yc7/+ipC+v2bLp4W9Tbpe16t6tfUa96YN+
 Sq7Vq0IPbtroZLLFGv79gPnl/v9/bjNt1hcKfnFjTXGk8I9eXY2LH3JxtMdsSru1CkO1eexe5
 b3nTi9/BrXS6P8vVYW67Y4avgdeSev8KLwCEPr0in3+65H5lVLbPrg/fyiyLrTvzV2fFW/9vT
 LZ/PeziPT1stut99cslzh+7M9Vxn4XHbPt7vicPY/vzXDPn/Gayvqb5Q/WuUyQ1FZiaU4I9FQ
 i7moOBEAoypCe0oDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-545.messagelabs.com!1645519273!2734!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.7; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 10572 invoked from network); 22 Feb 2022 08:41:13 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-13.tower-545.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 22 Feb 2022 08:41:13 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id DE6EE100196
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:41:12 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id DC11F100192
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 08:41:12 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.28; Tue, 22 Feb 2022 08:40:50 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 22 Feb 2022 16:41:06 +0800
Message-ID: <1645519272-2733-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/7] Merge multiple pidfd*.h into one header
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

Since pidfd_getfd.h/pidfd_send_signal.h/pidfd_open.h doesn't have own struct
definition, it only about syscall wrapper. Kernel also doesn't have the same
name headers.

So use pidfd.h instead of own header. It is also convenient to add the safe
macros or case uses multiple pidfd syscalls in the future.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/pidfd.h                          | 58 +++++++++++++++++++
 include/lapi/pidfd_getfd.h                    | 26 ---------
 include/lapi/pidfd_open.h                     | 28 ---------
 include/lapi/pidfd_send_signal.h              | 27 ---------
 testcases/kernel/syscalls/clone3/clone301.c   |  2 +-
 .../kernel/syscalls/fanotify/fanotify21.c     |  2 +-
 .../kernel/syscalls/pidfd_open/pidfd_open01.c |  3 +-
 .../kernel/syscalls/pidfd_open/pidfd_open02.c |  2 +-
 .../kernel/syscalls/pidfd_open/pidfd_open03.c |  2 +-
 .../kernel/syscalls/pidfd_open/pidfd_open04.c |  7 +--
 .../pidfd_send_signal/pidfd_send_signal01.c   |  3 +-
 .../pidfd_send_signal/pidfd_send_signal02.c   |  3 +-
 .../pidfd_send_signal/pidfd_send_signal03.c   |  3 +-
 13 files changed, 70 insertions(+), 96 deletions(-)
 create mode 100644 include/lapi/pidfd.h
 delete mode 100644 include/lapi/pidfd_getfd.h
 delete mode 100644 include/lapi/pidfd_open.h
 delete mode 100644 include/lapi/pidfd_send_signal.h

diff --git a/include/lapi/pidfd.h b/include/lapi/pidfd.h
new file mode 100644
index 000000000..244d3acaf
--- /dev/null
+++ b/include/lapi/pidfd.h
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
+ * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
+ */
+
+#ifndef LAPI_PIDFD_H__
+#define LAPI_PIDFD_H__
+
+#include <fcntl.h>
+#include "config.h"
+#include "lapi/syscalls.h"
+
+#ifndef PIDFD_NONBLOCK
+#define PIDFD_NONBLOCK O_NONBLOCK
+#endif
+
+static inline void pidfd_send_signal_supported(void)
+{
+	/* allow the tests to fail early */
+	tst_syscall(__NR_pidfd_send_signal);
+}
+
+#ifndef HAVE_PIDFD_SEND_SIGNAL
+static inline int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+				    unsigned int flags)
+{
+	return tst_syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
+}
+#endif
+
+static inline void pidfd_open_supported(void)
+{
+	/* allow the tests to fail early */
+	tst_syscall(__NR_pidfd_open);
+}
+
+#ifndef HAVE_PIDFD_OPEN
+static inline int pidfd_open(pid_t pid, unsigned int flags)
+{
+	return tst_syscall(__NR_pidfd_open, pid, flags);
+}
+#endif
+
+static inline void pidfd_getfd_supported(void)
+{
+	/* allow the tests to fail early */
+	tst_syscall(__NR_pidfd_getfd);
+}
+
+#ifndef HAVE_PIDFD_GETFD
+static inline int pidfd_getfd(int pidfd, int targetfd, unsigned int flags)
+{
+	return tst_syscall(__NR_pidfd_getfd, pidfd, targetfd, flags);
+}
+#endif
+
+#endif /* LAPI_PIDFD_H__ */
diff --git a/include/lapi/pidfd_getfd.h b/include/lapi/pidfd_getfd.h
deleted file mode 100644
index c6778163d..000000000
--- a/include/lapi/pidfd_getfd.h
+++ /dev/null
@@ -1,26 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
- * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
- */
-
-#ifndef LAPI_PIDFD_GETFD_H__
-#define LAPI_PIDFD_GETFD_H__
-
-#include "config.h"
-#include "lapi/syscalls.h"
-
-static inline void pidfd_getfd_supported(void)
-{
-	/* allow the tests to fail early */
-	tst_syscall(__NR_pidfd_getfd);
-}
-
-#ifndef HAVE_PIDFD_GETFD
-static inline int pidfd_getfd(int pidfd, int targetfd, unsigned int flags)
-{
-	return tst_syscall(__NR_pidfd_getfd, pidfd, targetfd, flags);
-}
-#endif
-
-#endif /* LAPI_PIDFD_GETFD_H__ */
diff --git a/include/lapi/pidfd_open.h b/include/lapi/pidfd_open.h
deleted file mode 100644
index 5cf10933e..000000000
--- a/include/lapi/pidfd_open.h
+++ /dev/null
@@ -1,28 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2020 Linaro Limited. All rights reserved.
- * Author: Viresh Kumar <viresh.kumar@linaro.org>
- */
-
-#ifndef LAPI_PIDFD_OPEN_H__
-#define LAPI_PIDFD_OPEN_H__
-
-#include <sys/syscall.h>
-#include <sys/types.h>
-#include "lapi/syscalls.h"
-#include "config.h"
-
-static inline void pidfd_open_supported(void)
-{
-	/* allow the tests to fail early */
-	tst_syscall(__NR_pidfd_open);
-}
-
-#ifndef HAVE_PIDFD_OPEN
-static inline int pidfd_open(pid_t pid, unsigned int flags)
-{
-	return tst_syscall(__NR_pidfd_open, pid, flags);
-}
-#endif
-
-#endif /* LAPI_PIDFD_OPEN_H__ */
diff --git a/include/lapi/pidfd_send_signal.h b/include/lapi/pidfd_send_signal.h
deleted file mode 100644
index 7426a91da..000000000
--- a/include/lapi/pidfd_send_signal.h
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2019 SUSE LLC
- * Author: Christian Amann <camann@suse.com>
- */
-
-#ifndef LAPI_PIDFD_SEND_SIGNAL_H__
-#define LAPI_PIDFD_SEND_SIGNAL_H__
-
-#include "tst_test.h"
-#include "lapi/syscalls.h"
-
-static inline void pidfd_send_signal_supported(void)
-{
-	/* allow the tests to fail early */
-	tst_syscall(__NR_pidfd_send_signal);
-}
-
-#ifndef HAVE_PIDFD_SEND_SIGNAL
-static inline int pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
-                                    unsigned int flags)
-{
-	return tst_syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
-}
-#endif /* HAVE_PIDFD_SEND_SIGNAL */
-
-#endif /* LAPI_PIDFD_SEND_SIGNAL_H__ */
diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
index 7ac4bb5a3..f7ef0b2d7 100644
--- a/testcases/kernel/syscalls/clone3/clone301.c
+++ b/testcases/kernel/syscalls/clone3/clone301.c
@@ -16,7 +16,7 @@
 
 #include "tst_test.h"
 #include "lapi/clone.h"
-#include "lapi/pidfd_send_signal.h"
+#include "lapi/pidfd.h"
 
 #define CHILD_SIGNAL	SIGUSR1
 #define DATA	777
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 6ae70c57e..bd6429ab5 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -23,7 +23,7 @@
 #include <string.h>
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
-#include "lapi/pidfd_open.h"
+#include "lapi/pidfd.h"
 
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
index c0e88647f..6f1e95ba8 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
@@ -13,9 +13,8 @@
  */
 
 #include <unistd.h>
-#include <fcntl.h>
 #include "tst_test.h"
-#include "lapi/pidfd_open.h"
+#include "lapi/pidfd.h"
 
 static void run(void)
 {
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
index 93a61a51d..9d6c9321d 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
@@ -13,7 +13,7 @@
  * - EINVAL flags is not valid
  */
 #include "tst_test.h"
-#include "lapi/pidfd_open.h"
+#include "lapi/pidfd.h"
 
 static pid_t expired_pid, my_pid, invalid_pid = -1;
 
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
index 7c7c75cb1..16a8442f5 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
@@ -15,7 +15,7 @@
 #include <stdlib.h>
 
 #include "tst_test.h"
-#include "lapi/pidfd_open.h"
+#include "lapi/pidfd.h"
 
 static void run(void)
 {
diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
index e94bb20db..60080c0c8 100644
--- a/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open04.c
@@ -12,15 +12,10 @@
  */
 
 #include <unistd.h>
-#include <fcntl.h>
 #include <sys/wait.h>
 #include <stdlib.h>
 #include "tst_test.h"
-#include "lapi/pidfd_open.h"
-
-#ifndef PIDFD_NONBLOCK
-#define PIDFD_NONBLOCK O_NONBLOCK
-#endif
+#include "lapi/pidfd.h"
 
 #ifndef P_PIDFD
 #define P_PIDFD  3
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
index 4cb5df94c..3d201aa9d 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal01.c
@@ -12,7 +12,8 @@
 #define _GNU_SOURCE
 #include <signal.h>
 #include <stdlib.h>
-#include "lapi/pidfd_send_signal.h"
+#include "tst_test.h"
+#include "lapi/pidfd.h"
 #include "tst_safe_pthread.h"
 
 #define SIGNAL  SIGUSR1
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
index 1e62b417f..9600fc2f9 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal02.c
@@ -24,7 +24,8 @@
 #define _GNU_SOURCE
 #include <pwd.h>
 #include <signal.h>
-#include "lapi/pidfd_send_signal.h"
+#include "tst_test.h"
+#include "lapi/pidfd.h"
 #include "tst_safe_pthread.h"
 
 #define CORRECT_SIGNAL		SIGUSR1
diff --git a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
index 0903d6707..fb61516d7 100644
--- a/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
+++ b/testcases/kernel/syscalls/pidfd_send_signal/pidfd_send_signal03.c
@@ -19,7 +19,8 @@
 #include <signal.h>
 #include <stdio.h>
 #include <unistd.h>
-#include "lapi/pidfd_send_signal.h"
+#include "tst_test.h"
+#include "lapi/pidfd.h"
 #include "tst_safe_pthread.h"
 
 #define PIDTRIES	3
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
