From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 21 Feb 2019 12:22:01 +0100
Subject: [LTP] [PATCH] syscalls/ustat: Move the syscall to lapi
Message-ID: <20190221112201.18324-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The dev parameter needs to be casted to unsigned in some cases, let's
move call to tst_syscall() from the tests to lapi so that the tests does
not have to worry about the low level details.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Steve Muckle <smuckle@google.com>
CC: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/ustat.h                      | 7 +++++++
 testcases/kernel/syscalls/ustat/ustat01.c | 5 ++---
 testcases/kernel/syscalls/ustat/ustat02.c | 5 ++---
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/lapi/ustat.h b/include/lapi/ustat.h
index 12c073582..6365b2e92 100644
--- a/include/lapi/ustat.h
+++ b/include/lapi/ustat.h
@@ -10,12 +10,19 @@
 #ifdef HAVE_SYS_USTAT_H
 # include <sys/ustat.h>
 #else
+# include "lapi/syscalls.h"
+
 struct ustat {
 	daddr_t f_tfree;
 	ino_t f_tinode;
 	char f_fname[6];
 	char f_fpack[6];
 };
+
+static inline int ustat(dev_t dev, struct ustat *ubuf)
+{
+	return tst_syscall(__NR_ustat, (unsigned int)dev, ubuf);
+}
 #endif
 
 #endif /* LAPI_USTAT_H */
diff --git a/testcases/kernel/syscalls/ustat/ustat01.c b/testcases/kernel/syscalls/ustat/ustat01.c
index 2e7dcc9d7..729f8c106 100644
--- a/testcases/kernel/syscalls/ustat/ustat01.c
+++ b/testcases/kernel/syscalls/ustat/ustat01.c
@@ -10,9 +10,8 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
-#include "lapi/syscalls.h"
-#include "lapi/ustat.h"
 #include "tst_test.h"
+#include "lapi/ustat.h"
 
 static dev_t dev_num;
 
@@ -20,7 +19,7 @@ void run(void)
 {
 	struct ustat ubuf;
 
-	TEST(tst_syscall(__NR_ustat, (unsigned int)dev_num, &ubuf));
+	TEST(ustat(dev_num, &ubuf));
 
 	if (TST_RET == -1)
 		tst_res(TFAIL | TTERRNO, "ustat(2) failed");
diff --git a/testcases/kernel/syscalls/ustat/ustat02.c b/testcases/kernel/syscalls/ustat/ustat02.c
index 9bbe4f3f5..3c9236200 100644
--- a/testcases/kernel/syscalls/ustat/ustat02.c
+++ b/testcases/kernel/syscalls/ustat/ustat02.c
@@ -11,9 +11,8 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 
-#include "lapi/syscalls.h"
-#include "lapi/ustat.h"
 #include "tst_test.h"
+#include "lapi/ustat.h"
 
 static dev_t invalid_dev = -1;
 static dev_t root_dev;
@@ -36,7 +35,7 @@ int TST_TOTAL = ARRAY_SIZE(tc);
 
 void run(unsigned int test)
 {
-	TEST(tst_syscall(__NR_ustat, *tc[test].dev, tc[test].buf));
+	TEST(ustat(*tc[test].dev, tc[test].buf));
 
 	if ((TST_RET == -1) && (TST_ERR == tc[test].exp_errno))
 		tst_res(TPASS | TTERRNO, "ustat(2) expected failure");
-- 
2.19.2

