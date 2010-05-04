Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1O9QgD-0004ys-Cv
	for ltp-list@lists.sourceforge.net; Tue, 04 May 2010 22:33:29 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9QgA-000531-1Q
	for ltp-list@lists.sourceforge.net; Tue, 04 May 2010 22:33:28 +0000
Date: Tue, 4 May 2010 17:33:16 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100504223315.GA16615@us.ibm.com>
References: <1272997208.5342.7.camel@subratamodak.linux.ibm.com>
	<20100504192248.GA3696@us.ibm.com>
	<y2l364299f41005041402uce37fd2axc6f1fc7f7df70497@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <y2l364299f41005041402uce37fd2axc6f1fc7f7df70497@mail.gmail.com>
Subject: Re: [LTP] [PATCH] Fix FILECAPS test hanging for more than 12 hours
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Tue, May 4, 2010 at 12:22 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> > Quoting Subrata Modak (subrata@linux.vnet.ibm.com):
> >> Serge, please add a Sign-off.
> >
> > It's there in the patch in your attachment...
> 
> Serge,
>     Please address the items in the previous review and we'll get it committed.
> Thanks,
> -Garrett

Ah, I see.  You only broke the testcase to get my attention so you
could get me to use more appropriate ltp helpers.  Sneaky!  And since
I learned some things in the process, great.  Hopefully I'll get them
right when I submit the next set.

From 2077a47e9cd2f85a8e54695c71396a1a8397d3d6 Mon Sep 17 00:00:00 2001
From: Serge E. Hallyn <serue@us.ibm.com>
Date: Wed, 28 Apr 2010 11:26:58 -0500
Subject: [PATCH 1/1] make filecaps tests succeed

Most of these are belated cleanup after the move to using /opt/ltp.
But come on, replacing 'return' with tst_exit(), are you just trying
to mess with my head?

Changelog: may 4: address Garrett's feedback
  1. single return 0 in print_caps.c
  2. use $TMP if defined for location of caps_fifo
  3. use tst_brkm in place of tst_resm.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
---
 testcases/kernel/security/filecaps/filecapstest.sh |   10 +++-
 testcases/kernel/security/filecaps/print_caps.c    |    5 +-
 .../kernel/security/filecaps/verify_caps_exec.c    |   48 ++++++++------------
 3 files changed, 28 insertions(+), 35 deletions(-)

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
index 5250007..c3f65a9 100644
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
@@ -191,10 +183,8 @@ int fork_drop_and_exec(int keepperms, cap_t expected_caps)
 				c, s, seqno);
 		}
 		p = index(buf, '.')+1;
-		if (p==(char *)1) {
-			tst_resm(TFAIL, "got a bad message from print_caps\n");
-			tst_exit();
-		}
+		if (p==(char *)1)
+			tst_brkm(TFAIL, tst_exit, "got a bad message from print_caps\n");
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
