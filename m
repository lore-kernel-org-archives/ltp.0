Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UGWCE-0003SK-Qw
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 15:05:26 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UGWCD-0007rU-S0
	for ltp-list@lists.sourceforge.net; Fri, 15 Mar 2013 15:05:26 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2FF5KnG016462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 15 Mar 2013 11:05:20 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Fri, 15 Mar 2013 23:03:12 +0800
Message-Id: <4dea33e9f2b651280003556eb8a523ee05810e6f.1363358877.git.zliu@redhat.com>
In-Reply-To: <6db9a42549e171e950e784135a5d01a53f0b4b4f.1363358877.git.zliu@redhat.com>
References: <cover.1363358877.git.zliu@redhat.com>
	<610d014b3e51b301d3f2adca6e8b068e62aba626.1363358877.git.zliu@redhat.com>
	<fd2789e70f79cb525ca7317061adab90f6387530.1363358877.git.zliu@redhat.com>
	<5de33faa5b15f22e96d68d1b543eb4bcfc64cfb7.1363358877.git.zliu@redhat.com>
	<a5ee11cc800fc73683472eeb2ba71cea7472035c.1363358877.git.zliu@redhat.com>
	<a5d23391d87bdbaa500d500c4677d5a7762f9d1c.1363358877.git.zliu@redhat.com>
	<6db9a42549e171e950e784135a5d01a53f0b4b4f.1363358877.git.zliu@redhat.com>
In-Reply-To: <cover.1363358877.git.zliu@redhat.com>
References: <cover.1363358877.git.zliu@redhat.com>
Subject: [LTP] [PATCH v2 7/7] lib/mem: removed the prefix underscore '_' of
	the internal function name
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

as chrubis' suggestion, the prefix that start with
_ or __ are reserved for compiler/libc implementation,
inside this patch, I removed all the prefix '_' of
the internal function name.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 56 +++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index e47765e..42ef435 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -27,7 +27,7 @@
 
 /* OOM */
 
-static int _alloc_mem(long int length, int testcase)
+static int alloc_mem(long int length, int testcase)
 {
 	void *s;
 
@@ -51,13 +51,13 @@ static int _alloc_mem(long int length, int testcase)
 	return 0;
 }
 
-static void _test_alloc(int testcase, int lite)
+static void test_alloc(int testcase, int lite)
 {
 	if (lite)
-		_alloc_mem(TESTMEM + MB, testcase);
+		alloc_mem(TESTMEM + MB, testcase);
 	else
 		while (1)
-			if (_alloc_mem(LENGTH, testcase))
+			if (alloc_mem(LENGTH, testcase))
 				return;
 }
 
@@ -70,7 +70,7 @@ void oom(int testcase, int lite)
 	case -1:
 		tst_brkm(TBROK | TERRNO, cleanup, "fork");
 	case 0:
-		_test_alloc(testcase, lite);
+		test_alloc(testcase, lite);
 		exit(0);
 	default:
 		break;
@@ -147,7 +147,7 @@ void testoom(int mempolicy, int lite)
 
 /* KSM */
 
-static void _check(char *path, long int value)
+static void check(char *path, long int value)
 {
 	FILE *fp;
 	char buf[BUFSIZ], fullpath[BUFSIZ];
@@ -162,7 +162,7 @@ static void _check(char *path, long int value)
 		tst_resm(TFAIL, "%s is not %ld.", path, value);
 }
 
-static void _wait_ksmd_done(void)
+static void wait_ksmd_done(void)
 {
 	char buf[BUFSIZ];
 	long pages_shared, pages_sharing, pages_volatile, pages_unshared;
@@ -203,24 +203,24 @@ static void _wait_ksmd_done(void)
 		 count * 10);
 }
 
-static void _group_check(int run, int pages_shared, int pages_sharing,
+static void group_check(int run, int pages_shared, int pages_sharing,
 			 int pages_volatile, int pages_unshared,
 			 int sleep_millisecs, int pages_to_scan)
 {
 	/* wait for ksm daemon to scan all mergeable pages. */
-	_wait_ksmd_done();
+	wait_ksmd_done();
 
 	tst_resm(TINFO, "check!");
-	_check("run", run);
-	_check("pages_shared", pages_shared);
-	_check("pages_sharing", pages_sharing);
-	_check("pages_volatile", pages_volatile);
-	_check("pages_unshared", pages_unshared);
-	_check("sleep_millisecs", sleep_millisecs);
-	_check("pages_to_scan", pages_to_scan);
+	check("run", run);
+	check("pages_shared", pages_shared);
+	check("pages_sharing", pages_sharing);
+	check("pages_volatile", pages_volatile);
+	check("pages_unshared", pages_unshared);
+	check("sleep_millisecs", sleep_millisecs);
+	check("pages_to_scan", pages_to_scan);
 }
 
-static void _verify(char **memory, char value, int proc,
+static void verify(char **memory, char value, int proc,
 		    int start, int end, int start2, int end2)
 {
 	int i, j;
@@ -329,12 +329,12 @@ static void create_ksm_child(int child_num, int size, int unit,
 			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
 
 		if (ksm_merge_data[j].mergeable_size < size * MB) {
-			_verify(memory, 'e', child_num, total_unit - 1,
+			verify(memory, 'e', child_num, total_unit - 1,
 				total_unit, unit * MB - 1, unit * MB);
-			_verify(memory, ksm_merge_data[j].data, child_num,
+			verify(memory, ksm_merge_data[j].data, child_num,
 				0, total_unit, 0, unit * MB - 1);
 		} else {
-			_verify(memory, ksm_merge_data[j].data, child_num,
+			verify(memory, ksm_merge_data[j].data, child_num,
 				0, total_unit, 0, unit * MB);
 		}
 	}
@@ -435,19 +435,19 @@ void create_same_memory(int size, int num, int unit)
 	write_file(PATH_KSM "sleep_millisecs", "0");
 
 	resume_ksm_children(child, num);
-	_group_check(1, 2, size * num * pages - 2, 0, 0, 0, size * pages * num);
+	group_check(1, 2, size * num * pages - 2, 0, 0, 0, size * pages * num);
 
 	stop_ksm_children(child, num);
 	resume_ksm_children(child, num);
-	_group_check(1, 3, size * num * pages - 3, 0, 0, 0, size * pages * num);
+	group_check(1, 3, size * num * pages - 3, 0, 0, 0, size * pages * num);
 
 	stop_ksm_children(child, num);
 	resume_ksm_children(child, num);
-	_group_check(1, 1, size * num * pages - 1, 0, 0, 0, size * pages * num);
+	group_check(1, 1, size * num * pages - 1, 0, 0, 0, size * pages * num);
 
 	stop_ksm_children(child, num);
 	resume_ksm_children(child, num);
-	_group_check(1, 1, size * num * pages - 2, 0, 1, 0, size * pages * num);
+	group_check(1, 1, size * num * pages - 2, 0, 1, 0, size * pages * num);
 
 	stop_ksm_children(child, num);
 
@@ -455,11 +455,11 @@ void create_same_memory(int size, int num, int unit)
 	write_file(PATH_KSM "run", "2");
 
 	resume_ksm_children(child, num);
-	_group_check(2, 0, 0, 0, 0, 0, size * pages * num);
+	group_check(2, 0, 0, 0, 0, 0, size * pages * num);
 
 	tst_resm(TINFO, "stop KSM.");
 	write_file(PATH_KSM "run", "0");
-	_group_check(0, 0, 0, 0, 0, 0, size * pages * num);
+	group_check(0, 0, 0, 0, 0, 0, size * pages * num);
 
 	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0)
 		if (WEXITSTATUS(status) != 0)
@@ -501,7 +501,7 @@ void ksm_usage(void)
 
 /* cpuset/memcg */
 
-static void _gather_node_cpus(char *cpus, long nd)
+static void gather_node_cpus(char *cpus, long nd)
 {
 	int ncpus = 0;
 	int i;
@@ -600,7 +600,7 @@ void write_cpusets(long nd)
 	snprintf(buf, BUFSIZ, "%ld", nd);
 	write_cpuset_files(CPATH_NEW, "mems", buf);
 
-	_gather_node_cpus(cpus, nd);
+	gather_node_cpus(cpus, nd);
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
