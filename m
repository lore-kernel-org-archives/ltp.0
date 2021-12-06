Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E20C433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 03:10:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 478ED3C0CCF
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 04:10:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF69B3C08E5
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 04:09:58 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4BF8E1400B63
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 04:09:54 +0100 (CET)
Received: from kwepemi100001.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J6pLq2ZN5zcbnK;
 Mon,  6 Dec 2021 11:09:39 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100001.china.huawei.com (7.221.188.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 11:09:49 +0800
Received: from ubuntu1604.huawei.com (10.67.174.57) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 11:09:49 +0800
To: <ltp@lists.linux.it>
Date: Mon, 6 Dec 2021 11:10:56 +0800
Message-ID: <1638760256-150779-1-git-send-email-wenyehai@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [10.67.174.57]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] remove duplicate header files fcntl.h
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

testcases: remove duplicate header files fcntl.h

Signed-off-by: Yehai Wen <wenyehai@huawei.com>
---
v2->v3: re-make patch to solve patching failure
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
index b3ab1b94e..58115ea43 100644
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
index a4af38858..c0c6a263c 100644
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
index 151edb841..418c07c45 100644
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
index 78b26ab56..1900c076b 100644
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
index c60e160f4..383796c90 100644
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
index 9f4ecded7..a658f07db 100644
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
index d19f3f3b8..701623dd7 100644
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
index ffb9fea74..587476454 100644
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
index a7a5e136c..27f464389 100644
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
index fd284fd7e..900308980 100644
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
index 3a68b51c8..3442114ff 100644
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
index c5a071def..8eb71486f 100644
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
index 1d187c28b..d6b07fc41 100644
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
index c52af22dd..a624554c5 100644
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
index fae2ab4f7..2f1b0229e 100644
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
index f1203a495..f1b50fd4e 100644
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
index b074214f7..3b0c7678e 100644
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
index 84b4a3ba0..566c76b1f 100644
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
index 2e13c7732..bff2c6a4e 100644
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
index 6c5054bbc..7e6afda92 100644
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
index 0d832cb59..f78a3643c 100644
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
index 0441c3add..daed419fb 100644
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
index e2eefda04..2ce119033 100644
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
index 7e816f26b..2846fd07f 100644
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
index 4c7eda2d6..f5240401a 100644
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
index 432007e4d..37894351f 100644
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
index 817e21729..9df4b7086 100644
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
index 9f859735f..960c7ce98 100644
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
index afe9dc129..59fd942d5 100644
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
index 72ca0e816..e23945c53 100644
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
index db2ac1e0c..cee6ed7d9 100644
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
index c54440660..88742b806 100644
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
index e288251b3..41aa94636 100644
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
index 1d1b66d12..36ecc08ef 100644
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
index 39c407cb8..0135b6f7e 100644
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

--
2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
