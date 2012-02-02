Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1Rsnmo-0004im-K1
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 03:56:38 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rsnmn-0003aE-Pf
	for ltp-list@lists.sourceforge.net; Thu, 02 Feb 2012 03:56:38 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q123uV9K015101
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Wed, 1 Feb 2012 19:56:31 -0800 (PST)
From: Jin Li <jin.li@windriver.com>
Date: Thu, 2 Feb 2012 11:56:24 +0800
Message-ID: <1328154984-1484-2-git-send-email-jin.li@windriver.com>
In-Reply-To: <1328154984-1484-1-git-send-email-jin.li@windriver.com>
References: <1328154984-1484-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Fix for msgctl test case msgctl11 on the target with
	more than 4G memory
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
To: ltp-list@lists.sourceforge.net
Cc: jin.li@windriver.com

The test msgctl11 will fail with log as follows once it is on the
target with more than 4G memory and use default maximum pid value 32768.
Because in this case, the maxnkids is always 0 which will cause fail
and exit.

maxnkids = ((free_pids / 4) / MSGMNI);

Test msgctl11 fail log

"msgctl11    1  TBROK  :  Not enough free pids"

This fix will update the maximum pid value to meet the need of
free pids on the target with more than 4G memory.

For example, on the target with 16G memory

nprocs = MSGMNI = 32768

and every message queue need read and write child process.

So need MSGMNI * 2 pids.

when nkids = maxnkids = 1,

the max pids will be updated to MSGMNI * 2 * 2 and give enought pids to

the test.

Signed-off-by: Jin Li <jin.li@windriver.com>
---
 include/system_specific_process_info.h          |    3 ++
 lib/system_specific_process_info.c              |   22 ++++++++++++++
 testcases/kernel/syscalls/ipc/msgctl/msgctl11.c |   36 +++++++++++++++++++----
 3 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/include/system_specific_process_info.h b/include/system_specific_process_info.h
index 956d90f..dddcac0 100644
--- a/include/system_specific_process_info.h
+++ b/include/system_specific_process_info.h
@@ -26,4 +26,7 @@ int get_max_pids(void);
 /* Returns number of free pids */
 int get_free_pids(void);
 
+/* Set max pid count to /proc/sys/kernel/pid_max */
+int set_max_pids(int);
+
 #endif
diff --git a/lib/system_specific_process_info.c b/lib/system_specific_process_info.c
index d3c9638..d631340 100644
--- a/lib/system_specific_process_info.c
+++ b/lib/system_specific_process_info.c
@@ -59,6 +59,28 @@ int get_max_pids(void)
 }
 
 
+int set_max_pids(int pids_max)
+{
+	FILE *f;
+
+	f = fopen("/proc/sys/kernel/pid_max", "w+");
+	if (!f) {
+		tst_resm(TBROK, "Could not open /proc/sys/kernel/pid_max");
+		return -1;
+	}
+	if (!fprintf(f, "%d", pids_max)) {
+		fclose(f);
+		tst_resm(TBROK, "Could not write to /proc/sys/kernel/pid_max");
+		return -1;
+	}
+	if (fclose(f)) {
+		tst_resm(TBROK, "Fail to close file /proc/sys/kernel/pid_max");
+		return -1;
+	}
+	return 0;
+}
+
+
 int get_free_pids(void)
 {
 	FILE *f;
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
index 57bd184..cfa0096 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl11.c
@@ -79,6 +79,9 @@ int TST_TOTAL = 1;		/* Total number of test cases. */
 
 int exp_enos[] = { 0 };		/* List must end with 0 */
 int maxnkids = MAXNKIDS;	/* Used if pid_max is exceeded */
+int max_pids;
+int adjust_max_pids;
+
 
 key_t keyarray[MAXNPROCS];
 
@@ -641,14 +644,29 @@ void setup()
 		tst_exit();
 	}
 
+	max_pids = get_max_pids();
+	adjust_max_pids = 0;
 	if ((MSGMNI * MAXNKIDS * 2) > (free_pids / 2)) {
-		maxnkids = ((free_pids / 4) / MSGMNI);
-		if (!maxnkids) {
-			tst_resm(TBROK, "Not enough free pids");
-			tst_exit();
+		if (nr_msgqs < 8192) {
+			maxnkids = ((free_pids / 4) / MSGMNI);
+			if (!maxnkids) {
+				tst_resm(TBROK, "Not enough free pids");
+				tst_exit();
+			}
+		} else  {
+			maxnkids = 1;
+
+			/* After the update of maximum pid number, the free
+			 * pids will be MSGMNI * 2 * 2
+			 */
+			adjust_max_pids = MSGMNI * 2 * 2 + max_pids - free_pids;
+			if ((set_max_pids(adjust_max_pids)) < 0) {
+				tst_resm(TBROK, "cannot adjust max pids");
+				tst_exit();
+			}
+			free_pids = get_free_pids();
 		}
 	}
-
 	tst_resm(TINFO, "Using upto %d pids", free_pids / 2);
 }
 
@@ -682,4 +700,10 @@ void cleanup()
 	fflush(stdout);
 	tst_rmdir();
 
-}
\ No newline at end of file
+	if (adjust_max_pids > max_pids) {
+		if (set_max_pids(max_pids) < 0) {
+			tst_resm(TBROK, "cannot restore the max pids");
+			tst_exit();
+		}
+	}
+}
-- 
1.6.3.1


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
