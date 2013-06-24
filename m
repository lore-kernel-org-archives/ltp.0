Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Ur36Q-0007YU-50
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 09:30:26 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ur36A-0007Qr-Ca
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 09:30:26 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r5O9U4jM013375
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Jun 2013 09:30:04 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5O9U3eF029505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Jun 2013 09:30:04 GMT
Received: from abhmt120.oracle.com (abhmt120.oracle.com [141.146.116.72])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r5O9U2Rq029011
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Jun 2013 09:30:03 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 24 Jun 2013 13:29:55 +0400
Message-Id: <1372066195-18166-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] syscalls/swapon: fix for variable page size
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

From: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>

mkswap refuses files of size < 10*(page size).

On systems with 8192 page size swapon02, swapon03 tests fail because
they try to use files of size 41920 (< 81920).

Modified swapon02, swapon03 so they operate on files of size
10*(page size).

In swapon01 test size of swap file is predefined. For unification
modified this test the same way.

Verified on systems with 4096 and 8192 page sizes.

Signed-off-by: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/swapon/swapon01.c |   19 +++++-
 testcases/kernel/syscalls/swapon/swapon02.c |   84 ++++++++++++---------------
 testcases/kernel/syscalls/swapon/swapon03.c |   17 +-----
 3 files changed, 55 insertions(+), 65 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index 11a49f9..05f1579 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -132,6 +132,10 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup()
 {
+	char cmd_buffer[256];
+
+	long bs = sysconf(_SC_PAGESIZE);
+	int count = 10;
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
@@ -154,15 +158,22 @@ void setup()
 			 "Cannot do swapon on a file located on a nfs filesystem");
 	}
 
-	if (!tst_cwd_has_free(65536)) {
+	if (!tst_cwd_has_free(bs*count)) {
 		tst_brkm(TBROK, cleanup,
 			 "Insufficient disk space to create swap file");
 	}
 
 	/*create file */
-	if (system("dd if=/dev/zero of=swapfile01 bs=1024 count=65536 >"
-		   " tmpfile 2>&1") != 0) {
-		tst_brkm(TBROK, cleanup, "Failed to create file for swap");
+	if (snprintf(cmd_buffer, sizeof(cmd_buffer),
+			"dd if=/dev/zero of=swapfile01 bs=%li "
+			"count=%i > /tmp/file 2>&1", bs, count) < 0) {
+		tst_brkm(TBROK, cleanup, 
+			"sprintf() failed to create command string");
+	}
+
+	if (system(cmd_buffer) != 0) {
+		tst_brkm(TBROK, cleanup, "dd command failed to create file via "
+			"command: %s", cmd_buffer);
 	}
 
 	/* make above file a swap file */
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index d44d6c3..c334350 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -102,6 +102,7 @@
 
 static void setup();
 static void cleanup();
+static int create_zeroed_file(const char *zeroedfile);
 static int setup01();
 static int cleanup01();
 static int setup02();
@@ -213,34 +214,43 @@ int main(int ac, char **av)
 }				/*End of main */
 
 /*
+ * create_zeroed_file() - This function creates zeroed file
+ * of minimum size to use as a swap file
+ */
+int create_zeroed_file(const char *zeroedfile)
+{
+	char cmd_buffer[256];
+
+	long bs = sysconf(_SC_PAGESIZE);
+
+	if (snprintf(cmd_buffer, sizeof(cmd_buffer),
+			"dd if=/dev/zero of=%s bs=%li "
+			"count=10 > /tmp/file 2>&1", zeroedfile, bs) < 0) {
+		tst_resm(TWARN, 
+			"sprintf() failed to create command string");
+
+		return -1;
+	}
+
+	if (system(cmd_buffer) != 0) {
+		tst_resm(TWARN, "dd command failed to create file via "
+			"command: %s", cmd_buffer);
+
+		return -1;
+	}
+
+	return 0;
+}
+
+
+/*
  * setup01() - This function creates the file and sets the user as nobody
  */
 int setup01()
 {
-	int pagesize = getpagesize();
-
-	/*create file */
-	if ((strncmp(kmachine, "ia64", 4)) == 0) {
-		if (system
-		    ("dd if=/dev/zero of=swapfile01 bs=1024  count=65536 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
-	} else if (pagesize == 65536) {
-		if (system
-		    ("dd if=/dev/zero of=swapfile01 bs=1048  count=655 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
-	} else {
-		if (system
-		    ("dd if=/dev/zero of=swapfile01 bs=1048  count=40 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
+	/* create zeroed file */
+	if (create_zeroed_file("swapfile01") != 0) {
+		tst_brkm(TBROK, cleanup, "Failed to create file for swap");
 	}
 
 	/* make above file a swap file */
@@ -293,31 +303,11 @@ int setup02()
  */
 int setup03()
 {
-	int pagesize = getpagesize();
 	int res = 0;
 
-	/*create file */
-	if ((strncmp(kmachine, "ia64", 4)) == 0) {
-		if (system
-		    ("dd if=/dev/zero of=alreadyused bs=1024  count=65536 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
-	} else if (pagesize == 65536) {
-		if (system
-		    ("dd if=/dev/zero of=alreadyused bs=1048  count=655 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
-	} else {
-		if (system
-		    ("dd if=/dev/zero of=alreadyused bs=1048  count=40 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
+	/* create zeroed file */
+	if (create_zeroed_file("alreadyused") != 0) {
+		tst_brkm(TBROK, cleanup, "Failed to create file for swap");
 	}
 
 	/* make above file a swap file */
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 3dbc998..75e93e5 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -208,8 +208,9 @@ int setup_swap()
 	pid_t pid;
 	int j, fd;		/*j is loop counter, fd is file descriptor */
 	int status;		/* used for fork */
-	int res = 0, pagesize = getpagesize();
-	int bs, count;
+	int res = 0;
+	int count = 10;
+	long bs = sysconf(_SC_PAGESIZE);
 	char filename[15];	/* array to store new filename */
 	char buf[BUFSIZ + 1];	/* temp buffer for reading /proc/swaps */
 
@@ -254,18 +255,6 @@ int setup_swap()
 		swapfiles = MAX_SWAPFILES;
 	}
 
-	/* args for dd */
-	if ((strncmp(kmachine, "ia64", 4)) == 0) {
-		bs = 1024;
-		count = 1024;
-	} else if (pagesize == 65536) {
-		bs = 1048;
-		count = 655;
-	} else {
-		bs = 1048;
-		count = 40;
-	}
-
 	pid = FORK_OR_VFORK();
 	if (pid == 0) {
 		/*create and turn on remaining swapfiles */
-- 
1.7.1


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
