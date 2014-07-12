Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1X5qTp-0000yv-5r
	for ltp-list@lists.sourceforge.net; Sat, 12 Jul 2014 06:08:17 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X5qTl-0004T5-HT
	for ltp-list@lists.sourceforge.net; Sat, 12 Jul 2014 06:08:17 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6C684Rs010497
	for <ltp-list@lists.sourceforge.net>; Sat, 12 Jul 2014 14:08:04 +0800
Message-ID: <1405145200.3386.4.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Sat, 12 Jul 2014 14:06:40 +0800
In-Reply-To: <1405145148.3386.3.camel@G08JYZSD130126>
References: <1405145148.3386.3.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] security/p9auth: Add p9auth tests to default
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

* Keep the entry like:
	p9auth_test1 p9auth_run_test.sh p9auth_test1
	p9auth_test2 p9auth_run_test.sh p9auth_test2
	p9auth_test3 p9auth_run_test.sh p9auth_test3

* Add p9auth tests to default

* Make p9auth testes name more saner:
	checkp9auth.sh  -->  p9auth_check.sh
	p9priv.sh       -->  p9auth_priv.sh
	p9unpriv.sh     -->  p9auth_unpriv.sh
	runp9auth.sh    -->  p9auth_run_test.sh
	unhex.c         -->  p9auth_unhex.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/p9auth                                     |  4 +-
 scenario_groups/default                            |  1 +
 testcases/kernel/security/p9auth/.gitignore        |  2 +-
 testcases/kernel/security/p9auth/checkp9auth.sh    | 54 -------------
 testcases/kernel/security/p9auth/p9auth_check.sh   | 54 +++++++++++++
 testcases/kernel/security/p9auth/p9auth_priv.sh    | 90 ++++++++++++++++++++++
 .../kernel/security/p9auth/p9auth_run_test.sh      | 62 +++++++++++++++
 testcases/kernel/security/p9auth/p9auth_unhex.c    | 50 ++++++++++++
 testcases/kernel/security/p9auth/p9auth_unpriv.sh  | 44 +++++++++++
 testcases/kernel/security/p9auth/p9priv.sh         | 90 ----------------------
 testcases/kernel/security/p9auth/p9unpriv.sh       | 44 -----------
 testcases/kernel/security/p9auth/runp9auth.sh      | 62 ---------------
 testcases/kernel/security/p9auth/unhex.c           | 50 ------------
 13 files changed, 305 insertions(+), 302 deletions(-)
 delete mode 100755 testcases/kernel/security/p9auth/checkp9auth.sh
 create mode 100755 testcases/kernel/security/p9auth/p9auth_check.sh
 create mode 100755 testcases/kernel/security/p9auth/p9auth_priv.sh
 create mode 100755 testcases/kernel/security/p9auth/p9auth_run_test.sh
 create mode 100644 testcases/kernel/security/p9auth/p9auth_unhex.c
 create mode 100755 testcases/kernel/security/p9auth/p9auth_unpriv.sh
 delete mode 100755 testcases/kernel/security/p9auth/p9priv.sh
 delete mode 100755 testcases/kernel/security/p9auth/p9unpriv.sh
 delete mode 100755 testcases/kernel/security/p9auth/runp9auth.sh
 delete mode 100644 testcases/kernel/security/p9auth/unhex.c

diff --git a/runtest/p9auth b/runtest/p9auth
index 17b1550..d0f6aa6 100644
--- a/runtest/p9auth
+++ b/runtest/p9auth
@@ -1,2 +1,4 @@
 #DESCRIPTION:p9auth /dev/caphash module
-p9auth		runp9auth.sh
+p9auth_test1 p9auth_run_test.sh p9auth_test1
+p9auth_test2 p9auth_run_test.sh p9auth_test2
+p9auth_test3 p9auth_run_test.sh p9auth_test3
diff --git a/scenario_groups/default b/scenario_groups/default
index 71b3646..2fdc9ee 100644
--- a/scenario_groups/default
+++ b/scenario_groups/default
@@ -30,3 +30,4 @@ fs_ext4
 pipes
 dma_thread_diotest
 cpuacct
+p9auth
diff --git a/testcases/kernel/security/p9auth/.gitignore b/testcases/kernel/security/p9auth/.gitignore
index a6ce058..56b0277 100644
--- a/testcases/kernel/security/p9auth/.gitignore
+++ b/testcases/kernel/security/p9auth/.gitignore
@@ -1 +1 @@
-/unhex
+/p9auth_unhex
diff --git a/testcases/kernel/security/p9auth/checkp9auth.sh b/testcases/kernel/security/p9auth/checkp9auth.sh
deleted file mode 100755
index 0eafd15..0000000
--- a/testcases/kernel/security/p9auth/checkp9auth.sh
+++ /dev/null
@@ -1,54 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2009                 ##
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
-
-p9auth_check()
-{
-	# check for openssl
-	if [ -e "/tmp/ab" ]; then
-		rm -f /tmp/ab
-	fi
-	echo "ab" > /tmp/ab
-	openssl sha1 -hmac "ab" /tmp/ab > /dev/null
-	ret=$?
-	if [ $ret -ne 0 ]; then
-		tst_brkm TCONF "openssl not installed, skipping p9auth tests."
-	fi
-
-	majfile=/sys/module/p9auth/parameters/cap_major
-	minfile=/sys/module/p9auth/parameters/cap_minor
-	if [ ! -f "$majfile" ]; then
-		tst_brkm TCONF "p9auth not detected.  Skipping p9auth tests."
-	fi
-
-	if [ ! -c "/dev/caphash" ]; then
-		rm -f /dev/caphash
-		maj=`cat $majfile`
-		mknod /dev/caphash c $maj 0
-	fi
-
-	if [ ! -c "/dev/capuse" ]; then
-		rm -f /dev/capuse
-		mknod /dev/capuse c $maj 1
-	fi
-	chmod ugo+w /dev/capuse
-
-	tst_resm TINFO "p9auth ready for testing"
-}
diff --git a/testcases/kernel/security/p9auth/p9auth_check.sh b/testcases/kernel/security/p9auth/p9auth_check.sh
new file mode 100755
index 0000000..0eafd15
--- /dev/null
+++ b/testcases/kernel/security/p9auth/p9auth_check.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2009                 ##
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
+
+p9auth_check()
+{
+	# check for openssl
+	if [ -e "/tmp/ab" ]; then
+		rm -f /tmp/ab
+	fi
+	echo "ab" > /tmp/ab
+	openssl sha1 -hmac "ab" /tmp/ab > /dev/null
+	ret=$?
+	if [ $ret -ne 0 ]; then
+		tst_brkm TCONF "openssl not installed, skipping p9auth tests."
+	fi
+
+	majfile=/sys/module/p9auth/parameters/cap_major
+	minfile=/sys/module/p9auth/parameters/cap_minor
+	if [ ! -f "$majfile" ]; then
+		tst_brkm TCONF "p9auth not detected.  Skipping p9auth tests."
+	fi
+
+	if [ ! -c "/dev/caphash" ]; then
+		rm -f /dev/caphash
+		maj=`cat $majfile`
+		mknod /dev/caphash c $maj 0
+	fi
+
+	if [ ! -c "/dev/capuse" ]; then
+		rm -f /dev/capuse
+		mknod /dev/capuse c $maj 1
+	fi
+	chmod ugo+w /dev/capuse
+
+	tst_resm TINFO "p9auth ready for testing"
+}
diff --git a/testcases/kernel/security/p9auth/p9auth_priv.sh b/testcases/kernel/security/p9auth/p9auth_priv.sh
new file mode 100755
index 0000000..42a9ea9
--- /dev/null
+++ b/testcases/kernel/security/p9auth/p9auth_priv.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2009                 ##
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
+
+p9auth_init()
+{
+	if [ -d "$LTPTMP" ]; then
+		rm -rf $LTPTMP
+	fi
+	mkdir -p $LTPTMP/d
+	chmod 755 $LTPTMP
+	chown -R ltp $LTPTMP/d
+}
+
+p9auth_setup()
+{
+	randstr=$RANDOM
+	if [ $p9auth_test = "p9auth_test2" ]; then
+		txt="$ltpuid@0"
+	elif [ $p9auth_test = "p9auth_test3" ]; then
+		txt="0@0"
+	fi
+	echo -n "$txt" > $LTPTMP/txtfile
+	openssl sha1 -hmac "$randstr" $LTPTMP/txtfile | awk '{ print $2 }' \
+		> $LTPTMP/hex
+	p9auth_unhex < $LTPTMP/hex > /dev/caphash
+	# give the child its token
+	echo -n "$txt@$randstr" > $LTPTMP/d/txtfile
+	chown ltp $LTPTMP/d/txtfile
+}
+
+p9auth_run()
+{
+	su ltp p9auth_unpriv.sh &
+	while [ ! -f $LTPTMP/d/childready ]; do :; done
+	touch $LTPTMP/childgo
+	until [ -f $LTPTMP/d/childfail -o -f $LTPTMP/d/childpass ]; do :; done
+}
+
+p9auth_test1()
+{
+	p9auth_init
+	p9auth_run
+	if [ -f $LTPTMP/d/childpass ]; then
+		tst_resm TFAIL "child could setuid with bad hash"
+	else
+		tst_resm TPASS "child couldn't setuid with bad hash"
+	fi
+}
+
+p9auth_test2()
+{
+	p9auth_init
+	p9auth_setup
+	p9auth_run
+	if [ -f $LTPTMP/d/childfail ]; then
+		tst_resm TFAIL "child couldn't setuid with good hash"
+	else
+		tst_resm TPASS "child could setuid with good hash"
+	fi
+}
+
+p9auth_test3()
+{
+	p9auth_init
+	p9auth_setup
+	p9auth_run
+	if [ -f $LTPTMP/d/childpass ]; then
+		tst_resm TFAIL "child could setuid from wrong source uid"
+	else
+		tst_resm TPASS "child couldn't setuid from wrong source uid"
+	fi
+}
diff --git a/testcases/kernel/security/p9auth/p9auth_run_test.sh b/testcases/kernel/security/p9auth/p9auth_run_test.sh
new file mode 100755
index 0000000..bf220a5
--- /dev/null
+++ b/testcases/kernel/security/p9auth/p9auth_run_test.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2008                 ##
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
+
+export TMPDIR=${TMPDIR:-/tmp}
+export LTPTMP=${TMPDIR}/p9auth_ltp
+
+TCID="$1"
+TST_TOTAL=1
+
+. test.sh
+. p9auth_check.sh
+. p9auth_priv.sh
+
+setup()
+{
+	tst_require_root
+
+	p9auth_check
+
+	if ! ltpuid=$(id -u ltp); then
+		useradd ltp
+		useradd_flag=1
+	else
+		useradd_flag=0
+	fi
+
+	p9auth_test="$TCID"
+}
+
+cleanup()
+{
+	rm -rf /tmp/ab
+	rm -rf $LTPTMP
+	if [ $useradd_flag -ne 0 ]; then
+		userdel -r ltp
+	fi
+}
+
+setup
+TST_CLEANUP=cleanup
+
+$p9auth_test
+
+tst_exit
diff --git a/testcases/kernel/security/p9auth/p9auth_unhex.c b/testcases/kernel/security/p9auth/p9auth_unhex.c
new file mode 100644
index 0000000..f3f7660
--- /dev/null
+++ b/testcases/kernel/security/p9auth/p9auth_unhex.c
@@ -0,0 +1,50 @@
+/******************************************************************************/
+/*                                                                            */
+/* Copyright (c) International Business Machines  Corp., 2008                 */
+/*                                                                            */
+/* This program is free software;  you can redistribute it and/or modify      */
+/* it under the terms of the GNU General Public License as published by       */
+/* the Free Software Foundation; either version 2 of the License, or          */
+/* (at your option) any later version.                                        */
+/*                                                                            */
+/* This program is distributed in the hope that it will be useful,            */
+/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
+/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
+/* the GNU General Public License for more details.                           */
+/*                                                                            */
+/* You should have received a copy of the GNU General Public License          */
+/* along with this program;  if not, write to the Free Software Foundation,   */
+/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
+/*                                                                            */
+/******************************************************************************/
+
+/*
+ * File: p9auth_unhex.c
+ * Author: Serge Hallyn
+ * Purpose: Read a 40 char hex value from stdin, output 20 char byte
+ * value on stdout.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+
+int main(void)
+{
+	char in[41], out[20];
+	unsigned int v;
+	int i, ret;
+
+	ret = read(STDIN_FILENO, in, 40);
+	if (ret != 40)
+		return 1;
+	in[40] = '\0';
+	for (i = 0; i < 20; i++) {
+		sscanf(&in[2 * i], "%02x", &v);
+		out[i] = v;
+	}
+	ret = write(STDOUT_FILENO, out, 20);
+	if (ret != 20)
+		return 1;
+
+	return 0;
+}
diff --git a/testcases/kernel/security/p9auth/p9auth_unpriv.sh b/testcases/kernel/security/p9auth/p9auth_unpriv.sh
new file mode 100755
index 0000000..a24edac
--- /dev/null
+++ b/testcases/kernel/security/p9auth/p9auth_unpriv.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+################################################################################
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2009                 ##
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
+
+tst_resm TINFO "ltptmp is $LTPTMP"
+
+myuid=`id -u`
+if [ "$myuid" -eq 0 ]; then
+	tst_brkm TBROK "Unprivileged child was started as root!"
+fi
+
+touch $LTPTMP/d/childready
+
+while [ 1 ]; do
+	if [ -f $LTPTMP/childexit ]; then
+		exit 0
+	fi
+	if [ -f $LTPTMP/childgo ]; then
+		echo -n `cat $LTPTMP/d/txtfile` > /dev/capuse
+		if [ `id -u` -eq 0 ]; then
+			touch $LTPTMP/d/childpass
+		else
+			touch $LTPTMP/d/childfail
+		fi
+		exit 0
+	fi
+done
diff --git a/testcases/kernel/security/p9auth/p9priv.sh b/testcases/kernel/security/p9auth/p9priv.sh
deleted file mode 100755
index 0355b66..0000000
--- a/testcases/kernel/security/p9auth/p9priv.sh
+++ /dev/null
@@ -1,90 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2009                 ##
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
-
-p9auth_init()
-{
-	if [ -d "$LTPTMP" ]; then
-		rm -rf $LTPTMP
-	fi
-	mkdir -p $LTPTMP/d
-	chmod 755 $LTPTMP
-	chown -R ltp $LTPTMP/d
-}
-
-p9auth_setup()
-{
-	randstr=$RANDOM
-	if [ $p9auth_test = "p9auth_test2" ]; then
-		txt="$ltpuid@0"
-	elif [ $p9auth_test = "p9auth_test3" ]; then
-		txt="0@0"
-	fi
-	echo -n "$txt" > $LTPTMP/txtfile
-	openssl sha1 -hmac "$randstr" $LTPTMP/txtfile | awk '{ print $2 }' \
-		> $LTPTMP/hex
-	unhex < $LTPTMP/hex > /dev/caphash
-	# give the child its token
-	echo -n "$txt@$randstr" > $LTPTMP/d/txtfile
-	chown ltp $LTPTMP/d/txtfile
-}
-
-p9auth_run()
-{
-	su ltp p9unpriv.sh &
-	while [ ! -f $LTPTMP/d/childready ]; do :; done
-	touch $LTPTMP/childgo
-	until [ -f $LTPTMP/d/childfail -o -f $LTPTMP/d/childpass ]; do :; done
-}
-
-p9auth_test1()
-{
-	p9auth_init
-	p9auth_run
-	if [ -f $LTPTMP/d/childpass ]; then
-		tst_resm TFAIL "child could setuid with bad hash"
-	else
-		tst_resm TPASS "child couldn't setuid with bad hash"
-	fi
-}
-
-p9auth_test2()
-{
-	p9auth_init
-	p9auth_setup
-	p9auth_run
-	if [ -f $LTPTMP/d/childfail ]; then
-		tst_resm TFAIL "child couldn't setuid with good hash"
-	else
-		tst_resm TPASS "child could setuid with good hash"
-	fi
-}
-
-p9auth_test3()
-{
-	p9auth_init
-	p9auth_setup
-	p9auth_run
-	if [ -f $LTPTMP/d/childpass ]; then
-		tst_resm TFAIL "child could setuid from wrong source uid"
-	else
-		tst_resm TPASS "child couldn't setuid from wrong source uid"
-	fi
-}
diff --git a/testcases/kernel/security/p9auth/p9unpriv.sh b/testcases/kernel/security/p9auth/p9unpriv.sh
deleted file mode 100755
index a24edac..0000000
--- a/testcases/kernel/security/p9auth/p9unpriv.sh
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2009                 ##
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
-
-tst_resm TINFO "ltptmp is $LTPTMP"
-
-myuid=`id -u`
-if [ "$myuid" -eq 0 ]; then
-	tst_brkm TBROK "Unprivileged child was started as root!"
-fi
-
-touch $LTPTMP/d/childready
-
-while [ 1 ]; do
-	if [ -f $LTPTMP/childexit ]; then
-		exit 0
-	fi
-	if [ -f $LTPTMP/childgo ]; then
-		echo -n `cat $LTPTMP/d/txtfile` > /dev/capuse
-		if [ `id -u` -eq 0 ]; then
-			touch $LTPTMP/d/childpass
-		else
-			touch $LTPTMP/d/childfail
-		fi
-		exit 0
-	fi
-done
diff --git a/testcases/kernel/security/p9auth/runp9auth.sh b/testcases/kernel/security/p9auth/runp9auth.sh
deleted file mode 100755
index 1196860..0000000
--- a/testcases/kernel/security/p9auth/runp9auth.sh
+++ /dev/null
@@ -1,62 +0,0 @@
-#!/bin/sh
-################################################################################
-##                                                                            ##
-## Copyright (c) International Business Machines  Corp., 2008                 ##
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
-
-export TMPDIR=${TMPDIR:-/tmp}
-export LTPTMP=${TMPDIR}/p9auth_ltp
-
-TCID="$1"
-TST_TOTAL=1
-
-. test.sh
-. checkp9auth.sh
-. p9priv.sh
-
-setup()
-{
-	tst_require_root
-
-	p9auth_check
-
-	if ! ltpuid=$(id -u ltp); then
-		useradd ltp
-		useradd_flag=1
-	else
-		useradd_flag=0
-	fi
-
-	p9auth_test="$TCID"
-}
-
-cleanup()
-{
-	rm -rf /tmp/ab
-	rm -rf $LTPTMP
-	if [ $useradd_flag -ne 0 ]; then
-		userdel -r ltp
-	fi
-}
-
-setup
-TST_CLEANUP=cleanup
-
-$p9auth_test
-
-tst_exit
diff --git a/testcases/kernel/security/p9auth/unhex.c b/testcases/kernel/security/p9auth/unhex.c
deleted file mode 100644
index f5bcded..0000000
--- a/testcases/kernel/security/p9auth/unhex.c
+++ /dev/null
@@ -1,50 +0,0 @@
-/******************************************************************************/
-/*                                                                            */
-/* Copyright (c) International Business Machines  Corp., 2008                 */
-/*                                                                            */
-/* This program is free software;  you can redistribute it and/or modify      */
-/* it under the terms of the GNU General Public License as published by       */
-/* the Free Software Foundation; either version 2 of the License, or          */
-/* (at your option) any later version.                                        */
-/*                                                                            */
-/* This program is distributed in the hope that it will be useful,            */
-/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
-/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
-/* the GNU General Public License for more details.                           */
-/*                                                                            */
-/* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software Foundation,   */
-/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
-/*                                                                            */
-/******************************************************************************/
-
-/*
- * File: unhex.c
- * Author: Serge Hallyn
- * Purpose: Read a 40 char hex value from stdin, output 20 char byte
- * value on stdout.
- */
-
-#include <stdio.h>
-#include <unistd.h>
-
-int main(void)
-{
-	char in[41], out[20];
-	unsigned int v;
-	int i, ret;
-
-	ret = read(STDIN_FILENO, in, 40);
-	if (ret != 40)
-		return 1;
-	in[40] = '\0';
-	for (i = 0; i < 20; i++) {
-		sscanf(&in[2 * i], "%02x", &v);
-		out[i] = v;
-	}
-	ret = write(STDOUT_FILENO, out, 20);
-	if (ret != 20)
-		return 1;
-
-	return 0;
-}
-- 
1.9.3




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
