From: Li Wang <liwang@redhat.com>
Date: Wed, 24 May 2017 15:18:31 +0800
Subject: [LTP] [PATCH] tst_tests.sh: set the shell TST_ID automatically
Message-ID: <20170524071831.25290-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

commit a5bf5254ca94 sets the tst_test->tid automatically in
LTP C test framework. Here proposed that the shell variable
TST_ID should be handled in the same way.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/test-writing-guidelines.txt                 | 5 -----
 testcases/commands/ar/ar01                      | 1 -
 testcases/commands/cp/cp_tests.sh               | 1 -
 testcases/commands/cpio/cpio_tests.sh           | 1 -
 testcases/commands/cron/cron_tests.sh           | 1 -
 testcases/commands/df/df01.sh                   | 1 -
 testcases/commands/du/du01.sh                   | 1 -
 testcases/commands/eject/eject-tests.sh         | 1 -
 testcases/commands/file/file_test.sh            | 1 -
 testcases/commands/gzip/gzip_tests.sh           | 1 -
 testcases/commands/insmod/insmod01.sh           | 1 -
 testcases/commands/keyctl/keyctl01.sh           | 1 -
 testcases/commands/ld/ld01                      | 1 -
 testcases/commands/ldd/ldd01                    | 1 -
 testcases/commands/ln/ln_tests.sh               | 1 -
 testcases/commands/lsmod/lsmod01.sh             | 1 -
 testcases/commands/mkdir/mkdir_tests.sh         | 1 -
 testcases/commands/mkfs/mkfs01.sh               | 1 -
 testcases/commands/mkswap/mkswap01.sh           | 1 -
 testcases/commands/mv/mv_tests.sh               | 1 -
 testcases/commands/nm/nm01                      | 1 -
 testcases/commands/tar/tar_tests.sh             | 1 -
 testcases/commands/unzip/unzip_tests.sh         | 1 -
 testcases/commands/wc/wc01.sh                   | 1 -
 testcases/commands/which/which01.sh             | 1 -
 testcases/kernel/controllers/cpuacct/cpuacct.sh | 1 -
 testcases/kernel/controllers/pids/pids.sh       | 1 -
 testcases/kernel/numa/numa01.sh                 | 1 -
 testcases/lib/tst_test.sh                       | 3 ++-
 29 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index d10668e..479c24e 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1306,7 +1306,6 @@ WARNING: All identifiers starting with TST_ or tst_ are reserved for the
 # This is a basic test for true shell buildin
 #
 
-TST_ID="true01"
 TST_TESTFUNC=do_test
 . tst_test.sh
 
@@ -1352,7 +1351,6 @@ starts the test.
 # Example test with tests in separate functions
 #
 
-TST_ID="example01"
 TST_TESTFUNC=test
 TST_CNT=2
 . tst_test.sh
@@ -1381,7 +1379,6 @@ found they are executed one by one.
 # Example test with tests in a single function
 #
 
-TST_ID="example02"
 TST_TESTFUNC=do_test
 TST_CNT=2
 . tst_test.sh
@@ -1461,7 +1458,6 @@ variable, if module wasn't found the test will exit with 'TCONF'.
 # Optional test command line parameters
 #
 
-TST_ID="example03"
 TST_OPTS="af:"
 TST_USAGE=usage
 TST_PARSE_ARGS=parse_args
@@ -1516,7 +1512,6 @@ if option has argument, its value in '$2'.
 # Optional test positional paramters
 #
 
-TST_ID="example04"
 TST_POS_ARGS=3
 TST_USAGE=usage
 TST_TESTFUNC=do_test
diff --git a/testcases/commands/ar/ar01 b/testcases/commands/ar/ar01
index e27cd04..746148e 100644
--- a/testcases/commands/ar/ar01
+++ b/testcases/commands/ar/ar01
@@ -22,7 +22,6 @@
 #
 # This is a basic ar command test.
 #
-TST_ID="ar01"
 TST_CNT=17
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
diff --git a/testcases/commands/cp/cp_tests.sh b/testcases/commands/cp/cp_tests.sh
index b04b9dd..30bb183 100755
--- a/testcases/commands/cp/cp_tests.sh
+++ b/testcases/commands/cp/cp_tests.sh
@@ -23,7 +23,6 @@
 #
 # Tests basic cp functionality
 #
-TST_ID="ln01"
 TST_CNT=5
 TST_TESTFUNC=do_test
 TST_SETUP=setup
diff --git a/testcases/commands/cpio/cpio_tests.sh b/testcases/commands/cpio/cpio_tests.sh
index 261194d..9ebfb10 100755
--- a/testcases/commands/cpio/cpio_tests.sh
+++ b/testcases/commands/cpio/cpio_tests.sh
@@ -23,7 +23,6 @@
 #
 # Test basic functionality of cpio command
 #
-TST_ID="cpio01"
 TST_TESTFUNC=cpio_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="cpio"
diff --git a/testcases/commands/cron/cron_tests.sh b/testcases/commands/cron/cron_tests.sh
index b76f0b6..47614f9 100644
--- a/testcases/commands/cron/cron_tests.sh
+++ b/testcases/commands/cron/cron_tests.sh
@@ -19,7 +19,6 @@
 #
 # Author: Manoj Iyer <manjo@mail.utexas.edu>
 
-TST_ID="cron_tests01"
 TST_CNT=3
 TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 739ec93..0552327 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -16,7 +16,6 @@
 # Test df command with some basic options.
 #
 
-TST_ID="df01"
 TST_CNT=12
 TST_SETUP=setup
 TST_CLEANUP=cleanup
diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
index 2fe23b3..ed1df56 100755
--- a/testcases/commands/du/du01.sh
+++ b/testcases/commands/du/du01.sh
@@ -20,7 +20,6 @@
 # Test du command with some basic options.
 #
 
-TST_ID="du01"
 TST_CNT=23
 TST_SETUP=setup
 TST_TESTFUNC=do_test
diff --git a/testcases/commands/eject/eject-tests.sh b/testcases/commands/eject/eject-tests.sh
index e9971b5..c1dcd58 100755
--- a/testcases/commands/eject/eject-tests.sh
+++ b/testcases/commands/eject/eject-tests.sh
@@ -24,7 +24,6 @@
 # Tests basic functionality of eject command.
 #
 
-TST_ID="eject01"
 TST_CNT=4
 TST_SETUP=setup
 TST_CLEANUP=cleanup
diff --git a/testcases/commands/file/file_test.sh b/testcases/commands/file/file_test.sh
index ed4792a..1ef59f9 100755
--- a/testcases/commands/file/file_test.sh
+++ b/testcases/commands/file/file_test.sh
@@ -24,7 +24,6 @@
 # testing if the file command can recognize some of the commonly
 # used file formats like, tar, tar.gz, rpm, C, ASCII, ELF etc.
 #
-TST_ID="file01"
 TST_CNT=20
 TST_SETUP=setup
 TST_TESTFUNC=do_test
diff --git a/testcases/commands/gzip/gzip_tests.sh b/testcases/commands/gzip/gzip_tests.sh
index 1cd5275..05ecb6f 100755
--- a/testcases/commands/gzip/gzip_tests.sh
+++ b/testcases/commands/gzip/gzip_tests.sh
@@ -28,7 +28,6 @@
 #			    uncompress all the files available.
 #
 
-TST_ID="gzip"
 TST_CNT=2
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
diff --git a/testcases/commands/insmod/insmod01.sh b/testcases/commands/insmod/insmod01.sh
index 532f802..a7835f9 100755
--- a/testcases/commands/insmod/insmod01.sh
+++ b/testcases/commands/insmod/insmod01.sh
@@ -16,7 +16,6 @@
 # Test the basic functionality of insmod command.
 #
 
-TST_ID="insmod01"
 TST_CLEANUP=cleanup
 TST_TESTFUNC=do_test
 TST_NEEDS_ROOT=1
diff --git a/testcases/commands/keyctl/keyctl01.sh b/testcases/commands/keyctl/keyctl01.sh
index 076a130..690fbbf 100644
--- a/testcases/commands/keyctl/keyctl01.sh
+++ b/testcases/commands/keyctl/keyctl01.sh
@@ -26,7 +26,6 @@
 #   KEYS: potential uninitialized variable
 #
 
-TST_ID="keyctl01"
 TST_SETUP=setup
 TST_CLEANUP=cleanup
 TST_TESTFUNC=do_test
diff --git a/testcases/commands/ld/ld01 b/testcases/commands/ld/ld01
index 3ff1d09..f24f6f9 100755
--- a/testcases/commands/ld/ld01
+++ b/testcases/commands/ld/ld01
@@ -25,7 +25,6 @@
 CC=${CC:=gcc}
 LD=${LD:=ld}
 
-TST_ID="ld01"
 TST_CNT=5
 TST_TESTFUNC=test
 TST_SETUP=setup
diff --git a/testcases/commands/ldd/ldd01 b/testcases/commands/ldd/ldd01
index ebd7492..cf2aac3 100755
--- a/testcases/commands/ldd/ldd01
+++ b/testcases/commands/ldd/ldd01
@@ -27,7 +27,6 @@
 #     -Ported
 #---------------------------------------------------------------------------
 
-TST_ID=ldd01
 TST_CNT=2
 TST_SETUP=setup
 TST_TESTFUNC=test
diff --git a/testcases/commands/ln/ln_tests.sh b/testcases/commands/ln/ln_tests.sh
index 5d9335a..bc48bed 100755
--- a/testcases/commands/ln/ln_tests.sh
+++ b/testcases/commands/ln/ln_tests.sh
@@ -23,7 +23,6 @@
 #
 # Basic test for ln
 #
-TST_ID="ln01"
 TST_CNT=6
 TST_TESTFUNC=do_test
 TST_SETUP=setup
diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
index e31c43d..132a446 100755
--- a/testcases/commands/lsmod/lsmod01.sh
+++ b/testcases/commands/lsmod/lsmod01.sh
@@ -15,7 +15,6 @@
 #
 # Test the basic functionality of lsmod command.
 #
-TST_ID="lsmod01"
 TST_TESTFUNC=lsmod_test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="lsmod"
diff --git a/testcases/commands/mkdir/mkdir_tests.sh b/testcases/commands/mkdir/mkdir_tests.sh
index a182e24..990162b 100755
--- a/testcases/commands/mkdir/mkdir_tests.sh
+++ b/testcases/commands/mkdir/mkdir_tests.sh
@@ -22,7 +22,6 @@
 #
 # Basic mkdir tests
 #
-TST_ID="mkdir01"
 TST_CNT=3
 TST_SETUP=setup
 TST_TESTFUNC=test
diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 72dc1bd..90c32ed 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -16,7 +16,6 @@
 # Test mkfs command with some basic options.
 #
 
-TST_ID="mkfs01"
 TST_CNT=5
 TST_SETUP=setup
 TST_TESTFUNC=test
diff --git a/testcases/commands/mkswap/mkswap01.sh b/testcases/commands/mkswap/mkswap01.sh
index f6d19ec..1c01c86 100755
--- a/testcases/commands/mkswap/mkswap01.sh
+++ b/testcases/commands/mkswap/mkswap01.sh
@@ -16,7 +16,6 @@
 # Test mkswap command with some basic options.
 #
 
-TST_ID="mkswap01"
 TST_CNT=10
 TST_SETUP=setup
 TST_TESTFUNC=do_test
diff --git a/testcases/commands/mv/mv_tests.sh b/testcases/commands/mv/mv_tests.sh
index 85d7991..ed55066 100755
--- a/testcases/commands/mv/mv_tests.sh
+++ b/testcases/commands/mv/mv_tests.sh
@@ -27,7 +27,6 @@
 #		  move file1 to file2 and backup the file2.
 #
 
-TST_ID=mv01
 TST_CNT=2
 TST_SETUP=setup
 TST_TESTFUNC=test
diff --git a/testcases/commands/nm/nm01 b/testcases/commands/nm/nm01
index 5255049..39d5c9a 100755
--- a/testcases/commands/nm/nm01
+++ b/testcases/commands/nm/nm01
@@ -24,7 +24,6 @@
 #
 NM=${NM:=nm}
 
-TST_ID="nm01"
 TST_CNT=7
 TST_TESTFUNC=test
 TST_SETUP=setup
diff --git a/testcases/commands/tar/tar_tests.sh b/testcases/commands/tar/tar_tests.sh
index b67bcf1..7ac18a4 100755
--- a/testcases/commands/tar/tar_tests.sh
+++ b/testcases/commands/tar/tar_tests.sh
@@ -24,7 +24,6 @@
 # Creates, lists and extracts an plain, gzip and bzip tar archive.
 #
 
-TST_ID="tar01"
 TST_CNT=6
 TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
diff --git a/testcases/commands/unzip/unzip_tests.sh b/testcases/commands/unzip/unzip_tests.sh
index f67b5da..532afc0 100755
--- a/testcases/commands/unzip/unzip_tests.sh
+++ b/testcases/commands/unzip/unzip_tests.sh
@@ -24,7 +24,6 @@
 # Tests basic functionality of unzip command.
 #
 
-TST_ID="unzip01"
 TST_SETUP=setup
 TST_TESTFUNC=do_test
 TST_NEEDS_TMPDIR=1
diff --git a/testcases/commands/wc/wc01.sh b/testcases/commands/wc/wc01.sh
index 2272dcb..e72819c 100755
--- a/testcases/commands/wc/wc01.sh
+++ b/testcases/commands/wc/wc01.sh
@@ -16,7 +16,6 @@
 # Test wc command with some basic options.
 #
 
-TST_ID="wc01"
 TST_CNT=12
 TST_SETUP=setup
 TST_TESTFUNC=do_test
diff --git a/testcases/commands/which/which01.sh b/testcases/commands/which/which01.sh
index eb87095..72c14fe 100755
--- a/testcases/commands/which/which01.sh
+++ b/testcases/commands/which/which01.sh
@@ -16,7 +16,6 @@
 # Test which command with some basic options.
 #
 
-TST_ID="which01"
 TST_CNT=10
 TST_SETUP=setup
 TST_TESTFUNC=do_test
diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
index 6d3778c..edd4a98 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
@@ -35,7 +35,6 @@
 # 2) Check that sum ltp_test/subgroup*/cpuacct.usage = ltp_test/cpuacct.usage
 #
 
-TST_ID="cpuacct"
 TST_SETUP=setup
 TST_CLEANUP=cleanup
 TST_TESTFUNC=do_test
diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
index eda29cb..e2385a1 100755
--- a/testcases/kernel/controllers/pids/pids.sh
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -26,7 +26,6 @@
 # Usage
 # ./pids.sh caseno max
 #
-TST_ID="pids"
 TST_CLEANUP=cleanup
 TST_SETUP=setup
 TST_TESTFUNC=do_test
diff --git a/testcases/kernel/numa/numa01.sh b/testcases/kernel/numa/numa01.sh
index 4eda3f1..bbc1c63 100755
--- a/testcases/kernel/numa/numa01.sh
+++ b/testcases/kernel/numa/numa01.sh
@@ -35,7 +35,6 @@
 #                                                                            #
 ##############################################################################
 
-TST_ID="numa01"
 TST_CNT=11
 TST_SETUP=setup
 TST_TESTFUNC=test
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 087adda..9453759 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -374,7 +374,8 @@ if TST_TEST_PATH=$(which $0) 2>/dev/null; then
 fi
 
 if [ -z "$TST_ID" ]; then
-	tst_brk TBROK "TST_ID is not defined"
+	filename=$(basename $0)
+	TST_ID=${filename%%.*}
 fi
 export TST_ID="$TST_ID"
 
-- 
2.9.3

