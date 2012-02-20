Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RzSGA-0004TN-2u
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 12:22:26 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RzSG6-0002Wd-3N
	for ltp-list@lists.sourceforge.net; Mon, 20 Feb 2012 12:22:26 +0000
Received: by daln34 with SMTP id n34so5770041dal.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Feb 2012 04:22:16 -0800 (PST)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Mon, 20 Feb 2012 20:21:30 +0800
Message-Id: <1329740490-22340-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1329735301-17676-1-git-send-email-caspar@casparzhang.com>
References: <1329735301-17676-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 3/2] mm: fix possible node missing in write_cpusets
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


If a system has noncontinuous nodes, or the node doesn't start from 0,
write_cpusets() function may fail because it hard-coded second node as
"node1". This patch fixes the function by fetching second node number
from the stored array.

Tested-by: Caspar Zhang <caspar@casparzhang.com>
Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/include/mem.h |    4 ++--
 testcases/kernel/mem/ksm/ksm02.c   |    6 ++----
 testcases/kernel/mem/ksm/ksm04.c   |    6 ++----
 testcases/kernel/mem/lib/mem.c     |   21 +++++++++++++--------
 4 files changed, 19 insertions(+), 18 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0001-mm-fix-possible-node-missing-in-write_cpusets.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-mm-fix-possible-node-missing-in-write_cpusets.patch"

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 4319a90..b40c0bc 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -52,8 +52,8 @@ void check_ksm_options(int *size, int *num, int *unit);
 void ksm_usage(void);
 
 /* For mm/oom* and mm/ksm* tests*/
-void _gather_cpus(char *cpus);
-void write_cpusets(void);
+void _gather_cpus(char *cpus, long nd);
+void write_cpusets(long nd);
 void umount_mem(char *path, char *path_new);
 void mount_mem(char *name, char *fs, char *options, char *path, char *path_new);
 
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 4cd1fab..7bed72b 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -85,7 +85,6 @@ int main(int argc, char *argv[])
 	int lc;
 	char *msg;
 	int size = 128, num = 3, unit = 1;
-	unsigned long nnodes;
 	unsigned long nmask = 2;
 	long nodes[MAXNODES];
 
@@ -93,8 +92,7 @@ int main(int argc, char *argv[])
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	nnodes = count_numa(nodes);
-	if (nnodes <= 1)
+	if (count_numa(nodes) <= 1)
 		tst_brkm(TCONF, NULL, "required a NUMA system.");
 
 	setup();
@@ -114,7 +112,7 @@ int main(int argc, char *argv[])
 		}
 		create_same_memory(size, num, unit);
 
-		write_cpusets();
+		write_cpusets(nodes[1]);
 		create_same_memory(size, num, unit);
 	}
 	cleanup();
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index de76db7..2f97712 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -85,7 +85,6 @@ int main(int argc, char *argv[])
 	int lc;
 	char *msg;
 	int size = 128, num = 3, unit = 1;
-	unsigned long nnodes;
 	unsigned long nmask = 2;
 	long nodes[MAXNODES];
 
@@ -93,8 +92,7 @@ int main(int argc, char *argv[])
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	nnodes = count_numa(nodes);
-	if (nnodes <= 1)
+	if (count_numa(nodes) <= 1)
 		tst_brkm(TCONF, NULL, "required a NUMA system.");
 
 	setup();
@@ -116,7 +114,7 @@ int main(int argc, char *argv[])
 		}
 		create_same_memory(size, num, unit);
 
-		write_cpusets();
+		write_cpusets(nodes[1]);
 		create_same_memory(size, num, unit);
 	}
 	cleanup();
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 9a1d5f2..104fef7 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -101,8 +101,14 @@ void oom(int testcase, int mempolicy, int lite)
 
 void testoom(int mempolicy, int lite, int numa)
 {
-	if (numa && !mempolicy)
-		write_cpusets();
+	long nodes[MAXNODES];
+
+	if (numa && !mempolicy) {
+		if (count_numa(nodes) <= 1)
+			tst_brkm(TCONF, cleanup, "required a NUMA system.");
+		/* write cpusets to 2nd node */
+		write_cpusets(nodes[1]);
+	}
 
 	tst_resm(TINFO, "start normal OOM testing.");
 	oom(NORMAL, mempolicy, lite);
@@ -586,7 +592,7 @@ void ksm_usage(void)
 
 /* For mm/oom* and mm/ksm* tests */
 
-void _gather_cpus(char *cpus)
+void _gather_cpus(char *cpus, long nd)
 {
 	int ncpus = 0;
 	int i;
@@ -596,8 +602,7 @@ void _gather_cpus(char *cpus)
 		ncpus++;
 
 	for (i = 0; i < ncpus; i++)
-		/* FIXME: possible non-existed node1 */
-		if (path_exist(PATH_SYS_SYSTEM "/node/node1/cpu%d", i)) {
+		if (path_exist(PATH_SYS_SYSTEM "/node/node%ld/cpu%d", nd, i)) {
 			sprintf(buf, "%d,", i);
 			strcat(cpus, buf);
 		}
@@ -605,14 +610,14 @@ void _gather_cpus(char *cpus)
 	cpus[strlen(cpus) - 1] = '\0';
 }
 
-void write_cpusets(void)
+void write_cpusets(long nd)
 {
 	char cpus[BUFSIZ] = "";
 	char buf[BUFSIZ] = "";
 	int fd;
 
-	_gather_cpus(cpus);
-	tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
+	_gather_cpus(cpus, nd);
+	tst_resm(TINFO, "CPU list for node%ld is: %s.", nd, cpus);
 
 	/*
 	 * try either '/dev/cpuset/mems' or '/dev/cpuset/cpuset.mems'

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



