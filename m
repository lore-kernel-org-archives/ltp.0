Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F89EC433F5
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 09:37:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 094E63C9023
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 10:37:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 949933C8DD1
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 10:37:34 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 772D860137B
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 10:37:30 +0100 (CET)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4J4W5p3Fc9zXdRS;
 Thu,  2 Dec 2021 17:35:26 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 17:37:25 +0800
Received: from ubuntu1604.huawei.com (10.67.174.57) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 2 Dec 2021 17:37:25 +0800
To: <ltp@lists.linux.it>
Date: Thu, 2 Dec 2021 17:38:38 +0800
Message-ID: <1638437918-60401-1-git-send-email-wenyehai@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.67.174.57]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] bugfix for testcases which with duplicate header
 files fcntl.h
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
From: wenyehai via ltp <ltp@lists.linux.it>
Reply-To: wenyehai <wenyehai@huawei.com>
Cc: wenyehai <wenyehai@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

testcases/kernel/syscalls:Remove duplicate header files fcntl.h.

Signed-off-by: Yehai Wen <wenyehai@huawei.com>
---
v1->v2: remove duplicate header files fcntl.h for all testcases
 testcases/kernel/syscalls/accept4/accept4_01.c            | 1 -
 testcases/kernel/syscalls/eventfd2/eventfd2_01.c          | 1 -
 testcases/kernel/syscalls/eventfd2/eventfd2_02.c          | 1 -
 testcases/kernel/syscalls/execveat/execveat03.c           | 1 -
 testcases/kernel/syscalls/fallocate/fallocate01.c         | 1 -
 testcases/kernel/syscalls/fchownat/fchownat01.c           | 1 -
 testcases/kernel/syscalls/fchownat/fchownat02.c           | 1 -
 testcases/kernel/syscalls/fcntl/fcntl29.c                 | 1 -
 testcases/kernel/syscalls/fcntl/fcntl30.c                 | 1 -
 testcases/kernel/syscalls/fcntl/fcntl31.c                 | 1 -
 testcases/kernel/syscalls/fcntl/fcntl34.c                 | 1 -
 testcases/kernel/syscalls/fcntl/fcntl35.c                 | 1 -
 testcases/kernel/syscalls/fcntl/fcntl36.c                 | 1 -
 testcases/kernel/syscalls/fcntl/fcntl37.c                 | 1 -
 testcases/kernel/syscalls/fcntl/fcntl38.c                 | 1 -
 testcases/kernel/syscalls/inotify_init/inotify_init1_01.c | 1 -
 testcases/kernel/syscalls/inotify_init/inotify_init1_02.c | 1 -
 testcases/kernel/syscalls/linkat/linkat02.c               | 1 -
 testcases/kernel/syscalls/mknodat/mknodat01.c             | 1 -
 testcases/kernel/syscalls/mknodat/mknodat02.c             | 1 -
 testcases/kernel/syscalls/open/open14.c                   | 1 -
 testcases/kernel/syscalls/openat/openat01.c               | 1 -
 testcases/kernel/syscalls/openat/openat02.c               | 1 -
 testcases/kernel/syscalls/openat/openat03.c               | 1 -
 testcases/kernel/syscalls/pipe/pipe12.c                   | 1 -
 testcases/kernel/syscalls/pipe2/pipe2_04.c                | 1 -
 testcases/kernel/syscalls/renameat/renameat01.c           | 1 -
 testcases/kernel/syscalls/signalfd4/signalfd4_01.c        | 1 -
 testcases/kernel/syscalls/socket/socket02.c               | 1 -
 testcases/kernel/syscalls/socketpair/socketpair02.c       | 1 -
 testcases/kernel/syscalls/tee/tee01.c                     | 1 -
 testcases/kernel/syscalls/timerfd/timerfd02.c             | 1 -
 testcases/kernel/syscalls/timerfd/timerfd03.c             | 1 -
 testcases/kernel/syscalls/vmsplice/vmsplice01.c           | 1 -
 testcases/kernel/syscalls/vmsplice/vmsplice02.c           | 2 --
 35 files changed, 36 deletions(-)

diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
index b3ab1b9..58115ea 100644
--- a/testcases/kernel/syscalls/accept4/accept4_01.c
+++ b/testcases/kernel/syscalls/accept4/accept4_01.c
@@ -13,7 +13,6 @@
 #include <sys/socket.h>
 #include <netinet/in.h>
 #include <stdlib.h>
-#include <fcntl.h>
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
index a4af388..c0c6a26 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
@@ -53,7 +53,6 @@
 /*              Ported to LTP                                                 */
 /*                      - Jan 08 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
 /******************************************************************************/
-#include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/syscall.h>
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
index 151edb8..418c07c 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_02.c
@@ -50,7 +50,6 @@
 /*              Ported to LTP                                                 */
 /*                      - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
 /******************************************************************************/
-#include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/syscall.h>
diff --git a/testcases/kernel/syscalls/execveat/execveat03.c b/testcases/kernel/syscalls/execveat/execveat03.c
index 78b26ab..1900c07 100644
--- a/testcases/kernel/syscalls/execveat/execveat03.c
+++ b/testcases/kernel/syscalls/execveat/execveat03.c
@@ -29,7 +29,6 @@
 #include <string.h>
 #include <sys/syscall.h>
 #include <sys/mount.h>
-#include <fcntl.h>
 #include "tst_test.h"
 #include "lapi/execveat.h"
 #include "lapi/fcntl.h"
diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
index c60e160..383796c 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate01.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
@@ -93,7 +93,6 @@
 #include <errno.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-#include <fcntl.h>
 #include <sys/syscall.h>
 #include <unistd.h>
 #include <inttypes.h>
diff --git a/testcases/kernel/syscalls/fchownat/fchownat01.c b/testcases/kernel/syscalls/fchownat/fchownat01.c
index 9f4ecde..a658f07 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat01.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat01.c
@@ -26,7 +26,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/fchownat/fchownat02.c b/testcases/kernel/syscalls/fchownat/fchownat02.c
index d19f3f3..701623d 100644
--- a/testcases/kernel/syscalls/fchownat/fchownat02.c
+++ b/testcases/kernel/syscalls/fchownat/fchownat02.c
@@ -24,7 +24,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/fcntl/fcntl29.c b/testcases/kernel/syscalls/fcntl/fcntl29.c
index ffb9fea..5874764 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl29.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl29.c
@@ -24,7 +24,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-#include <fcntl.h>
 #include <string.h>
 #include <signal.h>
 #include <sys/types.h>
diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c b/testcases/kernel/syscalls/fcntl/fcntl30.c
index a7a5e13..27f4643 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl30.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
@@ -25,7 +25,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-#include <fcntl.h>
 #include <string.h>
 #include <signal.h>
 #include <sys/types.h>
diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
index fd284fd..9003089 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl31.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
@@ -25,7 +25,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-#include <fcntl.h>
 #include <string.h>
 #include <signal.h>
 #include <sys/types.h>
diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index 3a68b51..3442114 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -7,7 +7,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include <fcntl.h>
 #include <pthread.h>
 #include <sched.h>
diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
index c5a071d..8eb7148 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl35.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
@@ -26,7 +26,6 @@
 #include <sys/types.h>
 #include <pwd.h>
 #include <unistd.h>
-#include <fcntl.h>
 #include <stdlib.h>
 #include "lapi/fcntl.h"
diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
index 1d187c2..d6b07fc 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl36.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -34,7 +34,6 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <fcntl.h>
 #include <pthread.h>
 #include <sched.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/fcntl/fcntl37.c b/testcases/kernel/syscalls/fcntl/fcntl37.c
index c52af22..a624554 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl37.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl37.c
@@ -14,7 +14,6 @@
  */
 #include <unistd.h>
-#include <fcntl.h>
 #include <sys/types.h>
 #include <limits.h>
 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/fcntl/fcntl38.c b/testcases/kernel/syscalls/fcntl/fcntl38.c
index fae2ab4..2f1b022 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl38.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl38.c
@@ -8,7 +8,6 @@
  *     Check that dnotify event is reported to both parent and subdir
  */
-#include <fcntl.h>
 #include <signal.h>
 #include <stdio.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
index f1203a4..f1b50fd 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_01.c
@@ -53,7 +53,6 @@
 /*              Ported to LTP                                                 */
 /*                      - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
 /******************************************************************************/
-#include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/syscall.h>
diff --git a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
index b074214..3b0c767 100644
--- a/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
+++ b/testcases/kernel/syscalls/inotify_init/inotify_init1_02.c
@@ -50,7 +50,6 @@
 /*              Ported to LTP                                                 */
 /*                      - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
 /******************************************************************************/
-#include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/syscall.h>
diff --git a/testcases/kernel/syscalls/linkat/linkat02.c b/testcases/kernel/syscalls/linkat/linkat02.c
index 84b4a3b..566c76b 100644
--- a/testcases/kernel/syscalls/linkat/linkat02.c
+++ b/testcases/kernel/syscalls/linkat/linkat02.c
@@ -21,7 +21,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/mknodat/mknodat01.c b/testcases/kernel/syscalls/mknodat/mknodat01.c
index 2e13c77..bff2c6a 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat01.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat01.c
@@ -27,7 +27,6 @@
 #define _GNU_SOURCE
 #include <sys/types.h>
-#include <fcntl.h>
 #include <sys/stat.h>
 #include <stdlib.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/mknodat/mknodat02.c b/testcases/kernel/syscalls/mknodat/mknodat02.c
index 6c5054b..7e6afda 100644
--- a/testcases/kernel/syscalls/mknodat/mknodat02.c
+++ b/testcases/kernel/syscalls/mknodat/mknodat02.c
@@ -27,7 +27,6 @@
 #define _GNU_SOURCE
 #include <sys/types.h>
-#include <fcntl.h>
 #include <sys/stat.h>
 #include <stdlib.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/open/open14.c b/testcases/kernel/syscalls/open/open14.c
index 0d832cb..f78a364 100644
--- a/testcases/kernel/syscalls/open/open14.c
+++ b/testcases/kernel/syscalls/open/open14.c
@@ -22,7 +22,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include <fcntl.h>
 #include <errno.h>
 #include "test.h"
diff --git a/testcases/kernel/syscalls/openat/openat01.c b/testcases/kernel/syscalls/openat/openat01.c
index 0441c3a..daed419 100644
--- a/testcases/kernel/syscalls/openat/openat01.c
+++ b/testcases/kernel/syscalls/openat/openat01.c
@@ -28,7 +28,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/openat/openat02.c b/testcases/kernel/syscalls/openat/openat02.c
index e2eefda..2ce1190 100644
--- a/testcases/kernel/syscalls/openat/openat02.c
+++ b/testcases/kernel/syscalls/openat/openat02.c
@@ -38,7 +38,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
 #include <unistd.h>
 #include <sys/wait.h>
 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/openat/openat03.c b/testcases/kernel/syscalls/openat/openat03.c
index 7e816f2..2846fd0 100644
--- a/testcases/kernel/syscalls/openat/openat03.c
+++ b/testcases/kernel/syscalls/openat/openat03.c
@@ -22,7 +22,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include <fcntl.h>
 #include <errno.h>
 #include "test.h"
diff --git a/testcases/kernel/syscalls/pipe/pipe12.c b/testcases/kernel/syscalls/pipe/pipe12.c
index 4c7eda2..f524040 100644
--- a/testcases/kernel/syscalls/pipe/pipe12.c
+++ b/testcases/kernel/syscalls/pipe/pipe12.c
@@ -11,7 +11,6 @@
 #define _GNU_SOURCE
 #include <unistd.h>
 #include <stdlib.h>
-#include <fcntl.h>
 #include "tst_test.h"
 #include "lapi/fcntl.h"
diff --git a/testcases/kernel/syscalls/pipe2/pipe2_04.c b/testcases/kernel/syscalls/pipe2/pipe2_04.c
index 432007e..3789435 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_04.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_04.c
@@ -11,7 +11,6 @@
 #define _GNU_SOURCE
 #include <stdlib.h>
 #include <features.h>
-#include <fcntl.h>
 #include <unistd.h>
 #include <stdio.h>
 #include "lapi/fcntl.h"
diff --git a/testcases/kernel/syscalls/renameat/renameat01.c b/testcases/kernel/syscalls/renameat/renameat01.c
index 817e217..9df4b70 100644
--- a/testcases/kernel/syscalls/renameat/renameat01.c
+++ b/testcases/kernel/syscalls/renameat/renameat01.c
@@ -41,7 +41,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/time.h>
-#include <fcntl.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
index 9f85973..960c7ce 100644
--- a/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
+++ b/testcases/kernel/syscalls/signalfd4/signalfd4_01.c
@@ -54,7 +54,6 @@
 /*              Ported to LTP                                                 */
 /*                      - Jan 08 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
 /******************************************************************************/
-#include <fcntl.h>
 #include <signal.h>
 #include <stdio.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/socket/socket02.c b/testcases/kernel/syscalls/socket/socket02.c
index afe9dc1..59fd942 100644
--- a/testcases/kernel/syscalls/socket/socket02.c
+++ b/testcases/kernel/syscalls/socket/socket02.c
@@ -12,7 +12,6 @@
 * in socket() in kernel 2.6.27.
 */
-#include <fcntl.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <netinet/in.h>
diff --git a/testcases/kernel/syscalls/socketpair/socketpair02.c b/testcases/kernel/syscalls/socketpair/socketpair02.c
index 72ca0e8..e23945c 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair02.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair02.c
@@ -13,7 +13,6 @@
 */
 #include <errno.h>
-#include <fcntl.h>
 #include <pthread.h>
 #include <stdio.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/tee/tee01.c b/testcases/kernel/syscalls/tee/tee01.c
index db2ac1e..cee6ed7 100644
--- a/testcases/kernel/syscalls/tee/tee01.c
+++ b/testcases/kernel/syscalls/tee/tee01.c
@@ -11,7 +11,6 @@
 #include <string.h>
 #include <signal.h>
 #include <sys/types.h>
-#include <fcntl.h>
 #include "tst_test.h"
 #include "lapi/fcntl.h"
diff --git a/testcases/kernel/syscalls/timerfd/timerfd02.c b/testcases/kernel/syscalls/timerfd/timerfd02.c
index c544406..88742b8 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd02.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd02.c
@@ -54,7 +54,6 @@
 /*                      - Jan 08 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
 /******************************************************************************/
-#include <fcntl.h>
 #include <stdio.h>
 #include <time.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/timerfd/timerfd03.c b/testcases/kernel/syscalls/timerfd/timerfd03.c
index e288251..41aa946 100644
--- a/testcases/kernel/syscalls/timerfd/timerfd03.c
+++ b/testcases/kernel/syscalls/timerfd/timerfd03.c
@@ -50,7 +50,6 @@
 /*              Ported to LTP                                                 */
 /*                      - Jan 13 2009 - Subrata <subrata@linux.vnet.ibm.com>  */
 /******************************************************************************/
-#include <fcntl.h>
 #include <stdio.h>
 #include <time.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice01.c b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
index 1d1b66d..36ecc08 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice01.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice01.c
@@ -11,7 +11,6 @@
 #include <string.h>
 #include <signal.h>
 #include <sys/types.h>
-#include <fcntl.h>
 #include <sys/poll.h>
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/vmsplice/vmsplice02.c b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
index 39c407c..0135b6f 100644
--- a/testcases/kernel/syscalls/vmsplice/vmsplice02.c
+++ b/testcases/kernel/syscalls/vmsplice/vmsplice02.c
@@ -18,9 +18,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <fcntl.h>
 #include <unistd.h>
-#include <fcntl.h>
 #include <sys/uio.h>
 #include <limits.h>
2.7.4


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
