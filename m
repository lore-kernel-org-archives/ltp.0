From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Dec 2017 10:51:57 +0100
Subject: [LTP] [PATCH v2 1/1] Add missing config.h includes
Message-ID: <20171222095157.19486-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Although in some cases it might be included by another header
(e.g. testcases/kernel/syscalls/move_pages/move_pages0*.c)
it's a good practise to add it in the file where is needed

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: I can add include only when it's *really* needed (i.e. where it's
not loaded by any other header).

Changes v1->v2:
Changes for testcases/kernel/module/delete_module/delete_module02.c
broke build, fixed it and merge as separate commit.
---
 include/lapi/mmap.h                                           | 2 ++
 testcases/cve/cve-2012-0957.c                                 | 1 +
 testcases/cve/cve-2016-4997.c                                 | 1 +
 testcases/kernel/io/aio/aio02/common.h                        | 1 +
 testcases/kernel/mem/ksm/ksm05.c                              | 1 +
 testcases/kernel/security/smack/smack_set_socket_labels.c     | 1 +
 testcases/kernel/syscalls/move_pages/move_pages01.c           | 1 +
 testcases/kernel/syscalls/move_pages/move_pages02.c           | 1 +
 testcases/kernel/syscalls/move_pages/move_pages03.c           | 1 +
 testcases/kernel/syscalls/move_pages/move_pages04.c           | 1 +
 testcases/kernel/syscalls/move_pages/move_pages05.c           | 1 +
 testcases/kernel/syscalls/move_pages/move_pages06.c           | 1 +
 testcases/kernel/syscalls/move_pages/move_pages07.c           | 1 +
 testcases/kernel/syscalls/move_pages/move_pages08.c           | 1 +
 testcases/kernel/syscalls/move_pages/move_pages09.c           | 1 +
 testcases/kernel/syscalls/ptrace/ptrace.h                     | 2 ++
 testcases/kernel/syscalls/ptrace/ptrace04.c                   | 3 +--
 testcases/kernel/syscalls/set_thread_area/set_thread_area01.c | 1 +
 18 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index 7a5580079..18c3ec2a0 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -19,6 +19,8 @@
 #ifndef LAPI_MMAP_H__
 #define LAPI_MMAP_H__
 
+#include "config.h"
+
 #ifndef MAP_HUGETLB
 # define MAP_HUGETLB 0x40000
 #endif
diff --git a/testcases/cve/cve-2012-0957.c b/testcases/cve/cve-2012-0957.c
index 096f49f69..ec6258a81 100644
--- a/testcases/cve/cve-2012-0957.c
+++ b/testcases/cve/cve-2012-0957.c
@@ -26,6 +26,7 @@
 
 #include <string.h>
 #include <sys/utsname.h>
+#include "config.h"
 #include "tst_test.h"
 #include "lapi/personality.h"
 
diff --git a/testcases/cve/cve-2016-4997.c b/testcases/cve/cve-2016-4997.c
index 2d99865b7..b2a704ff8 100644
--- a/testcases/cve/cve-2016-4997.c
+++ b/testcases/cve/cve-2016-4997.c
@@ -35,6 +35,7 @@
 #include <limits.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 
+#include "config.h"
 #include "tst_test.h"
 #include "tst_safe_net.h"
 #include "tst_kernel.h"
diff --git a/testcases/kernel/io/aio/aio02/common.h b/testcases/kernel/io/aio/aio02/common.h
index 4b80761a6..4a19c5ee4 100644
--- a/testcases/kernel/io/aio/aio02/common.h
+++ b/testcases/kernel/io/aio/aio02/common.h
@@ -1,3 +1,4 @@
+#include "config.h"
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index f3bfbf4fa..2b393affd 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -47,6 +47,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <errno.h>
+#include "config.h"
 #include "tst_test.h"
 #include "mem.h"
 
diff --git a/testcases/kernel/security/smack/smack_set_socket_labels.c b/testcases/kernel/security/smack/smack_set_socket_labels.c
index 7102d1352..187f5d1dd 100644
--- a/testcases/kernel/security/smack/smack_set_socket_labels.c
+++ b/testcases/kernel/security/smack/smack_set_socket_labels.c
@@ -9,6 +9,7 @@
  *	Casey Schaufler <casey@schaufler-ca.com>
  */
 
+#include "config.h"
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/testcases/kernel/syscalls/move_pages/move_pages01.c b/testcases/kernel/syscalls/move_pages/move_pages01.c
index e86c5fc80..4970aaafc 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages01.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages01.c
@@ -53,6 +53,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <errno.h>
+#include "config.h"
 #include "test.h"
 #include "move_pages_support.h"
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages02.c b/testcases/kernel/syscalls/move_pages/move_pages02.c
index ee84b92a7..beb4d8963 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages02.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages02.c
@@ -54,6 +54,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <errno.h>
+#include "config.h"
 #include "test.h"
 #include "move_pages_support.h"
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages03.c b/testcases/kernel/syscalls/move_pages/move_pages03.c
index f3f4fd9c1..aa75c12fa 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages03.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages03.c
@@ -58,6 +58,7 @@
 #include <signal.h>
 #include <semaphore.h>
 #include <errno.h>
+#include "config.h"
 #include "test.h"
 #include "move_pages_support.h"
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index 3678df0e0..833ef72f7 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -61,6 +61,7 @@
 #include <unistd.h>
 #include <signal.h>
 #include <errno.h>
+#include "config.h"
 #include "test.h"
 #include "move_pages_support.h"
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages05.c b/testcases/kernel/syscalls/move_pages/move_pages05.c
index da9642e7e..9c6c2ece4 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages05.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages05.c
@@ -56,6 +56,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <errno.h>
+#include "config.h"
 #include "test.h"
 #include "move_pages_support.h"
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages06.c b/testcases/kernel/syscalls/move_pages/move_pages06.c
index 0edb58218..91811b52f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages06.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages06.c
@@ -54,6 +54,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <errno.h>
+#include "config.h"
 #include "test.h"
 #include "move_pages_support.h"
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages07.c b/testcases/kernel/syscalls/move_pages/move_pages07.c
index 0ed54b77a..b4f6bd738 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages07.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages07.c
@@ -54,6 +54,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <errno.h>
+#include "config.h"
 #include "test.h"
 #include "move_pages_support.h"
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index bf237f35e..0c0ce967e 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages08.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
@@ -55,6 +55,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <limits.h>
+#include "config.h"
 #include "test.h"
 #include "move_pages_support.h"
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
index 2d9dc4680..1a017275a 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages09.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
@@ -54,6 +54,7 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <errno.h>
+#include "config.h"
 #include "test.h"
 #include "move_pages_support.h"
 
diff --git a/testcases/kernel/syscalls/ptrace/ptrace.h b/testcases/kernel/syscalls/ptrace/ptrace.h
index 4a43f01ef..abca0a4cd 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace.h
+++ b/testcases/kernel/syscalls/ptrace/ptrace.h
@@ -5,6 +5,8 @@
 #ifndef __LTP_PTRACE_H__
 #define __LTP_PTRACE_H__
 
+#include "config.h"
+
 #ifdef HAVE_SYS_PTRACE_H
 # include <sys/ptrace.h>
 #endif
diff --git a/testcases/kernel/syscalls/ptrace/ptrace04.c b/testcases/kernel/syscalls/ptrace/ptrace04.c
index af35fb3a2..7ffd8b013 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace04.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace04.c
@@ -14,9 +14,8 @@
 #include <stdlib.h>
 #include <unistd.h>
 
-#include <config.h>
+#include "config.h"
 #include "ptrace.h"
-
 #include "test.h"
 #include "spawn_ptrace_child.h"
 
diff --git a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
index b8639a3d3..eed5826cd 100644
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
@@ -19,6 +19,7 @@
  *
  ************************************************************************/
 
+#include "config.h"
 #include "set_thread_area.h"
 
 char *TCID = "set_thread_area_01";
-- 
2.15.1

