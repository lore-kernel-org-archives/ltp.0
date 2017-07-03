From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 3 Jul 2017 10:36:20 +0800
Subject: [LTP] [PATCH v2] commands: fix unmatched installation path of
	datafiles
In-Reply-To: <20170630114037.GB18305@rei.lan>
References: <20170630114037.GB18305@rei.lan>
Message-ID: <1499049380-8959-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Both file01 and unzip01 failed due to unmatched installation
path of datafiles.  It has been broken by:

commit f9a91c164ac52a4c91ff6aa9c156f110d04158d6
Author: Li Wang <liwang@redhat.com>
Date:   Wed May 24 15:18:31 2017 +0800

	tst_tests.sh: set the shell TST_ID automatically

We renamed these testcases to keep the test filenames constistent.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 runtest/commands                        |   4 +-
 testcases/commands/file/Makefile        |   2 +-
 testcases/commands/file/file01.sh       | 105 ++++++++++++++++++++++++++++++++
 testcases/commands/file/file_test.sh    | 105 --------------------------------
 testcases/commands/unzip/Makefile       |   2 +-
 testcases/commands/unzip/unzip01.sh     |  98 +++++++++++++++++++++++++++++
 testcases/commands/unzip/unzip_tests.sh |  98 -----------------------------
 7 files changed, 207 insertions(+), 207 deletions(-)
 create mode 100755 testcases/commands/file/file01.sh
 delete mode 100755 testcases/commands/file/file_test.sh
 create mode 100755 testcases/commands/unzip/unzip01.sh
 delete mode 100755 testcases/commands/unzip/unzip_tests.sh

diff --git a/runtest/commands b/runtest/commands
index 682deda..4661643 100644
--- a/runtest/commands
+++ b/runtest/commands
@@ -3,13 +3,13 @@ ar export TCdat=$LTPROOT/testcases/bin; ar01
 ld01 ld01
 ldd01 ldd01
 nm01 nm01
-file01 file_test.sh
+file01 file01.sh
 tar01  tar_tests.sh
 cron cron_tests.sh
 logrotate export TCdat=$LTPROOT/testcases/bin; logrotate_tests.sh
 mail export TCdat=$LTPROOT/testcases/bin; mail_tests.sh
 cpio01 cpio_tests.sh
-unzip01 unzip_tests.sh
+unzip01 unzip01.sh
 gzip01 gzip_tests.sh
 cp01 cp_tests.sh
 ln01 ln_tests.sh
diff --git a/testcases/commands/file/Makefile b/testcases/commands/file/Makefile
index e6257a1..776db32 100644
--- a/testcases/commands/file/Makefile
+++ b/testcases/commands/file/Makefile
@@ -24,6 +24,6 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= file_test.sh
+INSTALL_TARGETS		:= file01.sh
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/file/file01.sh b/testcases/commands/file/file01.sh
new file mode 100755
index 0000000..1b253cb
--- /dev/null
+++ b/testcases/commands/file/file01.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2001                 ##
+## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
+##                                                                            ##
+################################################################################
+#
+# This program tests the file command. The tests are aimed at
+# testing if the file command can recognize some of the commonly
+# used file formats like, tar, tar.gz, rpm, C, ASCII, ELF etc.
+#
+TST_CNT=20
+TST_SETUP=setup
+TST_TESTFUNC=do_test
+TST_NEEDS_TMPDIR=1
+. tst_test.sh
+
+setup()
+{
+	case $(readelf -h /bin/sh) in
+	*Data:*"big endian"*) TEST_ARCH=MSB;;
+	*Data:*"little endian"*) TEST_ARCH=LSB;;
+        *) tst_brk TBROK "Failed to determine CPU endianess";;
+	esac
+}
+
+file_test()
+{
+	local fname="$1"
+	local fpath
+	local i
+	shift
+
+	if ! [ -f "$fname" ]; then
+		fpath="$TST_DATAROOT/$fname"
+	else
+		fpath="$fname"
+	fi
+
+	EXPECT_PASS file "$fpath" \> file.out
+
+	while [ $# -gt 0 ]; do
+		if grep -q "$1" file.out; then
+			break
+		fi
+		shift
+	done
+
+	if [ $# -gt 0 ]; then
+		tst_res TPASS "$fname: recognized as $1"
+	else
+		tst_res TFAIL "$fname: was not recognized"
+		cat file.out
+	fi
+}
+
+do_test()
+{
+	case $1 in
+	 1) file_test in.txt "ASCII text";;
+	 2) file_test in.bash "Bourne-Again shell script";;
+	 3) file_test in.sh "POSIX shell script, ASCII text executable" \
+			    "POSIX shell script text executable" \
+			    "POSIX shell script text" \
+			    "Bourne shell script text executable";;
+	 4) file_test in.ksh "Korn shell script";;
+	 5) file_test in.csh "C shell script";;
+	 6) file_test in.c "ASCII C program text" "C source, ASCII text";;
+	 7) file_test in.pl "[pP]erl script, ASCII text executable" \
+			    "[pP]erl script text executable" \
+			    "a /usr/bin/perl script text";;
+	 8) file_test in.py "[pP]ython script, ASCII text executable" \
+			    "[pP]ython script text executable";;
+	 9) file_test in.m4 "M4 macro processor script, ASCII text" \
+			    "ASCII M4 macro language pre-processor text";;
+	10) file_test in "ELF .*-bit $TEST_ARCH executable, .*";;
+	11) file_test in.ar "current ar archive";;
+	12) file_test in.tar "tar archive";;
+	13) file_test in.tar.gz "gzip compressed data, .*";;
+	14) file_test in.tar.bz2 "bzip2 compressed data, .*";;
+	15) file_test in.src.rpm "RPM v3 src" "RPM v3.0 src";;
+	16) file_test in.jpg "JPEG image data";;
+	17) file_test in.png "PNG image data";;
+	18) file_test in.wav "RIFF (little-endian) data, WAVE audio, Microsoft PCM";;
+	19) file_test in.mp3 "MPEG ADTS, layer III";;
+	20) file_test in.zip "Zip archive data";;
+	esac
+}
+
+tst_run
diff --git a/testcases/commands/file/file_test.sh b/testcases/commands/file/file_test.sh
deleted file mode 100755
index 1ef59f9..0000000
--- a/testcases/commands/file/file_test.sh
+++ /dev/null
@@ -1,105 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-## Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>                          ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# This program tests the file command. The tests are aimed at
-# testing if the file command can recognize some of the commonly
-# used file formats like, tar, tar.gz, rpm, C, ASCII, ELF etc.
-#
-TST_CNT=20
-TST_SETUP=setup
-TST_TESTFUNC=do_test
-TST_NEEDS_TMPDIR=1
-. tst_test.sh
-
-setup()
-{
-	case $(readelf -h /bin/sh) in
-	*Data:*"big endian"*) TEST_ARCH=MSB;;
-	*Data:*"little endian"*) TEST_ARCH=LSB;;
-        *) tst_brk TBROK "Failed to determine CPU endianess";;
-	esac
-}
-
-file_test()
-{
-	local fname="$1"
-	local fpath
-	local i
-	shift
-
-	if ! [ -f "$fname" ]; then
-		fpath="$TST_DATAROOT/$fname"
-	else
-		fpath="$fname"
-	fi
-
-	EXPECT_PASS file "$fpath" \> file.out
-
-	while [ $# -gt 0 ]; do
-		if grep -q "$1" file.out; then
-			break
-		fi
-		shift
-	done
-
-	if [ $# -gt 0 ]; then
-		tst_res TPASS "$fname: recognized as $1"
-	else
-		tst_res TFAIL "$fname: was not recognized"
-		cat file.out
-	fi
-}
-
-do_test()
-{
-	case $1 in
-	 1) file_test in.txt "ASCII text";;
-	 2) file_test in.bash "Bourne-Again shell script";;
-	 3) file_test in.sh "POSIX shell script, ASCII text executable" \
-			    "POSIX shell script text executable" \
-			    "POSIX shell script text" \
-			    "Bourne shell script text executable";;
-	 4) file_test in.ksh "Korn shell script";;
-	 5) file_test in.csh "C shell script";;
-	 6) file_test in.c "ASCII C program text" "C source, ASCII text";;
-	 7) file_test in.pl "[pP]erl script, ASCII text executable" \
-			    "[pP]erl script text executable" \
-			    "a /usr/bin/perl script text";;
-	 8) file_test in.py "[pP]ython script, ASCII text executable" \
-			    "[pP]ython script text executable";;
-	 9) file_test in.m4 "M4 macro processor script, ASCII text" \
-			    "ASCII M4 macro language pre-processor text";;
-	10) file_test in "ELF .*-bit $TEST_ARCH executable, .*";;
-	11) file_test in.ar "current ar archive";;
-	12) file_test in.tar "tar archive";;
-    	13) file_test in.tar.gz "gzip compressed data, .*";;
-    	14) file_test in.tar.bz2 "bzip2 compressed data, .*";;
-	15) file_test in.src.rpm "RPM v3 src" "RPM v3.0 src";;
-	16) file_test in.jpg "JPEG image data";;
-	17) file_test in.png "PNG image data";;
-	18) file_test in.wav "RIFF (little-endian) data, WAVE audio, Microsoft PCM";;
-	19) file_test in.mp3 "MPEG ADTS, layer III";;
-	20) file_test in.zip "Zip archive data";;
-	esac
-}
-
-tst_run
diff --git a/testcases/commands/unzip/Makefile b/testcases/commands/unzip/Makefile
index fdebbce..72ac803 100644
--- a/testcases/commands/unzip/Makefile
+++ b/testcases/commands/unzip/Makefile
@@ -24,6 +24,6 @@ top_srcdir		?= ../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-INSTALL_TARGETS		:= unzip_tests.sh
+INSTALL_TARGETS		:= unzip01.sh
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/commands/unzip/unzip01.sh b/testcases/commands/unzip/unzip01.sh
new file mode 100755
index 0000000..532afc0
--- /dev/null
+++ b/testcases/commands/unzip/unzip01.sh
@@ -0,0 +1,98 @@
+#! /bin/sh
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2001                 ##
+##  Author:        Manoj Iyer, manjo@mail.utexas.edu                          ##
+## Copyright (c) Cyril Hrubis <chrubis@suse.cz>                               ##
+##                                                                            ##
+## This program is free software;  you can redistribute it and#or modify      ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
+## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
+## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
+##                                                                            ##
+################################################################################
+#
+# Tests basic functionality of unzip command.
+#
+
+TST_SETUP=setup
+TST_TESTFUNC=do_test
+TST_NEEDS_TMPDIR=1
+TST_NEEDS_CMDS="unzip"
+. tst_test.sh
+
+setup()
+{
+	cat > unzip_exp.out <<EOF
+Archive:  $TST_DATAROOT/test.zip
+   creating: dir/
+   creating: dir/d1/
+   creating: dir/d2/
+   creating: dir/d3/
+   creating: dir/d4/
+ extracting: dir/d1/f1
+ extracting: dir/d1/f2
+ extracting: dir/d1/f3
+   creating: dir/d2/d1/
+   creating: dir/d2/d2/
+   creating: dir/d2/d3/
+ extracting: dir/d2/f1
+ extracting: dir/d2/f2
+ extracting: dir/d2/f3
+   creating: dir/d3/d1/
+   creating: dir/d3/d2/
+   creating: dir/d3/d3/
+EOF
+}
+
+stable_ls()
+{
+	local i
+
+	for i in $(echo "$1/*" | sort); do
+
+		if ! [ -e "$i" ]; then
+			return
+		fi
+
+		echo "$i"
+
+		if [ -d "$i" ]; then
+			stable_ls "$i"
+		fi
+	done
+}
+
+do_test()
+{
+	EXPECT_PASS unzip "$TST_DATAROOT/test.zip" \> unzip.out
+
+	if diff -w unzip_exp.out unzip.out; then
+		tst_res TPASS "Unzip output is correct"
+	else
+		tst_res TFAIL "Unzip output is incorrect"
+		cat unzip.out
+	fi
+
+	stable_ls "dir" > dir.out
+
+	if diff "$TST_DATAROOT/dir.out" dir.out; then
+		tst_res TPASS "Files unzipped correctly"
+	else
+		tst_res TFAIL "Files unzipped incorrectly"
+		cat dir.out
+	fi
+
+	ROD rm -rf "dir/"
+}
+
+tst_run
diff --git a/testcases/commands/unzip/unzip_tests.sh b/testcases/commands/unzip/unzip_tests.sh
deleted file mode 100755
index 532afc0..0000000
--- a/testcases/commands/unzip/unzip_tests.sh
+++ /dev/null
@@ -1,98 +0,0 @@
-#! /bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2001                 ##
-##  Author:        Manoj Iyer, manjo@mail.utexas.edu                          ##
-## Copyright (c) Cyril Hrubis <chrubis@suse.cz>                               ##
-##                                                                            ##
-## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by       ##
-## the Free Software Foundation; either version 2 of the License, or          ##
-## (at your option) any later version.                                        ##
-##                                                                            ##
-## This program is distributed in the hope that it will be useful, but        ##
-## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
-## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.                                                          ##
-##                                                                            ##
-## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software Foundation,   ##
-## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
-##                                                                            ##
-################################################################################
-#
-# Tests basic functionality of unzip command.
-#
-
-TST_SETUP=setup
-TST_TESTFUNC=do_test
-TST_NEEDS_TMPDIR=1
-TST_NEEDS_CMDS="unzip"
-. tst_test.sh
-
-setup()
-{
-	cat > unzip_exp.out <<EOF
-Archive:  $TST_DATAROOT/test.zip
-   creating: dir/
-   creating: dir/d1/
-   creating: dir/d2/
-   creating: dir/d3/
-   creating: dir/d4/
- extracting: dir/d1/f1
- extracting: dir/d1/f2
- extracting: dir/d1/f3
-   creating: dir/d2/d1/
-   creating: dir/d2/d2/
-   creating: dir/d2/d3/
- extracting: dir/d2/f1
- extracting: dir/d2/f2
- extracting: dir/d2/f3
-   creating: dir/d3/d1/
-   creating: dir/d3/d2/
-   creating: dir/d3/d3/
-EOF
-}
-
-stable_ls()
-{
-	local i
-
-	for i in $(echo "$1/*" | sort); do
-
-		if ! [ -e "$i" ]; then
-			return
-		fi
-
-		echo "$i"
-
-		if [ -d "$i" ]; then
-			stable_ls "$i"
-		fi
-	done
-}
-
-do_test()
-{
-	EXPECT_PASS unzip "$TST_DATAROOT/test.zip" \> unzip.out
-
-	if diff -w unzip_exp.out unzip.out; then
-		tst_res TPASS "Unzip output is correct"
-	else
-		tst_res TFAIL "Unzip output is incorrect"
-		cat unzip.out
-	fi
-
-	stable_ls "dir" > dir.out
-
-	if diff "$TST_DATAROOT/dir.out" dir.out; then
-		tst_res TPASS "Files unzipped correctly"
-	else
-		tst_res TFAIL "Files unzipped incorrectly"
-		cat dir.out
-	fi
-
-	ROD rm -rf "dir/"
-}
-
-tst_run
-- 
1.8.3.1



