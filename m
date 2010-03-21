Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1Nt9gA-0006Vc-V9
	for ltp-list@lists.sourceforge.net; Sun, 21 Mar 2010 01:10:10 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nt9g9-0005Vv-SP
	for ltp-list@lists.sourceforge.net; Sun, 21 Mar 2010 01:10:10 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2L14F2A028758
	for <ltp-list@lists.sourceforge.net>; Sat, 20 Mar 2010 19:04:15 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2L1A4FA127472
	for <ltp-list@lists.sourceforge.net>; Sat, 20 Mar 2010 19:10:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2KIA3xR030959
	for <ltp-list@lists.sourceforge.net>; Sat, 20 Mar 2010 12:10:03 -0600
Date: Sat, 20 Mar 2010 20:10:04 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100321011004.GA28202@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH ltp] fix detection of setcap for filecaps test
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
To: LTP list <ltp-list@lists.sourceforge.net>

Remove the run-time checks and just have autoconf check for
libcap and setcap presence.

( applies on top of the patch I sent this morning )

After this, filecaps tests compile, install, and pass on f10 at least.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 m4/ltp-cap.m4                                      |    1 +
 testcases/kernel/security/Makefile                 |    3 +
 .../kernel/security/filecaps/checkforfilecaps.sh   |   40 ------------
 .../kernel/security/filecaps/checkforlibcap.sh     |   66 --------------------
 testcases/kernel/security/filecaps/filecapstest.sh |   16 +-----
 5 files changed, 5 insertions(+), 121 deletions(-)
 delete mode 100755 testcases/kernel/security/filecaps/checkforfilecaps.sh
 delete mode 100755 testcases/kernel/security/filecaps/checkforlibcap.sh

diff --git a/m4/ltp-cap.m4 b/m4/ltp-cap.m4
index 28d998d..caa436f 100644
--- a/m4/ltp-cap.m4
+++ b/m4/ltp-cap.m4
@@ -28,6 +28,7 @@ AH_TEMPLATE(HAVE_LIBCAP,
 AC_CHECK_HEADERS(sys/capability.h,[
 	LTP_CAPABILITY_SUPPORT=yes
 	AC_CHECK_LIB(cap,cap_compare,[AC_DEFINE(HAVE_LIBCAP) CAP_LIBS="-lcap"], [CAP_LIBS=""])
+	AC_CHECK_PROG(HAVE_SETCAP,setcap,setcap,false)
 ])]
 AC_SUBST(CAP_LIBS)
 )
diff --git a/testcases/kernel/security/Makefile b/testcases/kernel/security/Makefile
index a23ce8f..52b8d06 100644
--- a/testcases/kernel/security/Makefile
+++ b/testcases/kernel/security/Makefile
@@ -29,6 +29,9 @@ include	$(top_srcdir)/include/mk/env_pre.mk
 ifeq ($(strip $(CAP_LIBS)),)
 FILTER_OUT_DIRS		:= cap_bound filecaps
 endif
+ifeq ($(HAVE_SETCAP),false)
+FILTER_OUT_DIRS		+= filecaps
+endif
 
 # XXX (garrcoop): avoid compilation failures on RHEL 5.4, as reported by
 # Mitani-san, because of policy versioning issues...
diff --git a/testcases/kernel/security/filecaps/checkforfilecaps.sh b/testcases/kernel/security/filecaps/checkforfilecaps.sh
deleted file mode 100755
index 757d409..0000000
--- a/testcases/kernel/security/filecaps/checkforfilecaps.sh
+++ /dev/null
@@ -1,40 +0,0 @@
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
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
-##                                                                            ##
-################################################################################
-
-if ! check_simple_capset; then
-	echo Posix capabilities not compiled into the kernel.  Please
-	echo modprobe capability or recompile your kernel with
-	echo CONFIG_SECURITY_CAPABILITIES=y.
-	exit 1
-fi
-
-touch testme
-setcap cap_sys_admin=ip testme
-ret=$?
-rm -f testme
-if [ $ret -ne 0 ]; then
-	echo File capabilities not compiled into kernel.  Please
-	echo make sure your kernel is compiled with
-	echo CONFIG_SECURITY_FILE_CAPABILITIES=y.
-	exit 1
-fi
-
-exit 0
diff --git a/testcases/kernel/security/filecaps/checkforlibcap.sh b/testcases/kernel/security/filecaps/checkforlibcap.sh
deleted file mode 100755
index cc7642e..0000000
--- a/testcases/kernel/security/filecaps/checkforlibcap.sh
+++ /dev/null
@@ -1,66 +0,0 @@
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
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
-##                                                                            ##
-################################################################################
-
-if [ "x$CC" = "x" ]; then
-	export CC=gcc
-fi
-yesno=0
-if [ "$1" = "yesno" ]; then
-	yesno=1
-fi
-
-SETCAP=`which setcap`
-if [ -z "${SETCAP}" ]; then
-    ret=1
-else
-    ret=0
-fi
-
-if [ $ret -eq 0 ]; then
-	#also test for -lcap
-	$CC -o check_simple_capset check_simple_capset.c -lcap \
-         2>/dev/null
-
-	ret=$?
-fi
-
-if [ $ret -eq 0 ]; then
-       #also test for xattr
-       $CC -o check_xattr check_xattr.c
-       ret=$?
-       if [ $ret -ne 0 ]; then
-               echo "Please install xattr headers"
-       fi
-fi
-
-if [ $ret -ne 0 ]; then
-	if [ $yesno -eq 1 ]; then
-		echo no
-	else
-		exit 1
-	fi
-else
-	if [ $yesno -eq 1 ]; then
-		echo yes
-	else
-		exit 0
-	fi
-fi
diff --git a/testcases/kernel/security/filecaps/filecapstest.sh b/testcases/kernel/security/filecaps/filecapstest.sh
index 149cbc1..9025b58 100755
--- a/testcases/kernel/security/filecaps/filecapstest.sh
+++ b/testcases/kernel/security/filecaps/filecapstest.sh
@@ -19,22 +19,8 @@
 ##                                                                            ##
 ################################################################################
 
-checkforlibcap.sh
-ret=$?
-if [ $ret -ne 0 ]; then
-	echo "Filecaps 0 CONF : System doesn't support execution of the test"
-	echo setcap not installed.  Please install libcap-2.11 or newer from
-	echo ftp://ftp.kernel.org/pub/linux/libs/security/linux-privs/libcap2
-	exit 0
-fi
-checkforfilecaps.sh
-ret=$?
-if [ $ret -ne 0 ]; then
-	echo "Filecaps 0 CONF : File capabilities not available"
-	exit 0
-fi
-
 echo "Running in:"
+rm -f print_caps
 cp $LTPROOT/testcases/bin/print_caps .
 mkfifo caps_fifo
 chmod 777 caps_fifo
-- 
1.6.0.6


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
