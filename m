From: Zou Wei <zou_wei@huawei.com>
Date: Tue, 17 Mar 2020 15:27:11 +0800
Subject: [LTP] [PATCH] open_posix_testsuite: Fix compilation issues
Message-ID: <1584430031-47227-1-git-send-email-zou_wei@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix compilation issues:
1. Add the '-lpthread -lrt -lm' config into LDFLAGS
2. Update makefile and locate-test script

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 testcases/open_posix_testsuite/LDFLAGS             | 1 +
 testcases/open_posix_testsuite/functional/Makefile | 2 +-
 testcases/open_posix_testsuite/scripts/locate-test | 2 +-
 testcases/open_posix_testsuite/stress/Makefile     | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/open_posix_testsuite/LDFLAGS b/testcases/open_posix_testsuite/LDFLAGS
index e69de29..6c112d3 100644
--- a/testcases/open_posix_testsuite/LDFLAGS
+++ b/testcases/open_posix_testsuite/LDFLAGS
@@ -0,0 +1 @@
+-lpthread -lrt -lm
diff --git a/testcases/open_posix_testsuite/functional/Makefile b/testcases/open_posix_testsuite/functional/Makefile
index 3b22c89..50e03aa 100644
--- a/testcases/open_posix_testsuite/functional/Makefile
+++ b/testcases/open_posix_testsuite/functional/Makefile
@@ -5,7 +5,7 @@
 #

 all clean install test:
-	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
+	@for dir in `find . -name *Makefile | egrep -v '^./Makefile' | sed -e 's,/Makefile$$,,g'`; do \
 		$(MAKE) -C $$dir $@;						   \
 	done

diff --git a/testcases/open_posix_testsuite/scripts/locate-test b/testcases/open_posix_testsuite/scripts/locate-test
index 27f0bb5..e4ef994 100755
--- a/testcases/open_posix_testsuite/scripts/locate-test
+++ b/testcases/open_posix_testsuite/scripts/locate-test
@@ -92,7 +92,7 @@ runnable)
 	# waltz down the tools directory and try and build t0 (which doesn't
 	# make sense as it's a tool, not a test). Better criterion needs to
 	# be established for this file.
-	find "$WHERE/conformance" "$WHERE/stress" -type f -name '*[0-9].c' -o -name '[0-9]*-[0-9]*.sh' | grep -v buildonly | grep -v '^./tools'
+	find "$WHERE/conformance" "$WHERE/stress" -type f -name '*[0-9a-z].c' -o -name '[0-9]*-[0-9]*.sh' | grep -v buildonly | grep -v '^./tools' | grep -v 'testfrmw.c$'
 	find "$WHERE/functional" -type f -name '*.c'
 	;;
 test-tools)
diff --git a/testcases/open_posix_testsuite/stress/Makefile b/testcases/open_posix_testsuite/stress/Makefile
index b09527f..d6872a9 100644
--- a/testcases/open_posix_testsuite/stress/Makefile
+++ b/testcases/open_posix_testsuite/stress/Makefile
@@ -5,7 +5,7 @@
 #

 all clean install test:
-	@for dir in `ls -d */Makefile 2>/dev/null | sed -e 's,/Makefile$$,,g'`; do \
+	@for dir in `find . -name *Makefile | egrep -v '^./Makefile' | sed -e 's,/Makefile$$,,g'`; do \
 		$(MAKE) -C $$dir $@;						  \
 	done

--
2.6.2

