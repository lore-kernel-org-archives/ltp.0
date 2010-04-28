Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1O7G2z-00084d-Ns
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 22:48:01 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O7G2x-0003PC-HL
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 22:48:01 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3SMc7mD010691
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 16:38:07 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3SMloar150152
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 16:47:50 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3SMloOf030752
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 16:47:50 -0600
Received: from sergelap.hallyn.com ([9.49.206.189])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o3SMlnx6030665
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 16:47:50 -0600
Date: Wed, 28 Apr 2010 17:47:50 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100428224750.GA25829@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH ltp] make filecaps tests succeed
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

Most of these are belated cleanup after the move to using /opt/ltp.
Also undoing an ill-advised replacement of return with tst_exit.  All
filecaps tests now succeed on fedora 10.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 testcases/kernel/security/filecaps/filecapstest.sh |    9 ++++++---
 testcases/kernel/security/filecaps/print_caps.c    |    3 ++-
 .../kernel/security/filecaps/verify_caps_exec.c    |   19 ++++++++++++++-----
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/security/filecaps/filecapstest.sh b/testcases/kernel/security/filecaps/filecapstest.sh
index 43582dc..6864de4 100755
--- a/testcases/kernel/security/filecaps/filecapstest.sh
+++ b/testcases/kernel/security/filecaps/filecapstest.sh
@@ -22,8 +22,11 @@
 echo "Running in:"
 #rm -f print_caps
 #cp $LTPROOT/testcases/bin/print_caps .
-mkfifo caps_fifo
-chmod 777 caps_fifo
+#FIFOFILE="$LTPROOT/testcases/bin/caps_fifo"
+FIFOFILE="/tmp/caps_fifo"
+rm -f $FIFOFILE
+mkfifo $FIFOFILE
+chmod 777 $FIFOFILE
 exit_code=0
 echo "cap_sys_admin tests"
 verify_caps_exec 0
@@ -46,5 +49,5 @@ if [ $tmp -ne 0 ]; then
 	exit_code=$tmp
 fi
 
-unlink caps_fifo
+unlink $FIFOFILE
 exit $exit_code
diff --git a/testcases/kernel/security/filecaps/print_caps.c b/testcases/kernel/security/filecaps/print_caps.c
index f0e9bce..b887738 100644
--- a/testcases/kernel/security/filecaps/print_caps.c
+++ b/testcases/kernel/security/filecaps/print_caps.c
@@ -36,7 +36,7 @@
 #include <sys/capability.h>
 #endif
 
-#define FIFOFILE "caps_fifo"
+#define FIFOFILE "/tmp/caps_fifo"
 
 int main(int argc, char *argv[])
 {
@@ -68,4 +68,5 @@ int main(int argc, char *argv[])
 #else
 	return 0;
 #endif
+	return 0;
 }
diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
index 5250007..7360d4a 100644
--- a/testcases/kernel/security/filecaps/verify_caps_exec.c
+++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
@@ -43,7 +43,7 @@
 #include <sys/prctl.h>
 #include <test.h>
 
-#define TSTPATH "./print_caps"
+#define TSTPATH "print_caps"
 char *TCID = "filecaps";
 int TST_TOTAL=1;
 
@@ -70,7 +70,7 @@ void print_my_caps()
 	cap_free(txt);
 }
 
-int drop_root(int keep_perms)
+void drop_root(int keep_perms)
 {
 	int ret;
 
@@ -84,10 +84,19 @@ int drop_root(int keep_perms)
 	}
 	if (keep_perms) {
 		cap_t cap = cap_from_text("=eip");
-		cap_set_proc(cap);
+		int ret;
+		if (!cap) {
+			tst_resm(TBROK, "cap_from_text failed\n");
+			tst_exit();
+		}
+		ret = cap_set_proc(cap);
+		if (ret < 0) {
+			perror(cap_set_proc);
+			tst_resm(TBROK | TERRNO, "cap_set_proc failed\n");
+			tst_exit();
+		}
 		cap_free(cap);
 	}
-	tst_exit();
 }
 
 int perms_test(void)
@@ -114,7 +123,7 @@ int perms_test(void)
 	return ret;
 }
 
-#define FIFOFILE "caps_fifo"
+#define FIFOFILE "/tmp/caps_fifo"
 void create_fifo(void)
 {
 	int ret;
-- 
1.6.0.6


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
