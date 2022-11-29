Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A46C4332F
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 05:40:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D24C3CC591
	for <ltp@archiver.kernel.org>; Tue, 29 Nov 2022 06:40:39 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32A573CC590
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 06:40:28 +0100 (CET)
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com
 [195.245.230.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 154F66005E0
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 06:40:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1669700425; i=@fujitsu.com;
 bh=X3vvMXA1jI74qO00gUaHRN4dP0VQEw5ekNcpDlYtr5s=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=ILsbAU5QOEyItf5yZBUK1LMnSBhKILgoWWTyGncABrweU4N8i7jiArnhFd2PiEdtG
 G+nkvtjO1yiFEvdtmMNv1UTZySrbFesDe6JC64pLJezIh/9GyvwI7+mOekG74cHjvW
 5BKU3qAfVr73wGDd6FwJGa/COKWS6du169PscyqYkg2fKN1hGWqL2Ynh6vryOPk3q9
 IWNBynnbTNQcvB9jonVkhxfeZJLhtmVyKXOqIQQufXYcB3XGooOpE6k/qKu8tYLMjj
 d5rU37c8wFGrXdWjbhTzKoxyyf32pJcCBlOu8G1PBk5JwuYYmhqnAFjo46F/vLFbMu
 OxlKP6Y3WiPIg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRWlGSWpSXmKPExsViZ8ORqOsxuzX
 Z4OAkKYsV33cwOjB67Pu9jjWAMYo1My8pvyKBNePK0sOsBdMmMlY0zuxnb2Bc38jYxcjFISRw
 llHiw+4nUM4BJolzp3awdTFyAjl7GCVer1IEsdkENCWedS5gBrFFBCQkOhresoPYzALqEssn/
 WICsYUF4iR2PtwKVsMioCqx/8RjsDivgIfEplcbwWwJAQWJKQ/fM0PEBSVOznzCAjFHQuLgix
 fMEDWKEpc6vjFC2BUSs2a1QfWqSVw9t4l5AiP/LCTts5C0L2BkWsVoVpxaVJZapGtorpdUlJm
 eUZKbmJmjl1ilm6iXWqpbnlpcomuol1herJdaXKxXXJmbnJOil5dasokRGJApxewCOxiPLPuj
 d4hRkoNJSZT3RUVrshBfUn5KZUZicUZ8UWlOavEhRhkODiUJXsUZQDnBotT01Iq0zBxgdMCkJ
 Th4lER47SqB0rzFBYm5xZnpEKlTjMYcaxsO7GXmmDr7335mIZa8/LxUKXHenFlApQIgpRmleX
 CDYFF7iVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iwb/B0oCk8mXklcPteAZ3CBHTKJsUmkFN
 KEhFSUg1McWXLhY/OCnyw1fNxwDRmnadv32Ss/vRv37bIuamPnbz+1nYkP+4I4Lq61Tll9eNl
 6V80zfWmik7P9ogWOelVcL72/Qqv0GfzL6c/2eexVHEyB//rh1X5H80DPjdMdefhm7RN4cPsa
 5wvj9ZOE+WY9u/cmkPb19Xr+xs/5sg6eX1qwBLXPoMvCnlL5E2uijUsZbnqp8+01s5SpmZbvr
 X6x7gZ9rd5jqukzt/iuS+2nXeTxUV15lzWutQeC9YqxXtv7aNYzi5ZpHyC5dGlxslT+sOZWFg
 F7BxvLPThfVtc94TtQVNsWFzOo01Se38INvUYXOE0ypvxYO12Bf/8tcd+zEw67Wm8xl6/W8K/
 a+kDJZbijERDLeai4kQAn01yLlUDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-591.messagelabs.com!1669700424!225822!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19958 invoked from network); 29 Nov 2022 05:40:24 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-12.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 29 Nov 2022 05:40:24 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 08799100182
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 05:40:24 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126
 [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id F0A29100043
 for <ltp@lists.linux.it>; Tue, 29 Nov 2022 05:40:23 +0000 (GMT)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 29 Nov 2022 05:40:22 +0000
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <ltp@lists.linux.it>
Date: Tue, 29 Nov 2022 14:40:59 +0800
Message-ID: <1669704060-5635-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1 1/2] include/lapi/sched.h: move
 namespaces_constants.h's constant into here
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

Kernel header doesn't have this namespaces_constants.h header file and
it can be moved into lapi/sched. Also, lapi/clone.h have some duplicated
CLONE_* constants, they should be moved into here too.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 include/lapi/namespaces_constants.h           | 34 ---------------
 include/lapi/sched.h                          | 41 +++++++++++++++++--
 lib/tst_net.c                                 |  2 +-
 testcases/cve/cve-2017-16939.c                |  2 +-
 testcases/cve/icmp_rate_limit01.c             |  2 +-
 .../kernel/containers/libclone/libclone.h     |  3 +-
 testcases/kernel/containers/mountns/mountns.h |  2 +-
 .../kernel/containers/netns/netns_netlink.c   |  3 +-
 testcases/kernel/containers/pidns/pidns01.c   |  2 +-
 testcases/kernel/containers/pidns/pidns02.c   |  2 +-
 testcases/kernel/containers/pidns/pidns03.c   |  2 +-
 testcases/kernel/containers/pidns/pidns12.c   |  2 +-
 testcases/kernel/containers/pidns/pidns20.c   |  2 +-
 testcases/kernel/containers/pidns/pidns32.c   |  2 +-
 testcases/kernel/containers/share/ns_common.h |  2 +-
 testcases/kernel/containers/share/ns_create.c |  3 +-
 testcases/kernel/containers/share/ns_exec.c   |  3 +-
 testcases/kernel/containers/sysvipc/common.h  |  2 +-
 testcases/kernel/containers/timens/timens01.c |  2 +-
 testcases/kernel/containers/userns/common.h   |  2 +-
 .../kernel/controllers/cgroup/cgroup_core02.c |  3 +-
 .../syscalls/clock_gettime/clock_gettime03.c  |  2 +-
 .../clock_nanosleep/clock_nanosleep03.c       |  2 +-
 testcases/kernel/syscalls/clone/clone09.c     |  3 +-
 .../kernel/syscalls/fanotify/fanotify17.c     |  3 +-
 .../kernel/syscalls/getxattr/getxattr05.c     |  3 +-
 testcases/kernel/syscalls/ioctl/ioctl_ns01.c  |  3 +-
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c  |  3 +-
 testcases/kernel/syscalls/ioctl/ioctl_ns06.c  |  3 +-
 testcases/kernel/syscalls/setns/setns.h       |  2 +-
 testcases/kernel/syscalls/sysinfo/sysinfo03.c |  2 +-
 testcases/kernel/syscalls/timerfd/timerfd04.c |  2 +-
 32 files changed, 67 insertions(+), 79 deletions(-)
 delete mode 100644 include/lapi/namespaces_constants.h

diff --git a/include/lapi/namespaces_constants.h b/include/lapi/namespaces_constants.h
deleted file mode 100644
index e34b0d6a8..000000000
--- a/include/lapi/namespaces_constants.h
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2015 Red Hat, Inc.
- */
-
-#ifndef LAPI_NAMESPACES_CONSTANTS_H__
-#define LAPI_NAMESPACES_CONSTANTS_H__
-
-#ifndef CLONE_NEWIPC
-#  define CLONE_NEWIPC	0x08000000
-#endif
-#ifndef CLONE_NEWNS
-#  define CLONE_NEWNS	0x00020000
-#endif
-#ifndef CLONE_NEWNET
-#  define CLONE_NEWNET	0x40000000
-#endif
-#ifndef CLONE_NEWPID
-#  define CLONE_NEWPID	0x20000000
-#endif
-#ifndef CLONE_NEWUSER
-#  define CLONE_NEWUSER	0x10000000
-#endif
-#ifndef CLONE_NEWCGROUP
-#  define CLONE_NEWCGROUP 0x02000000
-#endif
-#ifndef CLONE_NEWUTS
-#  define CLONE_NEWUTS	0x04000000
-#endif
-#ifndef CLONE_NEWTIME
-#  define CLONE_NEWTIME 0x00000080
-#endif
-
-#endif /* LAPI_NAMESPACES_CONSTANTS_H__ */
diff --git a/include/lapi/sched.h b/include/lapi/sched.h
index 226d3109a..3b0b4be31 100644
--- a/include/lapi/sched.h
+++ b/include/lapi/sched.h
@@ -8,6 +8,7 @@
 #define LAPI_SCHED_H__
 
 #include <sched.h>
+#include <unistd.h>
 #include <stdint.h>
 #include <inttypes.h>
 #include "lapi/syscalls.h"
@@ -47,19 +48,51 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
 #endif
 
 #ifndef CLONE_VM
-# define CLONE_VM   0x00000100
+# define CLONE_VM	0x00000100
 #endif
 
 #ifndef CLONE_FS
-# define CLONE_FS   0x00000200
+# define CLONE_FS	0x00000200
+#endif
+
+#ifndef CLONE_NEWNS
+# define CLONE_NEWNS	0x00020000
 #endif
 
 #ifndef CLONE_SYSVSEM
-# define CLONE_SYSVSEM   0x00040000
+# define CLONE_SYSVSEM	0x00040000
+#endif
+
+#ifndef CLONE_NEWCGROUP
+# define CLONE_NEWCGROUP	0x02000000
+#endif
+
+#ifndef CLONE_NEWUTS
+# define CLONE_NEWUTS		0x04000000
+#endif
+
+#ifndef CLONE_NEWIPC
+#  define CLONE_NEWIPC		0x08000000
+#endif
+
+#ifndef CLONE_NEWUSER
+#  define CLONE_NEWUSER		0x10000000
+#endif
+
+#ifndef CLONE_NEWPID
+#  define CLONE_NEWPID		0x20000000
+#endif
+
+#ifndef CLONE_NEWNET
+# define CLONE_NEWNET		0x40000000
 #endif
 
 #ifndef CLONE_IO
-# define CLONE_IO        0x80000000
+# define CLONE_IO		0x80000000
+#endif
+
+#ifndef CLONE_NEWTIME
+# define CLONE_NEWTIME		0x00000080
 #endif
 
 #endif /* LAPI_SCHED_H__ */
diff --git a/lib/tst_net.c b/lib/tst_net.c
index 61fc0ea76..a97e25b11 100644
--- a/lib/tst_net.c
+++ b/lib/tst_net.c
@@ -14,7 +14,7 @@
 #include "tst_test.h"
 #include "tst_net.h"
 #include "tst_private.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 void tst_print_svar(const char *name, const char *val)
 {
diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
index eb5400c0c..e41fb274a 100644
--- a/testcases/cve/cve-2017-16939.c
+++ b/testcases/cve/cve-2017-16939.c
@@ -25,7 +25,7 @@
 #include "tst_res_flags.h"
 #include "tst_safe_macros.h"
 #include "tst_safe_net.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define BUFSIZE 2048
 
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index 7a51aa0a4..8ee50a276 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -34,7 +34,7 @@
 #include "lapi/if_addr.h"
 #include "tst_test.h"
 #include "tst_netdevice.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define DSTNET 0xfa444e00 /* 250.68.78.0 */
 #define SRCNET 0xfa444e40 /* 250.68.78.64 */
diff --git a/testcases/kernel/containers/libclone/libclone.h b/testcases/kernel/containers/libclone/libclone.h
index b8740f1bc..e92fdca02 100644
--- a/testcases/kernel/containers/libclone/libclone.h
+++ b/testcases/kernel/containers/libclone/libclone.h
@@ -19,7 +19,6 @@
 
 #include <stdio.h>
 #include <stdlib.h>
-#include <sched.h>
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
@@ -28,7 +27,7 @@
 #include <signal.h>
 #include "lapi/syscalls.h"
 #include "test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define T_UNSHARE 0
 #define T_CLONE 1
diff --git a/testcases/kernel/containers/mountns/mountns.h b/testcases/kernel/containers/mountns/mountns.h
index 76b37b477..615f1a058 100644
--- a/testcases/kernel/containers/mountns/mountns.h
+++ b/testcases/kernel/containers/mountns/mountns.h
@@ -8,7 +8,7 @@
 #define COMMON_H
 
 #include "tst_test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define DIRA "LTP_DIR_A"
 #define DIRB "LTP_DIR_B"
diff --git a/testcases/kernel/containers/netns/netns_netlink.c b/testcases/kernel/containers/netns/netns_netlink.c
index 6f60ff94e..e8df616e2 100644
--- a/testcases/kernel/containers/netns/netns_netlink.c
+++ b/testcases/kernel/containers/netns/netns_netlink.c
@@ -33,11 +33,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <sched.h>
 
 #include "tst_test.h"
 #include "tst_safe_macros.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define MAX_TRIES 1000
 
diff --git a/testcases/kernel/containers/pidns/pidns01.c b/testcases/kernel/containers/pidns/pidns01.c
index eba4b806b..5080b6fad 100644
--- a/testcases/kernel/containers/pidns/pidns01.c
+++ b/testcases/kernel/containers/pidns/pidns01.c
@@ -15,7 +15,7 @@
  */
 
 #include "tst_test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
diff --git a/testcases/kernel/containers/pidns/pidns02.c b/testcases/kernel/containers/pidns/pidns02.c
index 9f3a46526..b8913d3f6 100644
--- a/testcases/kernel/containers/pidns/pidns02.c
+++ b/testcases/kernel/containers/pidns/pidns02.c
@@ -14,7 +14,7 @@
  */
 
 #include "tst_test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
 {
diff --git a/testcases/kernel/containers/pidns/pidns03.c b/testcases/kernel/containers/pidns/pidns03.c
index b9b38b5d9..122ba7891 100644
--- a/testcases/kernel/containers/pidns/pidns03.c
+++ b/testcases/kernel/containers/pidns/pidns03.c
@@ -13,7 +13,7 @@
 
 #include <sys/mount.h>
 #include "tst_test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define PROCDIR "proc"
 
diff --git a/testcases/kernel/containers/pidns/pidns12.c b/testcases/kernel/containers/pidns/pidns12.c
index 0e6b17142..fb1ec90ca 100644
--- a/testcases/kernel/containers/pidns/pidns12.c
+++ b/testcases/kernel/containers/pidns/pidns12.c
@@ -16,7 +16,7 @@
 #define _GNU_SOURCE 1
 #include <signal.h>
 #include "tst_test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 static volatile pid_t sig_pid = -1;
 
diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
index f1e239dde..9f369699a 100644
--- a/testcases/kernel/containers/pidns/pidns20.c
+++ b/testcases/kernel/containers/pidns/pidns20.c
@@ -15,7 +15,7 @@
 #define _GNU_SOURCE 1
 #include <signal.h>
 #include "tst_test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 static volatile int signals;
 static volatile int last_signo;
diff --git a/testcases/kernel/containers/pidns/pidns32.c b/testcases/kernel/containers/pidns/pidns32.c
index 333e1fcad..3f7df788e 100644
--- a/testcases/kernel/containers/pidns/pidns32.c
+++ b/testcases/kernel/containers/pidns/pidns32.c
@@ -15,7 +15,7 @@
 
 #include <sys/mman.h>
 #include "tst_test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define MAXNEST 32
 
diff --git a/testcases/kernel/containers/share/ns_common.h b/testcases/kernel/containers/share/ns_common.h
index 69e51ce71..0f85aceb4 100644
--- a/testcases/kernel/containers/share/ns_common.h
+++ b/testcases/kernel/containers/share/ns_common.h
@@ -17,7 +17,7 @@
 #ifndef __NS_COMMON_H__
 #define __NS_COMMON_H__
 #include <sched.h>
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define PROC_PATH "/proc"
 #define NS_TOTAL 6
diff --git a/testcases/kernel/containers/share/ns_create.c b/testcases/kernel/containers/share/ns_create.c
index d4259f38b..3f09e71e0 100644
--- a/testcases/kernel/containers/share/ns_create.c
+++ b/testcases/kernel/containers/share/ns_create.c
@@ -24,7 +24,6 @@
  */
 
 #define _GNU_SOURCE
-#include <sched.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -32,7 +31,7 @@
 #include <string.h>
 #include <errno.h>
 #include "test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 #include "ns_common.h"
 
 char *TCID = "ns_create";
diff --git a/testcases/kernel/containers/share/ns_exec.c b/testcases/kernel/containers/share/ns_exec.c
index c492165f0..4abd1063b 100644
--- a/testcases/kernel/containers/share/ns_exec.c
+++ b/testcases/kernel/containers/share/ns_exec.c
@@ -21,7 +21,6 @@
  */
 
 #define _GNU_SOURCE
-#include <sched.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -31,7 +30,7 @@
 #include <errno.h>
 #include "test.h"
 #include "lapi/syscalls.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 #include "ns_common.h"
 
 char *TCID = "ns_exec";
diff --git a/testcases/kernel/containers/sysvipc/common.h b/testcases/kernel/containers/sysvipc/common.h
index 258d355d7..9b0fc16e9 100644
--- a/testcases/kernel/containers/sysvipc/common.h
+++ b/testcases/kernel/containers/sysvipc/common.h
@@ -11,7 +11,7 @@
 #include <stdlib.h>
 #include "tst_test.h"
 #include "lapi/syscalls.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 enum {
 	T_CLONE,
diff --git a/testcases/kernel/containers/timens/timens01.c b/testcases/kernel/containers/timens/timens01.c
index 3f6235ec3..3621b3446 100644
--- a/testcases/kernel/containers/timens/timens01.c
+++ b/testcases/kernel/containers/timens/timens01.c
@@ -15,9 +15,9 @@
  */
 
 #define _GNU_SOURCE
-#include "lapi/namespaces_constants.h"
 #include "lapi/posix_clocks.h"
 #include "tst_test.h"
+#include "lapi/sched.h"
 
 static struct tcase {
 	const char *desc;
diff --git a/testcases/kernel/containers/userns/common.h b/testcases/kernel/containers/userns/common.h
index d3bdcc53f..635d0f190 100644
--- a/testcases/kernel/containers/userns/common.h
+++ b/testcases/kernel/containers/userns/common.h
@@ -8,7 +8,7 @@
 #define COMMON_H
 
 #include "tst_test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define UID_MAP 0
 #define GID_MAP 1
diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
index e6d599b36..1872a7dff 100644
--- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
+++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
@@ -24,14 +24,13 @@
  */
 
 #define _GNU_SOURCE
-#include <sched.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <sys/types.h>
 #include <pwd.h>
 #include "tst_test.h"
 #include "tst_safe_file_at.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 static struct tst_cg_group *cg_child_a, *cg_child_b;
 static uid_t nobody_uid;
diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
index f185977d3..b02d22a14 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
@@ -18,7 +18,7 @@
 #include "time64_variants.h"
 #include "tst_safe_clocks.h"
 #include "tst_timer.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 static struct tcase {
 	int clk_id;
diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
index 5bd91fa61..dfc522278 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep03.c
@@ -18,7 +18,7 @@
 #include "time64_variants.h"
 #include "tst_safe_clocks.h"
 #include "tst_timer.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define OFFSET_S 10
 #define SLEEP_US 100000
diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/syscalls/clone/clone09.c
index e9e584564..e4691f513 100644
--- a/testcases/kernel/syscalls/clone/clone09.c
+++ b/testcases/kernel/syscalls/clone/clone09.c
@@ -4,14 +4,13 @@
  */
 
 #define _GNU_SOURCE
-#include <sched.h>
 #include <stdlib.h>
 #include <errno.h>
 
 #include "tst_test.h"
 #include "clone_platform.h"
 #include "lapi/syscalls.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 static void *child_stack;
 static int sysctl_net = -1;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/kernel/syscalls/fanotify/fanotify17.c
index 7d74b2540..3ecb31b6e 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify17.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify17.c
@@ -20,11 +20,10 @@
 #include <errno.h>
 #include <unistd.h>
 #include <sys/types.h>
-#include <sched.h>
 #include <stdlib.h>
 
 #include "tst_test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #ifdef HAVE_SYS_FANOTIFY_H
 #include "fanotify.h"
diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
index 3e73cc567..28eb4cbcf 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -20,7 +20,6 @@
 #include <errno.h>
 #include <unistd.h>
 #include <sys/types.h>
-#include <sched.h>
 #include <stdlib.h>
 
 #ifdef HAVE_SYS_XATTR_H
@@ -32,7 +31,7 @@
 #endif
 
 #include "tst_test.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #if defined(HAVE_SYS_XATTR_H) && defined(HAVE_LIBACL)
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
index 95be877dc..06c81ba1b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
@@ -19,11 +19,10 @@
 #define _GNU_SOURCE
 
 #include <errno.h>
-#include <sched.h>
 #include <stdlib.h>
 #include "tst_test.h"
 #include "lapi/ioctl_ns.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define STACK_SIZE (1024 * 1024)
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
index ae2f9da51..36e41c468 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -18,11 +18,10 @@
 
 #include <errno.h>
 #include <stdio.h>
-#include <sched.h>
 #include <stdlib.h>
 #include "tst_test.h"
 #include "lapi/ioctl_ns.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define STACK_SIZE (1024 * 1024)
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
index 393ba1437..45fc01ce7 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
@@ -19,11 +19,10 @@
 
 #include <errno.h>
 #include <stdio.h>
-#include <sched.h>
 #include <stdlib.h>
 #include "tst_test.h"
 #include "lapi/ioctl_ns.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define STACK_SIZE (1024 * 1024)
 
diff --git a/testcases/kernel/syscalls/setns/setns.h b/testcases/kernel/syscalls/setns/setns.h
index 46beef17f..45c759917 100644
--- a/testcases/kernel/syscalls/setns/setns.h
+++ b/testcases/kernel/syscalls/setns/setns.h
@@ -4,7 +4,7 @@
  */
 
 #include <stdio.h>
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define NS_MAX 5
 static int ns_types[NS_MAX];
diff --git a/testcases/kernel/syscalls/sysinfo/sysinfo03.c b/testcases/kernel/syscalls/sysinfo/sysinfo03.c
index af7cb6421..6b8f0aef7 100644
--- a/testcases/kernel/syscalls/sysinfo/sysinfo03.c
+++ b/testcases/kernel/syscalls/sysinfo/sysinfo03.c
@@ -14,9 +14,9 @@
  */
 
 #include <sys/sysinfo.h>
-#include "lapi/namespaces_constants.h"
 #include "lapi/posix_clocks.h"
 #include "tst_test.h"
+#include "lapi/sched.h"
 
 static int offsets[] = {
 	10,
diff --git a/testcases/kernel/syscalls/timerfd/timerfd04.c b/testcases/kernel/syscalls/timerfd/timerfd04.c
index eb7f98d5b..b24b4874e 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd04.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd04.c
@@ -19,7 +19,7 @@
 #include "tst_safe_clocks.h"
 #include "tst_safe_timerfd.h"
 #include "tst_timer.h"
-#include "lapi/namespaces_constants.h"
+#include "lapi/sched.h"
 
 #define SLEEP_US 40000
 
-- 
2.23.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
