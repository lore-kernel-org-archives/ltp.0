Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UboOX-0002uN-U5
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 08:46:10 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UboOW-0005j5-HV
	for ltp-list@lists.sourceforge.net; Mon, 13 May 2013 08:46:09 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4D8k2jc014201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 13 May 2013 04:46:02 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Mon, 13 May 2013 16:43:26 +0800
Message-Id: <45b6ebc4e0b5f2848c107c26ba144822bed090a1.1368434507.git.zliu@redhat.com>
Subject: [LTP] [PATCH v2 1/3] mm/ksm: enable merge_across_nodes knob before
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
Changed log:
V1 to V2:
  updated some comments.

 testcases/kernel/mem/ksm/ksm01.c | 19 +++++++++++++++++++
 testcases/kernel/mem/ksm/ksm02.c | 12 ++++++++++++
 testcases/kernel/mem/ksm/ksm03.c | 12 ++++++++++++
 testcases/kernel/mem/ksm/ksm04.c | 12 ++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 514d702..47a7753 100644
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
@@ -108,11 +110,28 @@ void setup(void)
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
+	/*
+	 * kernel commit 90bd6fd introduced a new KSM sysfs knob
+	 * /sys/kernel/mm/ksm/merge_across_nodes, setting it to '0'
+	 * will prevent KSM pages being merged across numa nodes,
+	 * which will cause the case fail, so we need to make sure
+	 * it is enabled before testing.
+	 */
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
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
index 6c96c74..e22a7a6 100644
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
@@ -123,6 +125,10 @@ int main(int argc, char *argv[])
 
 void cleanup(void)
 {
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0)
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes",
+				 "%d", merge_across_nodes);
+
 	umount_mem(CPATH, CPATH_NEW);
 	TEST_CLEANUP;
 }
@@ -136,6 +142,12 @@ void setup(void)
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
+		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+				"%d", &merge_across_nodes);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
+	}
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 4480399..a254b75 100644
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
@@ -109,6 +111,12 @@ void setup(void)
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
+		SAFE_FILE_SCANF(NULL, PATH_KSM "merge_across_nodes",
+				"%d", &merge_across_nodes);
+		SAFE_FILE_PRINTF(NULL, PATH_KSM "merge_across_nodes", "1");
+	}
+
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	TEST_PAUSE;
@@ -116,6 +124,10 @@ void setup(void)
 
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
index ed5e0b3..6b3c71b 100644
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
@@ -139,6 +145,12 @@ void setup(void)
 	if (access(PATH_KSM, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "KSM configuration is not enabled");
 
+	if (access(PATH_KSM "merge_across_nodes", F_OK) == 0) {
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
