Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1Mo23n-0006YV-OL
	for ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 21:29:07 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mo23k-0001b3-FF
	for ltp-list@lists.sourceforge.net; Wed, 16 Sep 2009 21:29:07 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8GLP1sJ031232
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 15:25:01 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8GLSwfv213132
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 15:28:58 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8GLSvFL019844
	for <ltp-list@lists.sourceforge.net>; Wed, 16 Sep 2009 15:28:57 -0600
Date: Wed, 16 Sep 2009 16:28:56 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20090916212856.GB19295@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [LTP PATCH] Create testcase for p9auth kernel module
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
To: Ashwin Ganti <ashwin.ganti@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

The p9auth module is a driver in the staging/ directory, which
implements kernel functionality supporting plan 9-style setuid.
Programs can be completely unprivileged, authorize themselves
to a privileged server, and obtain a token which they can use to
authorize a single setuid to a single specified new uid.

This testcase runs three tests:
	1. make sure we can't setuid without a hash
		(this is actually short-cut in the kernel code
		so it might be worthwhile having a separate
		test for having a hash, but an invalid one)
	2. make sure we can setuid when there is a valid hash
	3. make sure we cannot setuid if there is a valid hash,
		but our original uid isn't the one specified
		in the token.

Run the testcase using

	./runltp -f p9auth

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 runtest/p9auth                                  |    2 +
 testcases/kernel/security/Makefile              |    2 +-
 testcases/kernel/security/p9auth/Makefile       |   40 ++++++++
 testcases/kernel/security/p9auth/checkp9auth.sh |   58 ++++++++++++
 testcases/kernel/security/p9auth/p9priv.sh      |  111 +++++++++++++++++++++++
 testcases/kernel/security/p9auth/p9unpriv.sh    |   51 +++++++++++
 testcases/kernel/security/p9auth/unhex.c        |   47 ++++++++++
 7 files changed, 310 insertions(+), 1 deletions(-)
 create mode 100644 runtest/p9auth
 create mode 100644 testcases/kernel/security/p9auth/Makefile
 create mode 100644 testcases/kernel/security/p9auth/checkp9auth.sh
 create mode 100644 testcases/kernel/security/p9auth/p9priv.sh
 create mode 100644 testcases/kernel/security/p9auth/p9unpriv.sh
 create mode 100644 testcases/kernel/security/p9auth/unhex.c

diff --git a/runtest/p9auth b/runtest/p9auth
new file mode 100644
index 0000000..17b1550
--- /dev/null
+++ b/runtest/p9auth
@@ -0,0 +1,2 @@
+#DESCRIPTION:p9auth /dev/caphash module
+p9auth		runp9auth.sh
diff --git a/testcases/kernel/security/Makefile b/testcases/kernel/security/Makefile
index 862691a..3a26b22 100644
--- a/testcases/kernel/security/Makefile
+++ b/testcases/kernel/security/Makefile
@@ -1,4 +1,4 @@
-SUBDIRS = mmc_security filecaps integrity cap_bound
+SUBDIRS = mmc_security filecaps integrity cap_bound p9auth
 
 all:
 	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
diff --git a/testcases/kernel/security/p9auth/Makefile b/testcases/kernel/security/p9auth/Makefile
new file mode 100644
index 0000000..8bf7613
--- /dev/null
+++ b/testcases/kernel/security/p9auth/Makefile
@@ -0,0 +1,40 @@
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
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+################################################################################
+
+HAVE_P9AUTH := $(shell sh checkp9auth.sh yesno)
+
+SCRIPTS = runp9auth.sh checkp9auth.sh p9priv.sh p9unpriv.sh
+
+CFLAGS += -I../../../../include -Wall
+LDLIBS += -L../../../../lib -lltp -lcap
+
+ifeq ($(HAVE_P9AUTH),yes)
+SRCS    = $(wildcard *.c)
+TARGETS+= $(patsubst %.c,%,$(SRCS))
+endif
+
+all: $(TARGETS)
+
+INSTALLTARGETS = $(TARGETS) $(SCRIPTS)
+install: $(INSTALLTARGETS)
+	@set -e; for i in $(INSTALLTARGETS); do ln -f $$i ../../../bin/$$i ; chmod +x ../../../bin/$$i; done
+
+clean:
+	rm -f $(TARGETS) *.o
diff --git a/testcases/kernel/security/p9auth/checkp9auth.sh b/testcases/kernel/security/p9auth/checkp9auth.sh
new file mode 100644
index 0000000..25c5518
--- /dev/null
+++ b/testcases/kernel/security/p9auth/checkp9auth.sh
@@ -0,0 +1,58 @@
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
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+################################################################################
+
+yesno=0
+if [ "$1" = "yesno" ]; then
+	yesno=1
+fi
+
+# TODO check for openssl
+
+majfile=/sys/module/p9auth/parameters/cap_major
+minfile=/sys/module/p9auth/parameters/cap_minor
+if [ ! -f "$majfile" ]; then
+	if [ $yesno -eq 1 ]; then echo
+		"no"
+	else
+		echo "p9auth not detected.  Skipping p9auth tests."
+	fi
+	exit 1
+fi
+
+if [ ! -c "/dev/caphash" ]; then
+	rm -f /dev/caphash
+	maj=`cat $majfile`
+	mknod /dev/caphash c $maj 0
+fi
+
+if [ ! -c "/dev/capuse" ]; then
+	rm -f /dev/capuse
+	min=`cat $minfile`
+	mknod /dev/capuse c $maj 1
+fi
+chmod ugo+w /dev/capuse
+
+if [ $yesno -eq 1 ]; then
+	echo "yes"
+else
+	echo "p9auth ready for testing"
+fi
+exit 0
diff --git a/testcases/kernel/security/p9auth/p9priv.sh b/testcases/kernel/security/p9auth/p9priv.sh
new file mode 100644
index 0000000..0ff4ca7
--- /dev/null
+++ b/testcases/kernel/security/p9auth/p9priv.sh
@@ -0,0 +1,111 @@
+#!/bin/sh -v
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
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+################################################################################
+
+LTPTMP=/tmp/p9auth_ltp
+rm -rf $LTPTMP
+mkdir $LTPTMP
+chmod 755 $LTPTMP
+
+comms="$LTPTMP/childgo $LTPTMP/d/childready $LTPTMP/d/childfail $LTPTMP/d/childpass $LTPTMP/childexit"
+
+RM=`which rm`
+MKDIR=`which mkdir`
+CHOWN=`which chown`
+
+cleanup() {
+	$RM -rf $LTPTMP/d $comms
+	$MKDIR -p $LTPTMP/d
+	$CHOWN -R ltp $LTPTMP/d
+}
+
+if [ `id -u` -ne 0 ]; then
+	echo "Must start p9auth tests as root"
+	exit 1
+fi
+
+ltpuid=`grep ltp /etc/passwd | head -1 | awk -F: '{ print $3 '}`
+ret=$?
+if [ $? -ne 0 ]; then
+	echo "Failed to find ltp userid"
+	exit 1
+fi
+
+# TEST 1: ltp setuids to 0 but no valid hash
+# launch an unprivileged helper
+cleanup
+
+su ltp p9unpriv.sh &
+while [ ! -f $LTPTMP/d/childready ]; do :; done
+touch $LTPTMP/childgo
+while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :; done;
+if [ -f $LTPTMP/d/childpass ]; then
+	echo "FAIL: child could setuid with bad hash"
+	exit 1
+fi
+echo "PASS: child couldn't setuid with bad hash"
+
+# TEST 2: ltp setuids to 0 with valid hash
+
+# create the hash.  randstr doesn't have to be int, but it's ok
+cleanup
+randstr=$RANDOM
+txt="$ltpuid@0"
+echo -n "$txt" > $LTPTMP/txtfile
+openssl sha1 -hmac "$randstr" $LTPTMP/txtfile | awk '{ print $2 '} > $LTPTMP/hex
+unhex < $LTPTMP/hex > /dev/caphash
+# give the child its token
+echo -n "$txt@$randstr" > $LTPTMP/d/txtfile
+chown ltp $LTPTMP/d/txtfile
+
+su ltp p9unpriv.sh &
+while [ ! -f $LTPTMP/d/childready ]; do :; done
+touch $LTPTMP/childgo
+while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :; done;
+if [ -f $LTPTMP/d/childfail ]; then
+	echo "FAIL: child couldn't setuid with good hash"
+	exit 1
+fi
+echo "PASS: child could setuid with good hash"
+
+# TEST 3: 0 setuids to 0 with hash valid for ltp user
+cleanup
+randstr=$RANDOM
+txt="0@0"
+echo -n "$txt" > $LTPTMP/txtfile
+openssl sha1 -hmac "$randstr" $LTPTMP/txtfile | awk '{ print $2 '} > $LTPTMP/hex
+unhex < $LTPTMP/hex > /dev/caphash
+# give the child its token
+echo -n "$txt@$randstr" > $LTPTMP/d/txtfile
+chown ltp $LTPTMP/d/txtfile
+
+su ltp p9unpriv.sh &
+while [ ! -f $LTPTMP/d/childready ]; do :; done
+touch $LTPTMP/childgo
+while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :; done;
+if [ -f $LTPTMP/d/childpass ]; then
+	echo "PASS: child could setuid from wrong source uid"
+	exit 1
+fi
+echo "PASS: child couldn't setuid from wrong source uid"
+
+touch $LTPTMP/childexit
+
+exit 0
diff --git a/testcases/kernel/security/p9auth/p9unpriv.sh b/testcases/kernel/security/p9auth/p9unpriv.sh
new file mode 100644
index 0000000..8a0f162
--- /dev/null
+++ b/testcases/kernel/security/p9auth/p9unpriv.sh
@@ -0,0 +1,51 @@
+#!/bin/sh -v
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
+## along with this program;  if not, write to the Free Software               ##
+## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    ##
+##                                                                            ##
+################################################################################
+
+LTPTMP=/tmp/p9auth_ltp
+
+TOUCH=`which touch`
+ID=`which id`
+echo ltptmp is $LTPTMP
+
+myuid=`id -u`
+if [ "$myuid" -eq 0 ]; then
+	echo "Unprivileged child was started as root!"
+	exit 1
+fi
+
+$TOUCH $LTPTMP/d/childready
+
+while [ 1 ]; do
+	if [ -f $LTPTMP/childexit ]; then
+		exit 0
+	fi
+	if [ -f $LTPTMP/childgo ]; then
+		echo -n `cat $LTPTMP/d/txtfile` > /dev/capuse
+		if [ `$ID -u` -eq 0 ]; then
+			$TOUCH $LTPTMP/d/childpass
+		else
+			$TOUCH $LTPTMP/d/childfail
+		fi
+		exit 0
+	fi
+done
+
+exit 0
diff --git a/testcases/kernel/security/p9auth/unhex.c b/testcases/kernel/security/p9auth/unhex.c
new file mode 100644
index 0000000..7c78b6a
--- /dev/null
+++ b/testcases/kernel/security/p9auth/unhex.c
@@ -0,0 +1,47 @@
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
+/* along with this program;  if not, write to the Free Software               */
+/* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA    */
+/*                                                                            */
+/******************************************************************************/
+
+/*
+ * File: unhex.c
+ * Author: Serge Hallyn
+ * Purpose: Read a 40 char hex value from stdin, output 20 char byte
+ * value on stdout.
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+
+int main(int argc, char *argv[])
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
+		sscanf(&in[2*i], "%02x", &v);
+		out[i] = v;
+	}
+	write(STDOUT_FILENO, out, 20);
+	return 0;
+}
-- 
1.6.1.1


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
