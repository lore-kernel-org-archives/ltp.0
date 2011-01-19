Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfT9B-0005pp-Ba
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:12:05 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfT95-0000gp-9y
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:12:03 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0J8BrQ3004751
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Jan 2011 03:11:53 -0500
Date: Wed, 19 Jan 2011 03:11:53 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <604599063.56180.1295424713619.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <488834807.56177.1295424703727.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_56179_1044964947.1295424713617"
Subject: [LTP] [PATCH] rework code for oom and ksm tests
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
To: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_56179_1044964947.1295424713617
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Mainly to reduce code duplication. Also, to add an option for ksm01 to
use a different memory allocation unit size to take advantage of THP.
In addition, adjust ksm01 according the latest upstream development
effort,
http://marc.info/?l=linux-mm&m=129473104716901&w=2
http://marc.info/?l=linux-mm&m=129442718808733&w=2

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/include/mem.h |   50 +++
 testcases/kernel/mem/ksm/Makefile  |   23 ++-
 testcases/kernel/mem/ksm/ksm01.c   |  461 +------------------------
 testcases/kernel/mem/lib/Makefile  |   25 ++
 testcases/kernel/mem/lib/mem.c     |  651 ++++++++++++++++++++++++++++++++++++
 testcases/kernel/mem/oom/Makefile  |    6 +-
 testcases/kernel/mem/oom/oom01.c   |    5 +-
 testcases/kernel/mem/oom/oom02.c   |    4 +-
 testcases/kernel/mem/oom/oom03.c   |    5 +-
 testcases/kernel/mem/oom/oom04.c   |  256 +-------------
 10 files changed, 786 insertions(+), 700 deletions(-)
 create mode 100644 testcases/kernel/mem/include/mem.h
 create mode 100644 testcases/kernel/mem/lib/Makefile
 create mode 100644 testcases/kernel/mem/lib/mem.c

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
new file mode 100644
index 0000000..778d403
--- /dev/null
+++ b/testcases/kernel/mem/include/mem.h
@@ -0,0 +1,50 @@
+#ifndef _MEM_H
+#define _MEM_H
+#include "test.h"
+#include "usctest.h"
+
+#define LENGTH			(3UL<<30)
+#define SYSFS_OVER		"/proc/sys/vm/overcommit_memory"
+#define OVERCOMMIT		1
+#define NORMAL			2
+#define MLOCK			3
+#define KSM			4
+#define CPATH			"/dev/cpuset"
+#define CPATH_NEW		CPATH "/1"
+#define MAXNODES		512
+#define MEMCG_PATH		"/dev/cgroup"
+#define MEMCG_PATH_NEW		MEMCG_PATH "/1"
+#define TESTMEM			(1UL<<30)
+#define MB			(1UL<<20)
+#define PATH_SYS_SYSTEM		"/sys/devices/system"
+#define PATH_KSM		"/sys/kernel/mm/ksm/"
+
+char overcommit[BUFSIZ];
+int opt_num, opt_size, opt_unit;
+char *opt_numstr, *opt_sizestr, *opt_unitstr;
+/* memory pointer to identify per process, MB unit, and byte like
+   memory[process No.][MB unit No.][byte No.]. */
+char ***memory;
+
+void oom(int testcase, int mempolicy, int lite);
+void testoom(int mempolicy, int lite, int numa);
+long count_numa(void);
+int path_exist(const char *path, ...);
+int alloc_mem(long int length, int testcase);
+void test_alloc(int testcase, int lite);
+void gather_cpus(char *cpus);
+void umount_mem(char *path, char *path_new);
+void mount_mem(char *name, char *fs, char *options, char *path, char *path_new);
+void cleanup(void);
+void setup(void);
+void ksm_usage(void);
+void check(char *path, long int value);
+void verify(char value, int proc, int start, int end, int start2, int end2);
+void group_check(int run, int pages_shared, int pages_sharing,
+		int pages_volatile, int pages_unshared, int sleep_millisecs,
+		int pages_to_scan);
+void create_same_memory(int size, int num, int unit);
+void check_ksm_options(int *size, int *num, int *unit);
+void write_cpusets(void);
+void write_memcg(void);
+#endif
diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm/Makefile
index 3634570..81509bf 100644
--- a/testcases/kernel/mem/ksm/Makefile
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -18,5 +18,26 @@
 
 top_srcdir              ?= ../../../..
 
+include $(top_srcdir)/include/mk/env_pre.mk
+
+LDLIBS			+= $(NUMA_LIBS) -lmem
+LIBDIR			:= ../lib
+LIB			:= $(LIBDIR)/libmem.a
+FILTER_OUT_DIRS		:= $(LIBDIR)
+LDFLAGS			+= -L$(LIBDIR)
+
+$(LIBDIR):
+	mkdir -p "$@"
+
+$(LIB): $(LIBDIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
+
+MAKE_DEPS		:= $(LIB)
+
+trunk-clean:: | lib-clean
+
+lib-clean:: $(LIBDIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
+
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
 include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index 09f71d7..e1c7d7f 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -1,5 +1,5 @@
 /*
- * functional testing for Kernel Samepage Merging (KSM)
+ * Kernel Samepage Merging (KSM)
  *
  * Basic tests were to start several programs with same and different
  * memory contents and ensure only to merge the ones with the same
@@ -69,471 +69,46 @@
 #include <errno.h>
 #include "test.h"
 #include "usctest.h"
-
-#define _PATH_KSM	"/sys/kernel/mm/ksm/"
-#define MB		(1024 * 1024)
+#include "../include/mem.h"
 
 char *TCID = "ksm01";
 int TST_TOTAL = 1;
-static int opt_num, opt_size;
-static char *opt_numstr, *opt_sizestr;
-/* memory pointer to identify per process, MB, and byte like
-   memory[process No.][MB No.][byte No.]. */
-static char ***memory;
-static option_t options[] = {
-	{ "n:", &opt_num,	&opt_numstr},
-	{ "s:", &opt_size,	&opt_sizestr},
-	{ NULL, NULL,		NULL}
+
+option_t ksm_options[] = {
+        { "n:", &opt_num,       &opt_numstr},
+        { "s:", &opt_size,      &opt_sizestr},
+        { "u:", &opt_unit,      &opt_unitstr},
+        { NULL, NULL,           NULL}
 };
-static void setup(void);
-static void ksmtest(void);
-static void usage(void);
-static void check(char *path, char *path2, long int value);
-static void verify(char value, int proc, int start, int end, int start2,
-		int end2);
-static void group_check(int run, int pages_shared, int pages_sharing,
-			int pages_volatile, int pages_unshared,
-			int sleep_millisecs, int pages_to_scan);
 
 int main(int argc, char *argv[])
 {
 	int lc;
 	char *msg;
+	int size = 128, num = 3, unit = 1;
 
-	msg = parse_opts(argc, argv, options, usage);
-	if (msg != (char *)NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
 	setup();
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
-		ksmtest();
+		check_ksm_options(&size, &num, &unit);
+		create_same_memory(size, num, unit);
 	}
+	cleanup();
 	tst_exit();
 }
 
-void ksmtest(void)
-{
-	char buf[BUFSIZ], buf2[BUFSIZ];
-	int i, j, status, k, fd, *child;
-	int size = 128, num = 3;
-
-	if (opt_size) {
-		size = atoi(opt_sizestr);
-		if (size < 1)
-			tst_brkm(TBROK, NULL,
-				"size cannot be less than 1.");
-	}
-	if (opt_num) {
-		num = atoi(opt_numstr);
-		if (num < 3)
-			tst_brkm(TBROK, NULL,
-				"process number cannot be less 3.");
-	}
-	child = malloc(num);
-	if (child == NULL)
-		tst_brkm(TBROK|TERRNO, NULL, "malloc");
-
-	memory = malloc(num * sizeof(**memory));
-	if (memory == NULL)
-		tst_brkm(TBROK|TERRNO, NULL, "malloc");
-
-	switch (child[0] = fork()) {
-	case -1:
-		tst_brkm(TBROK|TERRNO, NULL, "fork");
-	case 0:
-		tst_resm(TINFO, "child 0 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill");
-
-		tst_resm(TINFO, "child 0 continues...");
-
-		/* Avoid TransparentHugePage allocation which can't ksm at the
-		   moment. */
-		tst_resm(TINFO, "child 0 allocates %d MB filled with 'c'.",
-			size);
-		memory[0] = malloc(size * sizeof(*memory));
-		if (memory[0] == NULL)
-			tst_brkm(TBROK|TERRNO, NULL, "malloc");
-		for (j = 0; j < size; j++) {
-			memory[0][j] = mmap(NULL, MB, PROT_READ|PROT_WRITE,
-					MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-			if (memory[0][j] == MAP_FAILED)
-				tst_brkm(TBROK|TERRNO, NULL, "mmap");
-			if (madvise(memory[0][j], MB, MADV_MERGEABLE) == -1)
-				tst_brkm(TBROK|TERRNO, NULL, "madvise");
-			for (i = 0; i < MB; i++)
-				memory[0][j][i] = 'c';
-		}
-		tst_resm(TINFO, "child 0 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill");
-
-		tst_resm(TINFO, "child 0 continues...");
-		verify('c', 0, 0, size, 0, MB);
-		tst_resm(TINFO, "child 0 changes memory content to 'd'.");
-		for (j = 0; j < size; j++) {
-			for (i = 0; i < MB; i++)
-				memory[0][j][i] = 'd';
-		}
-		/* Unmerge. */
-		tst_resm(TINFO, "child 0 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill");
-
-		tst_resm(TINFO, "child 0 continues...");
-		verify('d', 0, 0, size, 0, MB);
-		/* Stop. */
-		tst_resm(TINFO, "child 0 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill");
-		tst_resm(TINFO, "child 0 continues...");
-		exit(0);
-	}
-	switch (child[1] = fork()) {
-	case -1:
-		tst_brkm(TBROK|TERRNO, NULL, "fork");
-	case 0:
-		tst_resm(TINFO, "child 1 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill");
-		tst_resm(TINFO, "child 1 continues...");
-		tst_resm(TINFO, "child 1 allocates %d MB filled with 'a'.",
-			size);
-		memory[1] = malloc(size * sizeof(*memory));
-		if (memory[1] == NULL)
-			tst_brkm(TBROK|TERRNO, NULL, "malloc");
-		for (j = 0; j < size; j++) {
-			memory[1][j] = mmap(NULL, MB, PROT_READ|PROT_WRITE,
-					MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-			if (memory[1][j] == MAP_FAILED)
-				tst_brkm(TBROK|TERRNO, NULL, "mmap");
-			if (madvise(memory[1][j], MB, MADV_MERGEABLE) == -1)
-				tst_brkm(TBROK|TERRNO, NULL, "madvise");
-			for (i = 0; i < MB; i++)
-				memory[1][j][i] = 'a';
-		}
-
-		tst_resm(TINFO, "child 1 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill");
-		tst_resm(TINFO, "child 1 continues...");
-		verify('a', 1, 0, size, 0, MB);
-		tst_resm(TINFO, "child 1 changes memory content to 'b'.");
-		for (j = 0; j < size; j++) {
-			for (i = 0; i < MB; i++)
-				memory[1][j][i] = 'b';
-		}
-
-		tst_resm(TINFO, "child 1 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill");
-		tst_resm(TINFO, "child 1 continues...");
-		verify('b', 1, 0, size, 0, MB);
-		tst_resm(TINFO, "child 1 changes memory content to 'd'");
-		for (j = 0; j < size; j++) {
-			for (i = 0; i < MB; i++)
-				memory[1][j][i] = 'd';
-		}
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill");
-
-		tst_resm(TINFO, "child 1 continues...");
-		verify('d', 1, 0, size, 0, MB);
-		tst_resm(TINFO, "child 1 changes one page to 'e'.");
-		memory[1][size - 1][MB - 1] = 'e';
-
-		/* Unmerge. */
-		tst_resm(TINFO, "child 1 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill");
-		tst_resm(TINFO, "child 1 continues...");
-		verify('e', 1, size - 1, size, MB - 1, MB);
-		verify('d', 1, 0, size - 1, 0, MB - 1);
-
-		/* Stop. */
-		tst_resm(TINFO, "child 1 stops.");
-		if (raise(SIGSTOP) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill");
-		tst_resm(TINFO, "child 1 continues...");
-		exit(0);
-	}
-	for (k = 2; k < num; k++) {
-		switch (child[k] = fork()) {
-		case -1:
-			tst_brkm(TBROK|TERRNO, NULL, "fork");
-		case 0:
-			tst_resm(TINFO, "child %d stops.", k);
-			if (raise(SIGSTOP) == -1)
-				tst_brkm(TBROK|TERRNO, NULL, "kill");
-			tst_resm(TINFO, "child %d continues...", k);
-			tst_resm(TINFO, "child %d allocates %d "
-				"MB filled with 'a'.", k, size);
-			memory[k] = malloc(size * sizeof(*memory));
-			if (memory[k] == NULL)
-				tst_brkm(TBROK|TERRNO, NULL, "malloc");
-			for (j = 0; j < size; j++) {
-				memory[k][j] = mmap(NULL, MB,
-						PROT_READ|PROT_WRITE,
-						MAP_ANONYMOUS
-						|MAP_PRIVATE, -1, 0);
-				if (memory[k][j] == MAP_FAILED)
-					tst_brkm(TBROK|TERRNO, NULL,
-						"mmap");
-				if (madvise(memory[k][j], MB,
-						MADV_MERGEABLE) == -1)
-					tst_brkm(TBROK|TERRNO, NULL,
-						"madvise");
-				for (i = 0; i < MB; i++)
-					memory[k][j][i] = 'a';
-			}
-			tst_resm(TINFO, "child %d stops.", k);
-			if (raise(SIGSTOP) == -1)
-				tst_brkm(TBROK|TERRNO, NULL, "kill");
-			tst_resm(TINFO, "child %d continues...", k);
-			tst_resm(TINFO, "child %d changes memory content to "
-				"'d'", k);
-			for (j = 0; j < size; j++) {
-				for (i = 0; i < MB; i++)
-					memory[k][j][i] = 'd';
-		        }
-			/* Unmerge. */
-			tst_resm(TINFO, "child %d stops.", k);
-			if (raise(SIGSTOP) == -1)
-				tst_brkm(TBROK|TERRNO, NULL, "kill");
-			tst_resm(TINFO, "child %d continues...", k);
-
-			/* Stop. */
-			tst_resm(TINFO, "child %d stops.", k);
-			if (raise(SIGSTOP) == -1)
-				tst_brkm(TBROK|TERRNO, NULL, "kill");
-			tst_resm(TINFO, "child %d continues...", k);
-			exit(0);
-		}
-	}
-	tst_resm(TINFO, "KSM merging...");
-	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "run");
-	fd = open(buf, O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "open");
-	if (write(fd, "1", 1) != 1)
-		tst_brkm(TBROK|TERRNO, NULL, "write");
-	close(fd);
-	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "pages_to_scan");
-	snprintf(buf2, BUFSIZ, "%d", size * 256 * num);
-	fd = open(buf, O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "open");
-	if (write(fd, buf2, strlen(buf2)) != strlen(buf2))
-		tst_brkm(TBROK|TERRNO, NULL, "write");
-	close(fd);
-
-	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "sleep_millisecs");
-	fd = open(buf, O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "open");
-	if (write(fd, "0", 1) != 1)
-		tst_brkm(TBROK|TERRNO, NULL, "write");
-	close(fd);
-
-	tst_resm(TINFO, "wait for all children to stop.");
-	for (k = 0; k < num; k++) {
-		if (waitpid(child[k], &status, WUNTRACED) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-		if (!WIFSTOPPED(status))
-			tst_brkm(TBROK, NULL, "child %d was not stopped.",
-				k);
-	}
-	tst_resm(TINFO, "resume all children.");
-	for (k = 0; k < num; k++) {
-		if (kill(child[k], SIGCONT) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill child[%d]", k);
-	}
-	group_check(1, 2, size * num * 256 - 2, 0, 0, 0, size * 256 * num);
-
-	tst_resm(TINFO, "wait for child 1 to stop.");
-	if (waitpid(child[1], &status, WUNTRACED) == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-	if (!WIFSTOPPED(status))
-		tst_brkm(TBROK, NULL, "child 1 was not stopped.");
-
-	/* Child 1 changes all pages to 'b'. */
-	tst_resm(TINFO, "resume child 1.");
-	if (kill(child[1], SIGCONT) == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "kill");
-	group_check(1, 3, size * num * 256 - 3, 0, 0, 0, size * 256 * num);
-
-	tst_resm(TINFO, "wait for child 1 to stop.");
-	if (waitpid(child[1], &status, WUNTRACED) == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-	if (!WIFSTOPPED(status))
-		tst_brkm(TBROK, NULL, "child 1 was not stopped.");
-
-	/* All children change pages to 'd'. */
-	tst_resm(TINFO, "resume all children.");
-	for (k = 0; k < num; k++) {
-		if (kill(child[k], SIGCONT) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill child[%d]", k);
-	}
-	group_check(1, 1, size * num * 256 - 1, 0, 0, 0, size * 256 * num);
-
-	tst_resm(TINFO, "wait for all children to stop.");
-	for (k = 0; k < num; k++) {
-		if (waitpid(child[k], &status, WUNTRACED) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-		if (!WIFSTOPPED(status))
-			tst_brkm(TBROK, NULL, "child %d was not stopped.",
-				k);
-	}
-	/* Child 1 changes pages to 'e'. */
-	tst_resm(TINFO, "resume child 1.");
-	if (kill(child[1], SIGCONT) == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "kill");
-	group_check(1, 1, size * num * 256 - 2, 0, 1, 0, size * 256 * num);
-
-	tst_resm(TINFO, "wait for child 1 to stop.");
-	if (waitpid(child[1], &status, WUNTRACED) == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-	if (!WIFSTOPPED(status))
-		tst_brkm(TBROK, NULL, "child 1 was not stopped.");
-
-	tst_resm(TINFO, "resume all children.");
-	for (k = 0; k < num; k++) {
-		if (kill(child[k], SIGCONT) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill child[%d]", k);
-	}
-	tst_resm(TINFO, "KSM unmerging...");
-	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "run");
-	fd = open(buf, O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "open");
-	if (write(fd, "2", 1) != 1)
-		tst_brkm(TBROK|TERRNO, NULL, "write");
-	group_check(2, 0, 0, 0, 0, 0, size * 256 * num);
-
-	tst_resm(TINFO, "wait for all children to stop.");
-	for (k = 0; k < num; k++) {
-		if (waitpid(child[k], &status, WUNTRACED) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "waitpid");
-		if (!WIFSTOPPED(status))
-			tst_brkm(TBROK, NULL, "child %d was not stopped.",
-				k);
-	}
-	tst_resm(TINFO, "resume all children.");
-	for (k = 0; k < num; k++) {
-		if (kill(child[k], SIGCONT) == -1)
-			tst_brkm(TBROK|TERRNO, NULL, "kill child[%d]", k);
-	}
-	tst_resm(TINFO, "stop KSM.");
-	if (lseek(fd, 0, SEEK_SET) == -1)
-		tst_brkm(TBROK|TERRNO, NULL, "lseek");
-	if (write(fd, "0", 1) != 1)
-		tst_brkm(TBROK|TERRNO, NULL, "write");
-	close(fd);
-	group_check(0, 0, 0, 0, 0, 0, size * 256 * num);
-	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0)
-		if (WEXITSTATUS(status) != 0)
-			tst_resm(TFAIL, "child exit status is %d",
-				WEXITSTATUS(status));
-}
-
 void setup(void)
 {
-	char buf[BUFSIZ];
-	struct stat new;
+	tst_require_root(NULL);
 
-	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "run");
-	if (stat(buf, &new) == -1) {
-		if (errno == ENOENT)
-			tst_brkm(TCONF, NULL, "no KSM.");
-		else
-			tst_brkm(TBROK, NULL, "stat");
-	}
-	/*
-	 * setup a default signal hander and a
-	 * temporary working directory.
-	 */
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	TEST_PAUSE;
 }
 
-void usage(void)
+void cleanup(void)
 {
-	printf("  -n      Number of processes\n");
-	printf("  -s      Memory allocation size in MB\n");
+	TEST_CLEANUP;
 }
-
-/* There is currently a bug will cause the test failure - *
- http://marc.info/?l=linux-mm&m=128928530308526&w=2 .  Since it has
- still been discussed upstream, the interface here was added some
- flexiblity with path2, so it is possible to make changes here depends
- on the future implementation in kernel. For example, to verify
- (pages_sharing + pages_volatile) instead of a single item. */
-void check(char *path, char *path2, long int value)
-{
-	FILE *fp;
-	char buf[BUFSIZ], buf2[BUFSIZ];
-
-	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, path);
-	fp = fopen(buf, "r");
-	if (fp == NULL)
-		tst_brkm(TBROK|TERRNO, NULL, "fopen");
-	if (fgets(buf, BUFSIZ, fp) == NULL)
-		tst_brkm(TBROK|TERRNO, NULL, "fgets");
-	fclose(fp);
-
-	tst_resm(TINFO, "%s is %ld.", path, atol(buf));
-	if (path2 != NULL) {
-		snprintf(buf2, BUFSIZ, "%s%s", _PATH_KSM, path2);
-		fp = fopen(buf2, "r");
-		if (fp == NULL)
-			tst_brkm(TBROK|TERRNO, NULL, "fopen");
-		if (fgets(buf2, BUFSIZ, fp) == NULL)
-			tst_brkm(TBROK|TERRNO, NULL, "fgets");
-		fclose(fp);
-
-		tst_resm(TINFO, "%s is %ld.", path2, atol(buf2));
-		if (atol(buf) + atol(buf2) != value)
-			tst_resm(TFAIL, "%s + %s is not %ld.", path, path2,
-				value);
-	} else
-		if (atol(buf) != value)
-			tst_resm(TFAIL, "%s is not %ld.", path, value);
-}
-
-void verify(char value, int proc, int start, int end, int start2, int end2)
-{
-	int i, j;
-	void *s = NULL;
-
-	s = malloc((end - start) * (end2 - start2));
-	if (s == NULL)
-		tst_brkm(TBROK|TERRNO, NULL, "malloc");
-
-	tst_resm(TINFO, "child %d verifies memory content.", proc);
-	memset(s, value, (end - start) * (end2 - start2));
-	if (memcmp(memory[proc][start], s, (end - start) * (end2 - start2)) != 0)
-		for (j = start; j < end; j++)
-			for (i = start2; i < end2; i++)
-				if (memory[proc][j][i] != value)
-					tst_resm(TFAIL, "child %d has %c at "
-						"%d,%d,%d.",
-						proc, memory[proc][j][i], proc,
-						j, i);
-	free(s);
-}
-
-void group_check(int run, int pages_shared, int pages_sharing,
-		int pages_volatile, int pages_unshared,
-		int sleep_millisecs, int pages_to_scan)
-{
-        /* 5 seconds for ksm to scan pages. */
-	sleep(5);
-	tst_resm(TINFO, "check!");
-	check("run", NULL, run);
-	check("pages_shared", NULL, pages_shared);
-	check("pages_sharing", NULL, pages_sharing);
-	check("pages_volatile", NULL, pages_volatile);
-	check("pages_unshared", NULL, pages_unshared);
-	check("sleep_millisecs", NULL, sleep_millisecs);
-	check("pages_to_scan", NULL, pages_to_scan);
-}
\ No newline at end of file
diff --git a/testcases/kernel/mem/lib/Makefile b/testcases/kernel/mem/lib/Makefile
new file mode 100644
index 0000000..dd978a7
--- /dev/null
+++ b/testcases/kernel/mem/lib/Makefile
@@ -0,0 +1,25 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+LIB			:= libmem.a
+
+include $(top_srcdir)/include/mk/lib.mk
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
new file mode 100644
index 0000000..297eedd
--- /dev/null
+++ b/testcases/kernel/mem/lib/mem.c
@@ -0,0 +1,651 @@
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdarg.h>
+#include "test.h"
+#include "usctest.h"
+#include "../include/mem.h"
+#include "config.h"
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+#include <numaif.h>
+#endif
+
+void oom(int testcase, int mempolicy, int lite)
+{
+	pid_t pid;
+	int status;
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+	unsigned long nmask = 2;
+#endif
+
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+		if (mempolicy)
+			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"set_mempolicy");
+#endif
+		test_alloc(testcase, lite);
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+
+	if (testcase == OVERCOMMIT) {
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
+				status);
+	} else {
+		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
+				status);
+	}
+}
+
+void write_memcg(void)
+{
+	int fd;
+	char buf[BUFSIZ], mem[BUFSIZ];
+
+	fd = open(MEMCG_PATH_NEW "/memory.limit_in_bytes", O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	sprintf(mem, "%ld", TESTMEM);
+	if (write(fd, mem, strlen(mem)) != strlen(mem))
+		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+	close(fd);
+
+	fd = open(MEMCG_PATH_NEW "/tasks", O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	snprintf(buf, BUFSIZ, "%d", getpid());
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+	close(fd);	
+}
+
+void write_cpusets(void)
+{
+	char cpus[BUFSIZ] = "";
+	char buf[BUFSIZ] = "";
+	int fd;
+
+	gather_cpus(cpus);
+	tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
+
+	fd = open(CPATH_NEW "/mems", O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	if (write(fd, "1", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+	close(fd);
+
+	fd = open(CPATH_NEW "/cpus", O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
+		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+	close(fd);
+
+	fd = open(CPATH_NEW "/tasks", O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	snprintf(buf, BUFSIZ, "%d", getpid());
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+	close(fd);
+}
+
+void testoom(int mempolicy, int lite, int numa)
+{
+	if (numa && !mempolicy)
+		write_cpusets();
+
+	tst_resm(TINFO, "start normal OOM testing.");
+	oom(NORMAL, mempolicy, lite);
+
+	tst_resm(TINFO, "start OOM testing for mlocked pages.");
+	oom(MLOCK, mempolicy, lite);
+
+	tst_resm(TINFO, "start OOM testing for KSM pages.");
+	oom(KSM, mempolicy, lite);
+}
+
+long count_numa(void)
+{
+	int nnodes = 0;
+
+	while(path_exist(PATH_SYS_SYSTEM "/node/node%d", nnodes))
+		nnodes++;
+
+	return nnodes;
+}
+
+int path_exist(const char *path, ...)
+{
+	va_list ap;
+	char pathbuf[PATH_MAX];
+
+	va_start(ap, path);
+	vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
+	va_end(ap);
+
+	return access(pathbuf, F_OK) == 0;
+}
+
+void gather_cpus(char *cpus)
+{
+	int ncpus = 0;
+	int i;
+	char buf[BUFSIZ];
+
+	while(path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+		ncpus++;
+
+	for (i = 0; i < ncpus; i++)
+		if (path_exist(PATH_SYS_SYSTEM "/node/node1/cpu%d", i)) {
+			sprintf(buf, "%d,", i);
+			strcat(cpus, buf);
+		}
+	/* Remove the trailing comma. */
+	cpus[strlen(cpus) - 1] = '\0';
+}
+
+int alloc_mem(long int length, int testcase)
+{
+	void *s;
+
+	tst_resm(TINFO, "allocating %ld bytes.", length);
+	s = mmap(NULL, length, PROT_READ|PROT_WRITE,
+		MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (s == MAP_FAILED) {
+		if (testcase == OVERCOMMIT && errno == ENOMEM)
+			return 1;
+		else
+			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+	}
+	if (testcase == MLOCK && mlock(s, length) == -1)
+		tst_brkm(TINFO|TERRNO, cleanup, "mlock");
+	if (testcase == KSM
+		&& madvise(s, length, MADV_MERGEABLE) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "madvise");
+	memset(s, '\a', length);
+
+	return 0;
+}
+
+void test_alloc(int testcase, int lite)
+{
+	if (lite)
+		alloc_mem(TESTMEM + MB, testcase);
+	else
+		while(1)
+			if (alloc_mem(LENGTH, testcase))
+				return;
+}
+
+void umount_mem(char *path, char *path_new)
+{
+	FILE *fp;
+	int fd;
+	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+
+	/* Move all processes in task to its parent node. */
+	sprintf(s, "%s/tasks", path);
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open %s", s);
+
+	snprintf(s_new, BUFSIZ, "%s/tasks", path_new);
+	fp = fopen(s_new, "r");
+	if (fp == NULL)
+		tst_resm(TWARN|TERRNO, "fopen %s", s_new);
+	if ((fd != -1) && (fp != NULL)) {
+		while (fgets(value, BUFSIZ, fp) != NULL)
+			if (write(fd, value, strlen(value) - 1)
+				!= strlen(value) - 1)
+				tst_resm(TWARN|TERRNO, "write %s", s);
+	}
+	if (fd != -1)
+		close(fd);
+	if (fp != NULL)
+		fclose(fp);
+	if (rmdir(path_new) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", path_new);
+	if (umount(path) == -1)
+		tst_resm(TWARN|TERRNO, "umount %s", path);
+	if (rmdir(path) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", path);
+}
+
+void mount_mem(char *name, char *fs, char *options, char *path, char *path_new)
+{
+	if (mkdir(path, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", path);
+	if (mount(name, path, fs, 0, options) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount %s", path);
+	if (mkdir(path_new, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", path_new);
+}
+
+void ksm_usage(void)
+{
+	printf("  -n      Number of processes\n");
+	printf("  -s      Memory allocation size in MB\n");
+	printf("  -u      Memory allocation unit in MB\n");
+}
+
+void check(char *path, long int value)
+{
+	FILE *fp;
+	char buf[BUFSIZ];
+
+	snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, path);
+	fp = fopen(buf, "r");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, tst_exit, "fopen");
+	if (fgets(buf, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, tst_exit, "fgets");
+	fclose(fp);
+
+	tst_resm(TINFO, "%s is %ld.", path, atol(buf));
+	if (atol(buf) != value)
+		tst_resm(TFAIL, "%s is not %ld.", path, value);
+}
+
+void verify(char value, int proc, int start, int end, int start2, int end2)
+{
+	int i, j;
+	void *s = NULL;
+
+	s = malloc((end - start) * (end2 - start2));
+	if (s == NULL)
+		tst_brkm(TBROK|TERRNO, tst_exit, "malloc");
+
+	tst_resm(TINFO, "child %d verifies memory content.", proc);
+	memset(s, value, (end - start) * (end2 - start2));
+	if (memcmp(memory[proc][start], s, (end - start) * (end2 - start2))
+		!= 0)
+		for (j = start; j < end; j++)
+			for (i = start2; i < end2; i++)
+				if (memory[proc][j][i] != value)
+					tst_resm(TFAIL, "child %d has %c at "
+						"%d,%d,%d.",
+						proc, memory[proc][j][i], proc,
+						j, i);
+	free(s);
+}
+
+void group_check(int run, int pages_shared, int pages_sharing,
+		int pages_volatile, int pages_unshared,
+		int sleep_millisecs, int pages_to_scan)
+{
+        /* 5 seconds for ksm to scan pages. */
+	sleep(5);
+	tst_resm(TINFO, "check!");
+	check("run", run);
+	check("pages_shared", pages_shared);
+	check("pages_sharing", pages_sharing);
+	check("pages_volatile", pages_volatile);
+	check("pages_unshared", pages_unshared);
+	check("sleep_millisecs", sleep_millisecs);
+	check("pages_to_scan", pages_to_scan);
+}
+
+void create_same_memory(int size, int num, int unit)
+{
+	char buf[BUFSIZ], buf2[BUFSIZ];
+	int i, j, k;
+	int status, fd;
+	int *child;
+
+	child = malloc(num);
+	if (child == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+
+	memory = malloc(num * sizeof(**memory));
+	if (memory == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+
+	/* Don't call cleanup in those children. Instead, do a cleanup from the
+	   parent after fetched children's status.*/
+	switch (child[0] = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		tst_resm(TINFO, "child 0 stops.");
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+
+		tst_resm(TINFO, "child 0 continues...");
+		tst_resm(TINFO, "child 0 allocates %d MB filled with 'c'.",
+			size);
+		memory[0] = malloc(size / unit * sizeof(*memory));
+		if (memory[0] == NULL)
+			tst_brkm(TBROK|TERRNO, tst_exit, "malloc");
+		for (j = 0; j * unit < size; j++) {
+			memory[0][j] = mmap(NULL, unit * MB,
+					PROT_READ|PROT_WRITE,
+					MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+			if (memory[0][j] == MAP_FAILED)
+				tst_brkm(TBROK|TERRNO, tst_exit, "mmap");
+			if (madvise(memory[0][j], unit * MB, MADV_MERGEABLE)
+				== -1)
+				tst_brkm(TBROK|TERRNO, tst_exit, "madvise");
+			for (i = 0; i < unit * MB; i++)
+				memory[0][j][i] = 'c';
+		}
+		tst_resm(TINFO, "child 0 stops.");
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+
+		tst_resm(TINFO, "child 0 continues...");
+		verify('c', 0, 0, size / unit, 0, unit * MB);
+		tst_resm(TINFO, "child 0 changes memory content to 'd'.");
+		for (j = 0; j < size / unit; j++) {
+			for (i = 0; i < unit * MB; i++)
+				memory[0][j][i] = 'd';
+		}
+		/* Unmerge. */
+		tst_resm(TINFO, "child 0 stops.");
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+
+		tst_resm(TINFO, "child 0 continues...");
+		verify('d', 0, 0, size / unit, 0, unit * MB);
+		/* Stop. */
+		tst_resm(TINFO, "child 0 stops.");
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+		tst_resm(TINFO, "child 0 continues...");
+		exit(0);
+	}
+	switch (child[1] = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		tst_resm(TINFO, "child 1 stops.");
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+		tst_resm(TINFO, "child 1 continues...");
+		tst_resm(TINFO, "child 1 allocates %d MB filled with 'a'.",
+			size);
+		memory[1] = malloc(size / unit * sizeof(*memory));
+		if (memory[1] == NULL)
+			tst_brkm(TBROK|TERRNO, tst_exit, "malloc");
+		for (j = 0; j < size / unit; j++) {
+			memory[1][j] = mmap(NULL, unit * MB,
+					PROT_READ|PROT_WRITE,
+					MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+			if (memory[1][j] == MAP_FAILED)
+				tst_brkm(TBROK|TERRNO, tst_exit, "mmap");
+			if (madvise(memory[1][j], unit * MB, MADV_MERGEABLE)
+				== -1)
+				tst_brkm(TBROK|TERRNO, tst_exit, "madvise");
+			for (i = 0; i < unit * MB; i++)
+				memory[1][j][i] = 'a';
+		}
+		tst_resm(TINFO, "child 1 stops.");
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+		tst_resm(TINFO, "child 1 continues...");
+		verify('a', 1, 0, size / unit, 0, unit * MB);
+		tst_resm(TINFO, "child 1 changes memory content to 'b'.");
+		for (j = 0; j < size / unit; j++) {
+			for (i = 0; i < unit * MB; i++)
+				memory[1][j][i] = 'b';
+		}
+		tst_resm(TINFO, "child 1 stops.");
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+		tst_resm(TINFO, "child 1 continues...");
+		verify('b', 1, 0, size / unit, 0, unit * MB);
+		tst_resm(TINFO, "child 1 changes memory content to 'd'");
+		for (j = 0; j < size / unit; j++) {
+			for (i = 0; i < unit * MB; i++)
+				memory[1][j][i] = 'd';
+		}
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+
+		tst_resm(TINFO, "child 1 continues...");
+		verify('d', 1, 0, size / unit, 0, unit * MB);
+		tst_resm(TINFO, "child 1 changes one page to 'e'.");
+		memory[1][size / unit - 1][unit * MB - 1] = 'e';
+
+		/* Unmerge. */
+		tst_resm(TINFO, "child 1 stops.");
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+		tst_resm(TINFO, "child 1 continues...");
+		verify('e', 1, size / unit - 1, size / unit,
+			unit * MB - 1, unit * MB);
+		verify('d', 1, 0, size / unit - 1, 0, unit * MB - 1);
+
+		/* Stop. */
+		tst_resm(TINFO, "child 1 stops.");
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+		tst_resm(TINFO, "child 1 continues...");
+		exit(0);
+	}
+	for (k = 2; k < num; k++) {
+		switch (child[k] = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		case 0:
+			tst_resm(TINFO, "child %d stops.", k);
+			if (raise(SIGSTOP) == -1)
+				tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+			tst_resm(TINFO, "child %d continues...", k);
+			tst_resm(TINFO, "child %d allocates %d "
+				"MB filled with 'a'.", k, size);
+			memory[k] = malloc(size / unit * sizeof(*memory));
+			if (memory[k] == NULL)
+				tst_brkm(TBROK|TERRNO, tst_exit, "malloc");
+			for (j = 0; j < size / unit; j++) {
+				memory[k][j] = mmap(NULL, unit * MB,
+						PROT_READ|PROT_WRITE,
+						MAP_ANONYMOUS
+						|MAP_PRIVATE, -1, 0);
+				if (memory[k][j] == MAP_FAILED)
+					tst_brkm(TBROK|TERRNO, cleanup,
+						"mmap");
+				if (madvise(memory[k][j], unit * MB,
+						MADV_MERGEABLE) == -1)
+					tst_brkm(TBROK|TERRNO, cleanup,
+						"madvise");
+				for (i = 0; i < unit * MB; i++)
+					memory[k][j][i] = 'a';
+			}
+			tst_resm(TINFO, "child %d stops.", k);
+			if (raise(SIGSTOP) == -1)
+				tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+			tst_resm(TINFO, "child %d continues...", k);
+			tst_resm(TINFO, "child %d changes memory content to "
+				"'d'", k);
+			for (j = 0; j < size / unit; j++) {
+				for (i = 0; i < unit * MB; i++)
+					memory[k][j][i] = 'd';
+		        }
+			/* Unmerge. */
+			tst_resm(TINFO, "child %d stops.", k);
+			if (raise(SIGSTOP) == -1)
+				tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+			tst_resm(TINFO, "child %d continues...", k);
+
+			/* Stop. */
+			tst_resm(TINFO, "child %d stops.", k);
+			if (raise(SIGSTOP) == -1)
+				tst_brkm(TBROK|TERRNO, tst_exit, "kill");
+			tst_resm(TINFO, "child %d continues...", k);
+			exit(0);
+		}
+	}
+	tst_resm(TINFO, "KSM merging...");
+	snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, "run");
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, "1", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+	snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, "pages_to_scan");
+	snprintf(buf2, BUFSIZ, "%d", size * 256 * num);
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, buf2, strlen(buf2)) != strlen(buf2))
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, "sleep_millisecs");
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, "0", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	tst_resm(TINFO, "wait for all children to stop.");
+	for (k = 0; k < num; k++) {
+		if (waitpid(child[k], &status, WUNTRACED) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFSTOPPED(status))
+			tst_brkm(TBROK, cleanup, "child %d was not stopped.",
+				k);
+	}
+	tst_resm(TINFO, "resume all children.");
+	for (k = 0; k < num; k++) {
+		if (kill(child[k], SIGCONT) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "kill child[%d]", k);
+	}
+	group_check(1, 2, size * num * 256 - 2, 0, 0, 0, size * 256 * num);
+
+	tst_resm(TINFO, "wait for child 1 to stop.");
+	if (waitpid(child[1], &status, WUNTRACED) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (!WIFSTOPPED(status))
+		tst_brkm(TBROK, cleanup, "child 1 was not stopped.");
+
+	/* Child 1 changes all pages to 'b'. */
+	tst_resm(TINFO, "resume child 1.");
+	if (kill(child[1], SIGCONT) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "kill");
+	group_check(1, 3, size * num * 256 - 3, 0, 0, 0, size * 256 * num);
+
+	tst_resm(TINFO, "wait for child 1 to stop.");
+	if (waitpid(child[1], &status, WUNTRACED) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (!WIFSTOPPED(status))
+		tst_brkm(TBROK, cleanup, "child 1 was not stopped.");
+
+	/* All children change pages to 'd'. */
+	tst_resm(TINFO, "resume all children.");
+	for (k = 0; k < num; k++) {
+		if (kill(child[k], SIGCONT) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "kill child[%d]", k);
+	}
+	group_check(1, 1, size * num * 256 - 1, 0, 0, 0, size * 256 * num);
+
+	tst_resm(TINFO, "wait for all children to stop.");
+	for (k = 0; k < num; k++) {
+		if (waitpid(child[k], &status, WUNTRACED) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFSTOPPED(status))
+			tst_brkm(TBROK, cleanup, "child %d was not stopped.",
+				k);
+	}
+	/* Child 1 changes pages to 'e'. */
+	tst_resm(TINFO, "resume child 1.");
+	if (kill(child[1], SIGCONT) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "kill");
+	group_check(1, 1, size * num * 256 - 2, 0, 1, 0, size * 256 * num);
+
+	tst_resm(TINFO, "wait for child 1 to stop.");
+	if (waitpid(child[1], &status, WUNTRACED) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (!WIFSTOPPED(status))
+		tst_brkm(TBROK, cleanup, "child 1 was not stopped.");
+
+	tst_resm(TINFO, "resume all children.");
+	for (k = 0; k < num; k++) {
+		if (kill(child[k], SIGCONT) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "kill child[%d]", k);
+	}
+	tst_resm(TINFO, "KSM unmerging...");
+	snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, "run");
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, "2", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	group_check(2, 0, 0, 0, 0, 0, size * 256 * num);
+
+	tst_resm(TINFO, "wait for all children to stop.");
+	for (k = 0; k < num; k++) {
+		if (waitpid(child[k], &status, WUNTRACED) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFSTOPPED(status))
+			tst_brkm(TBROK, cleanup, "child %d was not stopped.",
+				k);
+	}
+	tst_resm(TINFO, "resume all children.");
+	for (k = 0; k < num; k++) {
+		if (kill(child[k], SIGCONT) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "kill child[%d]", k);
+	}
+	tst_resm(TINFO, "stop KSM.");
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	if (write(fd, "0", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+	group_check(0, 0, 0, 0, 0, 0, size * 256 * num);
+	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0)
+		if (WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "child exit status is %d",
+				WEXITSTATUS(status));
+}
+
+void check_ksm_options(int *size, int *num, int *unit)
+{
+	if (opt_size) {
+		*size = atoi(opt_sizestr);
+		if (*size < 1)
+			tst_brkm(TBROK, cleanup,
+				"size cannot be less than 1.");
+	}
+	if (opt_unit) {
+		*unit = atoi(opt_unitstr);
+		if (*unit > *size)
+			tst_brkm(TBROK, cleanup,
+				"unit cannot be greater than size.");
+		if (*size % *unit != 0)
+			tst_brkm(TBROK, cleanup,
+				"the remainder of division of size by unit is "
+				"not zero.");
+	}
+	if (opt_num) {
+		*num = atoi(opt_numstr);
+		if (*num < 3)
+			tst_brkm(TBROK, cleanup,
+				"process number cannot be less 3.");
+	}
+}
diff --git a/testcases/kernel/mem/oom/Makefile b/testcases/kernel/mem/oom/Makefile
index 01c0546..81509bf 100644
--- a/testcases/kernel/mem/oom/Makefile
+++ b/testcases/kernel/mem/oom/Makefile
@@ -20,9 +20,9 @@ top_srcdir              ?= ../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-LDLIBS			+= $(NUMA_LIBS) -loom
-LIBDIR			:= lib
-LIB			:= $(LIBDIR)/liboom.a
+LDLIBS			+= $(NUMA_LIBS) -lmem
+LIBDIR			:= ../lib
+LIB			:= $(LIBDIR)/libmem.a
 FILTER_OUT_DIRS		:= $(LIBDIR)
 LDFLAGS			+= -L$(LIBDIR)
 
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index c670d90..b6c9d83 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -38,13 +38,10 @@
 #include <unistd.h>
 #include "test.h"
 #include "usctest.h"
-#include "lib/oom.h"
+#include "../include/mem.h"
 
 char *TCID = "oom01";
 int TST_TOTAL = 1;
-extern int Tst_count;
-
-static void setup(void);
 
 int main(int argc, char *argv[])
 {
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 68ed1ef..04c6507 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -42,9 +42,7 @@ int TST_TOTAL = 1;
 #include <fcntl.h>
 #include <stdio.h>
 #include <errno.h>
-#include "lib/oom.h"
-
-static void setup(void);
+#include "../include/mem.h"
 
 int main(int argc, char *argv[])
 {
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index dd09467..da01d3e 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -35,13 +35,10 @@
 #include <errno.h>
 #include "test.h"
 #include "usctest.h"
-#include "lib/oom.h"
+#include "../include/mem.h"
 
 char *TCID = "oom03";
 int TST_TOTAL = 1;
-extern int Tst_count;
-
-static void setup(void);
 
 int main(int argc, char *argv[])
 {
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 1dff85e..8eb5c04 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -34,55 +34,15 @@
 
 char *TCID = "oom04";
 int TST_TOTAL = 1;
-extern int Tst_count;
 
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
-#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <sys/wait.h>
-#include <sys/mount.h>
-#include <numaif.h>
 #include <fcntl.h>
 #include <stdio.h>
-#include <unistd.h>
 #include <errno.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#include <signal.h>
-#include <unistd.h>
-#include <stdarg.h>
-
-#define MAXNODES		512
-#define CPATH			"/dev/cpuset"
-#define CPATH_NEW		CPATH "/1"
-#define MEMCG_PATH		"/dev/cgroup"
-#define MEMCG_PATH_NEW		MEMCG_PATH "/1"
-#define _PATH_SYS_SYSTEM	"/sys/devices/system"
-#define LENGTH			(3UL<<30)
-#define TESTMEM			(1UL<<30)
-#define MB			(1UL<<20)
-#define NORMAL			1
-#define MLOCK			2
-#define KSM			3
-#define SYSFS_OVER		"/proc/sys/vm/overcommit_memory"
-
-static char overcommit[BUFSIZ];
-
-static void setup(void);
-static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
-static void oom(int testcase, int mempolicy, int lite);
-static long count_numa(void);
-static int path_exist(const char *path, ...);
-static void testoom(int mempolicy, int lite);
-static void alloc_mem(long int length, int testcase);
-static void test_alloc(int testcase, int lite);
-static void gather_cpus(char *cpus);
-static void umount_mem(char *path, char *path_new);
-static void mount_mem(char *name, char *fs, char *options, char *path,
-		char *path_new);
+#include "../include/mem.h"
 
 int main(int argc, char *argv[])
 {
@@ -113,9 +73,7 @@ int main(int argc, char *argv[])
 			tst_brkm(TBROK|TERRNO, cleanup, "write");
 		close(fd);
 
-		snprintf(buf, BUFSIZ, "%s/memory.limit_in_bytes",
-			MEMCG_PATH_NEW);
-		fd = open(buf, O_WRONLY);
+		fd = open(MEMCG_PATH_NEW "/memory.limit_in_bytes", O_WRONLY);
 		if (fd == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
 		sprintf(mem, "%ld", TESTMEM);
@@ -123,8 +81,7 @@ int main(int argc, char *argv[])
 			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 		close(fd);
 
-		snprintf(buf, BUFSIZ, "%s/tasks", MEMCG_PATH_NEW);
-		fd = open(buf, O_WRONLY);
+		fd = open(MEMCG_PATH_NEW "/tasks", O_WRONLY);
 		if (fd == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
 		snprintf(buf, BUFSIZ, "%d", getpid());
@@ -135,9 +92,8 @@ int main(int argc, char *argv[])
 		tst_resm(TINFO, "process mempolicy.");
 		testoom(1, 0, 1);
 
-		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
-			MEMCG_PATH_NEW);
-		fd = open(buf, O_WRONLY);
+		fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
+			O_WRONLY);
 		if (fd == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
 		if (write(fd, mem, strlen(mem)) != strlen(mem))
@@ -146,9 +102,8 @@ int main(int argc, char *argv[])
 		testoom(1, 1, 1);
 
 		tst_resm(TINFO, "process cpuset.");
-		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
-			MEMCG_PATH_NEW);
-		fd = open(buf, O_WRONLY);
+		fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
+			O_WRONLY);
 		if (fd == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
 		sprintf(mem, "%ld", TESTMEM);
@@ -157,9 +112,8 @@ int main(int argc, char *argv[])
 		close(fd);
 		testoom(0, 0, 1);
 
-		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
-			MEMCG_PATH_NEW);
-		fd = open(buf, O_WRONLY);
+		fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
+			O_WRONLY);
 		if (fd == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
 		if (write(fd, mem, strlen(mem)) != strlen(mem))
@@ -168,52 +122,6 @@ int main(int argc, char *argv[])
 		testoom(0, 1, 1);
 	}
 	cleanup();
-	tst_exit();
-}
-
-void testoom(int mempolicy, int lite)
-{
-	int fd;
-	char buf[BUFSIZ] = "";
-	char cpus[BUFSIZ] = "";
-
-	if (!mempolicy) {
-		gather_cpus(cpus);
-		tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
-
-		snprintf(buf, BUFSIZ, "%s/cpuset.mems", CPATH_NEW);
-		fd = open(buf, O_WRONLY);
-		if (fd == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
-		if (write(fd, "1", 1) != 1)
-			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
-		close(fd);
-
-		snprintf(buf, BUFSIZ, "%s/cpuset.cpus", CPATH_NEW);
-		fd = open(buf, O_WRONLY);
-		if (fd == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
-		if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
-			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
-		close(fd);
-
-		snprintf(buf, BUFSIZ, "%s/tasks", CPATH_NEW);
-		fd = open(buf, O_WRONLY);
-		if (fd == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
-		snprintf(buf, BUFSIZ, "%d", getpid());
-		if (write(fd, buf, strlen(buf)) != strlen(buf))
-			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
-		close(fd);
-	}
-	tst_resm(TINFO, "start normal OOM testing.");
-	oom(NORMAL, mempolicy, lite);
-
-	tst_resm(TINFO, "start OOM testing for mlocked pages.");
-	oom(MLOCK, mempolicy, lite);
-
-	tst_resm(TINFO, "start OOM testing for KSM pages.");
-	oom(KSM, mempolicy, lite);
 }
 
 void setup(void)
@@ -236,50 +144,6 @@ void setup(void)
 	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
 }
 
-void umount_mem(char *path, char *path_new)
-{
-	FILE *fp;
-	int fd;
-	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
-
-	/* Move all processes in task to its parent node. */
-	snprintf(s, BUFSIZ, "%s/tasks", path);
-	fd = open(s, O_WRONLY);
-	if (fd == -1)
-		tst_resm(TWARN|TERRNO, "open %s", s);
-	snprintf(s_new, BUFSIZ, "%s/tasks", path_new);
-
-	fp = fopen(s_new, "r");
-	if (fp == NULL)
-		tst_resm(TWARN|TERRNO, "fopen %s", s_new);
-	if ((fd != -1) && (fp != NULL)) {
-		while (fgets(value, BUFSIZ, fp) != NULL)
-			if (write(fd, value, strlen(value) - 1)
-				!= strlen(value) - 1)
-				tst_resm(TWARN|TERRNO, "write %s", s);
-	}
-	if (fd != -1)
-		close(fd);
-	if (fp != NULL)
-		fclose(fp);
-	if (rmdir(path_new) == -1)
-		tst_resm(TWARN|TERRNO, "rmdir %s", path_new);
-	if (umount(path) == -1)
-		tst_resm(TWARN|TERRNO, "umount %s", path);
-	if (rmdir(path) == -1)
-		tst_resm(TWARN|TERRNO, "rmdir %s", path);
-}
-
-void mount_mem(char *name, char *fs, char *options, char *path, char *path_new)
-{
-	if (mkdir(path, 0777) == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", path);
-	if (mount(name, path, fs, 0, options) == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "mount %s", path);
-	if (mkdir(path_new, 0777) == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", path_new);
-}
-
 void cleanup(void)
 {
 	int fd;
@@ -295,105 +159,13 @@ void cleanup(void)
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 
 	TEST_CLEANUP;
-}
-
-void oom(int testcase, int mempolicy, int lite)
-{
-	pid_t pid;
-	int status;
-	unsigned long nmask = 2;
-
-	switch(pid = fork()) {
-	case -1:
-		tst_brkm(TBROK|TERRNO, cleanup, "fork");
-	case 0:
-		if (mempolicy)
-			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
-				tst_brkm(TBROK|TERRNO, cleanup,
-					"set_mempolicy");
-
-		test_alloc(testcase, lite);
-		exit(0);
-	default:
-		break;
-	}
-	tst_resm(TINFO, "expected victim is %d.", pid);
-	if (waitpid(-1, &status, 0) == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
-
-	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
-		tst_resm(TFAIL, "the victim unexpectedly failed: %d", status);
-}
-
-long count_numa(void)
-{
-	int nnodes = 0;
-
-	while(path_exist(_PATH_SYS_SYSTEM "/node/node%d", nnodes))
-		nnodes++;
-
-	return nnodes;
-}
-
-int path_exist(const char *path, ...)
-{
-	va_list ap;
-	char pathbuf[PATH_MAX];
-
-	va_start(ap, path);
-	vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
-	va_end(ap);
-
-	return access(pathbuf, F_OK) == 0;
-}
-
-void gather_cpus(char *cpus)
-{
-	int ncpus = 0;
-	int i;
-	char buf[BUFSIZ];
-
-	while(path_exist(_PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
-		ncpus++;
-
-	for (i = 0; i < ncpus; i++)
-		if (path_exist(_PATH_SYS_SYSTEM "/node/node1/cpu%d", i)) {
-			sprintf(buf, "%d,", i);
-			strcat(cpus, buf);
-		}
-	/* Remove the trailing comma. */
-	cpus[strlen(cpus) - 1] = '\0';
-}
-
-void alloc_mem(long int length, int testcase)
-{
-	void *s;
-
-	tst_resm(TINFO, "allocating %ld bytes.", length);
-	s = mmap(NULL, length, PROT_READ|PROT_WRITE,
-		MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
-	if (s == MAP_FAILED) {
-			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
-	}
-	if (testcase == MLOCK && mlock(s, length) == -1)
-		tst_brkm(TINFO|TERRNO, cleanup, "mlock");
-	if (testcase == KSM
-		&& madvise(s, length, MADV_MERGEABLE) == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "madvise");
-	memset(s, '\a', length);
-}
-
-void test_alloc(int testcase, int lite)
-{
-	if (lite)
-		alloc_mem(TESTMEM + MB, testcase);
-	else
-		while(1)
-			alloc_mem(LENGTH, testcase);
+	tst_exit();
 }
 
 #else /* no NUMA */
-int main(void) {
-	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+int main(void)
+{
+	tst_resm(TCONF, "no NUMA development packages installed.");
+	tst_exit();
 }
 #endif
-- 
1.7.3.2
------=_Part_56179_1044964947.1295424713617
Content-Type: text/x-patch; name=0001-rework-code-for-oom-and-ksm-tests.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-rework-code-for-oom-and-ksm-tests.patch

RnJvbSAwOGY1NWM2NzAyOGRkZTE5YWRkYzQxYzQ5YTk1ZmRmMzdhZjMzMDBlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBX
ZWQsIDE5IEphbiAyMDExIDE1OjQ4OjQxICswODAwClN1YmplY3Q6IFtQQVRDSF0gcmV3b3JrIGNv
ZGUgZm9yIG9vbSBhbmQga3NtIHRlc3RzCgpNYWlubHkgdG8gcmVkdWNlIGNvZGUgZHVwbGljYXRp
b24uIEFsc28sIHRvIGFkZCBhbiBvcHRpb24gZm9yIGtzbTAxIHRvCnVzZSBhIGRpZmZlcmVudCBt
ZW1vcnkgYWxsb2NhdGlvbiB1bml0IHNpemUgdG8gdGFrZSBhZHZhbnRhZ2Ugb2YgVEhQLgpJbiBh
ZGRpdGlvbiwgYWRqdXN0IGtzbTAxIGFjY29yZGluZyB0aGUgbGF0ZXN0IHVwc3RyZWFtIGRldmVs
b3BtZW50CmVmZm9ydCwKaHR0cDovL21hcmMuaW5mby8/bD1saW51eC1tbSZtPTEyOTQ3MzEwNDcx
NjkwMSZ3PTIKaHR0cDovL21hcmMuaW5mby8/bD1saW51eC1tbSZtPTEyOTQ0MjcxODgwODczMyZ3
PTIKClNpZ25lZC1vZmYtYnk6IENBSSBRaWFuIDxjYWlxaWFuQHJlZGhhdC5jb20+Ci0tLQogdGVz
dGNhc2VzL2tlcm5lbC9tZW0vaW5jbHVkZS9tZW0uaCB8ICAgNTAgKysrCiB0ZXN0Y2FzZXMva2Vy
bmVsL21lbS9rc20vTWFrZWZpbGUgIHwgICAyMyArKy0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL2tz
bS9rc20wMS5jICAgfCAgNDYxICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9r
ZXJuZWwvbWVtL2xpYi9NYWtlZmlsZSAgfCAgIDI1ICsrCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9s
aWIvbWVtLmMgICAgIHwgIDY1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysK
IHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9NYWtlZmlsZSAgfCAgICA2ICstCiB0ZXN0Y2FzZXMv
a2VybmVsL21lbS9vb20vb29tMDEuYyAgIHwgICAgNSArLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0v
b29tL29vbTAyLmMgICB8ICAgIDQgKy0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMy5j
ICAgfCAgICA1ICstCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDQuYyAgIHwgIDI1NiAr
LS0tLS0tLS0tLS0tLQogMTAgZmlsZXMgY2hhbmdlZCwgNzg2IGluc2VydGlvbnMoKyksIDcwMCBk
ZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL21lbS9pbmNs
dWRlL21lbS5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9tZW0vbGliL01h
a2VmaWxlCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9tZW0vbGliL21lbS5j
CgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaW5jbHVkZS9tZW0uaCBiL3Rlc3Rj
YXNlcy9rZXJuZWwvbWVtL2luY2x1ZGUvbWVtLmgKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXgg
MDAwMDAwMC4uNzc4ZDQwMwotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L2luY2x1ZGUvbWVtLmgKQEAgLTAsMCArMSw1MCBAQAorI2lmbmRlZiBfTUVNX0gKKyNkZWZpbmUg
X01FTV9ICisjaW5jbHVkZSAidGVzdC5oIgorI2luY2x1ZGUgInVzY3Rlc3QuaCIKKworI2RlZmlu
ZSBMRU5HVEgJCQkoM1VMPDwzMCkKKyNkZWZpbmUgU1lTRlNfT1ZFUgkJIi9wcm9jL3N5cy92bS9v
dmVyY29tbWl0X21lbW9yeSIKKyNkZWZpbmUgT1ZFUkNPTU1JVAkJMQorI2RlZmluZSBOT1JNQUwJ
CQkyCisjZGVmaW5lIE1MT0NLCQkJMworI2RlZmluZSBLU00JCQk0CisjZGVmaW5lIENQQVRICQkJ
Ii9kZXYvY3B1c2V0IgorI2RlZmluZSBDUEFUSF9ORVcJCUNQQVRIICIvMSIKKyNkZWZpbmUgTUFY
Tk9ERVMJCTUxMgorI2RlZmluZSBNRU1DR19QQVRICQkiL2Rldi9jZ3JvdXAiCisjZGVmaW5lIE1F
TUNHX1BBVEhfTkVXCQlNRU1DR19QQVRIICIvMSIKKyNkZWZpbmUgVEVTVE1FTQkJCSgxVUw8PDMw
KQorI2RlZmluZSBNQgkJCSgxVUw8PDIwKQorI2RlZmluZSBQQVRIX1NZU19TWVNURU0JCSIvc3lz
L2RldmljZXMvc3lzdGVtIgorI2RlZmluZSBQQVRIX0tTTQkJIi9zeXMva2VybmVsL21tL2tzbS8i
CisKK2NoYXIgb3ZlcmNvbW1pdFtCVUZTSVpdOworaW50IG9wdF9udW0sIG9wdF9zaXplLCBvcHRf
dW5pdDsKK2NoYXIgKm9wdF9udW1zdHIsICpvcHRfc2l6ZXN0ciwgKm9wdF91bml0c3RyOworLyog
bWVtb3J5IHBvaW50ZXIgdG8gaWRlbnRpZnkgcGVyIHByb2Nlc3MsIE1CIHVuaXQsIGFuZCBieXRl
IGxpa2UKKyAgIG1lbW9yeVtwcm9jZXNzIE5vLl1bTUIgdW5pdCBOby5dW2J5dGUgTm8uXS4gKi8K
K2NoYXIgKioqbWVtb3J5OworCit2b2lkIG9vbShpbnQgdGVzdGNhc2UsIGludCBtZW1wb2xpY3ks
IGludCBsaXRlKTsKK3ZvaWQgdGVzdG9vbShpbnQgbWVtcG9saWN5LCBpbnQgbGl0ZSwgaW50IG51
bWEpOworbG9uZyBjb3VudF9udW1hKHZvaWQpOworaW50IHBhdGhfZXhpc3QoY29uc3QgY2hhciAq
cGF0aCwgLi4uKTsKK2ludCBhbGxvY19tZW0obG9uZyBpbnQgbGVuZ3RoLCBpbnQgdGVzdGNhc2Up
Owordm9pZCB0ZXN0X2FsbG9jKGludCB0ZXN0Y2FzZSwgaW50IGxpdGUpOwordm9pZCBnYXRoZXJf
Y3B1cyhjaGFyICpjcHVzKTsKK3ZvaWQgdW1vdW50X21lbShjaGFyICpwYXRoLCBjaGFyICpwYXRo
X25ldyk7Cit2b2lkIG1vdW50X21lbShjaGFyICpuYW1lLCBjaGFyICpmcywgY2hhciAqb3B0aW9u
cywgY2hhciAqcGF0aCwgY2hhciAqcGF0aF9uZXcpOwordm9pZCBjbGVhbnVwKHZvaWQpOwordm9p
ZCBzZXR1cCh2b2lkKTsKK3ZvaWQga3NtX3VzYWdlKHZvaWQpOwordm9pZCBjaGVjayhjaGFyICpw
YXRoLCBsb25nIGludCB2YWx1ZSk7Cit2b2lkIHZlcmlmeShjaGFyIHZhbHVlLCBpbnQgcHJvYywg
aW50IHN0YXJ0LCBpbnQgZW5kLCBpbnQgc3RhcnQyLCBpbnQgZW5kMik7Cit2b2lkIGdyb3VwX2No
ZWNrKGludCBydW4sIGludCBwYWdlc19zaGFyZWQsIGludCBwYWdlc19zaGFyaW5nLAorCQlpbnQg
cGFnZXNfdm9sYXRpbGUsIGludCBwYWdlc191bnNoYXJlZCwgaW50IHNsZWVwX21pbGxpc2VjcywK
KwkJaW50IHBhZ2VzX3RvX3NjYW4pOwordm9pZCBjcmVhdGVfc2FtZV9tZW1vcnkoaW50IHNpemUs
IGludCBudW0sIGludCB1bml0KTsKK3ZvaWQgY2hlY2tfa3NtX29wdGlvbnMoaW50ICpzaXplLCBp
bnQgKm51bSwgaW50ICp1bml0KTsKK3ZvaWQgd3JpdGVfY3B1c2V0cyh2b2lkKTsKK3ZvaWQgd3Jp
dGVfbWVtY2codm9pZCk7CisjZW5kaWYKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L2tzbS9NYWtlZmlsZSBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2tzbS9NYWtlZmlsZQppbmRleCAz
NjM0NTcwLi44MTUwOWJmIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20vTWFr
ZWZpbGUKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0va3NtL01ha2VmaWxlCkBAIC0xOCw1ICsx
OCwyNiBAQAogCiB0b3Bfc3JjZGlyICAgICAgICAgICAgICA/PSAuLi8uLi8uLi8uLgogCitpbmNs
dWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9lbnZfcHJlLm1rCisKK0xETElCUwkJCSs9ICQo
TlVNQV9MSUJTKSAtbG1lbQorTElCRElSCQkJOj0gLi4vbGliCitMSUIJCQk6PSAkKExJQkRJUikv
bGlibWVtLmEKK0ZJTFRFUl9PVVRfRElSUwkJOj0gJChMSUJESVIpCitMREZMQUdTCQkJKz0gLUwk
KExJQkRJUikKKworJChMSUJESVIpOgorCW1rZGlyIC1wICIkQCIKKworJChMSUIpOiAkKExJQkRJ
UikKKwkkKE1BS0UpIC1DICReIC1mICIkKGFic19zcmNkaXIpLyReL01ha2VmaWxlIiBhbGwKKwor
TUFLRV9ERVBTCQk6PSAkKExJQikKKwordHJ1bmstY2xlYW46OiB8IGxpYi1jbGVhbgorCitsaWIt
Y2xlYW46OiAkKExJQkRJUikKKwkkKE1BS0UpIC1DICReIC1mICIkKGFic19zcmNkaXIpLyReL01h
a2VmaWxlIiBjbGVhbgorCitpbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9nZW5lcmlj
X3RydW5rX3RhcmdldC5tawogaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvdGVzdGNh
c2VzLm1rCi1pbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9nZW5lcmljX2xlYWZfdGFy
Z2V0Lm1rCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3NtMDEuYyBiL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2tzbS9rc20wMS5jCmluZGV4IDA5ZjcxZDcuLmUxYzdkN2YgMTAw
NjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2tzbS9rc20wMS5jCisrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvbWVtL2tzbS9rc20wMS5jCkBAIC0xLDUgKzEsNSBAQAogLyoKLSAqIGZ1bmN0aW9u
YWwgdGVzdGluZyBmb3IgS2VybmVsIFNhbWVwYWdlIE1lcmdpbmcgKEtTTSkKKyAqIEtlcm5lbCBT
YW1lcGFnZSBNZXJnaW5nIChLU00pCiAgKgogICogQmFzaWMgdGVzdHMgd2VyZSB0byBzdGFydCBz
ZXZlcmFsIHByb2dyYW1zIHdpdGggc2FtZSBhbmQgZGlmZmVyZW50CiAgKiBtZW1vcnkgY29udGVu
dHMgYW5kIGVuc3VyZSBvbmx5IHRvIG1lcmdlIHRoZSBvbmVzIHdpdGggdGhlIHNhbWUKQEAgLTY5
LDQ3MSArNjksNDYgQEAKICNpbmNsdWRlIDxlcnJuby5oPgogI2luY2x1ZGUgInRlc3QuaCIKICNp
bmNsdWRlICJ1c2N0ZXN0LmgiCi0KLSNkZWZpbmUgX1BBVEhfS1NNCSIvc3lzL2tlcm5lbC9tbS9r
c20vIgotI2RlZmluZSBNQgkJKDEwMjQgKiAxMDI0KQorI2luY2x1ZGUgIi4uL2luY2x1ZGUvbWVt
LmgiCiAKIGNoYXIgKlRDSUQgPSAia3NtMDEiOwogaW50IFRTVF9UT1RBTCA9IDE7Ci1zdGF0aWMg
aW50IG9wdF9udW0sIG9wdF9zaXplOwotc3RhdGljIGNoYXIgKm9wdF9udW1zdHIsICpvcHRfc2l6
ZXN0cjsKLS8qIG1lbW9yeSBwb2ludGVyIHRvIGlkZW50aWZ5IHBlciBwcm9jZXNzLCBNQiwgYW5k
IGJ5dGUgbGlrZQotICAgbWVtb3J5W3Byb2Nlc3MgTm8uXVtNQiBOby5dW2J5dGUgTm8uXS4gKi8K
LXN0YXRpYyBjaGFyICoqKm1lbW9yeTsKLXN0YXRpYyBvcHRpb25fdCBvcHRpb25zW10gPSB7Ci0J
eyAibjoiLCAmb3B0X251bSwJJm9wdF9udW1zdHJ9LAotCXsgInM6IiwgJm9wdF9zaXplLAkmb3B0
X3NpemVzdHJ9LAotCXsgTlVMTCwgTlVMTCwJCU5VTEx9CisKK29wdGlvbl90IGtzbV9vcHRpb25z
W10gPSB7CisgICAgICAgIHsgIm46IiwgJm9wdF9udW0sICAgICAgICZvcHRfbnVtc3RyfSwKKyAg
ICAgICAgeyAiczoiLCAmb3B0X3NpemUsICAgICAgJm9wdF9zaXplc3RyfSwKKyAgICAgICAgeyAi
dToiLCAmb3B0X3VuaXQsICAgICAgJm9wdF91bml0c3RyfSwKKyAgICAgICAgeyBOVUxMLCBOVUxM
LCAgICAgICAgICAgTlVMTH0KIH07Ci1zdGF0aWMgdm9pZCBzZXR1cCh2b2lkKTsKLXN0YXRpYyB2
b2lkIGtzbXRlc3Qodm9pZCk7Ci1zdGF0aWMgdm9pZCB1c2FnZSh2b2lkKTsKLXN0YXRpYyB2b2lk
IGNoZWNrKGNoYXIgKnBhdGgsIGNoYXIgKnBhdGgyLCBsb25nIGludCB2YWx1ZSk7Ci1zdGF0aWMg
dm9pZCB2ZXJpZnkoY2hhciB2YWx1ZSwgaW50IHByb2MsIGludCBzdGFydCwgaW50IGVuZCwgaW50
IHN0YXJ0MiwKLQkJaW50IGVuZDIpOwotc3RhdGljIHZvaWQgZ3JvdXBfY2hlY2soaW50IHJ1biwg
aW50IHBhZ2VzX3NoYXJlZCwgaW50IHBhZ2VzX3NoYXJpbmcsCi0JCQlpbnQgcGFnZXNfdm9sYXRp
bGUsIGludCBwYWdlc191bnNoYXJlZCwKLQkJCWludCBzbGVlcF9taWxsaXNlY3MsIGludCBwYWdl
c190b19zY2FuKTsKIAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIHsKIAlpbnQg
bGM7CiAJY2hhciAqbXNnOworCWludCBzaXplID0gMTI4LCBudW0gPSAzLCB1bml0ID0gMTsKIAot
CW1zZyA9IHBhcnNlX29wdHMoYXJnYywgYXJndiwgb3B0aW9ucywgdXNhZ2UpOwotCWlmIChtc2cg
IT0gKGNoYXIgKilOVUxMKQotCQl0c3RfYnJrbShUQlJPSywgTlVMTCwgIk9QVElPTiBQQVJTSU5H
IEVSUk9SIC0gJXMiLCBtc2cpOworCW1zZyA9IHBhcnNlX29wdHMoYXJnYywgYXJndiwga3NtX29w
dGlvbnMsIGtzbV91c2FnZSk7CisJaWYgKG1zZyAhPSBOVUxMKQorCQl0c3RfYnJrbShUQlJPSywg
dHN0X2V4aXQsICJPUFRJT04gUEFSU0lORyBFUlJPUiAtICVzIiwgbXNnKTsKIAlzZXR1cCgpOwog
CWZvciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyBsYysrKSB7CiAJCVRzdF9jb3VudCA9IDA7
Ci0JCWtzbXRlc3QoKTsKKwkJY2hlY2tfa3NtX29wdGlvbnMoJnNpemUsICZudW0sICZ1bml0KTsK
KwkJY3JlYXRlX3NhbWVfbWVtb3J5KHNpemUsIG51bSwgdW5pdCk7CiAJfQorCWNsZWFudXAoKTsK
IAl0c3RfZXhpdCgpOwogfQogCi12b2lkIGtzbXRlc3Qodm9pZCkKLXsKLQljaGFyIGJ1ZltCVUZT
SVpdLCBidWYyW0JVRlNJWl07Ci0JaW50IGksIGosIHN0YXR1cywgaywgZmQsICpjaGlsZDsKLQlp
bnQgc2l6ZSA9IDEyOCwgbnVtID0gMzsKLQotCWlmIChvcHRfc2l6ZSkgewotCQlzaXplID0gYXRv
aShvcHRfc2l6ZXN0cik7Ci0JCWlmIChzaXplIDwgMSkKLQkJCXRzdF9icmttKFRCUk9LLCBOVUxM
LAotCQkJCSJzaXplIGNhbm5vdCBiZSBsZXNzIHRoYW4gMS4iKTsKLQl9Ci0JaWYgKG9wdF9udW0p
IHsKLQkJbnVtID0gYXRvaShvcHRfbnVtc3RyKTsKLQkJaWYgKG51bSA8IDMpCi0JCQl0c3RfYnJr
bShUQlJPSywgTlVMTCwKLQkJCQkicHJvY2VzcyBudW1iZXIgY2Fubm90IGJlIGxlc3MgMy4iKTsK
LQl9Ci0JY2hpbGQgPSBtYWxsb2MobnVtKTsKLQlpZiAoY2hpbGQgPT0gTlVMTCkKLQkJdHN0X2Jy
a20oVEJST0t8VEVSUk5PLCBOVUxMLCAibWFsbG9jIik7Ci0KLQltZW1vcnkgPSBtYWxsb2MobnVt
ICogc2l6ZW9mKCoqbWVtb3J5KSk7Ci0JaWYgKG1lbW9yeSA9PSBOVUxMKQotCQl0c3RfYnJrbShU
QlJPS3xURVJSTk8sIE5VTEwsICJtYWxsb2MiKTsKLQotCXN3aXRjaCAoY2hpbGRbMF0gPSBmb3Jr
KCkpIHsKLQljYXNlIC0xOgotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJmb3JrIik7
Ci0JY2FzZSAwOgotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDAgc3RvcHMuIik7Ci0JCWlmIChy
YWlzZShTSUdTVE9QKSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtp
bGwiKTsKLQotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDAgY29udGludWVzLi4uIik7Ci0KLQkJ
LyogQXZvaWQgVHJhbnNwYXJlbnRIdWdlUGFnZSBhbGxvY2F0aW9uIHdoaWNoIGNhbid0IGtzbSBh
dCB0aGUKLQkJICAgbW9tZW50LiAqLwotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDAgYWxsb2Nh
dGVzICVkIE1CIGZpbGxlZCB3aXRoICdjJy4iLAotCQkJc2l6ZSk7Ci0JCW1lbW9yeVswXSA9IG1h
bGxvYyhzaXplICogc2l6ZW9mKCptZW1vcnkpKTsKLQkJaWYgKG1lbW9yeVswXSA9PSBOVUxMKQot
CQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAibWFsbG9jIik7Ci0JCWZvciAoaiA9IDA7
IGogPCBzaXplOyBqKyspIHsKLQkJCW1lbW9yeVswXVtqXSA9IG1tYXAoTlVMTCwgTUIsIFBST1Rf
UkVBRHxQUk9UX1dSSVRFLAotCQkJCQlNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFLCAtMSwgMCk7
Ci0JCQlpZiAobWVtb3J5WzBdW2pdID09IE1BUF9GQUlMRUQpCi0JCQkJdHN0X2Jya20oVEJST0t8
VEVSUk5PLCBOVUxMLCAibW1hcCIpOwotCQkJaWYgKG1hZHZpc2UobWVtb3J5WzBdW2pdLCBNQiwg
TUFEVl9NRVJHRUFCTEUpID09IC0xKQotCQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwg
Im1hZHZpc2UiKTsKLQkJCWZvciAoaSA9IDA7IGkgPCBNQjsgaSsrKQotCQkJCW1lbW9yeVswXVtq
XVtpXSA9ICdjJzsKLQkJfQotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDAgc3RvcHMuIik7Ci0J
CWlmIChyYWlzZShTSUdTVE9QKSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVM
TCwgImtpbGwiKTsKLQotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDAgY29udGludWVzLi4uIik7
Ci0JCXZlcmlmeSgnYycsIDAsIDAsIHNpemUsIDAsIE1CKTsKLQkJdHN0X3Jlc20oVElORk8sICJj
aGlsZCAwIGNoYW5nZXMgbWVtb3J5IGNvbnRlbnQgdG8gJ2QnLiIpOwotCQlmb3IgKGogPSAwOyBq
IDwgc2l6ZTsgaisrKSB7Ci0JCQlmb3IgKGkgPSAwOyBpIDwgTUI7IGkrKykKLQkJCQltZW1vcnlb
MF1bal1baV0gPSAnZCc7Ci0JCX0KLQkJLyogVW5tZXJnZS4gKi8KLQkJdHN0X3Jlc20oVElORk8s
ICJjaGlsZCAwIHN0b3BzLiIpOwotCQlpZiAocmFpc2UoU0lHU1RPUCkgPT0gLTEpCi0JCQl0c3Rf
YnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJraWxsIik7Ci0KLQkJdHN0X3Jlc20oVElORk8sICJj
aGlsZCAwIGNvbnRpbnVlcy4uLiIpOwotCQl2ZXJpZnkoJ2QnLCAwLCAwLCBzaXplLCAwLCBNQik7
Ci0JCS8qIFN0b3AuICovCi0JCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMCBzdG9wcy4iKTsKLQkJ
aWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQotCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxM
LCAia2lsbCIpOwotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDAgY29udGludWVzLi4uIik7Ci0J
CWV4aXQoMCk7Ci0JfQotCXN3aXRjaCAoY2hpbGRbMV0gPSBmb3JrKCkpIHsKLQljYXNlIC0xOgot
CQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJmb3JrIik7Ci0JY2FzZSAwOgotCQl0c3Rf
cmVzbShUSU5GTywgImNoaWxkIDEgc3RvcHMuIik7Ci0JCWlmIChyYWlzZShTSUdTVE9QKSA9PSAt
MSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwiKTsKLQkJdHN0X3Jlc20o
VElORk8sICJjaGlsZCAxIGNvbnRpbnVlcy4uLiIpOwotCQl0c3RfcmVzbShUSU5GTywgImNoaWxk
IDEgYWxsb2NhdGVzICVkIE1CIGZpbGxlZCB3aXRoICdhJy4iLAotCQkJc2l6ZSk7Ci0JCW1lbW9y
eVsxXSA9IG1hbGxvYyhzaXplICogc2l6ZW9mKCptZW1vcnkpKTsKLQkJaWYgKG1lbW9yeVsxXSA9
PSBOVUxMKQotCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAibWFsbG9jIik7Ci0JCWZv
ciAoaiA9IDA7IGogPCBzaXplOyBqKyspIHsKLQkJCW1lbW9yeVsxXVtqXSA9IG1tYXAoTlVMTCwg
TUIsIFBST1RfUkVBRHxQUk9UX1dSSVRFLAotCQkJCQlNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRF
LCAtMSwgMCk7Ci0JCQlpZiAobWVtb3J5WzFdW2pdID09IE1BUF9GQUlMRUQpCi0JCQkJdHN0X2Jy
a20oVEJST0t8VEVSUk5PLCBOVUxMLCAibW1hcCIpOwotCQkJaWYgKG1hZHZpc2UobWVtb3J5WzFd
W2pdLCBNQiwgTUFEVl9NRVJHRUFCTEUpID09IC0xKQotCQkJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgTlVMTCwgIm1hZHZpc2UiKTsKLQkJCWZvciAoaSA9IDA7IGkgPCBNQjsgaSsrKQotCQkJCW1l
bW9yeVsxXVtqXVtpXSA9ICdhJzsKLQkJfQotCi0JCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMSBz
dG9wcy4iKTsKLQkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQotCQkJdHN0X2Jya20oVEJST0t8
VEVSUk5PLCBOVUxMLCAia2lsbCIpOwotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgY29udGlu
dWVzLi4uIik7Ci0JCXZlcmlmeSgnYScsIDEsIDAsIHNpemUsIDAsIE1CKTsKLQkJdHN0X3Jlc20o
VElORk8sICJjaGlsZCAxIGNoYW5nZXMgbWVtb3J5IGNvbnRlbnQgdG8gJ2InLiIpOwotCQlmb3Ig
KGogPSAwOyBqIDwgc2l6ZTsgaisrKSB7Ci0JCQlmb3IgKGkgPSAwOyBpIDwgTUI7IGkrKykKLQkJ
CQltZW1vcnlbMV1bal1baV0gPSAnYic7Ci0JCX0KLQotCQl0c3RfcmVzbShUSU5GTywgImNoaWxk
IDEgc3RvcHMuIik7Ci0JCWlmIChyYWlzZShTSUdTVE9QKSA9PSAtMSkKLQkJCXRzdF9icmttKFRC
Uk9LfFRFUlJOTywgTlVMTCwgImtpbGwiKTsKLQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAxIGNv
bnRpbnVlcy4uLiIpOwotCQl2ZXJpZnkoJ2InLCAxLCAwLCBzaXplLCAwLCBNQik7Ci0JCXRzdF9y
ZXNtKFRJTkZPLCAiY2hpbGQgMSBjaGFuZ2VzIG1lbW9yeSBjb250ZW50IHRvICdkJyIpOwotCQlm
b3IgKGogPSAwOyBqIDwgc2l6ZTsgaisrKSB7Ci0JCQlmb3IgKGkgPSAwOyBpIDwgTUI7IGkrKykK
LQkJCQltZW1vcnlbMV1bal1baV0gPSAnZCc7Ci0JCX0KLQkJaWYgKHJhaXNlKFNJR1NUT1ApID09
IC0xKQotCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAia2lsbCIpOwotCi0JCXRzdF9y
ZXNtKFRJTkZPLCAiY2hpbGQgMSBjb250aW51ZXMuLi4iKTsKLQkJdmVyaWZ5KCdkJywgMSwgMCwg
c2l6ZSwgMCwgTUIpOwotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgY2hhbmdlcyBvbmUgcGFn
ZSB0byAnZScuIik7Ci0JCW1lbW9yeVsxXVtzaXplIC0gMV1bTUIgLSAxXSA9ICdlJzsKLQotCQkv
KiBVbm1lcmdlLiAqLwotCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgc3RvcHMuIik7Ci0JCWlm
IChyYWlzZShTSUdTVE9QKSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwg
ImtpbGwiKTsKLQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAxIGNvbnRpbnVlcy4uLiIpOwotCQl2
ZXJpZnkoJ2UnLCAxLCBzaXplIC0gMSwgc2l6ZSwgTUIgLSAxLCBNQik7Ci0JCXZlcmlmeSgnZCcs
IDEsIDAsIHNpemUgLSAxLCAwLCBNQiAtIDEpOwotCi0JCS8qIFN0b3AuICovCi0JCXRzdF9yZXNt
KFRJTkZPLCAiY2hpbGQgMSBzdG9wcy4iKTsKLQkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQot
CQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAia2lsbCIpOwotCQl0c3RfcmVzbShUSU5G
TywgImNoaWxkIDEgY29udGludWVzLi4uIik7Ci0JCWV4aXQoMCk7Ci0JfQotCWZvciAoayA9IDI7
IGsgPCBudW07IGsrKykgewotCQlzd2l0Y2ggKGNoaWxkW2tdID0gZm9yaygpKSB7Ci0JCWNhc2Ug
LTE6Ci0JCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJmb3JrIik7Ci0JCWNhc2UgMDoK
LQkJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgc3RvcHMuIiwgayk7Ci0JCQlpZiAocmFpc2Uo
U0lHU1RPUCkgPT0gLTEpCi0JCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAia2lsbCIp
OwotCQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAlZCBjb250aW51ZXMuLi4iLCBrKTsKLQkJCXRz
dF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgYWxsb2NhdGVzICVkICIKLQkJCQkiTUIgZmlsbGVkIHdp
dGggJ2EnLiIsIGssIHNpemUpOwotCQkJbWVtb3J5W2tdID0gbWFsbG9jKHNpemUgKiBzaXplb2Yo
Km1lbW9yeSkpOwotCQkJaWYgKG1lbW9yeVtrXSA9PSBOVUxMKQotCQkJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgTlVMTCwgIm1hbGxvYyIpOwotCQkJZm9yIChqID0gMDsgaiA8IHNpemU7IGorKykg
ewotCQkJCW1lbW9yeVtrXVtqXSA9IG1tYXAoTlVMTCwgTUIsCi0JCQkJCQlQUk9UX1JFQUR8UFJP
VF9XUklURSwKLQkJCQkJCU1BUF9BTk9OWU1PVVMKLQkJCQkJCXxNQVBfUFJJVkFURSwgLTEsIDAp
OwotCQkJCWlmIChtZW1vcnlba11bal0gPT0gTUFQX0ZBSUxFRCkKLQkJCQkJdHN0X2Jya20oVEJS
T0t8VEVSUk5PLCBOVUxMLAotCQkJCQkJIm1tYXAiKTsKLQkJCQlpZiAobWFkdmlzZShtZW1vcnlb
a11bal0sIE1CLAotCQkJCQkJTUFEVl9NRVJHRUFCTEUpID09IC0xKQotCQkJCQl0c3RfYnJrbShU
QlJPS3xURVJSTk8sIE5VTEwsCi0JCQkJCQkibWFkdmlzZSIpOwotCQkJCWZvciAoaSA9IDA7IGkg
PCBNQjsgaSsrKQotCQkJCQltZW1vcnlba11bal1baV0gPSAnYSc7Ci0JCQl9Ci0JCQl0c3RfcmVz
bShUSU5GTywgImNoaWxkICVkIHN0b3BzLiIsIGspOwotCQkJaWYgKHJhaXNlKFNJR1NUT1ApID09
IC0xKQotCQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImtpbGwiKTsKLQkJCXRzdF9y
ZXNtKFRJTkZPLCAiY2hpbGQgJWQgY29udGludWVzLi4uIiwgayk7Ci0JCQl0c3RfcmVzbShUSU5G
TywgImNoaWxkICVkIGNoYW5nZXMgbWVtb3J5IGNvbnRlbnQgdG8gIgotCQkJCSInZCciLCBrKTsK
LQkJCWZvciAoaiA9IDA7IGogPCBzaXplOyBqKyspIHsKLQkJCQlmb3IgKGkgPSAwOyBpIDwgTUI7
IGkrKykKLQkJCQkJbWVtb3J5W2tdW2pdW2ldID0gJ2QnOwotCQkgICAgICAgIH0KLQkJCS8qIFVu
bWVyZ2UuICovCi0JCQl0c3RfcmVzbShUSU5GTywgImNoaWxkICVkIHN0b3BzLiIsIGspOwotCQkJ
aWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQotCQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVM
TCwgImtpbGwiKTsKLQkJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgY29udGludWVzLi4uIiwg
ayk7Ci0KLQkJCS8qIFN0b3AuICovCi0JCQl0c3RfcmVzbShUSU5GTywgImNoaWxkICVkIHN0b3Bz
LiIsIGspOwotCQkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQotCQkJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgTlVMTCwgImtpbGwiKTsKLQkJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgY29u
dGludWVzLi4uIiwgayk7Ci0JCQlleGl0KDApOwotCQl9Ci0JfQotCXRzdF9yZXNtKFRJTkZPLCAi
S1NNIG1lcmdpbmcuLi4iKTsKLQlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVzJXMiLCBfUEFUSF9L
U00sICJydW4iKTsKLQlmZCA9IG9wZW4oYnVmLCBPX1dST05MWSk7Ci0JaWYgKGZkID09IC0xKQot
CQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJvcGVuIik7Ci0JaWYgKHdyaXRlKGZkLCAi
MSIsIDEpICE9IDEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgIndyaXRlIik7Ci0J
Y2xvc2UoZmQpOwotCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMlcyIsIF9QQVRIX0tTTSwgInBh
Z2VzX3RvX3NjYW4iKTsKLQlzbnByaW50ZihidWYyLCBCVUZTSVosICIlZCIsIHNpemUgKiAyNTYg
KiBudW0pOwotCWZkID0gb3BlbihidWYsIE9fV1JPTkxZKTsKLQlpZiAoZmQgPT0gLTEpCi0JCXRz
dF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgIm9wZW4iKTsKLQlpZiAod3JpdGUoZmQsIGJ1ZjIs
IHN0cmxlbihidWYyKSkgIT0gc3RybGVuKGJ1ZjIpKQotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8s
IE5VTEwsICJ3cml0ZSIpOwotCWNsb3NlKGZkKTsKLQotCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAi
JXMlcyIsIF9QQVRIX0tTTSwgInNsZWVwX21pbGxpc2VjcyIpOwotCWZkID0gb3BlbihidWYsIE9f
V1JPTkxZKTsKLQlpZiAoZmQgPT0gLTEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwg
Im9wZW4iKTsKLQlpZiAod3JpdGUoZmQsICIwIiwgMSkgIT0gMSkKLQkJdHN0X2Jya20oVEJST0t8
VEVSUk5PLCBOVUxMLCAid3JpdGUiKTsKLQljbG9zZShmZCk7Ci0KLQl0c3RfcmVzbShUSU5GTywg
IndhaXQgZm9yIGFsbCBjaGlsZHJlbiB0byBzdG9wLiIpOwotCWZvciAoayA9IDA7IGsgPCBudW07
IGsrKykgewotCQlpZiAod2FpdHBpZChjaGlsZFtrXSwgJnN0YXR1cywgV1VOVFJBQ0VEKSA9PSAt
MSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgIndhaXRwaWQiKTsKLQkJaWYgKCFX
SUZTVE9QUEVEKHN0YXR1cykpCi0JCQl0c3RfYnJrbShUQlJPSywgTlVMTCwgImNoaWxkICVkIHdh
cyBub3Qgc3RvcHBlZC4iLAotCQkJCWspOwotCX0KLQl0c3RfcmVzbShUSU5GTywgInJlc3VtZSBh
bGwgY2hpbGRyZW4uIik7Ci0JZm9yIChrID0gMDsgayA8IG51bTsgaysrKSB7Ci0JCWlmIChraWxs
KGNoaWxkW2tdLCBTSUdDT05UKSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVM
TCwgImtpbGwgY2hpbGRbJWRdIiwgayk7Ci0JfQotCWdyb3VwX2NoZWNrKDEsIDIsIHNpemUgKiBu
dW0gKiAyNTYgLSAyLCAwLCAwLCAwLCBzaXplICogMjU2ICogbnVtKTsKLQotCXRzdF9yZXNtKFRJ
TkZPLCAid2FpdCBmb3IgY2hpbGQgMSB0byBzdG9wLiIpOwotCWlmICh3YWl0cGlkKGNoaWxkWzFd
LCAmc3RhdHVzLCBXVU5UUkFDRUQpID09IC0xKQotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5V
TEwsICJ3YWl0cGlkIik7Ci0JaWYgKCFXSUZTVE9QUEVEKHN0YXR1cykpCi0JCXRzdF9icmttKFRC
Uk9LLCBOVUxMLCAiY2hpbGQgMSB3YXMgbm90IHN0b3BwZWQuIik7Ci0KLQkvKiBDaGlsZCAxIGNo
YW5nZXMgYWxsIHBhZ2VzIHRvICdiJy4gKi8KLQl0c3RfcmVzbShUSU5GTywgInJlc3VtZSBjaGls
ZCAxLiIpOwotCWlmIChraWxsKGNoaWxkWzFdLCBTSUdDT05UKSA9PSAtMSkKLQkJdHN0X2Jya20o
VEJST0t8VEVSUk5PLCBOVUxMLCAia2lsbCIpOwotCWdyb3VwX2NoZWNrKDEsIDMsIHNpemUgKiBu
dW0gKiAyNTYgLSAzLCAwLCAwLCAwLCBzaXplICogMjU2ICogbnVtKTsKLQotCXRzdF9yZXNtKFRJ
TkZPLCAid2FpdCBmb3IgY2hpbGQgMSB0byBzdG9wLiIpOwotCWlmICh3YWl0cGlkKGNoaWxkWzFd
LCAmc3RhdHVzLCBXVU5UUkFDRUQpID09IC0xKQotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5V
TEwsICJ3YWl0cGlkIik7Ci0JaWYgKCFXSUZTVE9QUEVEKHN0YXR1cykpCi0JCXRzdF9icmttKFRC
Uk9LLCBOVUxMLCAiY2hpbGQgMSB3YXMgbm90IHN0b3BwZWQuIik7Ci0KLQkvKiBBbGwgY2hpbGRy
ZW4gY2hhbmdlIHBhZ2VzIHRvICdkJy4gKi8KLQl0c3RfcmVzbShUSU5GTywgInJlc3VtZSBhbGwg
Y2hpbGRyZW4uIik7Ci0JZm9yIChrID0gMDsgayA8IG51bTsgaysrKSB7Ci0JCWlmIChraWxsKGNo
aWxkW2tdLCBTSUdDT05UKSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwg
ImtpbGwgY2hpbGRbJWRdIiwgayk7Ci0JfQotCWdyb3VwX2NoZWNrKDEsIDEsIHNpemUgKiBudW0g
KiAyNTYgLSAxLCAwLCAwLCAwLCBzaXplICogMjU2ICogbnVtKTsKLQotCXRzdF9yZXNtKFRJTkZP
LCAid2FpdCBmb3IgYWxsIGNoaWxkcmVuIHRvIHN0b3AuIik7Ci0JZm9yIChrID0gMDsgayA8IG51
bTsgaysrKSB7Ci0JCWlmICh3YWl0cGlkKGNoaWxkW2tdLCAmc3RhdHVzLCBXVU5UUkFDRUQpID09
IC0xKQotCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAid2FpdHBpZCIpOwotCQlpZiAo
IVdJRlNUT1BQRUQoc3RhdHVzKSkKLQkJCXRzdF9icmttKFRCUk9LLCBOVUxMLCAiY2hpbGQgJWQg
d2FzIG5vdCBzdG9wcGVkLiIsCi0JCQkJayk7Ci0JfQotCS8qIENoaWxkIDEgY2hhbmdlcyBwYWdl
cyB0byAnZScuICovCi0JdHN0X3Jlc20oVElORk8sICJyZXN1bWUgY2hpbGQgMS4iKTsKLQlpZiAo
a2lsbChjaGlsZFsxXSwgU0lHQ09OVCkgPT0gLTEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywg
TlVMTCwgImtpbGwiKTsKLQlncm91cF9jaGVjaygxLCAxLCBzaXplICogbnVtICogMjU2IC0gMiwg
MCwgMSwgMCwgc2l6ZSAqIDI1NiAqIG51bSk7Ci0KLQl0c3RfcmVzbShUSU5GTywgIndhaXQgZm9y
IGNoaWxkIDEgdG8gc3RvcC4iKTsKLQlpZiAod2FpdHBpZChjaGlsZFsxXSwgJnN0YXR1cywgV1VO
VFJBQ0VEKSA9PSAtMSkKLQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAid2FpdHBpZCIp
OwotCWlmICghV0lGU1RPUFBFRChzdGF0dXMpKQotCQl0c3RfYnJrbShUQlJPSywgTlVMTCwgImNo
aWxkIDEgd2FzIG5vdCBzdG9wcGVkLiIpOwotCi0JdHN0X3Jlc20oVElORk8sICJyZXN1bWUgYWxs
IGNoaWxkcmVuLiIpOwotCWZvciAoayA9IDA7IGsgPCBudW07IGsrKykgewotCQlpZiAoa2lsbChj
aGlsZFtrXSwgU0lHQ09OVCkgPT0gLTEpCi0JCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEws
ICJraWxsIGNoaWxkWyVkXSIsIGspOwotCX0KLQl0c3RfcmVzbShUSU5GTywgIktTTSB1bm1lcmdp
bmcuLi4iKTsKLQlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVzJXMiLCBfUEFUSF9LU00sICJydW4i
KTsKLQlmZCA9IG9wZW4oYnVmLCBPX1dST05MWSk7Ci0JaWYgKGZkID09IC0xKQotCQl0c3RfYnJr
bShUQlJPS3xURVJSTk8sIE5VTEwsICJvcGVuIik7Ci0JaWYgKHdyaXRlKGZkLCAiMiIsIDEpICE9
IDEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgIndyaXRlIik7Ci0JZ3JvdXBfY2hl
Y2soMiwgMCwgMCwgMCwgMCwgMCwgc2l6ZSAqIDI1NiAqIG51bSk7Ci0KLQl0c3RfcmVzbShUSU5G
TywgIndhaXQgZm9yIGFsbCBjaGlsZHJlbiB0byBzdG9wLiIpOwotCWZvciAoayA9IDA7IGsgPCBu
dW07IGsrKykgewotCQlpZiAod2FpdHBpZChjaGlsZFtrXSwgJnN0YXR1cywgV1VOVFJBQ0VEKSA9
PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgIndhaXRwaWQiKTsKLQkJaWYg
KCFXSUZTVE9QUEVEKHN0YXR1cykpCi0JCQl0c3RfYnJrbShUQlJPSywgTlVMTCwgImNoaWxkICVk
IHdhcyBub3Qgc3RvcHBlZC4iLAotCQkJCWspOwotCX0KLQl0c3RfcmVzbShUSU5GTywgInJlc3Vt
ZSBhbGwgY2hpbGRyZW4uIik7Ci0JZm9yIChrID0gMDsgayA8IG51bTsgaysrKSB7Ci0JCWlmIChr
aWxsKGNoaWxkW2tdLCBTSUdDT05UKSA9PSAtMSkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywg
TlVMTCwgImtpbGwgY2hpbGRbJWRdIiwgayk7Ci0JfQotCXRzdF9yZXNtKFRJTkZPLCAic3RvcCBL
U00uIik7Ci0JaWYgKGxzZWVrKGZkLCAwLCBTRUVLX1NFVCkgPT0gLTEpCi0JCXRzdF9icmttKFRC
Uk9LfFRFUlJOTywgTlVMTCwgImxzZWVrIik7Ci0JaWYgKHdyaXRlKGZkLCAiMCIsIDEpICE9IDEp
Ci0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgIndyaXRlIik7Ci0JY2xvc2UoZmQpOwot
CWdyb3VwX2NoZWNrKDAsIDAsIDAsIDAsIDAsIDAsIHNpemUgKiAyNTYgKiBudW0pOwotCXdoaWxl
ICh3YWl0cGlkKC0xLCAmc3RhdHVzLCBXVU5UUkFDRUQgfCBXQ09OVElOVUVEKSA+IDApCi0JCWlm
IChXRVhJVFNUQVRVUyhzdGF0dXMpICE9IDApCi0JCQl0c3RfcmVzbShURkFJTCwgImNoaWxkIGV4
aXQgc3RhdHVzIGlzICVkIiwKLQkJCQlXRVhJVFNUQVRVUyhzdGF0dXMpKTsKLX0KLQogdm9pZCBz
ZXR1cCh2b2lkKQogewotCWNoYXIgYnVmW0JVRlNJWl07Ci0Jc3RydWN0IHN0YXQgbmV3OworCXRz
dF9yZXF1aXJlX3Jvb3QoTlVMTCk7CiAKLQlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVzJXMiLCBf
UEFUSF9LU00sICJydW4iKTsKLQlpZiAoc3RhdChidWYsICZuZXcpID09IC0xKSB7Ci0JCWlmIChl
cnJubyA9PSBFTk9FTlQpCi0JCQl0c3RfYnJrbShUQ09ORiwgTlVMTCwgIm5vIEtTTS4iKTsKLQkJ
ZWxzZQotCQkJdHN0X2Jya20oVEJST0ssIE5VTEwsICJzdGF0Iik7Ci0JfQotCS8qCi0JICogc2V0
dXAgYSBkZWZhdWx0IHNpZ25hbCBoYW5kZXIgYW5kIGEKLQkgKiB0ZW1wb3Jhcnkgd29ya2luZyBk
aXJlY3RvcnkuCi0JICovCiAJdHN0X3NpZyhGT1JLLCBERUZfSEFORExFUiwgTlVMTCk7CiAJVEVT
VF9QQVVTRTsKIH0KIAotdm9pZCB1c2FnZSh2b2lkKQordm9pZCBjbGVhbnVwKHZvaWQpCiB7Ci0J
cHJpbnRmKCIgIC1uICAgICAgTnVtYmVyIG9mIHByb2Nlc3Nlc1xuIik7Ci0JcHJpbnRmKCIgIC1z
ICAgICAgTWVtb3J5IGFsbG9jYXRpb24gc2l6ZSBpbiBNQlxuIik7CisJVEVTVF9DTEVBTlVQOwog
fQotCi0vKiBUaGVyZSBpcyBjdXJyZW50bHkgYSBidWcgd2lsbCBjYXVzZSB0aGUgdGVzdCBmYWls
dXJlIC0gKgotIGh0dHA6Ly9tYXJjLmluZm8vP2w9bGludXgtbW0mbT0xMjg5Mjg1MzAzMDg1MjYm
dz0yIC4gIFNpbmNlIGl0IGhhcwotIHN0aWxsIGJlZW4gZGlzY3Vzc2VkIHVwc3RyZWFtLCB0aGUg
aW50ZXJmYWNlIGhlcmUgd2FzIGFkZGVkIHNvbWUKLSBmbGV4aWJsaXR5IHdpdGggcGF0aDIsIHNv
IGl0IGlzIHBvc3NpYmxlIHRvIG1ha2UgY2hhbmdlcyBoZXJlIGRlcGVuZHMKLSBvbiB0aGUgZnV0
dXJlIGltcGxlbWVudGF0aW9uIGluIGtlcm5lbC4gRm9yIGV4YW1wbGUsIHRvIHZlcmlmeQotIChw
YWdlc19zaGFyaW5nICsgcGFnZXNfdm9sYXRpbGUpIGluc3RlYWQgb2YgYSBzaW5nbGUgaXRlbS4g
Ki8KLXZvaWQgY2hlY2soY2hhciAqcGF0aCwgY2hhciAqcGF0aDIsIGxvbmcgaW50IHZhbHVlKQot
ewotCUZJTEUgKmZwOwotCWNoYXIgYnVmW0JVRlNJWl0sIGJ1ZjJbQlVGU0laXTsKLQotCXNucHJp
bnRmKGJ1ZiwgQlVGU0laLCAiJXMlcyIsIF9QQVRIX0tTTSwgcGF0aCk7Ci0JZnAgPSBmb3Blbihi
dWYsICJyIik7Ci0JaWYgKGZwID09IE5VTEwpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVM
TCwgImZvcGVuIik7Ci0JaWYgKGZnZXRzKGJ1ZiwgQlVGU0laLCBmcCkgPT0gTlVMTCkKLQkJdHN0
X2Jya20oVEJST0t8VEVSUk5PLCBOVUxMLCAiZmdldHMiKTsKLQlmY2xvc2UoZnApOwotCi0JdHN0
X3Jlc20oVElORk8sICIlcyBpcyAlbGQuIiwgcGF0aCwgYXRvbChidWYpKTsKLQlpZiAocGF0aDIg
IT0gTlVMTCkgewotCQlzbnByaW50ZihidWYyLCBCVUZTSVosICIlcyVzIiwgX1BBVEhfS1NNLCBw
YXRoMik7Ci0JCWZwID0gZm9wZW4oYnVmMiwgInIiKTsKLQkJaWYgKGZwID09IE5VTEwpCi0JCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJmb3BlbiIpOwotCQlpZiAoZmdldHMoYnVmMiwg
QlVGU0laLCBmcCkgPT0gTlVMTCkKLQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImZn
ZXRzIik7Ci0JCWZjbG9zZShmcCk7Ci0KLQkJdHN0X3Jlc20oVElORk8sICIlcyBpcyAlbGQuIiwg
cGF0aDIsIGF0b2woYnVmMikpOwotCQlpZiAoYXRvbChidWYpICsgYXRvbChidWYyKSAhPSB2YWx1
ZSkKLQkJCXRzdF9yZXNtKFRGQUlMLCAiJXMgKyAlcyBpcyBub3QgJWxkLiIsIHBhdGgsIHBhdGgy
LAotCQkJCXZhbHVlKTsKLQl9IGVsc2UKLQkJaWYgKGF0b2woYnVmKSAhPSB2YWx1ZSkKLQkJCXRz
dF9yZXNtKFRGQUlMLCAiJXMgaXMgbm90ICVsZC4iLCBwYXRoLCB2YWx1ZSk7Ci19Ci0KLXZvaWQg
dmVyaWZ5KGNoYXIgdmFsdWUsIGludCBwcm9jLCBpbnQgc3RhcnQsIGludCBlbmQsIGludCBzdGFy
dDIsIGludCBlbmQyKQotewotCWludCBpLCBqOwotCXZvaWQgKnMgPSBOVUxMOwotCi0JcyA9IG1h
bGxvYygoZW5kIC0gc3RhcnQpICogKGVuZDIgLSBzdGFydDIpKTsKLQlpZiAocyA9PSBOVUxMKQot
CQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIE5VTEwsICJtYWxsb2MiKTsKLQotCXRzdF9yZXNtKFRJ
TkZPLCAiY2hpbGQgJWQgdmVyaWZpZXMgbWVtb3J5IGNvbnRlbnQuIiwgcHJvYyk7Ci0JbWVtc2V0
KHMsIHZhbHVlLCAoZW5kIC0gc3RhcnQpICogKGVuZDIgLSBzdGFydDIpKTsKLQlpZiAobWVtY21w
KG1lbW9yeVtwcm9jXVtzdGFydF0sIHMsIChlbmQgLSBzdGFydCkgKiAoZW5kMiAtIHN0YXJ0Mikp
ICE9IDApCi0JCWZvciAoaiA9IHN0YXJ0OyBqIDwgZW5kOyBqKyspCi0JCQlmb3IgKGkgPSBzdGFy
dDI7IGkgPCBlbmQyOyBpKyspCi0JCQkJaWYgKG1lbW9yeVtwcm9jXVtqXVtpXSAhPSB2YWx1ZSkK
LQkJCQkJdHN0X3Jlc20oVEZBSUwsICJjaGlsZCAlZCBoYXMgJWMgYXQgIgotCQkJCQkJIiVkLCVk
LCVkLiIsCi0JCQkJCQlwcm9jLCBtZW1vcnlbcHJvY11bal1baV0sIHByb2MsCi0JCQkJCQlqLCBp
KTsKLQlmcmVlKHMpOwotfQotCi12b2lkIGdyb3VwX2NoZWNrKGludCBydW4sIGludCBwYWdlc19z
aGFyZWQsIGludCBwYWdlc19zaGFyaW5nLAotCQlpbnQgcGFnZXNfdm9sYXRpbGUsIGludCBwYWdl
c191bnNoYXJlZCwKLQkJaW50IHNsZWVwX21pbGxpc2VjcywgaW50IHBhZ2VzX3RvX3NjYW4pCi17
Ci0gICAgICAgIC8qIDUgc2Vjb25kcyBmb3Iga3NtIHRvIHNjYW4gcGFnZXMuICovCi0Jc2xlZXAo
NSk7Ci0JdHN0X3Jlc20oVElORk8sICJjaGVjayEiKTsKLQljaGVjaygicnVuIiwgTlVMTCwgcnVu
KTsKLQljaGVjaygicGFnZXNfc2hhcmVkIiwgTlVMTCwgcGFnZXNfc2hhcmVkKTsKLQljaGVjaygi
cGFnZXNfc2hhcmluZyIsIE5VTEwsIHBhZ2VzX3NoYXJpbmcpOwotCWNoZWNrKCJwYWdlc192b2xh
dGlsZSIsIE5VTEwsIHBhZ2VzX3ZvbGF0aWxlKTsKLQljaGVjaygicGFnZXNfdW5zaGFyZWQiLCBO
VUxMLCBwYWdlc191bnNoYXJlZCk7Ci0JY2hlY2soInNsZWVwX21pbGxpc2VjcyIsIE5VTEwsIHNs
ZWVwX21pbGxpc2Vjcyk7Ci0JY2hlY2soInBhZ2VzX3RvX3NjYW4iLCBOVUxMLCBwYWdlc190b19z
Y2FuKTsKLX0KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCmRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMva2VybmVsL21lbS9saWIvTWFrZWZpbGUgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9saWIvTWFr
ZWZpbGUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZGQ5NzhhNwotLS0gL2Rl
di9udWxsCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9NYWtlZmlsZQpAQCAtMCwwICsx
LDI1IEBACisjCisjICBDb3B5cmlnaHQgKEMpIDIwMTAgIFJlZCBIYXQsIEluYy4KKyMKKyMgIFRo
aXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyAgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5k
L29yIG1vZGlmeQorIyAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKKyMgIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRp
b247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCisjICAoYXQgeW91ciBvcHRp
b24pIGFueSBsYXRlciB2ZXJzaW9uLgorIworIyAgVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVk
IGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsCisjICBidXQgV0lUSE9VVCBBTlkg
V0FSUkFOVFk7ICB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyMgIE1FUkNI
QU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZQorIyAg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMuCisjCisjICBZ
b3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZQorIyAgYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07ICBpZiBub3QsIHdyaXRlIHRvIHRo
ZSBGcmVlIFNvZnR3YXJlCisjICBGb3VuZGF0aW9uLCBJbmMuLCA1OSBUZW1wbGUgUGxhY2UsIFN1
aXRlIDMzMCwgQm9zdG9uLCBNQSAwMjExMS0xMzA3IFVTQQorIworCit0b3Bfc3JjZGlyICAgICAg
ICAgICAgICA/PSAuLi8uLi8uLi8uLgorCitpbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9t
ay9lbnZfcHJlLm1rCisKK0xJQgkJCTo9IGxpYm1lbS5hCisKK2luY2x1ZGUgJCh0b3Bfc3JjZGly
KS9pbmNsdWRlL21rL2xpYi5tawpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vbGli
L21lbS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vbGliL21lbS5jCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAuLjI5N2VlZGQKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMv
a2VybmVsL21lbS9saWIvbWVtLmMKQEAgLTAsMCArMSw2NTEgQEAKKyNpbmNsdWRlIDxzeXMvbW1h
bi5oPgorI2luY2x1ZGUgPHN5cy90eXBlcy5oPgorI2luY2x1ZGUgPHN5cy93YWl0Lmg+CisjaW5j
bHVkZSA8c3lzL3N0YXQuaD4KKyNpbmNsdWRlIDxzeXMvbW91bnQuaD4KKyNpbmNsdWRlIDxmY250
bC5oPgorI2luY2x1ZGUgPHVuaXN0ZC5oPgorI2luY2x1ZGUgPGVycm5vLmg+CisjaW5jbHVkZSA8
c3RkaW8uaD4KKyNpbmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlIDxzdGRhcmcuaD4KKyNpbmNs
dWRlICJ0ZXN0LmgiCisjaW5jbHVkZSAidXNjdGVzdC5oIgorI2luY2x1ZGUgIi4uL2luY2x1ZGUv
bWVtLmgiCisjaW5jbHVkZSAiY29uZmlnLmgiCisjaWYgSEFWRV9OVU1BX0ggJiYgSEFWRV9MSU5V
WF9NRU1QT0xJQ1lfSCAmJiBIQVZFX05VTUFJRl9IIFwKKwkmJiBIQVZFX01QT0xfQ09OU1RBTlRT
CisjaW5jbHVkZSA8bnVtYWlmLmg+CisjZW5kaWYKKwordm9pZCBvb20oaW50IHRlc3RjYXNlLCBp
bnQgbWVtcG9saWN5LCBpbnQgbGl0ZSkKK3sKKwlwaWRfdCBwaWQ7CisJaW50IHN0YXR1czsKKyNp
ZiBIQVZFX05VTUFfSCAmJiBIQVZFX0xJTlVYX01FTVBPTElDWV9IICYmIEhBVkVfTlVNQUlGX0gg
XAorCSYmIEhBVkVfTVBPTF9DT05TVEFOVFMKKwl1bnNpZ25lZCBsb25nIG5tYXNrID0gMjsKKyNl
bmRpZgorCisJc3dpdGNoKHBpZCA9IGZvcmsoKSkgeworCWNhc2UgLTE6CisJCXRzdF9icmttKFRC
Uk9LfFRFUlJOTywgY2xlYW51cCwgImZvcmsiKTsKKwljYXNlIDA6CisjaWYgSEFWRV9OVU1BX0gg
JiYgSEFWRV9MSU5VWF9NRU1QT0xJQ1lfSCAmJiBIQVZFX05VTUFJRl9IIFwKKwkmJiBIQVZFX01Q
T0xfQ09OU1RBTlRTCisJCWlmIChtZW1wb2xpY3kpCisJCQlpZiAoc2V0X21lbXBvbGljeShNUE9M
X0JJTkQsICZubWFzaywgTUFYTk9ERVMpID09IC0xKQorCQkJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgY2xlYW51cCwKKwkJCQkJInNldF9tZW1wb2xpY3kiKTsKKyNlbmRpZgorCQl0ZXN0X2FsbG9j
KHRlc3RjYXNlLCBsaXRlKTsKKwkJZXhpdCgwKTsKKwlkZWZhdWx0OgorCQlicmVhazsKKwl9CisJ
dHN0X3Jlc20oVElORk8sICJleHBlY3RlZCB2aWN0aW0gaXMgJWQuIiwgcGlkKTsKKwlpZiAod2Fp
dHBpZCgtMSwgJnN0YXR1cywgMCkgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xl
YW51cCwgIndhaXRwaWQiKTsKKworCWlmICh0ZXN0Y2FzZSA9PSBPVkVSQ09NTUlUKSB7CisJCWlm
ICghV0lGRVhJVEVEKHN0YXR1cykgfHwgV0VYSVRTVEFUVVMoc3RhdHVzKSAhPSAwKQorCQkJdHN0
X3Jlc20oVEZBSUwsICJ0aGUgdmljdGltIHVuZXhwZWN0ZWRseSBmYWlsZWQ6ICVkIiwKKwkJCQlz
dGF0dXMpOworCX0gZWxzZSB7CisJCWlmICghV0lGU0lHTkFMRUQoc3RhdHVzKSB8fCBXVEVSTVNJ
RyhzdGF0dXMpICE9IFNJR0tJTEwpCisJCQl0c3RfcmVzbShURkFJTCwgInRoZSB2aWN0aW0gdW5l
eHBlY3RlZGx5IGZhaWxlZDogJWQiLAorCQkJCXN0YXR1cyk7CisJfQorfQorCit2b2lkIHdyaXRl
X21lbWNnKHZvaWQpCit7CisJaW50IGZkOworCWNoYXIgYnVmW0JVRlNJWl0sIG1lbVtCVUZTSVpd
OworCisJZmQgPSBvcGVuKE1FTUNHX1BBVEhfTkVXICIvbWVtb3J5LmxpbWl0X2luX2J5dGVzIiwg
T19XUk9OTFkpOworCWlmIChmZCA9PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVh
bnVwLCAib3BlbiAlcyIsIGJ1Zik7CisJc3ByaW50ZihtZW0sICIlbGQiLCBURVNUTUVNKTsKKwlp
ZiAod3JpdGUoZmQsIG1lbSwgc3RybGVuKG1lbSkpICE9IHN0cmxlbihtZW0pKQorCQl0c3RfYnJr
bShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSAlcyIsIGJ1Zik7CisJY2xvc2UoZmQpOwor
CisJZmQgPSBvcGVuKE1FTUNHX1BBVEhfTkVXICIvdGFza3MiLCBPX1dST05MWSk7CisJaWYgKGZk
ID09IC0xKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuICVzIiwgYnVm
KTsKKwlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVkIiwgZ2V0cGlkKCkpOworCWlmICh3cml0ZShm
ZCwgYnVmLCBzdHJsZW4oYnVmKSkgIT0gc3RybGVuKGJ1ZikpCisJCXRzdF9icmttKFRCUk9LfFRF
UlJOTywgY2xlYW51cCwgIndyaXRlICVzIiwgYnVmKTsKKwljbG9zZShmZCk7CQorfQorCit2b2lk
IHdyaXRlX2NwdXNldHModm9pZCkKK3sKKwljaGFyIGNwdXNbQlVGU0laXSA9ICIiOworCWNoYXIg
YnVmW0JVRlNJWl0gPSAiIjsKKwlpbnQgZmQ7CisKKwlnYXRoZXJfY3B1cyhjcHVzKTsKKwl0c3Rf
cmVzbShUSU5GTywgIkNQVSBsaXN0IGZvciAybmQgbm9kZSBpcyAlcy4iLCBjcHVzKTsKKworCWZk
ID0gb3BlbihDUEFUSF9ORVcgIi9tZW1zIiwgT19XUk9OTFkpOworCWlmIChmZCA9PSAtMSkKKwkJ
dHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiAlcyIsIGJ1Zik7CisJaWYgKHdy
aXRlKGZkLCAiMSIsIDEpICE9IDEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwg
IndyaXRlICVzIiwgYnVmKTsKKwljbG9zZShmZCk7CisKKwlmZCA9IG9wZW4oQ1BBVEhfTkVXICIv
Y3B1cyIsIE9fV1JPTkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOworCWlmICh3cml0ZShmZCwgY3B1cywgc3RybGVu
KGNwdXMpKSAhPSBzdHJsZW4oY3B1cykpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51
cCwgIndyaXRlICVzIiwgYnVmKTsKKwljbG9zZShmZCk7CisKKwlmZCA9IG9wZW4oQ1BBVEhfTkVX
ICIvdGFza3MiLCBPX1dST05MWSk7CisJaWYgKGZkID09IC0xKQorCQl0c3RfYnJrbShUQlJPS3xU
RVJSTk8sIGNsZWFudXAsICJvcGVuICVzIiwgYnVmKTsKKwlzbnByaW50ZihidWYsIEJVRlNJWiwg
IiVkIiwgZ2V0cGlkKCkpOworCWlmICh3cml0ZShmZCwgYnVmLCBzdHJsZW4oYnVmKSkgIT0gc3Ry
bGVuKGJ1ZikpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlICVzIiwg
YnVmKTsKKwljbG9zZShmZCk7Cit9CisKK3ZvaWQgdGVzdG9vbShpbnQgbWVtcG9saWN5LCBpbnQg
bGl0ZSwgaW50IG51bWEpCit7CisJaWYgKG51bWEgJiYgIW1lbXBvbGljeSkKKwkJd3JpdGVfY3B1
c2V0cygpOworCisJdHN0X3Jlc20oVElORk8sICJzdGFydCBub3JtYWwgT09NIHRlc3RpbmcuIik7
CisJb29tKE5PUk1BTCwgbWVtcG9saWN5LCBsaXRlKTsKKworCXRzdF9yZXNtKFRJTkZPLCAic3Rh
cnQgT09NIHRlc3RpbmcgZm9yIG1sb2NrZWQgcGFnZXMuIik7CisJb29tKE1MT0NLLCBtZW1wb2xp
Y3ksIGxpdGUpOworCisJdHN0X3Jlc20oVElORk8sICJzdGFydCBPT00gdGVzdGluZyBmb3IgS1NN
IHBhZ2VzLiIpOworCW9vbShLU00sIG1lbXBvbGljeSwgbGl0ZSk7Cit9CisKK2xvbmcgY291bnRf
bnVtYSh2b2lkKQoreworCWludCBubm9kZXMgPSAwOworCisJd2hpbGUocGF0aF9leGlzdChQQVRI
X1NZU19TWVNURU0gIi9ub2RlL25vZGUlZCIsIG5ub2RlcykpCisJCW5ub2RlcysrOworCisJcmV0
dXJuIG5ub2RlczsKK30KKworaW50IHBhdGhfZXhpc3QoY29uc3QgY2hhciAqcGF0aCwgLi4uKQor
eworCXZhX2xpc3QgYXA7CisJY2hhciBwYXRoYnVmW1BBVEhfTUFYXTsKKworCXZhX3N0YXJ0KGFw
LCBwYXRoKTsKKwl2c25wcmludGYocGF0aGJ1Ziwgc2l6ZW9mKHBhdGhidWYpLCBwYXRoLCBhcCk7
CisJdmFfZW5kKGFwKTsKKworCXJldHVybiBhY2Nlc3MocGF0aGJ1ZiwgRl9PSykgPT0gMDsKK30K
Kwordm9pZCBnYXRoZXJfY3B1cyhjaGFyICpjcHVzKQoreworCWludCBuY3B1cyA9IDA7CisJaW50
IGk7CisJY2hhciBidWZbQlVGU0laXTsKKworCXdoaWxlKHBhdGhfZXhpc3QoUEFUSF9TWVNfU1lT
VEVNICIvY3B1L2NwdSVkIiwgbmNwdXMpKQorCQluY3B1cysrOworCisJZm9yIChpID0gMDsgaSA8
IG5jcHVzOyBpKyspCisJCWlmIChwYXRoX2V4aXN0KFBBVEhfU1lTX1NZU1RFTSAiL25vZGUvbm9k
ZTEvY3B1JWQiLCBpKSkgeworCQkJc3ByaW50ZihidWYsICIlZCwiLCBpKTsKKwkJCXN0cmNhdChj
cHVzLCBidWYpOworCQl9CisJLyogUmVtb3ZlIHRoZSB0cmFpbGluZyBjb21tYS4gKi8KKwljcHVz
W3N0cmxlbihjcHVzKSAtIDFdID0gJ1wwJzsKK30KKworaW50IGFsbG9jX21lbShsb25nIGludCBs
ZW5ndGgsIGludCB0ZXN0Y2FzZSkKK3sKKwl2b2lkICpzOworCisJdHN0X3Jlc20oVElORk8sICJh
bGxvY2F0aW5nICVsZCBieXRlcy4iLCBsZW5ndGgpOworCXMgPSBtbWFwKE5VTEwsIGxlbmd0aCwg
UFJPVF9SRUFEfFBST1RfV1JJVEUsCisJCU1BUF9BTk9OWU1PVVN8TUFQX1BSSVZBVEUsIC0xLCAw
KTsKKwlpZiAocyA9PSBNQVBfRkFJTEVEKSB7CisJCWlmICh0ZXN0Y2FzZSA9PSBPVkVSQ09NTUlU
ICYmIGVycm5vID09IEVOT01FTSkKKwkJCXJldHVybiAxOworCQllbHNlCisJCQl0c3RfYnJrbShU
QlJPS3xURVJSTk8sIGNsZWFudXAsICJtbWFwIik7CisJfQorCWlmICh0ZXN0Y2FzZSA9PSBNTE9D
SyAmJiBtbG9jayhzLCBsZW5ndGgpID09IC0xKQorCQl0c3RfYnJrbShUSU5GT3xURVJSTk8sIGNs
ZWFudXAsICJtbG9jayIpOworCWlmICh0ZXN0Y2FzZSA9PSBLU00KKwkJJiYgbWFkdmlzZShzLCBs
ZW5ndGgsIE1BRFZfTUVSR0VBQkxFKSA9PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBj
bGVhbnVwLCAibWFkdmlzZSIpOworCW1lbXNldChzLCAnXGEnLCBsZW5ndGgpOworCisJcmV0dXJu
IDA7Cit9CisKK3ZvaWQgdGVzdF9hbGxvYyhpbnQgdGVzdGNhc2UsIGludCBsaXRlKQoreworCWlm
IChsaXRlKQorCQlhbGxvY19tZW0oVEVTVE1FTSArIE1CLCB0ZXN0Y2FzZSk7CisJZWxzZQorCQl3
aGlsZSgxKQorCQkJaWYgKGFsbG9jX21lbShMRU5HVEgsIHRlc3RjYXNlKSkKKwkJCQlyZXR1cm47
Cit9CisKK3ZvaWQgdW1vdW50X21lbShjaGFyICpwYXRoLCBjaGFyICpwYXRoX25ldykKK3sKKwlG
SUxFICpmcDsKKwlpbnQgZmQ7CisJY2hhciBzX25ld1tCVUZTSVpdLCBzW0JVRlNJWl0sIHZhbHVl
W0JVRlNJWl07CisKKwkvKiBNb3ZlIGFsbCBwcm9jZXNzZXMgaW4gdGFzayB0byBpdHMgcGFyZW50
IG5vZGUuICovCisJc3ByaW50ZihzLCAiJXMvdGFza3MiLCBwYXRoKTsKKwlmZCA9IG9wZW4ocywg
T19XUk9OTFkpOworCWlmIChmZCA9PSAtMSkKKwkJdHN0X3Jlc20oVFdBUk58VEVSUk5PLCAib3Bl
biAlcyIsIHMpOworCisJc25wcmludGYoc19uZXcsIEJVRlNJWiwgIiVzL3Rhc2tzIiwgcGF0aF9u
ZXcpOworCWZwID0gZm9wZW4oc19uZXcsICJyIik7CisJaWYgKGZwID09IE5VTEwpCisJCXRzdF9y
ZXNtKFRXQVJOfFRFUlJOTywgImZvcGVuICVzIiwgc19uZXcpOworCWlmICgoZmQgIT0gLTEpICYm
IChmcCAhPSBOVUxMKSkgeworCQl3aGlsZSAoZmdldHModmFsdWUsIEJVRlNJWiwgZnApICE9IE5V
TEwpCisJCQlpZiAod3JpdGUoZmQsIHZhbHVlLCBzdHJsZW4odmFsdWUpIC0gMSkKKwkJCQkhPSBz
dHJsZW4odmFsdWUpIC0gMSkKKwkJCQl0c3RfcmVzbShUV0FSTnxURVJSTk8sICJ3cml0ZSAlcyIs
IHMpOworCX0KKwlpZiAoZmQgIT0gLTEpCisJCWNsb3NlKGZkKTsKKwlpZiAoZnAgIT0gTlVMTCkK
KwkJZmNsb3NlKGZwKTsKKwlpZiAocm1kaXIocGF0aF9uZXcpID09IC0xKQorCQl0c3RfcmVzbShU
V0FSTnxURVJSTk8sICJybWRpciAlcyIsIHBhdGhfbmV3KTsKKwlpZiAodW1vdW50KHBhdGgpID09
IC0xKQorCQl0c3RfcmVzbShUV0FSTnxURVJSTk8sICJ1bW91bnQgJXMiLCBwYXRoKTsKKwlpZiAo
cm1kaXIocGF0aCkgPT0gLTEpCisJCXRzdF9yZXNtKFRXQVJOfFRFUlJOTywgInJtZGlyICVzIiwg
cGF0aCk7Cit9CisKK3ZvaWQgbW91bnRfbWVtKGNoYXIgKm5hbWUsIGNoYXIgKmZzLCBjaGFyICpv
cHRpb25zLCBjaGFyICpwYXRoLCBjaGFyICpwYXRoX25ldykKK3sKKwlpZiAobWtkaXIocGF0aCwg
MDc3NykgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm1rZGlyICVz
IiwgcGF0aCk7CisJaWYgKG1vdW50KG5hbWUsIHBhdGgsIGZzLCAwLCBvcHRpb25zKSA9PSAtMSkK
KwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAibW91bnQgJXMiLCBwYXRoKTsKKwlp
ZiAobWtkaXIocGF0aF9uZXcsIDA3NzcpID09IC0xKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8s
IGNsZWFudXAsICJta2RpciAlcyIsIHBhdGhfbmV3KTsKK30KKwordm9pZCBrc21fdXNhZ2Uodm9p
ZCkKK3sKKwlwcmludGYoIiAgLW4gICAgICBOdW1iZXIgb2YgcHJvY2Vzc2VzXG4iKTsKKwlwcmlu
dGYoIiAgLXMgICAgICBNZW1vcnkgYWxsb2NhdGlvbiBzaXplIGluIE1CXG4iKTsKKwlwcmludGYo
IiAgLXUgICAgICBNZW1vcnkgYWxsb2NhdGlvbiB1bml0IGluIE1CXG4iKTsKK30KKwordm9pZCBj
aGVjayhjaGFyICpwYXRoLCBsb25nIGludCB2YWx1ZSkKK3sKKwlGSUxFICpmcDsKKwljaGFyIGJ1
ZltCVUZTSVpdOworCisJc25wcmludGYoYnVmLCBCVUZTSVosICIlcyVzIiwgUEFUSF9LU00sIHBh
dGgpOworCWZwID0gZm9wZW4oYnVmLCAiciIpOworCWlmIChmcCA9PSBOVUxMKQorCQl0c3RfYnJr
bShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAiZm9wZW4iKTsKKwlpZiAoZmdldHMoYnVmLCBCVUZT
SVosIGZwKSA9PSBOVUxMKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAiZmdl
dHMiKTsKKwlmY2xvc2UoZnApOworCisJdHN0X3Jlc20oVElORk8sICIlcyBpcyAlbGQuIiwgcGF0
aCwgYXRvbChidWYpKTsKKwlpZiAoYXRvbChidWYpICE9IHZhbHVlKQorCQl0c3RfcmVzbShURkFJ
TCwgIiVzIGlzIG5vdCAlbGQuIiwgcGF0aCwgdmFsdWUpOworfQorCit2b2lkIHZlcmlmeShjaGFy
IHZhbHVlLCBpbnQgcHJvYywgaW50IHN0YXJ0LCBpbnQgZW5kLCBpbnQgc3RhcnQyLCBpbnQgZW5k
MikKK3sKKwlpbnQgaSwgajsKKwl2b2lkICpzID0gTlVMTDsKKworCXMgPSBtYWxsb2MoKGVuZCAt
IHN0YXJ0KSAqIChlbmQyIC0gc3RhcnQyKSk7CisJaWYgKHMgPT0gTlVMTCkKKwkJdHN0X2Jya20o
VEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgIm1hbGxvYyIpOworCisJdHN0X3Jlc20oVElORk8sICJj
aGlsZCAlZCB2ZXJpZmllcyBtZW1vcnkgY29udGVudC4iLCBwcm9jKTsKKwltZW1zZXQocywgdmFs
dWUsIChlbmQgLSBzdGFydCkgKiAoZW5kMiAtIHN0YXJ0MikpOworCWlmIChtZW1jbXAobWVtb3J5
W3Byb2NdW3N0YXJ0XSwgcywgKGVuZCAtIHN0YXJ0KSAqIChlbmQyIC0gc3RhcnQyKSkKKwkJIT0g
MCkKKwkJZm9yIChqID0gc3RhcnQ7IGogPCBlbmQ7IGorKykKKwkJCWZvciAoaSA9IHN0YXJ0Mjsg
aSA8IGVuZDI7IGkrKykKKwkJCQlpZiAobWVtb3J5W3Byb2NdW2pdW2ldICE9IHZhbHVlKQorCQkJ
CQl0c3RfcmVzbShURkFJTCwgImNoaWxkICVkIGhhcyAlYyBhdCAiCisJCQkJCQkiJWQsJWQsJWQu
IiwKKwkJCQkJCXByb2MsIG1lbW9yeVtwcm9jXVtqXVtpXSwgcHJvYywKKwkJCQkJCWosIGkpOwor
CWZyZWUocyk7Cit9CisKK3ZvaWQgZ3JvdXBfY2hlY2soaW50IHJ1biwgaW50IHBhZ2VzX3NoYXJl
ZCwgaW50IHBhZ2VzX3NoYXJpbmcsCisJCWludCBwYWdlc192b2xhdGlsZSwgaW50IHBhZ2VzX3Vu
c2hhcmVkLAorCQlpbnQgc2xlZXBfbWlsbGlzZWNzLCBpbnQgcGFnZXNfdG9fc2NhbikKK3sKKyAg
ICAgICAgLyogNSBzZWNvbmRzIGZvciBrc20gdG8gc2NhbiBwYWdlcy4gKi8KKwlzbGVlcCg1KTsK
Kwl0c3RfcmVzbShUSU5GTywgImNoZWNrISIpOworCWNoZWNrKCJydW4iLCBydW4pOworCWNoZWNr
KCJwYWdlc19zaGFyZWQiLCBwYWdlc19zaGFyZWQpOworCWNoZWNrKCJwYWdlc19zaGFyaW5nIiwg
cGFnZXNfc2hhcmluZyk7CisJY2hlY2soInBhZ2VzX3ZvbGF0aWxlIiwgcGFnZXNfdm9sYXRpbGUp
OworCWNoZWNrKCJwYWdlc191bnNoYXJlZCIsIHBhZ2VzX3Vuc2hhcmVkKTsKKwljaGVjaygic2xl
ZXBfbWlsbGlzZWNzIiwgc2xlZXBfbWlsbGlzZWNzKTsKKwljaGVjaygicGFnZXNfdG9fc2NhbiIs
IHBhZ2VzX3RvX3NjYW4pOworfQorCit2b2lkIGNyZWF0ZV9zYW1lX21lbW9yeShpbnQgc2l6ZSwg
aW50IG51bSwgaW50IHVuaXQpCit7CisJY2hhciBidWZbQlVGU0laXSwgYnVmMltCVUZTSVpdOwor
CWludCBpLCBqLCBrOworCWludCBzdGF0dXMsIGZkOworCWludCAqY2hpbGQ7CisKKwljaGlsZCA9
IG1hbGxvYyhudW0pOworCWlmIChjaGlsZCA9PSBOVUxMKQorCQl0c3RfYnJrbShUQlJPS3xURVJS
Tk8sIGNsZWFudXAsICJtYWxsb2MiKTsKKworCW1lbW9yeSA9IG1hbGxvYyhudW0gKiBzaXplb2Yo
KiptZW1vcnkpKTsKKwlpZiAobWVtb3J5ID09IE5VTEwpCisJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgY2xlYW51cCwgIm1hbGxvYyIpOworCisJLyogRG9uJ3QgY2FsbCBjbGVhbnVwIGluIHRob3Nl
IGNoaWxkcmVuLiBJbnN0ZWFkLCBkbyBhIGNsZWFudXAgZnJvbSB0aGUKKwkgICBwYXJlbnQgYWZ0
ZXIgZmV0Y2hlZCBjaGlsZHJlbidzIHN0YXR1cy4qLworCXN3aXRjaCAoY2hpbGRbMF0gPSBmb3Jr
KCkpIHsKKwljYXNlIC0xOgorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJmb3Jr
Iik7CisJY2FzZSAwOgorCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDAgc3RvcHMuIik7CisJCWlm
IChyYWlzZShTSUdTVE9QKSA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgdHN0X2V4
aXQsICJraWxsIik7CisKKwkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAwIGNvbnRpbnVlcy4uLiIp
OworCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDAgYWxsb2NhdGVzICVkIE1CIGZpbGxlZCB3aXRo
ICdjJy4iLAorCQkJc2l6ZSk7CisJCW1lbW9yeVswXSA9IG1hbGxvYyhzaXplIC8gdW5pdCAqIHNp
emVvZigqbWVtb3J5KSk7CisJCWlmIChtZW1vcnlbMF0gPT0gTlVMTCkKKwkJCXRzdF9icmttKFRC
Uk9LfFRFUlJOTywgdHN0X2V4aXQsICJtYWxsb2MiKTsKKwkJZm9yIChqID0gMDsgaiAqIHVuaXQg
PCBzaXplOyBqKyspIHsKKwkJCW1lbW9yeVswXVtqXSA9IG1tYXAoTlVMTCwgdW5pdCAqIE1CLAor
CQkJCQlQUk9UX1JFQUR8UFJPVF9XUklURSwKKwkJCQkJTUFQX0FOT05ZTU9VU3xNQVBfUFJJVkFU
RSwgLTEsIDApOworCQkJaWYgKG1lbW9yeVswXVtqXSA9PSBNQVBfRkFJTEVEKQorCQkJCXRzdF9i
cmttKFRCUk9LfFRFUlJOTywgdHN0X2V4aXQsICJtbWFwIik7CisJCQlpZiAobWFkdmlzZShtZW1v
cnlbMF1bal0sIHVuaXQgKiBNQiwgTUFEVl9NRVJHRUFCTEUpCisJCQkJPT0gLTEpCisJCQkJdHN0
X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgIm1hZHZpc2UiKTsKKwkJCWZvciAoaSA9IDA7
IGkgPCB1bml0ICogTUI7IGkrKykKKwkJCQltZW1vcnlbMF1bal1baV0gPSAnYyc7CisJCX0KKwkJ
dHN0X3Jlc20oVElORk8sICJjaGlsZCAwIHN0b3BzLiIpOworCQlpZiAocmFpc2UoU0lHU1RPUCkg
PT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAia2lsbCIpOworCisJ
CXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMCBjb250aW51ZXMuLi4iKTsKKwkJdmVyaWZ5KCdjJywg
MCwgMCwgc2l6ZSAvIHVuaXQsIDAsIHVuaXQgKiBNQik7CisJCXRzdF9yZXNtKFRJTkZPLCAiY2hp
bGQgMCBjaGFuZ2VzIG1lbW9yeSBjb250ZW50IHRvICdkJy4iKTsKKwkJZm9yIChqID0gMDsgaiA8
IHNpemUgLyB1bml0OyBqKyspIHsKKwkJCWZvciAoaSA9IDA7IGkgPCB1bml0ICogTUI7IGkrKykK
KwkJCQltZW1vcnlbMF1bal1baV0gPSAnZCc7CisJCX0KKwkJLyogVW5tZXJnZS4gKi8KKwkJdHN0
X3Jlc20oVElORk8sICJjaGlsZCAwIHN0b3BzLiIpOworCQlpZiAocmFpc2UoU0lHU1RPUCkgPT0g
LTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAia2lsbCIpOworCisJCXRz
dF9yZXNtKFRJTkZPLCAiY2hpbGQgMCBjb250aW51ZXMuLi4iKTsKKwkJdmVyaWZ5KCdkJywgMCwg
MCwgc2l6ZSAvIHVuaXQsIDAsIHVuaXQgKiBNQik7CisJCS8qIFN0b3AuICovCisJCXRzdF9yZXNt
KFRJTkZPLCAiY2hpbGQgMCBzdG9wcy4iKTsKKwkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQor
CQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgImtpbGwiKTsKKwkJdHN0X3Jlc20o
VElORk8sICJjaGlsZCAwIGNvbnRpbnVlcy4uLiIpOworCQlleGl0KDApOworCX0KKwlzd2l0Y2gg
KGNoaWxkWzFdID0gZm9yaygpKSB7CisJY2FzZSAtMToKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5P
LCBjbGVhbnVwLCAiZm9yayIpOworCWNhc2UgMDoKKwkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAx
IHN0b3BzLiIpOworCQlpZiAocmFpc2UoU0lHU1RPUCkgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJP
S3xURVJSTk8sIHRzdF9leGl0LCAia2lsbCIpOworCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEg
Y29udGludWVzLi4uIik7CisJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMSBhbGxvY2F0ZXMgJWQg
TUIgZmlsbGVkIHdpdGggJ2EnLiIsCisJCQlzaXplKTsKKwkJbWVtb3J5WzFdID0gbWFsbG9jKHNp
emUgLyB1bml0ICogc2l6ZW9mKCptZW1vcnkpKTsKKwkJaWYgKG1lbW9yeVsxXSA9PSBOVUxMKQor
CQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgIm1hbGxvYyIpOworCQlmb3IgKGog
PSAwOyBqIDwgc2l6ZSAvIHVuaXQ7IGorKykgeworCQkJbWVtb3J5WzFdW2pdID0gbW1hcChOVUxM
LCB1bml0ICogTUIsCisJCQkJCVBST1RfUkVBRHxQUk9UX1dSSVRFLAorCQkJCQlNQVBfQU5PTllN
T1VTfE1BUF9QUklWQVRFLCAtMSwgMCk7CisJCQlpZiAobWVtb3J5WzFdW2pdID09IE1BUF9GQUlM
RUQpCisJCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgIm1tYXAiKTsKKwkJCWlm
IChtYWR2aXNlKG1lbW9yeVsxXVtqXSwgdW5pdCAqIE1CLCBNQURWX01FUkdFQUJMRSkKKwkJCQk9
PSAtMSkKKwkJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAibWFkdmlzZSIpOwor
CQkJZm9yIChpID0gMDsgaSA8IHVuaXQgKiBNQjsgaSsrKQorCQkJCW1lbW9yeVsxXVtqXVtpXSA9
ICdhJzsKKwkJfQorCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgc3RvcHMuIik7CisJCWlmIChy
YWlzZShTSUdTVE9QKSA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgdHN0X2V4aXQs
ICJraWxsIik7CisJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMSBjb250aW51ZXMuLi4iKTsKKwkJ
dmVyaWZ5KCdhJywgMSwgMCwgc2l6ZSAvIHVuaXQsIDAsIHVuaXQgKiBNQik7CisJCXRzdF9yZXNt
KFRJTkZPLCAiY2hpbGQgMSBjaGFuZ2VzIG1lbW9yeSBjb250ZW50IHRvICdiJy4iKTsKKwkJZm9y
IChqID0gMDsgaiA8IHNpemUgLyB1bml0OyBqKyspIHsKKwkJCWZvciAoaSA9IDA7IGkgPCB1bml0
ICogTUI7IGkrKykKKwkJCQltZW1vcnlbMV1bal1baV0gPSAnYic7CisJCX0KKwkJdHN0X3Jlc20o
VElORk8sICJjaGlsZCAxIHN0b3BzLiIpOworCQlpZiAocmFpc2UoU0lHU1RPUCkgPT0gLTEpCisJ
CQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAia2lsbCIpOworCQl0c3RfcmVzbShU
SU5GTywgImNoaWxkIDEgY29udGludWVzLi4uIik7CisJCXZlcmlmeSgnYicsIDEsIDAsIHNpemUg
LyB1bml0LCAwLCB1bml0ICogTUIpOworCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgY2hhbmdl
cyBtZW1vcnkgY29udGVudCB0byAnZCciKTsKKwkJZm9yIChqID0gMDsgaiA8IHNpemUgLyB1bml0
OyBqKyspIHsKKwkJCWZvciAoaSA9IDA7IGkgPCB1bml0ICogTUI7IGkrKykKKwkJCQltZW1vcnlb
MV1bal1baV0gPSAnZCc7CisJCX0KKwkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQorCQkJdHN0
X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgImtpbGwiKTsKKworCQl0c3RfcmVzbShUSU5G
TywgImNoaWxkIDEgY29udGludWVzLi4uIik7CisJCXZlcmlmeSgnZCcsIDEsIDAsIHNpemUgLyB1
bml0LCAwLCB1bml0ICogTUIpOworCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgY2hhbmdlcyBv
bmUgcGFnZSB0byAnZScuIik7CisJCW1lbW9yeVsxXVtzaXplIC8gdW5pdCAtIDFdW3VuaXQgKiBN
QiAtIDFdID0gJ2UnOworCisJCS8qIFVubWVyZ2UuICovCisJCXRzdF9yZXNtKFRJTkZPLCAiY2hp
bGQgMSBzdG9wcy4iKTsKKwkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQorCQkJdHN0X2Jya20o
VEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgImtpbGwiKTsKKwkJdHN0X3Jlc20oVElORk8sICJjaGls
ZCAxIGNvbnRpbnVlcy4uLiIpOworCQl2ZXJpZnkoJ2UnLCAxLCBzaXplIC8gdW5pdCAtIDEsIHNp
emUgLyB1bml0LAorCQkJdW5pdCAqIE1CIC0gMSwgdW5pdCAqIE1CKTsKKwkJdmVyaWZ5KCdkJywg
MSwgMCwgc2l6ZSAvIHVuaXQgLSAxLCAwLCB1bml0ICogTUIgLSAxKTsKKworCQkvKiBTdG9wLiAq
LworCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgc3RvcHMuIik7CisJCWlmIChyYWlzZShTSUdT
VE9QKSA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgdHN0X2V4aXQsICJraWxsIik7
CisJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMSBjb250aW51ZXMuLi4iKTsKKwkJZXhpdCgwKTsK
Kwl9CisJZm9yIChrID0gMjsgayA8IG51bTsgaysrKSB7CisJCXN3aXRjaCAoY2hpbGRba10gPSBm
b3JrKCkpIHsKKwkJY2FzZSAtMToKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwg
ImZvcmsiKTsKKwkJY2FzZSAwOgorCQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAlZCBzdG9wcy4i
LCBrKTsKKwkJCWlmIChyYWlzZShTSUdTVE9QKSA9PSAtMSkKKwkJCQl0c3RfYnJrbShUQlJPS3xU
RVJSTk8sIHRzdF9leGl0LCAia2lsbCIpOworCQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAlZCBj
b250aW51ZXMuLi4iLCBrKTsKKwkJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgYWxsb2NhdGVz
ICVkICIKKwkJCQkiTUIgZmlsbGVkIHdpdGggJ2EnLiIsIGssIHNpemUpOworCQkJbWVtb3J5W2td
ID0gbWFsbG9jKHNpemUgLyB1bml0ICogc2l6ZW9mKCptZW1vcnkpKTsKKwkJCWlmIChtZW1vcnlb
a10gPT0gTlVMTCkKKwkJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAibWFsbG9j
Iik7CisJCQlmb3IgKGogPSAwOyBqIDwgc2l6ZSAvIHVuaXQ7IGorKykgeworCQkJCW1lbW9yeVtr
XVtqXSA9IG1tYXAoTlVMTCwgdW5pdCAqIE1CLAorCQkJCQkJUFJPVF9SRUFEfFBST1RfV1JJVEUs
CisJCQkJCQlNQVBfQU5PTllNT1VTCisJCQkJCQl8TUFQX1BSSVZBVEUsIC0xLCAwKTsKKwkJCQlp
ZiAobWVtb3J5W2tdW2pdID09IE1BUF9GQUlMRUQpCisJCQkJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgY2xlYW51cCwKKwkJCQkJCSJtbWFwIik7CisJCQkJaWYgKG1hZHZpc2UobWVtb3J5W2tdW2pd
LCB1bml0ICogTUIsCisJCQkJCQlNQURWX01FUkdFQUJMRSkgPT0gLTEpCisJCQkJCXRzdF9icmtt
KFRCUk9LfFRFUlJOTywgY2xlYW51cCwKKwkJCQkJCSJtYWR2aXNlIik7CisJCQkJZm9yIChpID0g
MDsgaSA8IHVuaXQgKiBNQjsgaSsrKQorCQkJCQltZW1vcnlba11bal1baV0gPSAnYSc7CisJCQl9
CisJCQl0c3RfcmVzbShUSU5GTywgImNoaWxkICVkIHN0b3BzLiIsIGspOworCQkJaWYgKHJhaXNl
KFNJR1NUT1ApID09IC0xKQorCQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgdHN0X2V4aXQsICJr
aWxsIik7CisJCQl0c3RfcmVzbShUSU5GTywgImNoaWxkICVkIGNvbnRpbnVlcy4uLiIsIGspOwor
CQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAlZCBjaGFuZ2VzIG1lbW9yeSBjb250ZW50IHRvICIK
KwkJCQkiJ2QnIiwgayk7CisJCQlmb3IgKGogPSAwOyBqIDwgc2l6ZSAvIHVuaXQ7IGorKykgewor
CQkJCWZvciAoaSA9IDA7IGkgPCB1bml0ICogTUI7IGkrKykKKwkJCQkJbWVtb3J5W2tdW2pdW2ld
ID0gJ2QnOworCQkgICAgICAgIH0KKwkJCS8qIFVubWVyZ2UuICovCisJCQl0c3RfcmVzbShUSU5G
TywgImNoaWxkICVkIHN0b3BzLiIsIGspOworCQkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQor
CQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgdHN0X2V4aXQsICJraWxsIik7CisJCQl0c3RfcmVz
bShUSU5GTywgImNoaWxkICVkIGNvbnRpbnVlcy4uLiIsIGspOworCisJCQkvKiBTdG9wLiAqLwor
CQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAlZCBzdG9wcy4iLCBrKTsKKwkJCWlmIChyYWlzZShT
SUdTVE9QKSA9PSAtMSkKKwkJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAia2ls
bCIpOworCQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAlZCBjb250aW51ZXMuLi4iLCBrKTsKKwkJ
CWV4aXQoMCk7CisJCX0KKwl9CisJdHN0X3Jlc20oVElORk8sICJLU00gbWVyZ2luZy4uLiIpOwor
CXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMlcyIsIFBBVEhfS1NNLCAicnVuIik7CisJZmQgPSBv
cGVuKGJ1ZiwgT19XUk9OTFkpOworCWlmIChmZCA9PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVS
Uk5PLCBjbGVhbnVwLCAib3BlbiIpOworCWlmICh3cml0ZShmZCwgIjEiLCAxKSAhPSAxKQorCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSIpOworCWNsb3NlKGZkKTsKKwlz
bnByaW50ZihidWYsIEJVRlNJWiwgIiVzJXMiLCBQQVRIX0tTTSwgInBhZ2VzX3RvX3NjYW4iKTsK
KwlzbnByaW50ZihidWYyLCBCVUZTSVosICIlZCIsIHNpemUgKiAyNTYgKiBudW0pOworCWZkID0g
b3BlbihidWYsIE9fV1JPTkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRF
UlJOTywgY2xlYW51cCwgIm9wZW4iKTsKKwlpZiAod3JpdGUoZmQsIGJ1ZjIsIHN0cmxlbihidWYy
KSkgIT0gc3RybGVuKGJ1ZjIpKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3
cml0ZSIpOworCWNsb3NlKGZkKTsKKworCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMlcyIsIFBB
VEhfS1NNLCAic2xlZXBfbWlsbGlzZWNzIik7CisJZmQgPSBvcGVuKGJ1ZiwgT19XUk9OTFkpOwor
CWlmIChmZCA9PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiIp
OworCWlmICh3cml0ZShmZCwgIjAiLCAxKSAhPSAxKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8s
IGNsZWFudXAsICJ3cml0ZSIpOworCWNsb3NlKGZkKTsKKworCXRzdF9yZXNtKFRJTkZPLCAid2Fp
dCBmb3IgYWxsIGNoaWxkcmVuIHRvIHN0b3AuIik7CisJZm9yIChrID0gMDsgayA8IG51bTsgaysr
KSB7CisJCWlmICh3YWl0cGlkKGNoaWxkW2tdLCAmc3RhdHVzLCBXVU5UUkFDRUQpID09IC0xKQor
CQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid2FpdHBpZCIpOworCQlpZiAoIVdJ
RlNUT1BQRUQoc3RhdHVzKSkKKwkJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiY2hpbGQgJWQg
d2FzIG5vdCBzdG9wcGVkLiIsCisJCQkJayk7CisJfQorCXRzdF9yZXNtKFRJTkZPLCAicmVzdW1l
IGFsbCBjaGlsZHJlbi4iKTsKKwlmb3IgKGsgPSAwOyBrIDwgbnVtOyBrKyspIHsKKwkJaWYgKGtp
bGwoY2hpbGRba10sIFNJR0NPTlQpID09IC0xKQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBj
bGVhbnVwLCAia2lsbCBjaGlsZFslZF0iLCBrKTsKKwl9CisJZ3JvdXBfY2hlY2soMSwgMiwgc2l6
ZSAqIG51bSAqIDI1NiAtIDIsIDAsIDAsIDAsIHNpemUgKiAyNTYgKiBudW0pOworCisJdHN0X3Jl
c20oVElORk8sICJ3YWl0IGZvciBjaGlsZCAxIHRvIHN0b3AuIik7CisJaWYgKHdhaXRwaWQoY2hp
bGRbMV0sICZzdGF0dXMsIFdVTlRSQUNFRCkgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgY2xlYW51cCwgIndhaXRwaWQiKTsKKwlpZiAoIVdJRlNUT1BQRUQoc3RhdHVzKSkKKwkJdHN0
X2Jya20oVEJST0ssIGNsZWFudXAsICJjaGlsZCAxIHdhcyBub3Qgc3RvcHBlZC4iKTsKKworCS8q
IENoaWxkIDEgY2hhbmdlcyBhbGwgcGFnZXMgdG8gJ2InLiAqLworCXRzdF9yZXNtKFRJTkZPLCAi
cmVzdW1lIGNoaWxkIDEuIik7CisJaWYgKGtpbGwoY2hpbGRbMV0sIFNJR0NPTlQpID09IC0xKQor
CQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJraWxsIik7CisJZ3JvdXBfY2hlY2so
MSwgMywgc2l6ZSAqIG51bSAqIDI1NiAtIDMsIDAsIDAsIDAsIHNpemUgKiAyNTYgKiBudW0pOwor
CisJdHN0X3Jlc20oVElORk8sICJ3YWl0IGZvciBjaGlsZCAxIHRvIHN0b3AuIik7CisJaWYgKHdh
aXRwaWQoY2hpbGRbMV0sICZzdGF0dXMsIFdVTlRSQUNFRCkgPT0gLTEpCisJCXRzdF9icmttKFRC
Uk9LfFRFUlJOTywgY2xlYW51cCwgIndhaXRwaWQiKTsKKwlpZiAoIVdJRlNUT1BQRUQoc3RhdHVz
KSkKKwkJdHN0X2Jya20oVEJST0ssIGNsZWFudXAsICJjaGlsZCAxIHdhcyBub3Qgc3RvcHBlZC4i
KTsKKworCS8qIEFsbCBjaGlsZHJlbiBjaGFuZ2UgcGFnZXMgdG8gJ2QnLiAqLworCXRzdF9yZXNt
KFRJTkZPLCAicmVzdW1lIGFsbCBjaGlsZHJlbi4iKTsKKwlmb3IgKGsgPSAwOyBrIDwgbnVtOyBr
KyspIHsKKwkJaWYgKGtpbGwoY2hpbGRba10sIFNJR0NPTlQpID09IC0xKQorCQkJdHN0X2Jya20o
VEJST0t8VEVSUk5PLCBjbGVhbnVwLCAia2lsbCBjaGlsZFslZF0iLCBrKTsKKwl9CisJZ3JvdXBf
Y2hlY2soMSwgMSwgc2l6ZSAqIG51bSAqIDI1NiAtIDEsIDAsIDAsIDAsIHNpemUgKiAyNTYgKiBu
dW0pOworCisJdHN0X3Jlc20oVElORk8sICJ3YWl0IGZvciBhbGwgY2hpbGRyZW4gdG8gc3RvcC4i
KTsKKwlmb3IgKGsgPSAwOyBrIDwgbnVtOyBrKyspIHsKKwkJaWYgKHdhaXRwaWQoY2hpbGRba10s
ICZzdGF0dXMsIFdVTlRSQUNFRCkgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNs
ZWFudXAsICJ3YWl0cGlkIik7CisJCWlmICghV0lGU1RPUFBFRChzdGF0dXMpKQorCQkJdHN0X2Jy
a20oVEJST0ssIGNsZWFudXAsICJjaGlsZCAlZCB3YXMgbm90IHN0b3BwZWQuIiwKKwkJCQlrKTsK
Kwl9CisJLyogQ2hpbGQgMSBjaGFuZ2VzIHBhZ2VzIHRvICdlJy4gKi8KKwl0c3RfcmVzbShUSU5G
TywgInJlc3VtZSBjaGlsZCAxLiIpOworCWlmIChraWxsKGNoaWxkWzFdLCBTSUdDT05UKSA9PSAt
MSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAia2lsbCIpOworCWdyb3VwX2No
ZWNrKDEsIDEsIHNpemUgKiBudW0gKiAyNTYgLSAyLCAwLCAxLCAwLCBzaXplICogMjU2ICogbnVt
KTsKKworCXRzdF9yZXNtKFRJTkZPLCAid2FpdCBmb3IgY2hpbGQgMSB0byBzdG9wLiIpOworCWlm
ICh3YWl0cGlkKGNoaWxkWzFdLCAmc3RhdHVzLCBXVU5UUkFDRUQpID09IC0xKQorCQl0c3RfYnJr
bShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3YWl0cGlkIik7CisJaWYgKCFXSUZTVE9QUEVEKHN0
YXR1cykpCisJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiY2hpbGQgMSB3YXMgbm90IHN0b3Bw
ZWQuIik7CisKKwl0c3RfcmVzbShUSU5GTywgInJlc3VtZSBhbGwgY2hpbGRyZW4uIik7CisJZm9y
IChrID0gMDsgayA8IG51bTsgaysrKSB7CisJCWlmIChraWxsKGNoaWxkW2tdLCBTSUdDT05UKSA9
PSAtMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgImtpbGwgY2hpbGRbJWRd
Iiwgayk7CisJfQorCXRzdF9yZXNtKFRJTkZPLCAiS1NNIHVubWVyZ2luZy4uLiIpOworCXNucHJp
bnRmKGJ1ZiwgQlVGU0laLCAiJXMlcyIsIFBBVEhfS1NNLCAicnVuIik7CisJZmQgPSBvcGVuKGJ1
ZiwgT19XUk9OTFkpOworCWlmIChmZCA9PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBj
bGVhbnVwLCAib3BlbiIpOworCWlmICh3cml0ZShmZCwgIjIiLCAxKSAhPSAxKQorCQl0c3RfYnJr
bShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSIpOworCWdyb3VwX2NoZWNrKDIsIDAsIDAs
IDAsIDAsIDAsIHNpemUgKiAyNTYgKiBudW0pOworCisJdHN0X3Jlc20oVElORk8sICJ3YWl0IGZv
ciBhbGwgY2hpbGRyZW4gdG8gc3RvcC4iKTsKKwlmb3IgKGsgPSAwOyBrIDwgbnVtOyBrKyspIHsK
KwkJaWYgKHdhaXRwaWQoY2hpbGRba10sICZzdGF0dXMsIFdVTlRSQUNFRCkgPT0gLTEpCisJCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3YWl0cGlkIik7CisJCWlmICghV0lGU1RP
UFBFRChzdGF0dXMpKQorCQkJdHN0X2Jya20oVEJST0ssIGNsZWFudXAsICJjaGlsZCAlZCB3YXMg
bm90IHN0b3BwZWQuIiwKKwkJCQlrKTsKKwl9CisJdHN0X3Jlc20oVElORk8sICJyZXN1bWUgYWxs
IGNoaWxkcmVuLiIpOworCWZvciAoayA9IDA7IGsgPCBudW07IGsrKykgeworCQlpZiAoa2lsbChj
aGlsZFtrXSwgU0lHQ09OVCkgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFu
dXAsICJraWxsIGNoaWxkWyVkXSIsIGspOworCX0KKwl0c3RfcmVzbShUSU5GTywgInN0b3AgS1NN
LiIpOworCWlmIChsc2VlayhmZCwgMCwgU0VFS19TRVQpID09IC0xKQorCQl0c3RfYnJrbShUQlJP
S3xURVJSTk8sIGNsZWFudXAsICJsc2VlayIpOworCWlmICh3cml0ZShmZCwgIjAiLCAxKSAhPSAx
KQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSIpOworCWNsb3NlKGZk
KTsKKwlncm91cF9jaGVjaygwLCAwLCAwLCAwLCAwLCAwLCBzaXplICogMjU2ICogbnVtKTsKKwl3
aGlsZSAod2FpdHBpZCgtMSwgJnN0YXR1cywgV1VOVFJBQ0VEIHwgV0NPTlRJTlVFRCkgPiAwKQor
CQlpZiAoV0VYSVRTVEFUVVMoc3RhdHVzKSAhPSAwKQorCQkJdHN0X3Jlc20oVEZBSUwsICJjaGls
ZCBleGl0IHN0YXR1cyBpcyAlZCIsCisJCQkJV0VYSVRTVEFUVVMoc3RhdHVzKSk7Cit9CisKK3Zv
aWQgY2hlY2tfa3NtX29wdGlvbnMoaW50ICpzaXplLCBpbnQgKm51bSwgaW50ICp1bml0KQorewor
CWlmIChvcHRfc2l6ZSkgeworCQkqc2l6ZSA9IGF0b2kob3B0X3NpemVzdHIpOworCQlpZiAoKnNp
emUgPCAxKQorCQkJdHN0X2Jya20oVEJST0ssIGNsZWFudXAsCisJCQkJInNpemUgY2Fubm90IGJl
IGxlc3MgdGhhbiAxLiIpOworCX0KKwlpZiAob3B0X3VuaXQpIHsKKwkJKnVuaXQgPSBhdG9pKG9w
dF91bml0c3RyKTsKKwkJaWYgKCp1bml0ID4gKnNpemUpCisJCQl0c3RfYnJrbShUQlJPSywgY2xl
YW51cCwKKwkJCQkidW5pdCBjYW5ub3QgYmUgZ3JlYXRlciB0aGFuIHNpemUuIik7CisJCWlmICgq
c2l6ZSAlICp1bml0ICE9IDApCisJCQl0c3RfYnJrbShUQlJPSywgY2xlYW51cCwKKwkJCQkidGhl
IHJlbWFpbmRlciBvZiBkaXZpc2lvbiBvZiBzaXplIGJ5IHVuaXQgaXMgIgorCQkJCSJub3QgemVy
by4iKTsKKwl9CisJaWYgKG9wdF9udW0pIHsKKwkJKm51bSA9IGF0b2kob3B0X251bXN0cik7CisJ
CWlmICgqbnVtIDwgMykKKwkJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLAorCQkJCSJwcm9jZXNz
IG51bWJlciBjYW5ub3QgYmUgbGVzcyAzLiIpOworCX0KK30KZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvbWVtL29vbS9NYWtlZmlsZSBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9NYWtl
ZmlsZQppbmRleCAwMWMwNTQ2Li44MTUwOWJmIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVs
L21lbS9vb20vTWFrZWZpbGUKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL01ha2VmaWxl
CkBAIC0yMCw5ICsyMCw5IEBAIHRvcF9zcmNkaXIgICAgICAgICAgICAgID89IC4uLy4uLy4uLy4u
CiAKIGluY2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL2Vudl9wcmUubWsKIAotTERMSUJT
CQkJKz0gJChOVU1BX0xJQlMpIC1sb29tCi1MSUJESVIJCQk6PSBsaWIKLUxJQgkJCTo9ICQoTElC
RElSKS9saWJvb20uYQorTERMSUJTCQkJKz0gJChOVU1BX0xJQlMpIC1sbWVtCitMSUJESVIJCQk6
PSAuLi9saWIKK0xJQgkJCTo9ICQoTElCRElSKS9saWJtZW0uYQogRklMVEVSX09VVF9ESVJTCQk6
PSAkKExJQkRJUikKIExERkxBR1MJCQkrPSAtTCQoTElCRElSKQogCmRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9v
b20wMS5jCmluZGV4IGM2NzBkOTAuLmI2YzlkODMgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvbWVtL29vbS9vb20wMS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMS5j
CkBAIC0zOCwxMyArMzgsMTAgQEAKICNpbmNsdWRlIDx1bmlzdGQuaD4KICNpbmNsdWRlICJ0ZXN0
LmgiCiAjaW5jbHVkZSAidXNjdGVzdC5oIgotI2luY2x1ZGUgImxpYi9vb20uaCIKKyNpbmNsdWRl
ICIuLi9pbmNsdWRlL21lbS5oIgogCiBjaGFyICpUQ0lEID0gIm9vbTAxIjsKIGludCBUU1RfVE9U
QUwgPSAxOwotZXh0ZXJuIGludCBUc3RfY291bnQ7Ci0KLXN0YXRpYyB2b2lkIHNldHVwKHZvaWQp
OwogCiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogewpkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20v
b29tMDIuYwppbmRleCA2OGVkMWVmLi4wNGM2NTA3IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2Vy
bmVsL21lbS9vb20vb29tMDIuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDIu
YwpAQCAtNDIsOSArNDIsNyBAQCBpbnQgVFNUX1RPVEFMID0gMTsKICNpbmNsdWRlIDxmY250bC5o
PgogI2luY2x1ZGUgPHN0ZGlvLmg+CiAjaW5jbHVkZSA8ZXJybm8uaD4KLSNpbmNsdWRlICJsaWIv
b29tLmgiCi0KLXN0YXRpYyB2b2lkIHNldHVwKHZvaWQpOworI2luY2x1ZGUgIi4uL2luY2x1ZGUv
bWVtLmgiCiAKIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiB7CmRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L29vbS9vb20wMy5jCmluZGV4IGRkMDk0NjcuLmRhMDFkM2UgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvbWVtL29vbS9vb20wMy5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9v
b20wMy5jCkBAIC0zNSwxMyArMzUsMTAgQEAKICNpbmNsdWRlIDxlcnJuby5oPgogI2luY2x1ZGUg
InRlc3QuaCIKICNpbmNsdWRlICJ1c2N0ZXN0LmgiCi0jaW5jbHVkZSAibGliL29vbS5oIgorI2lu
Y2x1ZGUgIi4uL2luY2x1ZGUvbWVtLmgiCiAKIGNoYXIgKlRDSUQgPSAib29tMDMiOwogaW50IFRT
VF9UT1RBTCA9IDE7Ci1leHRlcm4gaW50IFRzdF9jb3VudDsKLQotc3RhdGljIHZvaWQgc2V0dXAo
dm9pZCk7CiAKIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiB7CmRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDQuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L29vbS9vb20wNC5jCmluZGV4IDFkZmY4NWUuLjhlYjVjMDQgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvbWVtL29vbS9vb20wNC5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9v
b20wNC5jCkBAIC0zNCw1NSArMzQsMTUgQEAKIAogY2hhciAqVENJRCA9ICJvb20wNCI7CiBpbnQg
VFNUX1RPVEFMID0gMTsKLWV4dGVybiBpbnQgVHN0X2NvdW50OwogCiAjaWYgSEFWRV9OVU1BX0gg
JiYgSEFWRV9MSU5VWF9NRU1QT0xJQ1lfSCAmJiBIQVZFX05VTUFJRl9IIFwKIAkmJiBIQVZFX01Q
T0xfQ09OU1RBTlRTCi0jaW5jbHVkZSA8c3lzL21tYW4uaD4KICNpbmNsdWRlIDxzeXMvdHlwZXMu
aD4KICNpbmNsdWRlIDxzeXMvc3RhdC5oPgotI2luY2x1ZGUgPHN5cy93YWl0Lmg+Ci0jaW5jbHVk
ZSA8c3lzL21vdW50Lmg+Ci0jaW5jbHVkZSA8bnVtYWlmLmg+CiAjaW5jbHVkZSA8ZmNudGwuaD4K
ICNpbmNsdWRlIDxzdGRpby5oPgotI2luY2x1ZGUgPHVuaXN0ZC5oPgogI2luY2x1ZGUgPGVycm5v
Lmg+Ci0jaW5jbHVkZSA8c3RkbGliLmg+Ci0jaW5jbHVkZSA8c3RyaW5nLmg+Ci0jaW5jbHVkZSA8
ZXJybm8uaD4KLSNpbmNsdWRlIDxzaWduYWwuaD4KLSNpbmNsdWRlIDx1bmlzdGQuaD4KLSNpbmNs
dWRlIDxzdGRhcmcuaD4KLQotI2RlZmluZSBNQVhOT0RFUwkJNTEyCi0jZGVmaW5lIENQQVRICQkJ
Ii9kZXYvY3B1c2V0IgotI2RlZmluZSBDUEFUSF9ORVcJCUNQQVRIICIvMSIKLSNkZWZpbmUgTUVN
Q0dfUEFUSAkJIi9kZXYvY2dyb3VwIgotI2RlZmluZSBNRU1DR19QQVRIX05FVwkJTUVNQ0dfUEFU
SCAiLzEiCi0jZGVmaW5lIF9QQVRIX1NZU19TWVNURU0JIi9zeXMvZGV2aWNlcy9zeXN0ZW0iCi0j
ZGVmaW5lIExFTkdUSAkJCSgzVUw8PDMwKQotI2RlZmluZSBURVNUTUVNCQkJKDFVTDw8MzApCi0j
ZGVmaW5lIE1CCQkJKDFVTDw8MjApCi0jZGVmaW5lIE5PUk1BTAkJCTEKLSNkZWZpbmUgTUxPQ0sJ
CQkyCi0jZGVmaW5lIEtTTQkJCTMKLSNkZWZpbmUgU1lTRlNfT1ZFUgkJIi9wcm9jL3N5cy92bS9v
dmVyY29tbWl0X21lbW9yeSIKLQotc3RhdGljIGNoYXIgb3ZlcmNvbW1pdFtCVUZTSVpdOwotCi1z
dGF0aWMgdm9pZCBzZXR1cCh2b2lkKTsKLXN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkgTFRQX0FU
VFJJQlVURV9OT1JFVFVSTjsKLXN0YXRpYyB2b2lkIG9vbShpbnQgdGVzdGNhc2UsIGludCBtZW1w
b2xpY3ksIGludCBsaXRlKTsKLXN0YXRpYyBsb25nIGNvdW50X251bWEodm9pZCk7Ci1zdGF0aWMg
aW50IHBhdGhfZXhpc3QoY29uc3QgY2hhciAqcGF0aCwgLi4uKTsKLXN0YXRpYyB2b2lkIHRlc3Rv
b20oaW50IG1lbXBvbGljeSwgaW50IGxpdGUpOwotc3RhdGljIHZvaWQgYWxsb2NfbWVtKGxvbmcg
aW50IGxlbmd0aCwgaW50IHRlc3RjYXNlKTsKLXN0YXRpYyB2b2lkIHRlc3RfYWxsb2MoaW50IHRl
c3RjYXNlLCBpbnQgbGl0ZSk7Ci1zdGF0aWMgdm9pZCBnYXRoZXJfY3B1cyhjaGFyICpjcHVzKTsK
LXN0YXRpYyB2b2lkIHVtb3VudF9tZW0oY2hhciAqcGF0aCwgY2hhciAqcGF0aF9uZXcpOwotc3Rh
dGljIHZvaWQgbW91bnRfbWVtKGNoYXIgKm5hbWUsIGNoYXIgKmZzLCBjaGFyICpvcHRpb25zLCBj
aGFyICpwYXRoLAotCQljaGFyICpwYXRoX25ldyk7CisjaW5jbHVkZSAiLi4vaW5jbHVkZS9tZW0u
aCIKIAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIHsKQEAgLTExMyw5ICs3Myw3
IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAJCQl0c3RfYnJrbShUQlJPS3xU
RVJSTk8sIGNsZWFudXAsICJ3cml0ZSIpOwogCQljbG9zZShmZCk7CiAKLQkJc25wcmludGYoYnVm
LCBCVUZTSVosICIlcy9tZW1vcnkubGltaXRfaW5fYnl0ZXMiLAotCQkJTUVNQ0dfUEFUSF9ORVcp
OwotCQlmZCA9IG9wZW4oYnVmLCBPX1dST05MWSk7CisJCWZkID0gb3BlbihNRU1DR19QQVRIX05F
VyAiL21lbW9yeS5saW1pdF9pbl9ieXRlcyIsIE9fV1JPTkxZKTsKIAkJaWYgKGZkID09IC0xKQog
CQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiAlcyIsIGJ1Zik7CiAJCXNw
cmludGYobWVtLCAiJWxkIiwgVEVTVE1FTSk7CkBAIC0xMjMsOCArODEsNyBAQCBpbnQgbWFpbihp
bnQgYXJnYywgY2hhciAqYXJndltdKQogCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVw
LCAid3JpdGUgJXMiLCBidWYpOwogCQljbG9zZShmZCk7CiAKLQkJc25wcmludGYoYnVmLCBCVUZT
SVosICIlcy90YXNrcyIsIE1FTUNHX1BBVEhfTkVXKTsKLQkJZmQgPSBvcGVuKGJ1ZiwgT19XUk9O
TFkpOworCQlmZCA9IG9wZW4oTUVNQ0dfUEFUSF9ORVcgIi90YXNrcyIsIE9fV1JPTkxZKTsKIAkJ
aWYgKGZkID09IC0xKQogCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiAl
cyIsIGJ1Zik7CiAJCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJWQiLCBnZXRwaWQoKSk7CkBAIC0x
MzUsOSArOTIsOCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCQl0c3RfcmVz
bShUSU5GTywgInByb2Nlc3MgbWVtcG9saWN5LiIpOwogCQl0ZXN0b29tKDEsIDAsIDEpOwogCi0J
CXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMvbWVtb3J5Lm1lbXN3LmxpbWl0X2luX2J5dGVzIiwK
LQkJCU1FTUNHX1BBVEhfTkVXKTsKLQkJZmQgPSBvcGVuKGJ1ZiwgT19XUk9OTFkpOworCQlmZCA9
IG9wZW4oTUVNQ0dfUEFUSF9ORVcgIi9tZW1vcnkubWVtc3cubGltaXRfaW5fYnl0ZXMiLAorCQkJ
T19XUk9OTFkpOwogCQlpZiAoZmQgPT0gLTEpCiAJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNs
ZWFudXAsICJvcGVuICVzIiwgYnVmKTsKIAkJaWYgKHdyaXRlKGZkLCBtZW0sIHN0cmxlbihtZW0p
KSAhPSBzdHJsZW4obWVtKSkKQEAgLTE0Niw5ICsxMDIsOCBAQCBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqYXJndltdKQogCQl0ZXN0b29tKDEsIDEsIDEpOwogCiAJCXRzdF9yZXNtKFRJTkZPLCAi
cHJvY2VzcyBjcHVzZXQuIik7Ci0JCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMvbWVtb3J5Lm1l
bXN3LmxpbWl0X2luX2J5dGVzIiwKLQkJCU1FTUNHX1BBVEhfTkVXKTsKLQkJZmQgPSBvcGVuKGJ1
ZiwgT19XUk9OTFkpOworCQlmZCA9IG9wZW4oTUVNQ0dfUEFUSF9ORVcgIi9tZW1vcnkubWVtc3cu
bGltaXRfaW5fYnl0ZXMiLAorCQkJT19XUk9OTFkpOwogCQlpZiAoZmQgPT0gLTEpCiAJCQl0c3Rf
YnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuICVzIiwgYnVmKTsKIAkJc3ByaW50Ziht
ZW0sICIlbGQiLCBURVNUTUVNKTsKQEAgLTE1Nyw5ICsxMTIsOCBAQCBpbnQgbWFpbihpbnQgYXJn
YywgY2hhciAqYXJndltdKQogCQljbG9zZShmZCk7CiAJCXRlc3Rvb20oMCwgMCwgMSk7CiAKLQkJ
c25wcmludGYoYnVmLCBCVUZTSVosICIlcy9tZW1vcnkubWVtc3cubGltaXRfaW5fYnl0ZXMiLAot
CQkJTUVNQ0dfUEFUSF9ORVcpOwotCQlmZCA9IG9wZW4oYnVmLCBPX1dST05MWSk7CisJCWZkID0g
b3BlbihNRU1DR19QQVRIX05FVyAiL21lbW9yeS5tZW1zdy5saW1pdF9pbl9ieXRlcyIsCisJCQlP
X1dST05MWSk7CiAJCWlmIChmZCA9PSAtMSkKIAkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xl
YW51cCwgIm9wZW4gJXMiLCBidWYpOwogCQlpZiAod3JpdGUoZmQsIG1lbSwgc3RybGVuKG1lbSkp
ICE9IHN0cmxlbihtZW0pKQpAQCAtMTY4LDUyICsxMjIsNiBAQCBpbnQgbWFpbihpbnQgYXJnYywg
Y2hhciAqYXJndltdKQogCQl0ZXN0b29tKDAsIDEsIDEpOwogCX0KIAljbGVhbnVwKCk7Ci0JdHN0
X2V4aXQoKTsKLX0KLQotdm9pZCB0ZXN0b29tKGludCBtZW1wb2xpY3ksIGludCBsaXRlKQotewot
CWludCBmZDsKLQljaGFyIGJ1ZltCVUZTSVpdID0gIiI7Ci0JY2hhciBjcHVzW0JVRlNJWl0gPSAi
IjsKLQotCWlmICghbWVtcG9saWN5KSB7Ci0JCWdhdGhlcl9jcHVzKGNwdXMpOwotCQl0c3RfcmVz
bShUSU5GTywgIkNQVSBsaXN0IGZvciAybmQgbm9kZSBpcyAlcy4iLCBjcHVzKTsKLQotCQlzbnBy
aW50ZihidWYsIEJVRlNJWiwgIiVzL2NwdXNldC5tZW1zIiwgQ1BBVEhfTkVXKTsKLQkJZmQgPSBv
cGVuKGJ1ZiwgT19XUk9OTFkpOwotCQlpZiAoZmQgPT0gLTEpCi0JCQl0c3RfYnJrbShUQlJPS3xU
RVJSTk8sIGNsZWFudXAsICJvcGVuICVzIiwgYnVmKTsKLQkJaWYgKHdyaXRlKGZkLCAiMSIsIDEp
ICE9IDEpCi0JCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSAlcyIsIGJ1
Zik7Ci0JCWNsb3NlKGZkKTsKLQotCQlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVzL2NwdXNldC5j
cHVzIiwgQ1BBVEhfTkVXKTsKLQkJZmQgPSBvcGVuKGJ1ZiwgT19XUk9OTFkpOwotCQlpZiAoZmQg
PT0gLTEpCi0JCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuICVzIiwgYnVm
KTsKLQkJaWYgKHdyaXRlKGZkLCBjcHVzLCBzdHJsZW4oY3B1cykpICE9IHN0cmxlbihjcHVzKSkK
LQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlICVzIiwgYnVmKTsKLQkJ
Y2xvc2UoZmQpOwotCi0JCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMvdGFza3MiLCBDUEFUSF9O
RVcpOwotCQlmZCA9IG9wZW4oYnVmLCBPX1dST05MWSk7Ci0JCWlmIChmZCA9PSAtMSkKLQkJCXRz
dF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOwotCQlzbnByaW50
ZihidWYsIEJVRlNJWiwgIiVkIiwgZ2V0cGlkKCkpOwotCQlpZiAod3JpdGUoZmQsIGJ1Ziwgc3Ry
bGVuKGJ1ZikpICE9IHN0cmxlbihidWYpKQotCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVh
bnVwLCAid3JpdGUgJXMiLCBidWYpOwotCQljbG9zZShmZCk7Ci0JfQotCXRzdF9yZXNtKFRJTkZP
LCAic3RhcnQgbm9ybWFsIE9PTSB0ZXN0aW5nLiIpOwotCW9vbShOT1JNQUwsIG1lbXBvbGljeSwg
bGl0ZSk7Ci0KLQl0c3RfcmVzbShUSU5GTywgInN0YXJ0IE9PTSB0ZXN0aW5nIGZvciBtbG9ja2Vk
IHBhZ2VzLiIpOwotCW9vbShNTE9DSywgbWVtcG9saWN5LCBsaXRlKTsKLQotCXRzdF9yZXNtKFRJ
TkZPLCAic3RhcnQgT09NIHRlc3RpbmcgZm9yIEtTTSBwYWdlcy4iKTsKLQlvb20oS1NNLCBtZW1w
b2xpY3ksIGxpdGUpOwogfQogCiB2b2lkIHNldHVwKHZvaWQpCkBAIC0yMzYsNTAgKzE0NCw2IEBA
IHZvaWQgc2V0dXAodm9pZCkKIAltb3VudF9tZW0oIm1lbWNnIiwgImNncm91cCIsICJtZW1vcnki
LCBNRU1DR19QQVRILCBNRU1DR19QQVRIX05FVyk7CiB9CiAKLXZvaWQgdW1vdW50X21lbShjaGFy
ICpwYXRoLCBjaGFyICpwYXRoX25ldykKLXsKLQlGSUxFICpmcDsKLQlpbnQgZmQ7Ci0JY2hhciBz
X25ld1tCVUZTSVpdLCBzW0JVRlNJWl0sIHZhbHVlW0JVRlNJWl07Ci0KLQkvKiBNb3ZlIGFsbCBw
cm9jZXNzZXMgaW4gdGFzayB0byBpdHMgcGFyZW50IG5vZGUuICovCi0Jc25wcmludGYocywgQlVG
U0laLCAiJXMvdGFza3MiLCBwYXRoKTsKLQlmZCA9IG9wZW4ocywgT19XUk9OTFkpOwotCWlmIChm
ZCA9PSAtMSkKLQkJdHN0X3Jlc20oVFdBUk58VEVSUk5PLCAib3BlbiAlcyIsIHMpOwotCXNucHJp
bnRmKHNfbmV3LCBCVUZTSVosICIlcy90YXNrcyIsIHBhdGhfbmV3KTsKLQotCWZwID0gZm9wZW4o
c19uZXcsICJyIik7Ci0JaWYgKGZwID09IE5VTEwpCi0JCXRzdF9yZXNtKFRXQVJOfFRFUlJOTywg
ImZvcGVuICVzIiwgc19uZXcpOwotCWlmICgoZmQgIT0gLTEpICYmIChmcCAhPSBOVUxMKSkgewot
CQl3aGlsZSAoZmdldHModmFsdWUsIEJVRlNJWiwgZnApICE9IE5VTEwpCi0JCQlpZiAod3JpdGUo
ZmQsIHZhbHVlLCBzdHJsZW4odmFsdWUpIC0gMSkKLQkJCQkhPSBzdHJsZW4odmFsdWUpIC0gMSkK
LQkJCQl0c3RfcmVzbShUV0FSTnxURVJSTk8sICJ3cml0ZSAlcyIsIHMpOwotCX0KLQlpZiAoZmQg
IT0gLTEpCi0JCWNsb3NlKGZkKTsKLQlpZiAoZnAgIT0gTlVMTCkKLQkJZmNsb3NlKGZwKTsKLQlp
ZiAocm1kaXIocGF0aF9uZXcpID09IC0xKQotCQl0c3RfcmVzbShUV0FSTnxURVJSTk8sICJybWRp
ciAlcyIsIHBhdGhfbmV3KTsKLQlpZiAodW1vdW50KHBhdGgpID09IC0xKQotCQl0c3RfcmVzbShU
V0FSTnxURVJSTk8sICJ1bW91bnQgJXMiLCBwYXRoKTsKLQlpZiAocm1kaXIocGF0aCkgPT0gLTEp
Ci0JCXRzdF9yZXNtKFRXQVJOfFRFUlJOTywgInJtZGlyICVzIiwgcGF0aCk7Ci19Ci0KLXZvaWQg
bW91bnRfbWVtKGNoYXIgKm5hbWUsIGNoYXIgKmZzLCBjaGFyICpvcHRpb25zLCBjaGFyICpwYXRo
LCBjaGFyICpwYXRoX25ldykKLXsKLQlpZiAobWtkaXIocGF0aCwgMDc3NykgPT0gLTEpCi0JCXRz
dF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm1rZGlyICVzIiwgcGF0aCk7Ci0JaWYgKG1v
dW50KG5hbWUsIHBhdGgsIGZzLCAwLCBvcHRpb25zKSA9PSAtMSkKLQkJdHN0X2Jya20oVEJST0t8
VEVSUk5PLCBjbGVhbnVwLCAibW91bnQgJXMiLCBwYXRoKTsKLQlpZiAobWtkaXIocGF0aF9uZXcs
IDA3NzcpID09IC0xKQotCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJta2RpciAl
cyIsIHBhdGhfbmV3KTsKLX0KLQogdm9pZCBjbGVhbnVwKHZvaWQpCiB7CiAJaW50IGZkOwpAQCAt
Mjk1LDEwNSArMTU5LDEzIEBAIHZvaWQgY2xlYW51cCh2b2lkKQogCXVtb3VudF9tZW0oTUVNQ0df
UEFUSCwgTUVNQ0dfUEFUSF9ORVcpOwogCiAJVEVTVF9DTEVBTlVQOwotfQotCi12b2lkIG9vbShp
bnQgdGVzdGNhc2UsIGludCBtZW1wb2xpY3ksIGludCBsaXRlKQotewotCXBpZF90IHBpZDsKLQlp
bnQgc3RhdHVzOwotCXVuc2lnbmVkIGxvbmcgbm1hc2sgPSAyOwotCi0Jc3dpdGNoKHBpZCA9IGZv
cmsoKSkgewotCWNhc2UgLTE6Ci0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgImZv
cmsiKTsKLQljYXNlIDA6Ci0JCWlmIChtZW1wb2xpY3kpCi0JCQlpZiAoc2V0X21lbXBvbGljeShN
UE9MX0JJTkQsICZubWFzaywgTUFYTk9ERVMpID09IC0xKQotCQkJCXRzdF9icmttKFRCUk9LfFRF
UlJOTywgY2xlYW51cCwKLQkJCQkJInNldF9tZW1wb2xpY3kiKTsKLQotCQl0ZXN0X2FsbG9jKHRl
c3RjYXNlLCBsaXRlKTsKLQkJZXhpdCgwKTsKLQlkZWZhdWx0OgotCQlicmVhazsKLQl9Ci0JdHN0
X3Jlc20oVElORk8sICJleHBlY3RlZCB2aWN0aW0gaXMgJWQuIiwgcGlkKTsKLQlpZiAod2FpdHBp
ZCgtMSwgJnN0YXR1cywgMCkgPT0gLTEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51
cCwgIndhaXRwaWQiKTsKLQotCWlmICghV0lGU0lHTkFMRUQoc3RhdHVzKSB8fCBXVEVSTVNJRyhz
dGF0dXMpICE9IFNJR0tJTEwpCi0JCXRzdF9yZXNtKFRGQUlMLCAidGhlIHZpY3RpbSB1bmV4cGVj
dGVkbHkgZmFpbGVkOiAlZCIsIHN0YXR1cyk7Ci19Ci0KLWxvbmcgY291bnRfbnVtYSh2b2lkKQot
ewotCWludCBubm9kZXMgPSAwOwotCi0Jd2hpbGUocGF0aF9leGlzdChfUEFUSF9TWVNfU1lTVEVN
ICIvbm9kZS9ub2RlJWQiLCBubm9kZXMpKQotCQlubm9kZXMrKzsKLQotCXJldHVybiBubm9kZXM7
Ci19Ci0KLWludCBwYXRoX2V4aXN0KGNvbnN0IGNoYXIgKnBhdGgsIC4uLikKLXsKLQl2YV9saXN0
IGFwOwotCWNoYXIgcGF0aGJ1ZltQQVRIX01BWF07Ci0KLQl2YV9zdGFydChhcCwgcGF0aCk7Ci0J
dnNucHJpbnRmKHBhdGhidWYsIHNpemVvZihwYXRoYnVmKSwgcGF0aCwgYXApOwotCXZhX2VuZChh
cCk7Ci0KLQlyZXR1cm4gYWNjZXNzKHBhdGhidWYsIEZfT0spID09IDA7Ci19Ci0KLXZvaWQgZ2F0
aGVyX2NwdXMoY2hhciAqY3B1cykKLXsKLQlpbnQgbmNwdXMgPSAwOwotCWludCBpOwotCWNoYXIg
YnVmW0JVRlNJWl07Ci0KLQl3aGlsZShwYXRoX2V4aXN0KF9QQVRIX1NZU19TWVNURU0gIi9jcHUv
Y3B1JWQiLCBuY3B1cykpCi0JCW5jcHVzKys7Ci0KLQlmb3IgKGkgPSAwOyBpIDwgbmNwdXM7IGkr
KykKLQkJaWYgKHBhdGhfZXhpc3QoX1BBVEhfU1lTX1NZU1RFTSAiL25vZGUvbm9kZTEvY3B1JWQi
LCBpKSkgewotCQkJc3ByaW50ZihidWYsICIlZCwiLCBpKTsKLQkJCXN0cmNhdChjcHVzLCBidWYp
OwotCQl9Ci0JLyogUmVtb3ZlIHRoZSB0cmFpbGluZyBjb21tYS4gKi8KLQljcHVzW3N0cmxlbihj
cHVzKSAtIDFdID0gJ1wwJzsKLX0KLQotdm9pZCBhbGxvY19tZW0obG9uZyBpbnQgbGVuZ3RoLCBp
bnQgdGVzdGNhc2UpCi17Ci0Jdm9pZCAqczsKLQotCXRzdF9yZXNtKFRJTkZPLCAiYWxsb2NhdGlu
ZyAlbGQgYnl0ZXMuIiwgbGVuZ3RoKTsKLQlzID0gbW1hcChOVUxMLCBsZW5ndGgsIFBST1RfUkVB
RHxQUk9UX1dSSVRFLAotCQlNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFLCAtMSwgMCk7Ci0JaWYg
KHMgPT0gTUFQX0ZBSUxFRCkgewotCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAi
bW1hcCIpOwotCX0KLQlpZiAodGVzdGNhc2UgPT0gTUxPQ0sgJiYgbWxvY2socywgbGVuZ3RoKSA9
PSAtMSkKLQkJdHN0X2Jya20oVElORk98VEVSUk5PLCBjbGVhbnVwLCAibWxvY2siKTsKLQlpZiAo
dGVzdGNhc2UgPT0gS1NNCi0JCSYmIG1hZHZpc2UocywgbGVuZ3RoLCBNQURWX01FUkdFQUJMRSkg
PT0gLTEpCi0JCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm1hZHZpc2UiKTsKLQlt
ZW1zZXQocywgJ1xhJywgbGVuZ3RoKTsKLX0KLQotdm9pZCB0ZXN0X2FsbG9jKGludCB0ZXN0Y2Fz
ZSwgaW50IGxpdGUpCi17Ci0JaWYgKGxpdGUpCi0JCWFsbG9jX21lbShURVNUTUVNICsgTUIsIHRl
c3RjYXNlKTsKLQllbHNlCi0JCXdoaWxlKDEpCi0JCQlhbGxvY19tZW0oTEVOR1RILCB0ZXN0Y2Fz
ZSk7CisJdHN0X2V4aXQoKTsKIH0KIAogI2Vsc2UgLyogbm8gTlVNQSAqLwotaW50IG1haW4odm9p
ZCkgewotCXRzdF9icmttKFRDT05GLCBOVUxMLCAibm8gTlVNQSBkZXZlbG9wbWVudCBwYWNrYWdl
cyBpbnN0YWxsZWQuIik7CitpbnQgbWFpbih2b2lkKQoreworCXRzdF9yZXNtKFRDT05GLCAibm8g
TlVNQSBkZXZlbG9wbWVudCBwYWNrYWdlcyBpbnN0YWxsZWQuIik7CisJdHN0X2V4aXQoKTsKIH0K
ICNlbmRpZgotLSAKMS43LjMuMgoK
------=_Part_56179_1044964947.1295424713617
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
------=_Part_56179_1044964947.1295424713617
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_56179_1044964947.1295424713617--

