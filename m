Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1X5qSz-0006JY-AP
	for ltp-list@lists.sourceforge.net; Sat, 12 Jul 2014 06:07:25 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1X5qSw-0007au-5L
	for ltp-list@lists.sourceforge.net; Sat, 12 Jul 2014 06:07:25 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6C67C7A010485
	for <ltp-list@lists.sourceforge.net>; Sat, 12 Jul 2014 14:07:13 +0800
Message-ID: <1405145148.3386.3.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Sat, 12 Jul 2014 14:05:48 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] security/p9auth: Cleanup
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

* Use test.sh

* Use p9auth_check() function instead of checkp9auth.sh

* Define some functions in p9priv.sh:
	p9auth_init()
	p9auth_setup()
	p9auth_run()
	p9auth_test{1,2,3}()

* Delete argc and argv in unhex.c to fix compilation warnings.

* Some cleanup

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/security/p9auth/Makefile       |   4 +-
 testcases/kernel/security/p9auth/checkp9auth.sh |  98 +++++++---------
 testcases/kernel/security/p9auth/p9priv.sh      | 147 ++++++++++--------------
 testcases/kernel/security/p9auth/p9unpriv.sh    |  23 ++--
 testcases/kernel/security/p9auth/runp9auth.sh   |  55 ++++++---
 testcases/kernel/security/p9auth/unhex.c        |  11 +-
 6 files changed, 161 insertions(+), 177 deletions(-)

diff --git a/testcases/kernel/security/p9auth/Makefile b/testcases/kernel/security/p9auth/Makefile
index 603b9d4..66c7f51 100644
--- a/testcases/kernel/security/p9auth/Makefile
+++ b/testcases/kernel/security/p9auth/Makefile
@@ -13,8 +13,8 @@
 ## for more details.                                                          ##
 ##                                                                            ##
 ## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
 ##                                                                            ##
 ################################################################################
 
diff --git a/testcases/kernel/security/p9auth/checkp9auth.sh b/testcases/kernel/security/p9auth/checkp9auth.sh
index c2a6ca9..0eafd15 100755
--- a/testcases/kernel/security/p9auth/checkp9auth.sh
+++ b/testcases/kernel/security/p9auth/checkp9auth.sh
@@ -1,70 +1,54 @@
 #!/bin/sh
 ################################################################################
-##										      ##
-## Copyright (c) International Business Machines  Corp., 2009		   ##
-##										      ##
+##                                                                            ##
+## Copyright (c) International Business Machines  Corp., 2009                 ##
+##                                                                            ##
 ## This program is free software;  you can redistribute it and#or modify      ##
-## it under the terms of the GNU General Public License as published by	##
-## the Free Software Foundation; either version 2 of the License, or	   ##
-## (at your option) any later version.					     ##
-##										      ##
-## This program is distributed in the hope that it will be useful, but	 ##
+## it under the terms of the GNU General Public License as published by       ##
+## the Free Software Foundation; either version 2 of the License, or          ##
+## (at your option) any later version.                                        ##
+##                                                                            ##
+## This program is distributed in the hope that it will be useful, but        ##
 ## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
 ## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
-## for more details.								  ##
-##										      ##
-## You should have received a copy of the GNU General Public License	   ##
-## along with this program;  if not, write to the Free Software		 ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
-##										      ##
+## for more details.                                                          ##
+##                                                                            ##
+## You should have received a copy of the GNU General Public License          ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
+##                                                                            ##
 ################################################################################
 
-yesno=0
-if [ "$1" = "yesno" ]; then
-	yesno=1
-fi
-
-# check for openssl
-rm -f /tmp/ab
-echo ab > /tmp/ab
-openssl sha1 -hmac "ab" /tmp/ab > /dev/null
-ret=$?
-if [ $ret -ne 0 ]; then
-	if [ $yesno -eq 1 ]; then echo
-		 "no"
-	else
-		 echo "openssl not installed, skipping p9auth tests."
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
 	fi
-	exit 1
-fi
 
-majfile=/sys/module/p9auth/parameters/cap_major
-minfile=/sys/module/p9auth/parameters/cap_minor
-if [ ! -f "$majfile" ]; then
-	if [ $yesno -eq 1 ]; then echo
-		 "no"
-	else
-		 echo "p9auth not detected.  Skipping p9auth tests."
+	majfile=/sys/module/p9auth/parameters/cap_major
+	minfile=/sys/module/p9auth/parameters/cap_minor
+	if [ ! -f "$majfile" ]; then
+		tst_brkm TCONF "p9auth not detected.  Skipping p9auth tests."
 	fi
-	exit 1
-fi
 
-if [ ! -c "/dev/caphash" ]; then
-	rm -f /dev/caphash
-	maj=`cat $majfile`
-	mknod /dev/caphash c $maj 0
-fi
+	if [ ! -c "/dev/caphash" ]; then
+		rm -f /dev/caphash
+		maj=`cat $majfile`
+		mknod /dev/caphash c $maj 0
+	fi
 
-if [ ! -c "/dev/capuse" ]; then
-	rm -f /dev/capuse
-	min=`cat $minfile`
-	mknod /dev/capuse c $maj 1
-fi
-chmod ugo+w /dev/capuse
+	if [ ! -c "/dev/capuse" ]; then
+		rm -f /dev/capuse
+		mknod /dev/capuse c $maj 1
+	fi
+	chmod ugo+w /dev/capuse
 
-if [ $yesno -eq 1 ]; then
-	echo "yes"
-else
-	echo "p9auth ready for testing"
-fi
-exit 0
+	tst_resm TINFO "p9auth ready for testing"
+}
diff --git a/testcases/kernel/security/p9auth/p9priv.sh b/testcases/kernel/security/p9auth/p9priv.sh
index fae3249..0355b66 100755
--- a/testcases/kernel/security/p9auth/p9priv.sh
+++ b/testcases/kernel/security/p9auth/p9priv.sh
@@ -14,98 +14,77 @@
 ## for more details.                                                          ##
 ##                                                                            ##
 ## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
 ##                                                                            ##
 ################################################################################
 
-export TMPDIR=${TMPDIR:-/tmp}
-export LTPTMP=${TMPDIR}/p9auth_ltp
-export TST_TOTAL=3
-export TCID="p9auth"
-
-export TST_COUNT=1
-
-rm -rf $LTPTMP
-mkdir $LTPTMP
-chmod 755 $LTPTMP
-
-comms="$LTPTMP/childgo $LTPTMP/d/childready $LTPTMP/d/childfail $LTPTMP/d/childpass $LTPTMP/childexit"
-
-cleanup() {
-	rm -rf $LTPTMP/d $comms
+p9auth_init()
+{
+	if [ -d "$LTPTMP" ]; then
+		rm -rf $LTPTMP
+	fi
 	mkdir -p $LTPTMP/d
+	chmod 755 $LTPTMP
 	chown -R ltp $LTPTMP/d
 }
 
-if [ "$(id -ru)" -ne 0 ]; then
-	tst_resm TBROK "Must start p9auth tests as root"
-	exit 1
-fi
-
-if ! ltpuid=$(id -u ltp); then
-	tst_resm TCONF "Failed to find ltp userid"
-	exit 1
-fi
-
-# TEST 1: ltp setuids to 0 but no valid hash
-# launch an unprivileged helper
-cleanup
-
-su ltp p9unpriv.sh &
-while [ ! -f $LTPTMP/d/childready ]; do :; done
-touch $LTPTMP/childgo
-until [ -f $LTPTMP/d/childfail -o -f $LTPTMP/d/childpass ]; do :; done
-if [ -f $LTPTMP/d/childpass ]; then
-	tst_resm TFAIL "child could setuid with bad hash"
-	exit 1
-fi
-tst_resm TPASS "child couldn't setuid with bad hash"
-
-# TEST 2: ltp setuids to 0 with valid hash
-
-# create the hash.  randstr doesn't have to be int, but it's ok
-cleanup
-randstr=$RANDOM
-txt="$ltpuid@0"
-echo -n "$txt" > $LTPTMP/txtfile
-openssl sha1 -hmac "$randstr" $LTPTMP/txtfile | awk '{ print $2 '} > $LTPTMP/hex
-unhex < $LTPTMP/hex > /dev/caphash
-# give the child its token
-echo -n "$txt@$randstr" > $LTPTMP/d/txtfile
-chown ltp $LTPTMP/d/txtfile
-
-su ltp p9unpriv.sh &
-while [ ! -f $LTPTMP/d/childready ]; do :; done
-touch $LTPTMP/childgo
-until [ -f $LTPTMP/d/childfail -o -f $LTPTMP/d/childpass ]; do :; done
-if [ -f $LTPTMP/d/childfail ]; then
-	tst_resm TFAIL "child couldn't setuid with good hash"
-	exit 1
-fi
-tst_resm TPASS "child could setuid with good hash"
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
+	unhex < $LTPTMP/hex > /dev/caphash
+	# give the child its token
+	echo -n "$txt@$randstr" > $LTPTMP/d/txtfile
+	chown ltp $LTPTMP/d/txtfile
+}
 
-# TEST 3: 0 setuids to 0 with hash valid for ltp user
-cleanup
-randstr=$RANDOM
-txt="0@0"
-echo -n "$txt" > $LTPTMP/txtfile
-openssl sha1 -hmac "$randstr" $LTPTMP/txtfile | awk '{ print $2 '} > $LTPTMP/hex
-unhex < $LTPTMP/hex > /dev/caphash
-# give the child its token
-echo -n "$txt@$randstr" > $LTPTMP/d/txtfile
-chown ltp $LTPTMP/d/txtfile
+p9auth_run()
+{
+	su ltp p9unpriv.sh &
+	while [ ! -f $LTPTMP/d/childready ]; do :; done
+	touch $LTPTMP/childgo
+	until [ -f $LTPTMP/d/childfail -o -f $LTPTMP/d/childpass ]; do :; done
+}
 
-su ltp p9unpriv.sh &
-while [ ! -f $LTPTMP/d/childready ]; do :; done
-touch $LTPTMP/childgo
-until [ -f $LTPTMP/d/childfail -o -f $LTPTMP/d/childpass ]; do :; done;
-if [ -f $LTPTMP/d/childpass ]; then
-	tst_resm TFAIL "child could setuid from wrong source uid"
-	exit 1
-fi
-tst_resm TPASS "child couldn't setuid from wrong source uid"
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
 
-touch $LTPTMP/childexit
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
 
-exit 0
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
diff --git a/testcases/kernel/security/p9auth/p9unpriv.sh b/testcases/kernel/security/p9auth/p9unpriv.sh
index 9dfb1fa..a24edac 100755
--- a/testcases/kernel/security/p9auth/p9unpriv.sh
+++ b/testcases/kernel/security/p9auth/p9unpriv.sh
@@ -14,24 +14,19 @@
 ## for more details.                                                          ##
 ##                                                                            ##
 ## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
 ##                                                                            ##
 ################################################################################
 
-LTPTMP=/tmp/p9auth_ltp
-
-TOUCH=`which touch`
-ID=`which id`
-echo ltptmp is $LTPTMP
+tst_resm TINFO "ltptmp is $LTPTMP"
 
 myuid=`id -u`
 if [ "$myuid" -eq 0 ]; then
-	echo "Unprivileged child was started as root!"
-	exit 1
+	tst_brkm TBROK "Unprivileged child was started as root!"
 fi
 
-$TOUCH $LTPTMP/d/childready
+touch $LTPTMP/d/childready
 
 while [ 1 ]; do
 	if [ -f $LTPTMP/childexit ]; then
@@ -39,13 +34,11 @@ while [ 1 ]; do
 	fi
 	if [ -f $LTPTMP/childgo ]; then
 		echo -n `cat $LTPTMP/d/txtfile` > /dev/capuse
-		if [ `$ID -u` -eq 0 ]; then
-			$TOUCH $LTPTMP/d/childpass
+		if [ `id -u` -eq 0 ]; then
+			touch $LTPTMP/d/childpass
 		else
-			$TOUCH $LTPTMP/d/childfail
+			touch $LTPTMP/d/childfail
 		fi
 		exit 0
 	fi
 done
-
-exit 0
diff --git a/testcases/kernel/security/p9auth/runp9auth.sh b/testcases/kernel/security/p9auth/runp9auth.sh
index 45b4143..1196860 100755
--- a/testcases/kernel/security/p9auth/runp9auth.sh
+++ b/testcases/kernel/security/p9auth/runp9auth.sh
@@ -14,24 +14,49 @@
 ## for more details.                                                          ##
 ##                                                                            ##
 ## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
 ##                                                                            ##
 ################################################################################
 
-checkp9auth.sh
-ret=$?
-if [ $ret -ne 0 ]; then
-	echo "p9auth module is not supported by this kernel."
-	exit 0
-fi
+export TMPDIR=${TMPDIR:-/tmp}
+export LTPTMP=${TMPDIR}/p9auth_ltp
 
-exit_code=0
+TCID="$1"
+TST_TOTAL=1
 
-p9priv.sh
-tmp=$?
-if [ $tmp -ne 0 ]; then
-	exit_code=$tmp
-fi
+. test.sh
+. checkp9auth.sh
+. p9priv.sh
 
-exit $exit_code
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
diff --git a/testcases/kernel/security/p9auth/unhex.c b/testcases/kernel/security/p9auth/unhex.c
index 7235fa2..f5bcded 100644
--- a/testcases/kernel/security/p9auth/unhex.c
+++ b/testcases/kernel/security/p9auth/unhex.c
@@ -13,8 +13,8 @@
 /* the GNU General Public License for more details.                           */
 /*                                                                            */
 /* You should have received a copy of the GNU General Public License          */
-/* along with this program;  if not, write to the Free Software               */
-/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
+/* along with this program;  if not, write to the Free Software Foundation,   */
+/* Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           */
 /*                                                                            */
 /******************************************************************************/
 
@@ -28,7 +28,7 @@
 #include <stdio.h>
 #include <unistd.h>
 
-int main(int argc, char *argv[])
+int main(void)
 {
 	char in[41], out[20];
 	unsigned int v;
@@ -42,6 +42,9 @@ int main(int argc, char *argv[])
 		sscanf(&in[2 * i], "%02x", &v);
 		out[i] = v;
 	}
-	write(STDOUT_FILENO, out, 20);
+	ret = write(STDOUT_FILENO, out, 20);
+	if (ret != 20)
+		return 1;
+
 	return 0;
 }
-- 
1.9.3




------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
