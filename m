Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1OA2L8-000731-CC
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 14:46:14 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OA2L7-0000s4-Bq
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 14:46:14 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o46EclMI001351
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 08:38:47 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o46EjwNE142010
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 08:46:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o46Ejvf2015432
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 08:45:57 -0600
Date: Thu, 6 May 2010 09:45:56 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100506144556.GA11460@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH v2] make filecaps tests succeed
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
Cc: Subrata Modak1 <subrata.modak@in.ibm.com>

(Garrett I was going to add your ack, but wasn't absolutely sure
whether you meant it should apply to the whole thing or not)

Most of these are belated cleanup after the move to using /opt/ltp.
But come on, replacing 'return' with tst_exit(), are you just trying
to mess with my head?

Changelog:
 may 4: address Garrett's feedback
  1. single return 0 in print_caps.c
  2. use $TMP if defined for location of caps_fifo
  3. use tst_brkm in place of tst_resm.
 may 5: address Garrett's comment:
  don't add 1 to null pointer and then check for 1

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 testcases/kernel/security/filecaps/filecapstest.sh |   10 +++-
 testcases/kernel/security/filecaps/print_caps.c    |    5 +-
 .../kernel/security/filecaps/verify_caps_exec.c    |   51 ++++++++------------
 3 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/testcases/kernel/security/filecaps/filecapstest.sh b/testcases/kernel/security/filecaps/filecapstest.sh
index 43582dc..8e2ba11 100755
--- a/testcases/kernel/security/filecaps/filecapstest.sh
+++ b/testcases/kernel/security/filecaps/filecapstest.sh
@@ -22,8 +22,12 @@
 echo "Running in:"
 #rm -f print_caps
 #cp $LTPROOT/testcases/bin/print_caps .
-mkfifo caps_fifo
-chmod 777 caps_fifo
+#FIFOFILE="$LTPROOT/testcases/bin/caps_fifo"
+TMP=${TMP:=/tmp}
+FIFOFILE="$TMP/caps_fifo"
+rm -f $FIFOFILE
+mkfifo $FIFOFILE
+chmod 777 $FIFOFILE
 exit_code=0
 echo "cap_sys_admin tests"
 verify_caps_exec 0
@@ -46,5 +50,5 @@ if [ $tmp -ne 0 ]; then
 	exit_code=$tmp
 fi
 
-unlink caps_fifo
+unlink $FIFOFILE
 exit $exit_code
diff --git a/testcases/kernel/security/filecaps/print_caps.c b/testcases/kernel/security/filecaps/print_caps.c
index f0e9bce..1c3fc1b 100644
--- a/testcases/kernel/security/filecaps/print_caps.c
+++ b/testcases/kernel/security/filecaps/print_caps.c
@@ -36,7 +36,7 @@
 #include <sys/capability.h>
 #endif
 
-#define FIFOFILE "caps_fifo"
+#define FIFOFILE "/tmp/caps_fifo"
 
 int main(int argc, char *argv[])
 {
@@ -65,7 +65,6 @@ int main(int argc, char *argv[])
 	close(fd);
 
 	cap_free(cap);
-#else
-	return 0;
 #endif
+	return 0;
 }
diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
index 5250007..605f0f6 100644
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
 
@@ -78,16 +78,19 @@ int drop_root(int keep_perms)
 		prctl(PR_SET_KEEPCAPS, 1);
 	ret = setresuid(1000, 1000, 1000);
 	if (ret) {
-		perror("setresuid");
-		tst_resm(TFAIL, "Error dropping root privs\n");
+		tst_brkm(TFAIL | TERRNO, tst_exit, "Error dropping root privs\n");
 		tst_exit();
 	}
 	if (keep_perms) {
 		cap_t cap = cap_from_text("=eip");
-		cap_set_proc(cap);
+		int ret;
+		if (!cap)
+			tst_brkm(TBROK | TERRNO, tst_exit, "cap_from_text failed\n");
+		ret = cap_set_proc(cap);
+		if (ret < 0)
+			tst_brkm(TBROK | TERRNO, tst_exit, "cap_set_proc failed\n");
 		cap_free(cap);
 	}
-	tst_exit();
 }
 
 int perms_test(void)
@@ -114,17 +117,14 @@ int perms_test(void)
 	return ret;
 }
 
-#define FIFOFILE "caps_fifo"
+#define FIFOFILE "/tmp/caps_fifo"
 void create_fifo(void)
 {
 	int ret;
 
 	ret = mkfifo(FIFOFILE, S_IRWXU | S_IRWXG | S_IRWXO);
-	if (ret == -1 && errno != EEXIST) {
-		perror("mkfifo");
-		tst_resm(TFAIL, "failed creating %s\n", FIFOFILE);
-		tst_exit();
-	}
+	if (ret == -1 && errno != EEXIST)
+		tst_brkm(TFAIL | TERRNO, tst_exit, "failed creating %s\n", FIFOFILE);
 }
 
 void write_to_fifo(char *buf)
@@ -142,11 +142,8 @@ void read_from_fifo(char *buf)
 
 	memset(buf, 0, 200);
 	fd = open(FIFOFILE, O_RDONLY);
-	if (fd < 0) {
-		perror("open");
-		tst_resm(TFAIL, "Failed opening fifo\n");
-		tst_exit();
-	}
+	if (fd < 0)
+		tst_brkm(TFAIL | TERRNO, tst_exit, "Failed opening fifo\n");
 	read(fd, buf, 199);
 	close(fd);
 }
@@ -162,23 +159,18 @@ int fork_drop_and_exec(int keepperms, cap_t expected_caps)
 	static int seqno = 0;
 
 	pid = fork();
-	if (pid < 0) {
-		perror("fork");
-		tst_resm(TFAIL, "%s: failed fork\n", __FUNCTION__);
-		tst_exit();
-	}
+	if (pid < 0)
+		tst_brkm(TFAIL | TERRNO, tst_exit, "%s: failed fork\n", __FUNCTION__);
 	if (pid == 0) {
 		drop_root(keepperms);
 		print_my_caps();
 		sprintf(buf, "%d", seqno);
 		ret = execlp(TSTPATH, TSTPATH, buf, NULL);
-		perror("execl");
-		tst_resm(TFAIL, "%s: exec failed\n", __FUNCTION__);
 		capstxt = cap_to_text(expected_caps, NULL);
 		snprintf(buf, 200, "failed to run as %s\n", capstxt);
 		cap_free(capstxt);
 		write_to_fifo(buf);
-		tst_exit();
+		tst_brkm(TFAIL, tst_exit, "%s: exec failed\n", __FUNCTION__);
 	} else {
 		p = buf;
 		while (1) {
@@ -190,11 +182,10 @@ int fork_drop_and_exec(int keepperms, cap_t expected_caps)
 			tst_resm(TINFO, "got a bad seqno (c=%d, s=%d, seqno=%d)",
 				c, s, seqno);
 		}
-		p = index(buf, '.')+1;
-		if (p==(char *)1) {
-			tst_resm(TFAIL, "got a bad message from print_caps\n");
-			tst_exit();
-		}
+		p = index(buf, '.');
+		if (!p)
+			tst_brkm(TFAIL, tst_exit, "got a bad message from print_caps\n");
+		p += 1;
 		actual_caps = cap_from_text(p);
 		if (cap_compare(actual_caps, expected_caps) != 0) {
 			capstxt = cap_to_text(expected_caps, NULL);
-- 
1.6.0.6


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
