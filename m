Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1Tr0XG-0002Yd-Jy
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 06:13:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tr0XF-00013a-IB
	for ltp-list@lists.sourceforge.net; Fri, 04 Jan 2013 06:13:42 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r046DZbd016615
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 4 Jan 2013 01:13:35 -0500
From: Zhouping Liu <zliu@redhat.com>
Date: Fri,  4 Jan 2013 14:12:10 +0800
Message-Id: <ef3e82060d793bdd820b38b6ea669a70ef6bb494.1357277005.git.zliu@redhat.com>
In-Reply-To: <2a7ebedf19609652dd8a5da772b4575927d6891d.1357277005.git.zliu@redhat.com>
References: <cover.1357277005.git.zliu@redhat.com>
	<2a7ebedf19609652dd8a5da772b4575927d6891d.1357277005.git.zliu@redhat.com>
In-Reply-To: <cover.1357277005.git.zliu@redhat.com>
References: <cover.1357277005.git.zliu@redhat.com>
Subject: [LTP] [PATCH v3 2/2] mm/include: removed the global var 'memory'
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

we don't use the global var 'memory' any more,
so removed it, and changed local var 'memory_new'
as 'memory'.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/include/_private.h |  2 +-
 testcases/kernel/mem/include/mem.h      |  5 -----
 testcases/kernel/mem/lib/mem.c          | 34 ++++++++++++++++-----------------
 3 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/mem/include/_private.h b/testcases/kernel/mem/include/_private.h
index 43eda0e..d34d417 100644
--- a/testcases/kernel/mem/include/_private.h
+++ b/testcases/kernel/mem/include/_private.h
@@ -11,7 +11,7 @@ static void _check(char *path, long int value);
 static void _group_check(int run, int pages_shared, int pages_sharing,
 		int pages_volatile, int pages_unshared,
 		int sleep_millisecs, int pages_to_scan);
-static void _verify(char **memory_new, char value, int proc, int start, int end,
+static void _verify(char **memory, char value, int proc, int start, int end,
 		int start2, int end2);
 
 /* cpuset/memcg */
diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index 16a65db..1233493 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -36,11 +36,6 @@ void testoom(int mempolicy, int lite, int numa);
 
 #define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
 
-/*
- * memory pointer to identify per process, MB unit, and byte like
- * memory[process No.][MB unit No.][byte No.].
- */
-char ***memory;
 void write_memcg(void);
 void create_same_memory(int size, int num, int unit);
 int  opt_num, opt_size, opt_unit;
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 87d47a8..a827b25 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -200,7 +200,7 @@ static void _group_check(int run, int pages_shared, int pages_sharing,
 	_check("pages_to_scan", pages_to_scan);
 }
 
-static void _verify(char **memory_new, char value, int proc,
+static void _verify(char **memory, char value, int proc,
 		    int start, int end, int start2, int end2)
 {
 	int i, j;
@@ -212,14 +212,14 @@ static void _verify(char **memory_new, char value, int proc,
 
 	tst_resm(TINFO, "child %d verifies memory content.", proc);
 	memset(s, value, (end - start) * (end2 - start2));
-	if (memcmp(memory_new[start], s, (end - start) * (end2 - start2))
+	if (memcmp(memory[start], s, (end - start) * (end2 - start2))
 	    != 0)
 		for (j = start; j < end; j++)
 			for (i = start2; i < end2; i++)
-				if (memory_new[j][i] != value)
+				if (memory[j][i] != value)
 					tst_resm(TFAIL, "child %d has %c at "
 						 "%d,%d,%d.",
-						 proc, memory_new[j][i], proc,
+						 proc, memory[j][i], proc,
 						 j, i);
 	free(s);
 }
@@ -241,7 +241,7 @@ static struct ksm_merge_data {
 };
 
 static void ksm_child_memset(int child_num, int size, int total_unit,
-		 struct ksm_merge_data ksm_merge_data, char **memory_new)
+		 struct ksm_merge_data ksm_merge_data, char **memory)
 {
 	int i, j;
 	int unit = size / total_unit;
@@ -260,34 +260,34 @@ static void ksm_child_memset(int child_num, int size, int total_unit,
 
 	for (j = 0; j < total_unit; j++) {
 		for (i = 0; i < unit * MB; i++)
-			memory_new[j][i] = ksm_merge_data.data;
+			memory[j][i] = ksm_merge_data.data;
 	}
 
 	/* if it contains unshared page, then set 'e' char
 	 * at the end of the last page
 	 */
 	if (ksm_merge_data.mergeable_size < size * MB)
-		memory_new[j-1][i-1] = 'e';
+		memory[j-1][i-1] = 'e';
 }
 
 static void create_ksm_child(int child_num, int size, int unit,
 		       struct ksm_merge_data *ksm_merge_data)
 {
 	int j, total_unit;
-	char **memory_new;
+	char **memory;
 
 	/* The total units in all */
 	total_unit = size / unit;
 
-	/* Apply for the space for memory_new */
-	memory_new = (char **)malloc(total_unit * sizeof(char *));
+	/* Apply for the space for memory */
+	memory = (char **)malloc(total_unit * sizeof(char *));
 	for (j = 0; j < total_unit; j++) {
-		memory_new[j] = mmap(NULL, unit * MB, PROT_READ|PROT_WRITE,
+		memory[j] = mmap(NULL, unit * MB, PROT_READ|PROT_WRITE,
 			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-		if (memory_new[j] == MAP_FAILED)
+		if (memory[j] == MAP_FAILED)
 			tst_brkm(TBROK|TERRNO, tst_exit, "mmap");
 #ifdef HAVE_MADV_MERGEABLE
-		if (madvise(memory_new[j], unit * MB, MADV_MERGEABLE) == -1)
+		if (madvise(memory[j], unit * MB, MADV_MERGEABLE) == -1)
 			tst_brkm(TBROK|TERRNO, tst_exit, "madvise");
 #endif
 	}
@@ -300,7 +300,7 @@ static void create_ksm_child(int child_num, int size, int unit,
 	for (j = 0; j < 4; j++) {
 
 		ksm_child_memset(child_num, size, total_unit,
-				  ksm_merge_data[j], memory_new);
+				  ksm_merge_data[j], memory);
 
 		fflush(stdout);
 
@@ -309,12 +309,12 @@ static void create_ksm_child(int child_num, int size, int unit,
 			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
 
 		if (ksm_merge_data[j].mergeable_size < size * MB) {
-			_verify(memory_new, 'e', child_num, total_unit - 1,
+			_verify(memory, 'e', child_num, total_unit - 1,
 				total_unit, unit * MB - 1, unit * MB);
-			_verify(memory_new, ksm_merge_data[j].data, child_num,
+			_verify(memory, ksm_merge_data[j].data, child_num,
 				0, total_unit, 0, unit * MB - 1);
 		} else {
-			_verify(memory_new, ksm_merge_data[j].data, child_num,
+			_verify(memory, ksm_merge_data[j].data, child_num,
 				0, total_unit, 0, unit * MB);
 		}
 	}
-- 
1.7.11.7


------------------------------------------------------------------------------
Master HTML5, CSS3, ASP.NET, MVC, AJAX, Knockout.js, Web API and
much more. Get web development skills now with LearnDevNow -
350+ hours of step-by-step video tutorials by Microsoft MVPs and experts.
SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122812
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
