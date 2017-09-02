From: Petr Vorel <petr.vorel@gmail.com>
Date: Sat,  2 Sep 2017 02:59:24 +0200
Subject: [LTP] [RFC PATCH 4/6] android: cve: Fix build of most of the tests
In-Reply-To: <20170902005926.15923-1-petr.vorel@gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
Message-ID: <20170902005926.15923-5-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/cve/Makefile        | 3 +++
 testcases/cve/cve-2014-0196.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index 5119c67cf..7c8917569 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -19,6 +19,7 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 CFLAGS			+= -D_GNU_SOURCE
 
+ifneq ($(ANDROID),1)
 cve-2016-7117:	CFLAGS += -pthread
 cve-2016-7117:	LDLIBS += -lrt
 
@@ -27,9 +28,11 @@ cve-2014-0196:  LDLIBS += -lrt -lutil
 
 cve-2017-2671:	CFLAGS += -pthread
 cve-2017-2671:	LDLIBS += -lrt
+endif
 
 ifeq ($(ANDROID),1)
 FILTER_OUT_MAKE_TARGETS	+= cve-2017-5669
+CPPFLAGS		+= -I$(abs_srcdir)/../../include/android
 endif
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/cve/cve-2014-0196.c b/testcases/cve/cve-2014-0196.c
index 4e2b3f582..87fea2781 100644
--- a/testcases/cve/cve-2014-0196.c
+++ b/testcases/cve/cve-2014-0196.c
@@ -34,6 +34,7 @@
  * privilege escalation POC https://www.exploit-db.com/exploits/33516/
  */
 
+#if !defined(__ANDROID_API__) || __ANDROID_API__ >= 23
 #include <pty.h>
 #include <stdio.h>
 #include <string.h>
@@ -159,3 +160,11 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = run,
 };
+#else /* Android API < 23 */
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+int main(void)
+{
+	tst_brk(TCONF, "test does not run on Android API < 23");
+}
+#endif
-- 
2.14.0

