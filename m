Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UajRP-0003Gf-Al
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 09:16:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UajRL-00026X-4y
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 09:16:39 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4A9GSJa007802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 10 May 2013 05:16:28 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 10 May 2013 17:13:57 +0800
Message-Id: <83efca15b955541cfdd6a0d7a07bd303381e5ed4.1368177082.git.zliu@redhat.com>
Subject: [LTP] [PATCH 1/3] mm/ksm: set the merge_across_nodes knob before
	testing
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

This kernel commit 90bd6fd31c809(ksm: allow trees per NUMA node)
introduced a new KSM sysfs knob /sys/kernel/mm/ksm/merge_across_nodes,
when it is set to zero, only pages from the same node are merged,
which is different with the previous behavior, and ksm test cases
sometimes will fail in NUMA system.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/ksm/ksm01.c | 16 ++++++++++++++++
 testcases/kernel/mem/ksm/ksm02.c | 17 +++++++++++++++++
 testcases/kernel/mem/ksm/ksm03.c | 16 ++++++++++++++++
 testcases/kernel/mem/ksm/ksm04.c | 16 ++++++++++++++++
 4 files changed, 65 insertions(+)

diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 514d702..9c14212 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -73,6 +73,8 @@
 char *TCID = "ksm01";
 int TST_TOTAL = 1;
 
+static int merge_across_nodes;
+
 option_t ksm_options[] = {
 	{"n:", &opt_num, &opt_numstr},
 	{"s:", &opt_size, &opt_sizestr},
@@ -108,11 +110,25 @@ void setup(void)
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
+		/*
+		 * Save the current value of merge_across_nodes knob,
+		 * and make it perform as the default behavior.
+		 */
+		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+				"%d", &merge_across_nodes);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
+	}
+
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	TEST_PAUSE;
 }
 
 void cleanup(void)
 {
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes",
+				 "%d", merge_across_nodes);
+
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 6c96c74..1b4612d 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -73,6 +73,8 @@
 char *TCID = "ksm02";
 int TST_TOTAL = 1;
 
+static int merge_across_nodes;
+
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 option_t ksm_options[] = {
@@ -123,6 +125,11 @@ int main(int argc, char *argv[])
 
 void cleanup(void)
 {
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
+		/* recover the old value */
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes",
+				 "%d", merge_across_nodes);
+
 	umount_mem(CPATH, CPATH_NEW);
 	TEST_CLEANUP;
 }
@@ -136,6 +143,16 @@ void setup(void)
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
+		/*
+		 * Save the current value of merge_across_nodes knob,
+		 * and make it perform as the default behavior.
+		 */
+		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+				"%d", &merge_across_nodes);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
+	}
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 4480399..349496c 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -73,6 +73,8 @@
 char *TCID = "ksm03";
 int TST_TOTAL = 1;
 
+static int merge_across_nodes;
+
 option_t ksm_options[] = {
 	{"n:", &opt_num, &opt_numstr},
 	{"s:", &opt_size, &opt_sizestr},
@@ -109,6 +111,16 @@ void setup(void)
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
+		/*
+		 * Save the current value of merge_across_nodes knob,
+		 * and make it perform as the default behavior.
+		 */
+		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+				"%d", &merge_across_nodes);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
+	}
+
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	TEST_PAUSE;
@@ -116,6 +128,10 @@ void setup(void)
 
 void cleanup(void)
 {
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes",
+				 "%d", merge_across_nodes);
+
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 	TEST_CLEANUP;
 }
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index ed5e0b3..f0582c5 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -73,6 +73,8 @@
 char *TCID = "ksm04";
 int TST_TOTAL = 1;
 
+static int merge_across_nodes;
+
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 option_t ksm_options[] = {
@@ -125,6 +127,10 @@ int main(int argc, char *argv[])
 
 void cleanup(void)
 {
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes",
+				 "%d", merge_across_nodes);
+
 	umount_mem(CPATH, CPATH_NEW);
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 	TEST_CLEANUP;
@@ -139,6 +145,16 @@ void setup(void)
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
+		/*
+		 * Save the current value of merge_across_nodes knob,
+		 * and make it perform as the default behavior.
+		 */
+		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+				"%d", &merge_across_nodes);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
+	}
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
-- 
1.7.11.7


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
