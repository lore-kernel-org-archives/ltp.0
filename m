Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XWhhI-0003kU-KJ
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 08:13:12 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XWhhG-0004YD-Pa
	for ltp-list@lists.sourceforge.net; Wed, 24 Sep 2014 08:13:12 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8O8D4bL004469
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Sep 2014 04:13:04 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s8O8D23B020298
	for <ltp-list@lists.sourceforge.net>; Wed, 24 Sep 2014 04:13:03 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 24 Sep 2014 10:13:00 +0200
Message-Id: <21cfeabab1b94a95295f03c96c2a1cb7f99faada.1411546290.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2] ldd01: remove all -m32/-m64 logic
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

and build all binaries with same CFLAGS as rest of LTP build.
Also treat lddfile*.so and lddfile.out as data files.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/commands/ade/ldd/Makefile             |   13 +------
 testcases/commands/ade/ldd/datafiles/Makefile   |   40 ++++++++++++++++++++
 testcases/commands/ade/ldd/datafiles/lddfile1.c |    5 ++
 testcases/commands/ade/ldd/datafiles/lddfile2.c |    5 ++
 testcases/commands/ade/ldd/datafiles/lddfile3.c |    5 ++
 testcases/commands/ade/ldd/datafiles/lddfile4.c |    5 ++
 testcases/commands/ade/ldd/datafiles/lddfile5.c |    5 ++
 testcases/commands/ade/ldd/datafiles/main.c     |   18 +++++++++
 testcases/commands/ade/ldd/ldd01                |   46 ++++------------------
 testcases/commands/ade/ldd/lddfile1.c           |    5 --
 testcases/commands/ade/ldd/lddfile2.c           |    5 --
 testcases/commands/ade/ldd/lddfile3.c           |    5 --
 testcases/commands/ade/ldd/lddfile4.c           |    5 --
 testcases/commands/ade/ldd/lddfile5.c           |    5 --
 testcases/commands/ade/ldd/main.c               |   18 ---------
 15 files changed, 93 insertions(+), 92 deletions(-)
 create mode 100644 testcases/commands/ade/ldd/datafiles/Makefile
 create mode 100644 testcases/commands/ade/ldd/datafiles/lddfile1.c
 create mode 100644 testcases/commands/ade/ldd/datafiles/lddfile2.c
 create mode 100644 testcases/commands/ade/ldd/datafiles/lddfile3.c
 create mode 100644 testcases/commands/ade/ldd/datafiles/lddfile4.c
 create mode 100644 testcases/commands/ade/ldd/datafiles/lddfile5.c
 create mode 100644 testcases/commands/ade/ldd/datafiles/main.c
 delete mode 100644 testcases/commands/ade/ldd/lddfile1.c
 delete mode 100644 testcases/commands/ade/ldd/lddfile2.c
 delete mode 100644 testcases/commands/ade/ldd/lddfile3.c
 delete mode 100644 testcases/commands/ade/ldd/lddfile4.c
 delete mode 100644 testcases/commands/ade/ldd/lddfile5.c
 delete mode 100644 testcases/commands/ade/ldd/main.c

diff --git a/testcases/commands/ade/ldd/Makefile b/testcases/commands/ade/ldd/Makefile
index eae06cd..f37f21b 100644
--- a/testcases/commands/ade/ldd/Makefile
+++ b/testcases/commands/ade/ldd/Makefile
@@ -13,10 +13,6 @@
 #    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 #    GNU General Public License for more details.
 #
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
 # Garrett Cooper, July 2009
 #
 
@@ -24,13 +20,6 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-CPPFLAGS		+= -fpic
-
 INSTALL_TARGETS		:= ldd01
 
-MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%.obj,$(wildcard $(abs_srcdir)/*.c))
-
-$(MAKE_TARGETS): %.obj: %.o
-	mv $^ $@
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/ade/ldd/datafiles/Makefile b/testcases/commands/ade/ldd/datafiles/Makefile
new file mode 100644
index 0000000..213cc74
--- /dev/null
+++ b/testcases/commands/ade/ldd/datafiles/Makefile
@@ -0,0 +1,40 @@
+#
+#    commands/ade/ldd/datafiles testcases Makefile.
+#
+#    Copyright (C) 2014, Linux Test Project.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+
+top_srcdir		?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+CPPFLAGS		+= -fpic
+
+INSTALL_TARGETS		:= ldd*.so lddfile.out
+
+LDD_C_FILES		:= $(wildcard $(abs_srcdir)/lddfile*.c)
+LDD_SO_FILES		:= $(patsubst $(abs_srcdir)/%.c,%.obj.so,$(LDD_C_FILES))
+MAKE_TARGETS		:= lddfile.out
+CLEAN_TARGETS		+= *.obj $(LDD_SO_FILES)
+
+%.obj: %.o
+	mv $^ $@
+
+%.obj.so: %.obj
+	$(CC) $(CFLAGS) -shared -o $@ $^
+
+lddfile.out: main.obj $(LDD_SO_FILES)
+	$(CC) $(CFLAGS) -O -o $@ $(LDD_SO_FILES) main.obj
+
+INSTALL_DIR		:= testcases/data/ldd01
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/ade/ldd/datafiles/lddfile1.c b/testcases/commands/ade/ldd/datafiles/lddfile1.c
new file mode 100644
index 0000000..ccb5786
--- /dev/null
+++ b/testcases/commands/ade/ldd/datafiles/lddfile1.c
@@ -0,0 +1,5 @@
+#include <stdio.h>
+void file1(void)
+{
+	printf("Control in function %s\n", __func__);
+}
diff --git a/testcases/commands/ade/ldd/datafiles/lddfile2.c b/testcases/commands/ade/ldd/datafiles/lddfile2.c
new file mode 100644
index 0000000..20aede3
--- /dev/null
+++ b/testcases/commands/ade/ldd/datafiles/lddfile2.c
@@ -0,0 +1,5 @@
+#include <stdio.h>
+void file2(void)
+{
+	printf("Control in function %s\n", __func__);
+}
diff --git a/testcases/commands/ade/ldd/datafiles/lddfile3.c b/testcases/commands/ade/ldd/datafiles/lddfile3.c
new file mode 100644
index 0000000..a4529f7
--- /dev/null
+++ b/testcases/commands/ade/ldd/datafiles/lddfile3.c
@@ -0,0 +1,5 @@
+#include <stdio.h>
+void file3(void)
+{
+	printf("Control in function %s\n", __func__);
+}
diff --git a/testcases/commands/ade/ldd/datafiles/lddfile4.c b/testcases/commands/ade/ldd/datafiles/lddfile4.c
new file mode 100644
index 0000000..9dc339d
--- /dev/null
+++ b/testcases/commands/ade/ldd/datafiles/lddfile4.c
@@ -0,0 +1,5 @@
+#include <stdio.h>
+void file4(void)
+{
+	printf("Control in function %s\n", __func__);
+}
diff --git a/testcases/commands/ade/ldd/datafiles/lddfile5.c b/testcases/commands/ade/ldd/datafiles/lddfile5.c
new file mode 100644
index 0000000..3fbb7f6
--- /dev/null
+++ b/testcases/commands/ade/ldd/datafiles/lddfile5.c
@@ -0,0 +1,5 @@
+#include <stdio.h>
+void file5(void)
+{
+	printf("Control in function %s\n", __func__);
+}
diff --git a/testcases/commands/ade/ldd/datafiles/main.c b/testcases/commands/ade/ldd/datafiles/main.c
new file mode 100644
index 0000000..69e278e
--- /dev/null
+++ b/testcases/commands/ade/ldd/datafiles/main.c
@@ -0,0 +1,18 @@
+#include <stdio.h>
+
+void file1(void);
+void file2(void);
+void file3(void);
+void file4(void);
+void file5(void);
+
+int main(void)
+{
+	file1();
+	file2();
+	file3();
+	file4();
+	file5();
+	printf("All Functions Executed\n");
+	return 0;
+}
diff --git a/testcases/commands/ade/ldd/ldd01 b/testcases/commands/ade/ldd/ldd01
index c60d3ac..87d3811 100755
--- a/testcases/commands/ade/ldd/ldd01
+++ b/testcases/commands/ade/ldd/ldd01
@@ -35,64 +35,36 @@ $trace_logic
 CC=${CC:=gcc}
 LDD=${LDD:=ldd}
 TCdat=${TCdat:-`pwd`}
-TCtmp=${TCtmp:-/tmp/ldd01-$$}
 
-do_cleanup()
-{
-	rm -rf $TCtmp
-}
-
-do_setup()
+do_test()
 {
-	mkdir $TCtmp
-
-	# Check for ppc64 architecture or x86_64 architecture
-	if uname -a | grep -iq powerpc; then
-		file lddfile1.obj | grep 64-bit >/dev/null 2>&1
-		if [ $? -eq 0 ]; then
-			CFLAGS="-m64"
-		fi
-	elif uname -a | grep -iq x86_64; then
-		file lddfile1.obj | grep 32-bit >/dev/null 2>&1
-		if [ $? -eq 0 ]; then
-			CFLAGS="-m32"
-		fi
+	if [ -z "$LTPROOT" ]; then
+		export LD_LIBRARY_PATH=./datafiles:$LD_LIBRARY_PATH
+		LDDTESTFILE="./datafiles/lddfile.out"
+	else
+		export LD_LIBRARY_PATH=$LTPROOT/testcases/data/ldd01:$LD_LIBRARY_PATH
+		LDDTESTFILE="$LTPROOT/testcases/data/ldd01/lddfile.out"
 	fi
-	$CC $CFLAGS -shared -o $TCtmp/lddfile1.obj.so $TCdat/lddfile1.obj
-	$CC $CFLAGS -shared -o $TCtmp/lddfile2.obj.so $TCdat/lddfile2.obj
-	$CC $CFLAGS -shared -o $TCtmp/lddfile3.obj.so $TCdat/lddfile3.obj
-	$CC $CFLAGS -shared -o $TCtmp/lddfile4.obj.so $TCdat/lddfile4.obj
-	$CC $CFLAGS -shared -o $TCtmp/lddfile5.obj.so $TCdat/lddfile5.obj
-	$CC $CFLAGS -O -o $TCtmp/a.out $TCtmp/lddfile*.obj.so $TCdat/main.obj
-}
 
-do_test()
-{
 	echo "  ASSERTION 1  "
-
-	$LDD $TCtmp/a.out | grep -E "lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
+	$LDD $LDDTESTFILE | grep -E "lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
 	if [ $? -eq 0 ]; then
 		echo "ASSERTION #1 PASS"
 	else
 		echo "ASSERTION #1 FAIL"
-		do_cleanup
 		return 1
 	fi
 
 	echo " ASSERTION 2  "
-
-	$LDD -v $TCtmp/a.out | grep -E "GLIBC|lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
+	$LDD -v $LDDTESTFILE | grep -E "GLIBC|lddfile1.obj.so|lddfile2.obj.so|lddfile3.obj.so|lddfile4.obj.so|lddfile5.obj.so"
 	if [ $? -eq 0 ]; then
 		echo "ASSERTION #2 PASS"
 	else
 		echo "ASSERTION #2 FAIL"
-		do_cleanup
 		return 1
 	fi
 
 	echo "TEST PASSES"
-	do_cleanup
 	return 0
 }
-do_setup
 do_test
diff --git a/testcases/commands/ade/ldd/lddfile1.c b/testcases/commands/ade/ldd/lddfile1.c
deleted file mode 100644
index 377f7a3..0000000
--- a/testcases/commands/ade/ldd/lddfile1.c
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <stdio.h>
-void file1()
-{
-	printf("Control in function %s\n", __func__);
-}
diff --git a/testcases/commands/ade/ldd/lddfile2.c b/testcases/commands/ade/ldd/lddfile2.c
deleted file mode 100644
index 5fd2b4b..0000000
--- a/testcases/commands/ade/ldd/lddfile2.c
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <stdio.h>
-void file2()
-{
-	printf("Control in function %s\n", __func__);
-}
diff --git a/testcases/commands/ade/ldd/lddfile3.c b/testcases/commands/ade/ldd/lddfile3.c
deleted file mode 100644
index d6b4cc9..0000000
--- a/testcases/commands/ade/ldd/lddfile3.c
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <stdio.h>
-void file3()
-{
-	printf("Control in function %s\n", __func__);
-}
diff --git a/testcases/commands/ade/ldd/lddfile4.c b/testcases/commands/ade/ldd/lddfile4.c
deleted file mode 100644
index 1db89bb..0000000
--- a/testcases/commands/ade/ldd/lddfile4.c
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <stdio.h>
-void file4()
-{
-	printf("Control in function %s\n", __func__);
-}
diff --git a/testcases/commands/ade/ldd/lddfile5.c b/testcases/commands/ade/ldd/lddfile5.c
deleted file mode 100644
index 2f46cdb..0000000
--- a/testcases/commands/ade/ldd/lddfile5.c
+++ /dev/null
@@ -1,5 +0,0 @@
-#include <stdio.h>
-void file5()
-{
-	printf("Control in function %s\n", __func__);
-}
diff --git a/testcases/commands/ade/ldd/main.c b/testcases/commands/ade/ldd/main.c
deleted file mode 100644
index 0f23b8b..0000000
--- a/testcases/commands/ade/ldd/main.c
+++ /dev/null
@@ -1,18 +0,0 @@
-#include <stdio.h>
-
-void file1();
-void file2();
-void file3();
-void file4();
-void file5();
-
-int main()
-{
-	file1();
-	file2();
-	file3();
-	file4();
-	file5();
-	printf("All Functions Executed\n");
-	return 0;
-}
-- 
1.7.1


------------------------------------------------------------------------------
Meet PCI DSS 3.0 Compliance Requirements with EventLog Analyzer
Achieve PCI DSS 3.0 Compliant Status with Out-of-the-box PCI DSS Reports
Are you Audit-Ready for PCI DSS 3.0 Compliance? Download White paper
Comply to PCI DSS 3.0 Requirement 10 and 11.5 with EventLog Analyzer
http://pubads.g.doubleclick.net/gampad/clk?id=154622311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
