Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UGAwL-0003sh-KY
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:23:37 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UGAwJ-0006Yz-OU
	for ltp-list@lists.sourceforge.net; Thu, 14 Mar 2013 16:23:37 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2EGNT21005295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Mar 2013 12:23:29 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 15 Mar 2013 00:21:35 +0800
Message-Id: <054d2c7ca1e3c6e4794c0f42f927b555a4273da7.1363246555.git.zliu@redhat.com>
In-Reply-To: <cover.1363246555.git.zliu@redhat.com>
References: <cover.1363246555.git.zliu@redhat.com>
In-Reply-To: <cover.1363246555.git.zliu@redhat.com>
References: <cover.1363246555.git.zliu@redhat.com>
Subject: [LTP] [PATCH 1/5] lib/mem: modified _gather_cpus() as
	_gather_node_cpus()
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
To: LTP List <ltp-list@lists.sourceforge.net>

The previous _gather_cpus() tried to collect all the specified
node's cpus, but it didn't pay attention to the offline cpus,
if one cpu in the specified node were offline, it can't write
the cpu number to cgroups/*.cpus, and return -EINVAL.

The patch fixed it, and modified the function name, as the new
name make more sense.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index a827b25..29de64a 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -481,20 +481,42 @@ void ksm_usage(void)
 
 /* cpuset/memcg */
 
-static void _gather_cpus(char *cpus, long nd)
+static void _gather_node_cpus(char *cpus, long nd)
 {
 	int ncpus = 0;
-	int i;
+	int fd, i;
+	long online;
 	char buf[BUFSIZ];
+	char path[BUFSIZ], path1[BUFSIZ];
 
 	while (path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
 		ncpus++;
 
-	for (i = 0; i < ncpus; i++)
-		if (path_exist(PATH_SYS_SYSTEM "/node/node%ld/cpu%d", nd, i)) {
+	for (i = 0; i < ncpus; i++) {
+		snprintf(path, BUFSIZ,
+			 PATH_SYS_SYSTEM "/node/node%ld/cpu%d", nd, i);
+		if (path_exist(path, nd, i)) {
+			snprintf(path1, BUFSIZ, "%s/online", path);
+			/*
+			 * No cpu0/online knob, as it can't support to
+			 * on/offline cpu0, so if the 'nd' node contains
+			 * cpu0, it should skip to check cpu0/online's value.
+			 */
+			if (i == 0)
+				goto  next;
+			fd = open(path1, O_RDONLY);
+			if (fd == -1)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					 "open %s", path1);
+			read_file(path1, buf);
+			online = SAFE_STRTOL(cleanup, buf, 0, 1);
+			if (online == 0)
+				continue;
+next:
 			sprintf(buf, "%d,", i);
 			strcat(cpus, buf);
 		}
+	}
 	/* Remove the trailing comma. */
 	cpus[strlen(cpus) - 1] = '\0';
 }
@@ -563,7 +585,7 @@ void write_cpusets(long nd)
 	snprintf(buf, BUFSIZ, "%ld", nd);
 	write_cpuset_files(CPATH_NEW, "mems", buf);
 
-	_gather_cpus(cpus, nd);
+	_gather_node_cpus(cpus, nd);
 	write_cpuset_files(CPATH_NEW, "cpus", cpus);
 
 	snprintf(buf, BUFSIZ, "%d", getpid());
-- 
1.7.11.7


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
