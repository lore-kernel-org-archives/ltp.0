Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1ZSNLH-00030i-NE
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2015 10:45:07 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZSNLF-0005fa-Q1
	for ltp-list@lists.sourceforge.net; Thu, 20 Aug 2015 10:45:07 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 0BC48A2C10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Aug 2015 10:45:00 +0000 (UTC)
Received: from dhcp-13-206.nay.redhat.com (dhcp12-104.nay.redhat.com
	[10.66.12.104] (may be forged))
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t7KAiuea028669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Aug 2015 06:44:59 -0400
From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Aug 2015 18:44:55 +0800
Message-Id: <1440067495-10326-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH] ltp/pounder: do some cleanup work for pounder21 test
	suites
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

ChangeLog:
	- Cleanup ltp buildscript in pounder
	- Remove two outdated patches from pounder21/src/

Signed-off-by: Li Wang <liwang@redhat.com>
---
 tools/pounder21/build_scripts/ltp          |  41 ----------
 tools/pounder21/src/ltp-debian-build.patch | 120 -----------------------------
 tools/pounder21/src/ltp-setregid-fix.patch |  14 ----
 3 files changed, 175 deletions(-)
 delete mode 100644 tools/pounder21/src/ltp-debian-build.patch
 delete mode 100644 tools/pounder21/src/ltp-setregid-fix.patch

diff --git a/tools/pounder21/build_scripts/ltp b/tools/pounder21/build_scripts/ltp
index dfebe28..314719c 100755
--- a/tools/pounder21/build_scripts/ltp
+++ b/tools/pounder21/build_scripts/ltp
@@ -25,47 +25,6 @@ source "$POUNDER_HOME/libpounder.sh"
 # Go up two levels to the top ltp dir.
 cd "$POUNDER_HOME/../../"
 
-# Apply a patch if this is Debian/Ubuntu.
-if [ -f /etc/debian_version ]; then
-	# Have we already patched this?
-	if [ ! -e "testcases/network/sctp/func_tests/test_1_to_1_connect.c.pounder" ]; then
-		cp -pRdu testcases/network/sctp/func_tests/test_1_to_1_connect.c testcases/network/sctp/func_tests/test_1_to_1_connect.c.pounder
-		echo "Debian/Ubuntu detected; applying build fixes..."
-		patch -p1 < $POUNDER_SRCDIR/ltp-debian-build.patch
-		RESULT=$?
-		if [ $RESULT -ne 0 ]; then
-			echo Patching failed.
-			exit 1
-		fi
-	fi
-else
-	# We need to _unpatch_ this.
-	if [ -e "testcases/network/sctp/func_tests/test_1_to_1_connect.c.pounder" ]; then
-		rm -rf testcases/network/sctp/func_tests/test_1_to_1_connect.c.pounder
-		echo "Previous Debian/Ubuntu detected; removing build fixes..."
-		patch -p1 -R < $POUNDER_SRCDIR/ltp-debian-build.patch
-		RESULT=$?
-		if [ $RESULT -ne 0 ]; then
-			echo Patching failed.
-			exit 1
-		fi
-	fi
-
-fi
-
-# NAK the setregid EPERM -> EINVAL patch, because it's
-# broken on 2.6!  May be fixed some time after 20050804 release.
-#if [ ! -e "testcases/kernel/syscalls/setregid/setregid02.c.pounder" ]; then
-#	echo "Patching some holes in ltp..."
-#	cp -pRdu testcases/kernel/syscalls/setregid/setregid02.c testcases/kernel/syscalls/setregid/setregid02.c.pounder
-#	patch -p1 < $POUNDER_SRCDIR/ltp-setregid-fix.patch
-#	RESULT=$?
-#	if [ $RESULT -ne 0 ]; then
-#		echo Patching failed.
-#		exit 1
-#	fi
-#fi
-
 # Build
 ./configure
 make -j$NR_CPUS
diff --git a/tools/pounder21/src/ltp-debian-build.patch b/tools/pounder21/src/ltp-debian-build.patch
deleted file mode 100644
index 9447e7b..0000000
--- a/tools/pounder21/src/ltp-debian-build.patch
+++ /dev/null
@@ -1,120 +0,0 @@
-diff -Naur ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_connect.c ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_connect.c
---- ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_connect.c	2005-08-04 13:33:05.000000000 -0700
-+++ ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_connect.c	2005-08-15 22:45:58.000000000 -0700
-@@ -51,7 +51,7 @@
- #include <string.h>
- #include <sys/types.h>
- #include <sys/socket.h>
--#include <linux/socket.h>
-+
- #include <netinet/in.h>         /* for sockaddr_in */
- #include <arpa/inet.h>
- #include <sys/errno.h>
-diff -Naur ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_nonblock.c ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_nonblock.c
---- ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_nonblock.c	2005-08-04 13:33:05.000000000 -0700
-+++ ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_nonblock.c	2005-08-15 22:45:58.000000000 -0700
-@@ -53,7 +53,7 @@
- #include <errno.h>
- #include <netinet/sctp.h>
- #include <sys/uio.h>
--#include <linux/socket.h>
-+
- #include <sctputil.h>
-
- char *TCID = __FILE__;
-diff -Naur ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_recvfrom.c ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_recvfrom.c
---- ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_recvfrom.c	2005-08-04 13:33:05.000000000 -0700
-+++ ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_recvfrom.c	2005-08-15 22:45:58.000000000 -0700
-@@ -53,7 +53,7 @@
- #include <errno.h>
- #include <netinet/sctp.h>
- #include <sys/uio.h>
--#include <linux/socket.h>
-+
- #include <sctputil.h>
-
- char *TCID = __FILE__;
-diff -Naur ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_recvmsg.c ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_recvmsg.c
---- ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_recvmsg.c	2005-08-04 13:33:05.000000000 -0700
-+++ ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_recvmsg.c	2005-08-15 22:45:58.000000000 -0700
-@@ -54,7 +54,7 @@
- #include <errno.h>
- #include <netinet/sctp.h>
- #include <sys/uio.h>
--#include <linux/socket.h>
-+
- #include <sctputil.h>
-
- #define MSG_EOF 0x200
-diff -Naur ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_rtoinfo.c ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_rtoinfo.c
---- ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_rtoinfo.c	2005-08-04 13:33:05.000000000 -0700
-+++ ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_rtoinfo.c	2005-08-15 22:45:58.000000000 -0700
-@@ -45,7 +45,7 @@
- #include <string.h>
- #include <sys/types.h>
- #include <sys/socket.h>
--#include <linux/socket.h>
-+
- #include <linux/in.h>         /* for sockaddr_in */
- #include <linux/in6.h>         /* for sockaddr_in6 */
- #include <sys/errno.h>
-diff -Naur ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_send.c ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_send.c
---- ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_send.c	2005-08-04 13:33:05.000000000 -0700
-+++ ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_send.c	2005-08-15 22:45:58.000000000 -0700
-@@ -54,7 +54,7 @@
- #include <errno.h>
- #include <netinet/sctp.h>
- #include <sys/uio.h>
--#include <linux/socket.h>
-+
- #include <sctputil.h>
-
- char *TCID = __FILE__;
-diff -Naur ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_sendmsg.c ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_sendmsg.c
---- ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_sendmsg.c	2005-08-04 13:33:05.000000000 -0700
-+++ ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_sendmsg.c	2005-08-15 22:45:58.000000000 -0700
-@@ -61,7 +61,7 @@
- #include <errno.h>
- #include <netinet/sctp.h>
- #include <sys/uio.h>
--#include <linux/socket.h>
-+
- #include <sctputil.h>
-
- #define MSG_EOF 0x200
-diff -Naur ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_sendto.c ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_sendto.c
---- ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_sendto.c	2005-08-04 13:33:05.000000000 -0700
-+++ ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_sendto.c	2005-08-15 22:45:58.000000000 -0700
-@@ -50,7 +50,7 @@
- #include <errno.h>
- #include <netinet/sctp.h>
- #include <sys/uio.h>
--#include <linux/socket.h>
-+
- #include <sctputil.h>
-
- char *TCID = __FILE__;
-diff -Naur ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_shutdown.c ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_shutdown.c
---- ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_shutdown.c	2005-08-04 13:33:05.000000000 -0700
-+++ ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_shutdown.c	2005-08-15 22:45:58.000000000 -0700
-@@ -45,7 +45,7 @@
- #include <sys/socket.h>
- #include <netinet/in.h>
- #include <arpa/inet.h>
--#include <linux/socket.h>
-+
- #include <netinet/sctp.h>
- #include <sys/types.h>
- #include <unistd.h>
-diff -Naur ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_threads.c ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_threads.c
---- ltp-full-20050804/testcases/network/sctp/func_tests/test_1_to_1_threads.c	2005-08-04 13:33:05.000000000 -0700
-+++ ltp-full-20050804-new/testcases/network/sctp/func_tests/test_1_to_1_threads.c	2005-08-15 22:45:58.000000000 -0700
-@@ -47,7 +47,7 @@
- #include <errno.h>
- #include <netinet/sctp.h>
- #include <sys/uio.h>
--#include <linux/socket.h>
-+
- #include <sctputil.h>
-
- #define THREADS 10    /* FIXME should be 500 instead of 10 */
diff --git a/tools/pounder21/src/ltp-setregid-fix.patch b/tools/pounder21/src/ltp-setregid-fix.patch
deleted file mode 100644
index f26ee53..0000000
--- a/tools/pounder21/src/ltp-setregid-fix.patch
+++ /dev/null
@@ -1,14 +0,0 @@
-diff -Naur ltp-full-20050804/testcases/kernel/syscalls/setregid/setregid02.c ltp-full-20050804-new/testcases/kernel/syscalls/setregid/setregid02.c
---- ltp-full-20050804/testcases/kernel/syscalls/setregid/setregid02.c	2005-08-04 13:33:06.000000000 -0700
-+++ ltp-full-20050804-new/testcases/kernel/syscalls/setregid/setregid02.c	2005-08-17 11:33:35.000000000 -0700
-@@ -106,8 +106,8 @@
- 	{ &bin_gr_gid, &neg_one, EPERM, &users, &users, "After setregid(bin, -1)," },
- 	{ &root_gr_gid, &bin_gr_gid, EPERM, &users, &users, "After setregid(root, bin)" },
- 	{ &bin_gr_gid, &root_gr_gid, EPERM, &users, &users, "After setregid(bin, root)," },
--	{ &inval_user, &neg_one, EINVAL, &users, &users, "After setregid(invalid group, -1)," },
--	{ &neg_one, &inval_user, EINVAL, &users, &users, "After setregid(-1, invalid group)," },
-+	{ &inval_user, &neg_one, EPERM, &users, &users, "After setregid(invalid group, -1)," },
-+	{ &neg_one, &inval_user, EPERM, &users, &users, "After setregid(-1, invalid group)," },
- };
-
- int TST_TOTAL = sizeof(test_data)/sizeof(test_data[0]);
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
