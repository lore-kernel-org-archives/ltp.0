From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 17 Jun 2019 23:31:38 +0200
Subject: [LTP] [PATCH 1/1] syscalls/ustat: Use __kernel_daddr_t instead of
	daddr_t
Message-ID: <20190617213138.15896-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes build for musl, which does not have <sys/ustat.h> nor
typedef daddr_t. Musl does not define these as ustat is deprecated
in favor of statfs() and daddr_t is ancient [1].

Other libc also does not have <sys/ustat.h> (ustat support was removed
from glibc in 2.28), but they have daddr_t.

This brings <linux/types.h> dependency for ustat testing.

Typedef is needed as sparc and mips have __kernel_daddr_t long,
otherwise it's int.

[1] https://www.openwall.com/lists/musl/2019/06/10/1

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 configure.ac                              | 1 +
 include/lapi/ustat.h                      | 5 +++--
 testcases/kernel/syscalls/ustat/ustat01.c | 8 +++++++-
 testcases/kernel/syscalls/ustat/ustat02.c | 8 +++++++-
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 53ad784d7..8ca7e8065 100644
--- a/configure.ac
+++ b/configure.ac
@@ -46,6 +46,7 @@ AC_CHECK_HEADERS([ \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
+    linux/types.h \
     linux/userfaultfd.h \
     mm.h \
     netinet/sctp.h \
diff --git a/include/lapi/ustat.h b/include/lapi/ustat.h
index 12c073582..98633e749 100644
--- a/include/lapi/ustat.h
+++ b/include/lapi/ustat.h
@@ -9,9 +9,10 @@
 
 #ifdef HAVE_SYS_USTAT_H
 # include <sys/ustat.h>
-#else
+#elif HAVE_LINUX_TYPES_H
+# include <linux/types.h>
 struct ustat {
-	daddr_t f_tfree;
+	__kernel_daddr_t f_tfree;
 	ino_t f_tinode;
 	char f_fname[6];
 	char f_fpack[6];
diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 2e7dcc9d7..0252858be 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -5,6 +5,10 @@
  * Check that ustat() succeeds given correct parameters.
  */
 
+#include "config.h"
+#include "tst_test.h"
+
+#if defined(HAVE_SYS_USTAT_H) || defined(HAVE_LINUX_TYPES_H)
 #include <unistd.h>
 #include <errno.h>
 #include <sys/types.h>
@@ -12,7 +16,6 @@
 
 #include "lapi/syscalls.h"
 #include "lapi/ustat.h"
-#include "tst_test.h"
 
 static dev_t dev_num;
 
@@ -42,3 +45,6 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 };
+#else
+TST_TEST_TCONF("testing ustat requires <sys/ustat.h> or <linux/types.h>");
+#endif
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index 9bbe4f3f5..4c171f7b8 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -6,6 +6,10 @@
  * invalid dev_t parameter and for bad address paramater.
  */
 
+#include "config.h"
+#include "tst_test.h"
+
+#if defined(HAVE_SYS_USTAT_H) || defined(HAVE_LINUX_TYPES_H)
 #include <unistd.h>
 #include <errno.h>
 #include <sys/stat.h>
@@ -13,7 +17,6 @@
 
 #include "lapi/syscalls.h"
 #include "lapi/ustat.h"
-#include "tst_test.h"
 
 static dev_t invalid_dev = -1;
 static dev_t root_dev;
@@ -61,3 +64,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.tcnt = ARRAY_SIZE(tc),
 };
+#else
+TST_TEST_TCONF("testing ustat requires <sys/ustat.h> or <linux/types.h>");
+#endif
-- 
2.20.1

