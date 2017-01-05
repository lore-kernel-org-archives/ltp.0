From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  5 Jan 2017 14:16:14 +0100
Subject: [LTP] [COMMITTED] [PATCH] commands/ld01: Fix test for LTP compiled
	with -m32
Message-ID: <1483622174-22581-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test was pre-compiling the object files while LTP was build which
leads to a problem when LTP is compiled with -m32 where the produced
object files ended up incompatible with the 64bit ld command.

So after this commit the only installed datafiles are the C sources and
the object files are produced in the test setup.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/commands/ld/datafiles/Makefile |  5 ++---
 testcases/commands/ld/ld01               | 18 +++++++++++++-----
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/testcases/commands/ld/datafiles/Makefile b/testcases/commands/ld/datafiles/Makefile
index 7a46714..7b19207 100644
--- a/testcases/commands/ld/datafiles/Makefile
+++ b/testcases/commands/ld/datafiles/Makefile
@@ -16,8 +16,7 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_DIR		:= testcases/data/ld01
-
-CPPFLAGS		+= -fPIC
-MAKE_TARGETS		:= $(patsubst $(abs_srcdir)/%.c,%.o,$(wildcard $(abs_srcdir)/*.c))
+MAKE_TARGETS		:=
+INSTALL_TARGETS		:= $(wildcard *.c)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/commands/ld/ld01 b/testcases/commands/ld/ld01
index b7b0993..3ff1d09 100755
--- a/testcases/commands/ld/ld01
+++ b/testcases/commands/ld/ld01
@@ -28,10 +28,18 @@ LD=${LD:=ld}
 TST_ID="ld01"
 TST_CNT=5
 TST_TESTFUNC=test
+TST_SETUP=setup
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="$CC $LD"
 . tst_test.sh
 
+setup()
+{
+	for i in rf1 f1 rd1 d1 main; do
+		ROD $CC -fPIC -c -o ${i}.o $TST_DATAROOT/${i}.c
+	done
+}
+
 test1()
 {
 	EXPECT_FAIL $LD x.o y.o 2\> ld.out
@@ -58,7 +66,7 @@ test2()
 
 test3()
 {
-	EXPECT_PASS $LD -shared $TST_DATAROOT/f1.o $TST_DATAROOT/d1.o -o test.so
+	EXPECT_PASS $LD -shared f1.o d1.o -o test.so
 
 	if file test.so |grep -q shared; then
 		tst_res TPASS "Shared library could be build"
@@ -69,14 +77,14 @@ test3()
 
 test4()
 {
-	EXPECT_PASS $LD -Bdynamic -shared $TST_DATAROOT/f1.o $TST_DATAROOT/d1.o -o test.so
-	EXPECT_FAIL $LD -Bstatic -L. $TST_DATAROOT/main.o $TST_DATAROOT/rd1.o test.so -o a.out
+	EXPECT_PASS $LD -Bdynamic -shared f1.o d1.o -o test.so
+	EXPECT_FAIL $LD -Bstatic -L. main.o rd1.o test.so -o a.out
 }
 
 test5()
 {
-	EXPECT_PASS $LD -Bdynamic -shared $TST_DATAROOT/main.o $TST_DATAROOT/f1.o $TST_DATAROOT/rf1.o -o test.so -L/usr/lib/
-	EXPECT_FAIL $LD -Bstatic -r $TST_DATAROOT/main.o $TST_DATAROOT/f1.o $TST_DATAROOT/rf1.o test.so -L/usr/lib/ 2\> ld.out
+	EXPECT_PASS $LD -Bdynamic -shared main.o f1.o rf1.o -o test.so -L/usr/lib/
+	EXPECT_FAIL $LD -Bstatic -r main.o f1.o rf1.o test.so -L/usr/lib/ 2\> ld.out
 	cat ld.out
 
 	if grep -q "$LD: attempted static link of dynamic object" ld.out; then
-- 
2.7.3

