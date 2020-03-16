From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 16 Mar 2020 18:29:16 +0800
Subject: [LTP] [PATCH] openposix/functional/timers: Add missing Makefile
Message-ID: <1584354556-6439-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Currently, open_posix_testsuite/scripts/generate-makefiles.sh and local-test
think every c file is a test case, only directory with c file will generate
Makefile. It doesn't work well in situation with middle layer not having c file
like openposix/functional/thread. So add missing Makefile for this case and also
add LDLIBS for linking with -lrt.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/open_posix_testsuite/functional/Makefile     |  2 +-
 .../open_posix_testsuite/functional/timers/Makefile    | 10 ++++++++++
 .../functional/timers/timers/LDLIBS                    |  1 +
 3 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 testcases/open_posix_testsuite/functional/timers/Makefile
 create mode 100644 testcases/open_posix_testsuite/functional/timers/timers/LDLIBS

diff --git a/testcases/open_posix_testsuite/functional/Makefile b/testcases/open_posix_testsuite/functional/Makefile
index b647f0796..3b22c89af 100644
--- a/testcases/open_posix_testsuite/functional/Makefile
+++ b/testcases/open_posix_testsuite/functional/Makefile
@@ -10,4 +10,4 @@ all clean install test:
 	done
 
 distclean-makefiles:
-	@find */ -name 'Makefile*' | grep -v threads/Makefile | xargs rm -f
+	@find */ -name 'Makefile*' | grep -v threads/Makefile | grep -v timers/Makefile | xargs rm -f
diff --git a/testcases/open_posix_testsuite/functional/timers/Makefile b/testcases/open_posix_testsuite/functional/timers/Makefile
new file mode 100644
index 000000000..6cf8b0642
--- /dev/null
+++ b/testcases/open_posix_testsuite/functional/timers/Makefile
@@ -0,0 +1,10 @@
+#
+# Read COPYING for licensing details.
+#
+# Ngie Cooper, June 2010
+#
+
+all clean install test:
+	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
+		$(MAKE) -C $$dir $@;						   \
+	done
diff --git a/testcases/open_posix_testsuite/functional/timers/timers/LDLIBS b/testcases/open_posix_testsuite/functional/timers/timers/LDLIBS
new file mode 100644
index 000000000..4c7e2d8de
--- /dev/null
+++ b/testcases/open_posix_testsuite/functional/timers/timers/LDLIBS
@@ -0,0 +1 @@
+-lrt
-- 
2.18.1



