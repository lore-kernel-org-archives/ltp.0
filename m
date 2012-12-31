Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1TpVMs-0006I6-VC
	for ltp-list@lists.sourceforge.net; Mon, 31 Dec 2012 02:44:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TpVMr-00083J-5q
	for ltp-list@lists.sourceforge.net; Mon, 31 Dec 2012 02:44:46 +0000
From: Zhouping Liu <zliu@redhat.com>
Date: Mon, 31 Dec 2012 10:48:12 +0800
Message-Id: <24ea25c3c6664fadf44f2497fd72db939791b731.1356921636.git.zliu@redhat.com>
Subject: [LTP] [PATCH 1/2] lib/mm: rewrote create_same_memory function
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

create_same_memory() was too large and had lots of duplicated codes,
and it's a little hard-coding, so that it's not easy to read and
extend it.

I splited it for five sub-functions:

  _ksm_child_memset();
  _create_ksm_child();
  _stop_ksm_children();
  _resume_ksm_children();
  create_smae_memory();

Also I intruduced a data struct to control the mergeable data:

  struct _ksm_merge_data {
        char data;
        int mergeable_size;
  };

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/include/_private.h |   2 +-
 testcases/kernel/mem/lib/mem.c          | 425 +++++++++++++-------------------
 2 files changed, 170 insertions(+), 257 deletions(-)

diff --git a/testcases/kernel/mem/include/_private.h b/testcases/kernel/mem/include/_private.h
index 71164f5..43eda0e 100644
--- a/testcases/kernel/mem/include/_private.h
+++ b/testcases/kernel/mem/include/_private.h
@@ -11,7 +11,7 @@ static void _check(char *path, long int value);
 static void _group_check(int run, int pages_shared, int pages_sharing,
 		int pages_volatile, int pages_unshared,
 		int sleep_millisecs, int pages_to_scan);
-static void _verify(char value, int proc, int start, int end,
+static void _verify(char **memory_new, char value, int proc, int start, int end,
 		int start2, int end2);
 
 /* cpuset/memcg */
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index f095fe1..05abcc7 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -200,8 +200,8 @@ static void _group_check(int run, int pages_shared, int pages_sharing,
 	_check("pages_to_scan", pages_to_scan);
 }
 
-static void _verify(char value, int proc, int start, int end,
-		    int start2, int end2)
+static void _verify(char **memory_new, char value, int proc,
+		    int start, int end, int start2, int end2)
 {
 	int i, j;
 	void *s = NULL;
@@ -212,14 +212,14 @@ static void _verify(char value, int proc, int start, int end,
 
 	tst_resm(TINFO, "child %d verifies memory content.", proc);
 	memset(s, value, (end - start) * (end2 - start2));
-	if (memcmp(memory[proc][start], s, (end - start) * (end2 - start2))
+	if (memcmp(memory_new[start], s, (end - start) * (end2 - start2))
 	    != 0)
 		for (j = start; j < end; j++)
 			for (i = start2; i < end2; i++)
-				if (memory[proc][j][i] != value)
+				if (memory_new[j][i] != value)
 					tst_resm(TFAIL, "child %d has %c at "
 						 "%d,%d,%d.",
-						 proc, memory[proc][j][i], proc,
+						 proc, memory_new[j][i], proc,
 						 j, i);
 	free(s);
 }
@@ -235,299 +235,212 @@ void write_memcg(void)
 	write_file(MEMCG_PATH_NEW "/tasks", buf);
 }
 
-void create_same_memory(int size, int num, int unit)
+struct _ksm_merge_data {
+	char data;
+	int mergeable_size;
+};
+
+void _ksm_child_memset(int child_num, int size, int total_unit,
+		 struct _ksm_merge_data ksm_merge_data, char **memory_new)
 {
-	char buf[BUFSIZ];
-	int i, j, k;
-	int status;
-	int *child;
-	long ps, pages;
+	int i, j;
+	int unit = size / total_unit;
 
-	ps = sysconf(_SC_PAGE_SIZE);
-	pages = 1024 * 1024 / ps;
+	tst_resm(TINFO, "child %d continues...", child_num);
 
-	child = malloc(num);
-	if (child == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
+	if (ksm_merge_data.mergeable_size == size * MB) {
+		tst_resm(TINFO, "child %d allocates %d MB filled with '%c'",
+			child_num, size, ksm_merge_data.data);
 
-	memory = malloc(num * sizeof(**memory));
-	if (memory == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
+	} else {
+		tst_resm(TINFO, "child %d allocates %d MB filled with '%c'"
+				" except one page with 'e'",
+				child_num, size, ksm_merge_data.data);
+	}
 
-	/* Don't call cleanup in those children. Instead, do a cleanup from the
-	   parent after fetched children's status. */
-	switch (child[0] = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-	case 0:
-		tst_resm(TINFO, "child 0 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-
-		tst_resm(TINFO, "child 0 continues...");
-		tst_resm(TINFO, "child 0 allocates %d MB filled with 'c'.",
-			 size);
-		memory[0] = malloc(size / unit * sizeof(*memory));
-		if (memory[0] == NULL)
-			tst_brkm(TBROK | TERRNO, tst_exit, "malloc");
-		for (j = 0; j * unit < size; j++) {
-			memory[0][j] = mmap(NULL, unit * MB,
-					    PROT_READ | PROT_WRITE,
-					    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-			if (memory[0][j] == MAP_FAILED)
-				tst_brkm(TBROK | TERRNO, tst_exit, "mmap");
+	for (j = 0; j < total_unit; j++) {
+		for (i = 0; i < unit * MB; i++)
+			memory_new[j][i] = ksm_merge_data.data;
+	}
+
+	/* if it contains unshared page, then set 'e' char
+	 * at the end of the last page
+	 */
+	if (ksm_merge_data.mergeable_size < size * MB)
+		memory_new[j-1][i-1] = 'e';
+}
 
+void _create_ksm_child(int child_num, int size, int unit,
+		       struct _ksm_merge_data *ksm_merge_data)
+{
+	int j, total_unit;
+	char **memory_new;
+
+	/* The total units in all */
+	total_unit = size / unit;
+
+	/* Apply for the space for memory_new */
+	memory_new = (char **)malloc(total_unit * sizeof(char *));
+	for (j = 0; j < total_unit; j++) {
+		memory_new[j] = mmap(NULL, unit * MB, PROT_READ|PROT_WRITE,
+			MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+		if (memory_new[j] == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, tst_exit, "mmap");
 #ifdef HAVE_MADV_MERGEABLE
-			if (madvise(memory[0][j], unit * MB, MADV_MERGEABLE)
-			    == -1)
-				tst_brkm(TBROK | TERRNO, tst_exit, "madvise");
+		if (madvise(memory_new[j], unit * MB, MADV_MERGEABLE) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "madvise");
 #endif
-			for (i = 0; i < unit * MB; i++)
-				memory[0][j][i] = 'c';
-		}
-		tst_resm(TINFO, "child 0 stops.");
+	}
+
+	tst_resm(TINFO, "child %d stops.", child_num);
+	if (raise(SIGSTOP) == -1)
+		tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+	fflush(stdout);
+
+	for (j = 0; j < 4; j++) {
+
+		_ksm_child_memset(child_num, size, total_unit,
+				  ksm_merge_data[j], memory_new);
+
+		fflush(stdout);
+
+		tst_resm(TINFO, "child %d stops.", child_num);
 		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-
-		tst_resm(TINFO, "child 0 continues...");
-		_verify('c', 0, 0, size / unit, 0, unit * MB);
-		tst_resm(TINFO, "child 0 changes memory content to 'd'.");
-		for (j = 0; j < size / unit; j++) {
-			for (i = 0; i < unit * MB; i++)
-				memory[0][j][i] = 'd';
+			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+
+		if (ksm_merge_data[j].mergeable_size < size * MB) {
+			_verify(memory_new, 'e', child_num, total_unit - 1,
+				total_unit, unit * MB - 1, unit * MB);
+			_verify(memory_new, ksm_merge_data[j].data, child_num,
+				0, total_unit, 0, unit * MB - 1);
+		} else {
+			_verify(memory_new, ksm_merge_data[j].data, child_num,
+				0, total_unit, 0, unit * MB);
 		}
-		/* Unmerge. */
-		tst_resm(TINFO, "child 0 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK | TERRNO, tst_exit, "kill");
+	}
 
-		tst_resm(TINFO, "child 0 continues...");
-		_verify('d', 0, 0, size / unit, 0, unit * MB);
-		/* Stop. */
-		tst_resm(TINFO, "child 0 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-		tst_resm(TINFO, "child 0 continues...");
-		exit(0);
+	tst_resm(TINFO, "child %d finished.", child_num);
+}
+
+void _stop_ksm_children(int *child, int num)
+{
+	int k, status;
+
+	tst_resm(TINFO, "wait for all children to stop.");
+	for (k = 0; k < num; k++) {
+		if (waitpid(child[k], &status, WUNTRACED) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFSTOPPED(status))
+			tst_brkm(TBROK, cleanup, "child %d was not stopped", k);
 	}
-	switch (child[1] = fork()) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-	case 0:
-		tst_resm(TINFO, "child 1 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-		tst_resm(TINFO, "child 1 continues...");
-		tst_resm(TINFO, "child 1 allocates %d MB filled with 'a'.",
-			 size);
-		memory[1] = malloc(size / unit * sizeof(*memory));
-		if (memory[1] == NULL)
-			tst_brkm(TBROK | TERRNO, tst_exit, "malloc");
-		for (j = 0; j < size / unit; j++) {
-			memory[1][j] = mmap(NULL, unit * MB,
-					    PROT_READ | PROT_WRITE,
-					    MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-			if (memory[1][j] == MAP_FAILED)
-				tst_brkm(TBROK | TERRNO, tst_exit, "mmap");
-#ifdef HAVE_MADV_MERGEABLE
-			if (madvise(memory[1][j], unit * MB, MADV_MERGEABLE)
-			    == -1)
-				tst_brkm(TBROK | TERRNO, tst_exit, "madvise");
-#endif
-			for (i = 0; i < unit * MB; i++)
-				memory[1][j][i] = 'a';
-		}
-		tst_resm(TINFO, "child 1 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-		tst_resm(TINFO, "child 1 continues...");
-		_verify('a', 1, 0, size / unit, 0, unit * MB);
-		tst_resm(TINFO, "child 1 changes memory content to 'b'.");
-		for (j = 0; j < size / unit; j++) {
-			for (i = 0; i < unit * MB; i++)
-				memory[1][j][i] = 'b';
-		}
-		tst_resm(TINFO, "child 1 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-		tst_resm(TINFO, "child 1 continues...");
-		_verify('b', 1, 0, size / unit, 0, unit * MB);
-		tst_resm(TINFO, "child 1 changes memory content to 'd'");
-		for (j = 0; j < size / unit; j++) {
-			for (i = 0; i < unit * MB; i++)
-				memory[1][j][i] = 'd';
-		}
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK | TERRNO, tst_exit, "kill");
+}
 
-		tst_resm(TINFO, "child 1 continues...");
-		_verify('d', 1, 0, size / unit, 0, unit * MB);
-		tst_resm(TINFO, "child 1 changes one page to 'e'.");
-		memory[1][size / unit - 1][unit * MB - 1] = 'e';
+void _resume_ksm_children(int *child, int num)
+{
+	int k, status;
 
-		/* Unmerge. */
-		tst_resm(TINFO, "child 1 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-		tst_resm(TINFO, "child 1 continues...");
-		_verify('e', 1, size / unit - 1, size / unit,
-			unit * MB - 1, unit * MB);
-		_verify('d', 1, 0, size / unit - 1, 0, unit * MB - 1);
-
-		/* Stop. */
-		tst_resm(TINFO, "child 1 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-		tst_resm(TINFO, "child 1 continues...");
-		exit(0);
+	tst_resm(TINFO, "resume all children.");
+	for (k = 0; k < num; k++) {
+		if (kill(child[k], SIGCONT) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "kill child[%d]", k);
 	}
-	for (k = 2; k < num; k++) {
-		switch (child[k] = fork()) {
+	fflush(stdout);
+}
+
+void create_same_memory(int size, int num, int unit)
+{
+	char buf[BUFSIZ];
+	int i, j, status, *child;
+	unsigned long ps, pages;
+	struct _ksm_merge_data **ksm_data;
+
+	struct _ksm_merge_data ksm_data0[] = {
+	       {'c', size*MB}, {'c', size*MB}, {'d', size*MB}, {'d', size*MB},
+	};
+	struct _ksm_merge_data ksm_data1[] = {
+	       {'a', size*MB}, {'b', size*MB}, {'d', size*MB}, {'d', size*MB-1},
+	};
+	struct _ksm_merge_data ksm_data2[] = {
+	       {'a', size*MB}, {'a', size*MB}, {'d', size*MB}, {'d', size*MB},
+	};
+
+	ps = sysconf(_SC_PAGE_SIZE);
+	pages = MB / ps;
+
+	ksm_data = (struct _ksm_merge_data **)malloc
+		   ((num - 3) * sizeof(struct _ksm_merge_data *));
+	/* Since from third child, the data is same with the first child's */
+	for (i = 0; i < num - 3; i++) {
+		ksm_data[i] = (struct _ksm_merge_data *)malloc
+			      (4 * sizeof(struct _ksm_merge_data));
+		for (j = 0; j < 4; j++) {
+			ksm_data[i][j].data = ksm_data0[j].data;
+			ksm_data[i][j].mergeable_size =
+				ksm_data0[j].mergeable_size;
+		}
+	}
+
+	child = (int *)malloc(num * sizeof(int));
+	if (child == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup, "malloc");
+
+	for (i = 0; i < num; i++) {
+		fflush(stdout);
+		switch (child[i] = fork()) {
 		case -1:
-			tst_brkm(TBROK | TERRNO, cleanup, "fork");
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
 		case 0:
-			tst_resm(TINFO, "child %d stops.", k);
-			if (raise(SIGSTOP) == -1)
-				tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-			tst_resm(TINFO, "child %d continues...", k);
-			tst_resm(TINFO, "child %d allocates %d "
-				 "MB filled with 'a'.", k, size);
-			memory[k] = malloc(size / unit * sizeof(*memory));
-			if (memory[k] == NULL)
-				tst_brkm(TBROK | TERRNO, tst_exit, "malloc");
-			for (j = 0; j < size / unit; j++) {
-				memory[k][j] = mmap(NULL, unit * MB,
-						    PROT_READ | PROT_WRITE,
-						    MAP_ANONYMOUS
-						    | MAP_PRIVATE, -1, 0);
-				if (memory[k][j] == MAP_FAILED)
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "mmap");
-#ifdef HAVE_MADV_MERGEABLE
-				if (madvise(memory[k][j], unit * MB,
-					    MADV_MERGEABLE) == -1)
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "madvise");
-#endif
-				for (i = 0; i < unit * MB; i++)
-					memory[k][j][i] = 'a';
+			if (i == 0) {
+				_create_ksm_child(i, size, unit, ksm_data0);
+				exit(0);
+			} else if (i == 1) {
+				_create_ksm_child(i, size, unit, ksm_data1);
+				exit(0);
+			} else if (i == 2) {
+				_create_ksm_child(i, size, unit, ksm_data2);
+				exit(0);
+			} else {
+				_create_ksm_child(i, size, unit, ksm_data[i-3]);
+				exit(0);
 			}
-			tst_resm(TINFO, "child %d stops.", k);
-			if (raise(SIGSTOP) == -1)
-				tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-			tst_resm(TINFO, "child %d continues...", k);
-			tst_resm(TINFO, "child %d changes memory content to "
-				 "'d'", k);
-			for (j = 0; j < size / unit; j++) {
-				for (i = 0; i < unit * MB; i++)
-					memory[k][j][i] = 'd';
-			}
-			/* Unmerge. */
-			tst_resm(TINFO, "child %d stops.", k);
-			if (raise(SIGSTOP) == -1)
-				tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-			tst_resm(TINFO, "child %d continues...", k);
-
-			/* Stop. */
-			tst_resm(TINFO, "child %d stops.", k);
-			if (raise(SIGSTOP) == -1)
-				tst_brkm(TBROK | TERRNO, tst_exit, "kill");
-			tst_resm(TINFO, "child %d continues...", k);
-			exit(0);
 		}
 	}
+
+	_stop_ksm_children(child, num);
+
 	tst_resm(TINFO, "KSM merging...");
 	write_file(PATH_KSM "run", "1");
 	snprintf(buf, BUFSIZ, "%ld", size * pages * num);
 	write_file(PATH_KSM "pages_to_scan", buf);
 	write_file(PATH_KSM "sleep_millisecs", "0");
 
-	tst_resm(TINFO, "wait for all children to stop.");
-	for (k = 0; k < num; k++) {
-		if (waitpid(child[k], &status, WUNTRACED) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
-		if (!WIFSTOPPED(status))
-			tst_brkm(TBROK, cleanup, "child %d was not stopped.",
-				 k);
-	}
-	tst_resm(TINFO, "resume all children.");
-	for (k = 0; k < num; k++) {
-		if (kill(child[k], SIGCONT) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "kill child[%d]", k);
-	}
+	_resume_ksm_children(child, num);
 	_group_check(1, 2, size * num * pages - 2, 0, 0, 0, size * pages * num);
 
-	tst_resm(TINFO, "wait for child 1 to stop.");
-	if (waitpid(child[1], &status, WUNTRACED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
-	if (!WIFSTOPPED(status))
-		tst_brkm(TBROK, cleanup, "child 1 was not stopped.");
-
-	/* Child 1 changes all pages to 'b'. */
-	tst_resm(TINFO, "resume child 1.");
-	if (kill(child[1], SIGCONT) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "kill");
+	_stop_ksm_children(child, num);
+	_resume_ksm_children(child, num);
 	_group_check(1, 3, size * num * pages - 3, 0, 0, 0, size * pages * num);
 
-	tst_resm(TINFO, "wait for child 1 to stop.");
-	if (waitpid(child[1], &status, WUNTRACED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
-	if (!WIFSTOPPED(status))
-		tst_brkm(TBROK, cleanup, "child 1 was not stopped.");
-
-	/* All children change pages to 'd'. */
-	tst_resm(TINFO, "resume all children.");
-	for (k = 0; k < num; k++) {
-		if (kill(child[k], SIGCONT) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "kill child[%d]", k);
-	}
+	_stop_ksm_children(child, num);
+	_resume_ksm_children(child, num);
 	_group_check(1, 1, size * num * pages - 1, 0, 0, 0, size * pages * num);
 
-	tst_resm(TINFO, "wait for all children to stop.");
-	for (k = 0; k < num; k++) {
-		if (waitpid(child[k], &status, WUNTRACED) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
-		if (!WIFSTOPPED(status))
-			tst_brkm(TBROK, cleanup, "child %d was not stopped.",
-				 k);
-	}
-	/* Child 1 changes pages to 'e'. */
-	tst_resm(TINFO, "resume child 1.");
-	if (kill(child[1], SIGCONT) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "kill");
+	_stop_ksm_children(child, num);
+	_resume_ksm_children(child, num);
 	_group_check(1, 1, size * num * pages - 2, 0, 1, 0, size * pages * num);
 
-	tst_resm(TINFO, "wait for child 1 to stop.");
-	if (waitpid(child[1], &status, WUNTRACED) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
-	if (!WIFSTOPPED(status))
-		tst_brkm(TBROK, cleanup, "child 1 was not stopped.");
+	_stop_ksm_children(child, num);
 
-	tst_resm(TINFO, "resume all children.");
-	for (k = 0; k < num; k++) {
-		if (kill(child[k], SIGCONT) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "kill child[%d]", k);
-	}
 	tst_resm(TINFO, "KSM unmerging...");
 	write_file(PATH_KSM "run", "2");
+
+	_resume_ksm_children(child, num);
 	_group_check(2, 0, 0, 0, 0, 0, size * pages * num);
 
-	tst_resm(TINFO, "wait for all children to stop.");
-	for (k = 0; k < num; k++) {
-		if (waitpid(child[k], &status, WUNTRACED) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
-		if (!WIFSTOPPED(status))
-			tst_brkm(TBROK, cleanup, "child %d was not stopped.",
-				 k);
-	}
-	tst_resm(TINFO, "resume all children.");
-	for (k = 0; k < num; k++) {
-		if (kill(child[k], SIGCONT) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "kill child[%d]", k);
-	}
 	tst_resm(TINFO, "stop KSM.");
 	write_file(PATH_KSM "run", "0");
 	_group_check(0, 0, 0, 0, 0, 0, size * pages * num);
+
 	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0)
 		if (WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child exit status is %d",
-- 
1.7.11.7


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. SALE $99.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122412
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
