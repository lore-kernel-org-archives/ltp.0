From: Li Wang <liwang@redhat.com>
Date: Thu,  8 Jul 2021 21:06:02 +0800
Subject: [LTP] [PATCH] gethostid: skip test if sethostid undefined
Message-ID: <20210708130602.970689-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is to avoid compiling error if the sethostid() is not
implemented, e.g. build with Alpine's musl-libc.

CI: https://github.com/wangli5665/ltp/runs/3019192920

Signed-off-by: Li Wang <liwang@redhat.com>
---
 configure.ac                                      | 1 +
 testcases/kernel/syscalls/gethostid/gethostid01.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index 1a43ebea8..25c421de0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -128,6 +128,7 @@ AC_CHECK_FUNCS_ONCE([ \
     renameat2 \
     sched_getcpu \
     sendmmsg \
+    sethostid \
     setns \
     sigpending \
     splice \
diff --git a/testcases/kernel/syscalls/gethostid/gethostid01.c b/testcases/kernel/syscalls/gethostid/gethostid01.c
index 802604777..20e4cd307 100644
--- a/testcases/kernel/syscalls/gethostid/gethostid01.c
+++ b/testcases/kernel/syscalls/gethostid/gethostid01.c
@@ -26,6 +26,8 @@
 
 #include "tst_test.h"
 
+#ifdef HAVE_SETHOSTID
+
 static long origin;
 static long tc[] = {0x00000000, 0x0000ffff};
 
@@ -64,3 +66,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.tcnt = ARRAY_SIZE(tc),
 };
+
+#else
+TST_TEST_TCONF("sethostid is undefined.");
+#endif
-- 
2.31.1

