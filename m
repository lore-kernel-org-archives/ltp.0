Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1My9ZB-0006P1-76
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 19:31:21 +0000
Received: from mail-px0-f180.google.com ([209.85.216.180])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My9Z6-0000hn-5b
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 19:31:21 +0000
Received: by mail-px0-f180.google.com with SMTP id 10so53834pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 12:31:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200910130143.53176.vapier@gentoo.org>
References: <364299f40910122222q5117ecf0i854db292154132c7@mail.gmail.com>
	<200910130130.30228.vapier@gentoo.org>
	<364299f40910122240p586a60aarc796112b68c519e2@mail.gmail.com>
	<200910130143.53176.vapier@gentoo.org>
Date: Wed, 14 Oct 2009 12:31:15 -0700
Message-ID: <364299f40910141231x6fb16559obe7470e34209b080@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] convert linktest.pl to linktest.sh
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

This proposed change makes linktest.pl into linktest.sh, to avoid
missing coverage with symlinks and hardlinks due to a lacking perl
dependency on the target host.

This change has been outstanding for some time in our private copy of
LTP and needed to get checked into CVS.

//edit[1]: Incorporate comments made by Mike F.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

diff --exclude '*CVS*' -NaurP ./runtest/fs ../ltp.bk/runtest/fs
--- ./runtest/fs	2009-10-12 22:06:10.000000000 -0700
+++ ../ltp.bk/runtest/fs	2009-10-12 22:09:12.000000000 -0700
@@ -40,7 +40,7 @@
 iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write
-Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$

 fs_inod01 fs_inod $TMP 10 10 10
-linker01 linktest.sh 1000 1000
+linker01 linktest.pl 1000 1000
 openfile01 openfile -f10 -t10
 inode01 inode01
 inode02 inode02
diff --exclude '*CVS*' -NaurP ./runtest/stress.part1
../ltp.bk/runtest/stress.part1
--- ./runtest/stress.part1	2009-10-12 22:06:15.000000000 -0700
+++ ../ltp.bk/runtest/stress.part1	2009-10-12 22:09:12.000000000 -0700
@@ -156,7 +156,7 @@
 iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write
-Da -Dv -n 2 500b:doio.f1.$$ 1000b:doio.f2.$$

 fs_inod01 fs_inod $TMP 10 10 1
-linker01 linktest.sh
+linker01 linktest.pl
 openfile01 openfile -f10 -t10
 inode01 inode01
 inode02 inode02
diff --exclude '*CVS*' -NaurP
./testcases/kernel/fs/linktest/linktest.pl
../ltp.bk/testcases/kernel/fs/linktest/linktest.pl
--- ./testcases/kernel/fs/linktest/linktest.pl	1969-12-31
16:00:00.000000000 -0800
+++ ../ltp.bk/testcases/kernel/fs/linktest/linktest.pl	2009-10-12
22:18:49.000000000 -0700
@@ -0,0 +1,89 @@
+#!/usr/bin/perl
+
+#   Copyright (c) International Business Machines  Corp., 2000
+#
+#   This program is free software;  you can redistribute it and/or modify
+#   it under the terms of the GNU General Public License as published by
+#   the Free Software Foundation; either version 2 of the License, or
+#   (at your option) any later version.
+#
+#   This program is distributed in the hope that it will be useful,
+#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#   the GNU General Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License
+#   along with this program;  if not, write to the Free Software
+#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+
+#
+#  FILE(s)     : linktest.pl README
+#  DESCRIPTION : Regression test for max links per file
+#  USE         : linktest.pl <number of symlinks> <number of hardlinks>
+#  AUTHOR      : Jeff Martin (martinjn@us.ibm.com)
+#  HISTORY     :
+#     (05/07/01)v.99  Needed a quick script to test a hardlink
limitation that was found.
+#     (28/07/08) Veerendra C <vechandr@in.ibm.com>
+#                     Modified to return proper return code on
failure/success.
+#                     Also modified to return errors if unable to
create dir/files
+
+$ret = 0;
+if ( system("mkdir hlink") ) {
+     $ret = -1 ;
+}
+
+if ( system("mkdir slink") ) {
+     $ret = -1 ;
+}
+
+if ( system("touch hlink/hfile") ) {
+     $ret = -1 ;
+}
+
+if ( system("touch slink/sfile") ) {
+     $ret = -1 ;
+}
+
+if ( $ret == -1 ) {
+    printf ("Error %d: Not able to create dir/file's\n " , $ret);
+    exit -1;
+}
+
+$scount=shift @ARGV;
+chdir "slink";
+for($x=0;$x<$scount;$x++) {
+   $result=symlink("sfile","sfile$x");
+   if(!$result) {
+      $serrors++;
+      }
+   }
+chdir "..";
+$hcount=shift @ARGV;
+for($x=0;$x<$hcount;$x++) {
+   $result=link("hlink/hfile","hlink/hfile$x");
+   if(!$result) {
+      $herrors++;
+      }
+   }
+
+if($herrors) {
+    printf ("linker01 : FAIL Hard Link Errors = %d\n", $herrors);
+    $ret = -1
+}
+else {
+    printf ("linker01 : HardLink Test PASS\n" )
+}
+if($serrors) {
+    printf ("linker01 : FAIL Soft Link Errors = %d\n", $serrors);
+    $ret = -1
+}
+else {
+    printf ("linker01 : SoftLink Test PASS\n" );
+}
+
+unlink <hlink/hfile*>;
+unlink <slink/sfile*>;
+rmdir hlink;
+rmdir slink;
+exit $ret;
diff --exclude '*CVS*' -NaurP
./testcases/kernel/fs/linktest/linktest.sh
../ltp.bk/testcases/kernel/fs/linktest/linktest.sh
--- ./testcases/kernel/fs/linktest/linktest.sh	2009-10-14
12:27:10.000000000 -0700
+++ ../ltp.bk/testcases/kernel/fs/linktest/linktest.sh	1969-12-31
16:00:00.000000000 -0800
@@ -1,76 +0,0 @@
-#!/bin/sh
-
-#   Copyright (c) International Business Machines  Corp., 2000
-#
-#   This program is free software;  you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2 of the License, or
-#   (at your option) any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#   the GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program;  if not, write to the Free Software
-#   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
-
-
-#
-#  FILE(s)     : linktest.sh README
-#  DESCRIPTION : Regression test for max links per file
-#  USE         : linktest.sh <number of symlinks> <number of hardlinks>
-#  AUTHOR      : Garrett Cooper (yanegomi@gmail.com)
-#  HISTORY     :
-#	A rewrite of testcases/kernel/fs/linktest.pl
-
-# XXX: Change to a temp dir via mktemp -d.
-cd "${0%/*}"
-
-export TCID=linker01
-export TST_TOTAL=2
-export TST_COUNT=1
-
-if [ $# -ne 2 ]; then
-	tst_res TBROK "" "Usage: $0 {softlink count} {hardlink count}"
-	exit -1
-fi
-
-mkdir hlink slink && touch hlink/hfile slink/sfile
-
-do_link() {
-	pfix=$1
-	ln_opts=$2
-	limit=$3
-	prefix_msg=$4
-
-	lerrors=0
-
-	i=0
-
-	cd ${pfix}link
-	while [ $i -lt $limit ]; do
-		if ! ln ${ln_opts} "$PWD/${pfix}file" ${pfix}file${i}; then
-			: $(( lerrors += 1 ))
-		fi
-		: $(( i+= 1 ))
-	done
-	cd ..
-
-	if [ $lerrors -eq 0 ]; then
-		RTYPE=TPASS
-	else
-		RTYPE=TFAIL
-	fi
-
-	tst_res $RTYPE "" "$prefix_msg Link Errors: $lerrors"
-
-	: $(( TST_COUNT += 1 ))
-
-}
-
-do_link s "-s" ${1} "Symbolic"
-do_link h   "" ${2} "Hard"
-
-rm -Rf hlink slink
diff --exclude '*CVS*' -NaurP ./testcases/kernel/fs/linktest/Makefile
../ltp.bk/testcases/kernel/fs/linktest/Makefile
--- ./testcases/kernel/fs/linktest/Makefile	2009-10-12 22:05:06.000000000 -0700
+++ ../ltp.bk/testcases/kernel/fs/linktest/Makefile	2009-10-12
22:09:13.000000000 -0700
@@ -24,6 +24,6 @@

 include $(top_srcdir)/include/mk/env_pre.mk

-INSTALL_TARGETS			:= linktest.sh
+INSTALL_TARGETS			:= linktest.pl

 include $(top_srcdir)/include/mk/generic_leaf_target.mk

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
