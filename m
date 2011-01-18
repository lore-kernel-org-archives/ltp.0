Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfD0g-000827-S3
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 14:58:14 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfD0e-0002QT-61
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 14:58:14 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0IEw6B0031883
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Jan 2011 09:58:06 -0500
Date: Tue, 18 Jan 2011 09:58:06 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <359461755.37148.1295362686019.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1667525559.37140.1295362676640.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_37147_773432378.1295362686018"
Subject: [LTP] [PATCH 2/3] mem: add a new library for tests use
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

------=_Part_37147_773432378.1295362686018
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/include/mem.h |   50 +++
 testcases/kernel/mem/lib/mem.c     |  651 ++++++++++++++++++++++++++++++++++++
 2 files changed, 701 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/include/mem.h
 create mode 100644 testcases/kernel/mem/lib/mem.c

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
new file mode 100644
index 0000000..d95b3e1
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
+void cleanup(void) LTP_ATTRIBUTE_NORETURN;
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
-- 
1.7.3.2
------=_Part_37147_773432378.1295362686018
Content-Type: text/x-patch; name=0002-mem-add-a-new-library-for-tests-use.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0002-mem-add-a-new-library-for-tests-use.patch

RnJvbSBiNTM3MzY3ODAxNDFiMzI0NmU3ZDhiOWY0YzRmMTExZDJhODNlMDlmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDE4IEphbiAyMDExIDExOjIzOjM4ICswODAwClN1YmplY3Q6IFtQQVRDSCAyLzNdIG1lbTog
YWRkIGEgbmV3IGxpYnJhcnkgZm9yIHRlc3RzIHVzZQoKClNpZ25lZC1vZmYtYnk6IENBSSBRaWFu
IDxjYWlxaWFuQHJlZGhhdC5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vaW5jbHVkZS9t
ZW0uaCB8ICAgNTAgKysrCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9saWIvbWVtLmMgICAgIHwgIDY1
MSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwg
NzAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVz
dGNhc2VzL2tlcm5lbC9tZW0vaW5jbHVkZS9tZW0uaAogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3Rj
YXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
bWVtL2luY2x1ZGUvbWVtLmggYi90ZXN0Y2FzZXMva2VybmVsL21lbS9pbmNsdWRlL21lbS5oCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLmQ5NWIzZTEKLS0tIC9kZXYvbnVsbAor
KysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9pbmNsdWRlL21lbS5oCkBAIC0wLDAgKzEsNTAgQEAK
KyNpZm5kZWYgX01FTV9ICisjZGVmaW5lIF9NRU1fSAorI2luY2x1ZGUgInRlc3QuaCIKKyNpbmNs
dWRlICJ1c2N0ZXN0LmgiCisKKyNkZWZpbmUgTEVOR1RICQkJKDNVTDw8MzApCisjZGVmaW5lIFNZ
U0ZTX09WRVIJCSIvcHJvYy9zeXMvdm0vb3ZlcmNvbW1pdF9tZW1vcnkiCisjZGVmaW5lIE9WRVJD
T01NSVQJCTEKKyNkZWZpbmUgTk9STUFMCQkJMgorI2RlZmluZSBNTE9DSwkJCTMKKyNkZWZpbmUg
S1NNCQkJNAorI2RlZmluZSBDUEFUSAkJCSIvZGV2L2NwdXNldCIKKyNkZWZpbmUgQ1BBVEhfTkVX
CQlDUEFUSCAiLzEiCisjZGVmaW5lIE1BWE5PREVTCQk1MTIKKyNkZWZpbmUgTUVNQ0dfUEFUSAkJ
Ii9kZXYvY2dyb3VwIgorI2RlZmluZSBNRU1DR19QQVRIX05FVwkJTUVNQ0dfUEFUSCAiLzEiCisj
ZGVmaW5lIFRFU1RNRU0JCQkoMVVMPDwzMCkKKyNkZWZpbmUgTUIJCQkoMVVMPDwyMCkKKyNkZWZp
bmUgUEFUSF9TWVNfU1lTVEVNCQkiL3N5cy9kZXZpY2VzL3N5c3RlbSIKKyNkZWZpbmUgUEFUSF9L
U00JCSIvc3lzL2tlcm5lbC9tbS9rc20vIgorCitjaGFyIG92ZXJjb21taXRbQlVGU0laXTsKK2lu
dCBvcHRfbnVtLCBvcHRfc2l6ZSwgb3B0X3VuaXQ7CitjaGFyICpvcHRfbnVtc3RyLCAqb3B0X3Np
emVzdHIsICpvcHRfdW5pdHN0cjsKKy8qIG1lbW9yeSBwb2ludGVyIHRvIGlkZW50aWZ5IHBlciBw
cm9jZXNzLCBNQiB1bml0LCBhbmQgYnl0ZSBsaWtlCisgICBtZW1vcnlbcHJvY2VzcyBOby5dW01C
IHVuaXQgTm8uXVtieXRlIE5vLl0uICovCitjaGFyICoqKm1lbW9yeTsKKwordm9pZCBvb20oaW50
IHRlc3RjYXNlLCBpbnQgbWVtcG9saWN5LCBpbnQgbGl0ZSk7Cit2b2lkIHRlc3Rvb20oaW50IG1l
bXBvbGljeSwgaW50IGxpdGUsIGludCBudW1hKTsKK2xvbmcgY291bnRfbnVtYSh2b2lkKTsKK2lu
dCBwYXRoX2V4aXN0KGNvbnN0IGNoYXIgKnBhdGgsIC4uLik7CitpbnQgYWxsb2NfbWVtKGxvbmcg
aW50IGxlbmd0aCwgaW50IHRlc3RjYXNlKTsKK3ZvaWQgdGVzdF9hbGxvYyhpbnQgdGVzdGNhc2Us
IGludCBsaXRlKTsKK3ZvaWQgZ2F0aGVyX2NwdXMoY2hhciAqY3B1cyk7Cit2b2lkIHVtb3VudF9t
ZW0oY2hhciAqcGF0aCwgY2hhciAqcGF0aF9uZXcpOwordm9pZCBtb3VudF9tZW0oY2hhciAqbmFt
ZSwgY2hhciAqZnMsIGNoYXIgKm9wdGlvbnMsIGNoYXIgKnBhdGgsIGNoYXIgKnBhdGhfbmV3KTsK
K3ZvaWQgY2xlYW51cCh2b2lkKSBMVFBfQVRUUklCVVRFX05PUkVUVVJOOwordm9pZCBzZXR1cCh2
b2lkKTsKK3ZvaWQga3NtX3VzYWdlKHZvaWQpOwordm9pZCBjaGVjayhjaGFyICpwYXRoLCBsb25n
IGludCB2YWx1ZSk7Cit2b2lkIHZlcmlmeShjaGFyIHZhbHVlLCBpbnQgcHJvYywgaW50IHN0YXJ0
LCBpbnQgZW5kLCBpbnQgc3RhcnQyLCBpbnQgZW5kMik7Cit2b2lkIGdyb3VwX2NoZWNrKGludCBy
dW4sIGludCBwYWdlc19zaGFyZWQsIGludCBwYWdlc19zaGFyaW5nLAorCQlpbnQgcGFnZXNfdm9s
YXRpbGUsIGludCBwYWdlc191bnNoYXJlZCwgaW50IHNsZWVwX21pbGxpc2VjcywKKwkJaW50IHBh
Z2VzX3RvX3NjYW4pOwordm9pZCBjcmVhdGVfc2FtZV9tZW1vcnkoaW50IHNpemUsIGludCBudW0s
IGludCB1bml0KTsKK3ZvaWQgY2hlY2tfa3NtX29wdGlvbnMoaW50ICpzaXplLCBpbnQgKm51bSwg
aW50ICp1bml0KTsKK3ZvaWQgd3JpdGVfY3B1c2V0cyh2b2lkKTsKK3ZvaWQgd3JpdGVfbWVtY2co
dm9pZCk7CisjZW5kaWYKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0u
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwpuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwLi4yOTdlZWRkCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9tZW0vbGliL21lbS5jCkBAIC0wLDAgKzEsNjUxIEBACisjaW5jbHVkZSA8c3lzL21tYW4uaD4K
KyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KKyNpbmNsdWRlIDxzeXMvd2FpdC5oPgorI2luY2x1ZGUg
PHN5cy9zdGF0Lmg+CisjaW5jbHVkZSA8c3lzL21vdW50Lmg+CisjaW5jbHVkZSA8ZmNudGwuaD4K
KyNpbmNsdWRlIDx1bmlzdGQuaD4KKyNpbmNsdWRlIDxlcnJuby5oPgorI2luY2x1ZGUgPHN0ZGlv
Lmg+CisjaW5jbHVkZSA8c3RyaW5nLmg+CisjaW5jbHVkZSA8c3RkYXJnLmg+CisjaW5jbHVkZSAi
dGVzdC5oIgorI2luY2x1ZGUgInVzY3Rlc3QuaCIKKyNpbmNsdWRlICIuLi9pbmNsdWRlL21lbS5o
IgorI2luY2x1ZGUgImNvbmZpZy5oIgorI2lmIEhBVkVfTlVNQV9IICYmIEhBVkVfTElOVVhfTUVN
UE9MSUNZX0ggJiYgSEFWRV9OVU1BSUZfSCBcCisJJiYgSEFWRV9NUE9MX0NPTlNUQU5UUworI2lu
Y2x1ZGUgPG51bWFpZi5oPgorI2VuZGlmCisKK3ZvaWQgb29tKGludCB0ZXN0Y2FzZSwgaW50IG1l
bXBvbGljeSwgaW50IGxpdGUpCit7CisJcGlkX3QgcGlkOworCWludCBzdGF0dXM7CisjaWYgSEFW
RV9OVU1BX0ggJiYgSEFWRV9MSU5VWF9NRU1QT0xJQ1lfSCAmJiBIQVZFX05VTUFJRl9IIFwKKwkm
JiBIQVZFX01QT0xfQ09OU1RBTlRTCisJdW5zaWduZWQgbG9uZyBubWFzayA9IDI7CisjZW5kaWYK
KworCXN3aXRjaChwaWQgPSBmb3JrKCkpIHsKKwljYXNlIC0xOgorCQl0c3RfYnJrbShUQlJPS3xU
RVJSTk8sIGNsZWFudXAsICJmb3JrIik7CisJY2FzZSAwOgorI2lmIEhBVkVfTlVNQV9IICYmIEhB
VkVfTElOVVhfTUVNUE9MSUNZX0ggJiYgSEFWRV9OVU1BSUZfSCBcCisJJiYgSEFWRV9NUE9MX0NP
TlNUQU5UUworCQlpZiAobWVtcG9saWN5KQorCQkJaWYgKHNldF9tZW1wb2xpY3koTVBPTF9CSU5E
LCAmbm1hc2ssIE1BWE5PREVTKSA9PSAtMSkKKwkJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNs
ZWFudXAsCisJCQkJCSJzZXRfbWVtcG9saWN5Iik7CisjZW5kaWYKKwkJdGVzdF9hbGxvYyh0ZXN0
Y2FzZSwgbGl0ZSk7CisJCWV4aXQoMCk7CisJZGVmYXVsdDoKKwkJYnJlYWs7CisJfQorCXRzdF9y
ZXNtKFRJTkZPLCAiZXhwZWN0ZWQgdmljdGltIGlzICVkLiIsIHBpZCk7CisJaWYgKHdhaXRwaWQo
LTEsICZzdGF0dXMsIDApID09IC0xKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAs
ICJ3YWl0cGlkIik7CisKKwlpZiAodGVzdGNhc2UgPT0gT1ZFUkNPTU1JVCkgeworCQlpZiAoIVdJ
RkVYSVRFRChzdGF0dXMpIHx8IFdFWElUU1RBVFVTKHN0YXR1cykgIT0gMCkKKwkJCXRzdF9yZXNt
KFRGQUlMLCAidGhlIHZpY3RpbSB1bmV4cGVjdGVkbHkgZmFpbGVkOiAlZCIsCisJCQkJc3RhdHVz
KTsKKwl9IGVsc2UgeworCQlpZiAoIVdJRlNJR05BTEVEKHN0YXR1cykgfHwgV1RFUk1TSUcoc3Rh
dHVzKSAhPSBTSUdLSUxMKQorCQkJdHN0X3Jlc20oVEZBSUwsICJ0aGUgdmljdGltIHVuZXhwZWN0
ZWRseSBmYWlsZWQ6ICVkIiwKKwkJCQlzdGF0dXMpOworCX0KK30KKwordm9pZCB3cml0ZV9tZW1j
Zyh2b2lkKQoreworCWludCBmZDsKKwljaGFyIGJ1ZltCVUZTSVpdLCBtZW1bQlVGU0laXTsKKwor
CWZkID0gb3BlbihNRU1DR19QQVRIX05FVyAiL21lbW9yeS5saW1pdF9pbl9ieXRlcyIsIE9fV1JP
TkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwg
Im9wZW4gJXMiLCBidWYpOworCXNwcmludGYobWVtLCAiJWxkIiwgVEVTVE1FTSk7CisJaWYgKHdy
aXRlKGZkLCBtZW0sIHN0cmxlbihtZW0pKSAhPSBzdHJsZW4obWVtKSkKKwkJdHN0X2Jya20oVEJS
T0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUgJXMiLCBidWYpOworCWNsb3NlKGZkKTsKKworCWZk
ID0gb3BlbihNRU1DR19QQVRIX05FVyAiL3Rhc2tzIiwgT19XUk9OTFkpOworCWlmIChmZCA9PSAt
MSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiAlcyIsIGJ1Zik7CisJ
c25wcmludGYoYnVmLCBCVUZTSVosICIlZCIsIGdldHBpZCgpKTsKKwlpZiAod3JpdGUoZmQsIGJ1
Ziwgc3RybGVuKGJ1ZikpICE9IHN0cmxlbihidWYpKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8s
IGNsZWFudXAsICJ3cml0ZSAlcyIsIGJ1Zik7CisJY2xvc2UoZmQpOwkKK30KKwordm9pZCB3cml0
ZV9jcHVzZXRzKHZvaWQpCit7CisJY2hhciBjcHVzW0JVRlNJWl0gPSAiIjsKKwljaGFyIGJ1ZltC
VUZTSVpdID0gIiI7CisJaW50IGZkOworCisJZ2F0aGVyX2NwdXMoY3B1cyk7CisJdHN0X3Jlc20o
VElORk8sICJDUFUgbGlzdCBmb3IgMm5kIG5vZGUgaXMgJXMuIiwgY3B1cyk7CisKKwlmZCA9IG9w
ZW4oQ1BBVEhfTkVXICIvbWVtcyIsIE9fV1JPTkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9i
cmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOworCWlmICh3cml0ZShm
ZCwgIjEiLCAxKSAhPSAxKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0
ZSAlcyIsIGJ1Zik7CisJY2xvc2UoZmQpOworCisJZmQgPSBvcGVuKENQQVRIX05FVyAiL2NwdXMi
LCBPX1dST05MWSk7CisJaWYgKGZkID09IC0xKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNs
ZWFudXAsICJvcGVuICVzIiwgYnVmKTsKKwlpZiAod3JpdGUoZmQsIGNwdXMsIHN0cmxlbihjcHVz
KSkgIT0gc3RybGVuKGNwdXMpKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3
cml0ZSAlcyIsIGJ1Zik7CisJY2xvc2UoZmQpOworCisJZmQgPSBvcGVuKENQQVRIX05FVyAiL3Rh
c2tzIiwgT19XUk9OTFkpOworCWlmIChmZCA9PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5P
LCBjbGVhbnVwLCAib3BlbiAlcyIsIGJ1Zik7CisJc25wcmludGYoYnVmLCBCVUZTSVosICIlZCIs
IGdldHBpZCgpKTsKKwlpZiAod3JpdGUoZmQsIGJ1Ziwgc3RybGVuKGJ1ZikpICE9IHN0cmxlbihi
dWYpKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSAlcyIsIGJ1Zik7
CisJY2xvc2UoZmQpOworfQorCit2b2lkIHRlc3Rvb20oaW50IG1lbXBvbGljeSwgaW50IGxpdGUs
IGludCBudW1hKQoreworCWlmIChudW1hICYmICFtZW1wb2xpY3kpCisJCXdyaXRlX2NwdXNldHMo
KTsKKworCXRzdF9yZXNtKFRJTkZPLCAic3RhcnQgbm9ybWFsIE9PTSB0ZXN0aW5nLiIpOworCW9v
bShOT1JNQUwsIG1lbXBvbGljeSwgbGl0ZSk7CisKKwl0c3RfcmVzbShUSU5GTywgInN0YXJ0IE9P
TSB0ZXN0aW5nIGZvciBtbG9ja2VkIHBhZ2VzLiIpOworCW9vbShNTE9DSywgbWVtcG9saWN5LCBs
aXRlKTsKKworCXRzdF9yZXNtKFRJTkZPLCAic3RhcnQgT09NIHRlc3RpbmcgZm9yIEtTTSBwYWdl
cy4iKTsKKwlvb20oS1NNLCBtZW1wb2xpY3ksIGxpdGUpOworfQorCitsb25nIGNvdW50X251bWEo
dm9pZCkKK3sKKwlpbnQgbm5vZGVzID0gMDsKKworCXdoaWxlKHBhdGhfZXhpc3QoUEFUSF9TWVNf
U1lTVEVNICIvbm9kZS9ub2RlJWQiLCBubm9kZXMpKQorCQlubm9kZXMrKzsKKworCXJldHVybiBu
bm9kZXM7Cit9CisKK2ludCBwYXRoX2V4aXN0KGNvbnN0IGNoYXIgKnBhdGgsIC4uLikKK3sKKwl2
YV9saXN0IGFwOworCWNoYXIgcGF0aGJ1ZltQQVRIX01BWF07CisKKwl2YV9zdGFydChhcCwgcGF0
aCk7CisJdnNucHJpbnRmKHBhdGhidWYsIHNpemVvZihwYXRoYnVmKSwgcGF0aCwgYXApOworCXZh
X2VuZChhcCk7CisKKwlyZXR1cm4gYWNjZXNzKHBhdGhidWYsIEZfT0spID09IDA7Cit9CisKK3Zv
aWQgZ2F0aGVyX2NwdXMoY2hhciAqY3B1cykKK3sKKwlpbnQgbmNwdXMgPSAwOworCWludCBpOwor
CWNoYXIgYnVmW0JVRlNJWl07CisKKwl3aGlsZShwYXRoX2V4aXN0KFBBVEhfU1lTX1NZU1RFTSAi
L2NwdS9jcHUlZCIsIG5jcHVzKSkKKwkJbmNwdXMrKzsKKworCWZvciAoaSA9IDA7IGkgPCBuY3B1
czsgaSsrKQorCQlpZiAocGF0aF9leGlzdChQQVRIX1NZU19TWVNURU0gIi9ub2RlL25vZGUxL2Nw
dSVkIiwgaSkpIHsKKwkJCXNwcmludGYoYnVmLCAiJWQsIiwgaSk7CisJCQlzdHJjYXQoY3B1cywg
YnVmKTsKKwkJfQorCS8qIFJlbW92ZSB0aGUgdHJhaWxpbmcgY29tbWEuICovCisJY3B1c1tzdHJs
ZW4oY3B1cykgLSAxXSA9ICdcMCc7Cit9CisKK2ludCBhbGxvY19tZW0obG9uZyBpbnQgbGVuZ3Ro
LCBpbnQgdGVzdGNhc2UpCit7CisJdm9pZCAqczsKKworCXRzdF9yZXNtKFRJTkZPLCAiYWxsb2Nh
dGluZyAlbGQgYnl0ZXMuIiwgbGVuZ3RoKTsKKwlzID0gbW1hcChOVUxMLCBsZW5ndGgsIFBST1Rf
UkVBRHxQUk9UX1dSSVRFLAorCQlNQVBfQU5PTllNT1VTfE1BUF9QUklWQVRFLCAtMSwgMCk7CisJ
aWYgKHMgPT0gTUFQX0ZBSUxFRCkgeworCQlpZiAodGVzdGNhc2UgPT0gT1ZFUkNPTU1JVCAmJiBl
cnJubyA9PSBFTk9NRU0pCisJCQlyZXR1cm4gMTsKKwkJZWxzZQorCQkJdHN0X2Jya20oVEJST0t8
VEVSUk5PLCBjbGVhbnVwLCAibW1hcCIpOworCX0KKwlpZiAodGVzdGNhc2UgPT0gTUxPQ0sgJiYg
bWxvY2socywgbGVuZ3RoKSA9PSAtMSkKKwkJdHN0X2Jya20oVElORk98VEVSUk5PLCBjbGVhbnVw
LCAibWxvY2siKTsKKwlpZiAodGVzdGNhc2UgPT0gS1NNCisJCSYmIG1hZHZpc2UocywgbGVuZ3Ro
LCBNQURWX01FUkdFQUJMRSkgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51
cCwgIm1hZHZpc2UiKTsKKwltZW1zZXQocywgJ1xhJywgbGVuZ3RoKTsKKworCXJldHVybiAwOwor
fQorCit2b2lkIHRlc3RfYWxsb2MoaW50IHRlc3RjYXNlLCBpbnQgbGl0ZSkKK3sKKwlpZiAobGl0
ZSkKKwkJYWxsb2NfbWVtKFRFU1RNRU0gKyBNQiwgdGVzdGNhc2UpOworCWVsc2UKKwkJd2hpbGUo
MSkKKwkJCWlmIChhbGxvY19tZW0oTEVOR1RILCB0ZXN0Y2FzZSkpCisJCQkJcmV0dXJuOworfQor
Cit2b2lkIHVtb3VudF9tZW0oY2hhciAqcGF0aCwgY2hhciAqcGF0aF9uZXcpCit7CisJRklMRSAq
ZnA7CisJaW50IGZkOworCWNoYXIgc19uZXdbQlVGU0laXSwgc1tCVUZTSVpdLCB2YWx1ZVtCVUZT
SVpdOworCisJLyogTW92ZSBhbGwgcHJvY2Vzc2VzIGluIHRhc2sgdG8gaXRzIHBhcmVudCBub2Rl
LiAqLworCXNwcmludGYocywgIiVzL3Rhc2tzIiwgcGF0aCk7CisJZmQgPSBvcGVuKHMsIE9fV1JP
TkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9yZXNtKFRXQVJOfFRFUlJOTywgIm9wZW4gJXMi
LCBzKTsKKworCXNucHJpbnRmKHNfbmV3LCBCVUZTSVosICIlcy90YXNrcyIsIHBhdGhfbmV3KTsK
KwlmcCA9IGZvcGVuKHNfbmV3LCAiciIpOworCWlmIChmcCA9PSBOVUxMKQorCQl0c3RfcmVzbShU
V0FSTnxURVJSTk8sICJmb3BlbiAlcyIsIHNfbmV3KTsKKwlpZiAoKGZkICE9IC0xKSAmJiAoZnAg
IT0gTlVMTCkpIHsKKwkJd2hpbGUgKGZnZXRzKHZhbHVlLCBCVUZTSVosIGZwKSAhPSBOVUxMKQor
CQkJaWYgKHdyaXRlKGZkLCB2YWx1ZSwgc3RybGVuKHZhbHVlKSAtIDEpCisJCQkJIT0gc3RybGVu
KHZhbHVlKSAtIDEpCisJCQkJdHN0X3Jlc20oVFdBUk58VEVSUk5PLCAid3JpdGUgJXMiLCBzKTsK
Kwl9CisJaWYgKGZkICE9IC0xKQorCQljbG9zZShmZCk7CisJaWYgKGZwICE9IE5VTEwpCisJCWZj
bG9zZShmcCk7CisJaWYgKHJtZGlyKHBhdGhfbmV3KSA9PSAtMSkKKwkJdHN0X3Jlc20oVFdBUk58
VEVSUk5PLCAicm1kaXIgJXMiLCBwYXRoX25ldyk7CisJaWYgKHVtb3VudChwYXRoKSA9PSAtMSkK
KwkJdHN0X3Jlc20oVFdBUk58VEVSUk5PLCAidW1vdW50ICVzIiwgcGF0aCk7CisJaWYgKHJtZGly
KHBhdGgpID09IC0xKQorCQl0c3RfcmVzbShUV0FSTnxURVJSTk8sICJybWRpciAlcyIsIHBhdGgp
OworfQorCit2b2lkIG1vdW50X21lbShjaGFyICpuYW1lLCBjaGFyICpmcywgY2hhciAqb3B0aW9u
cywgY2hhciAqcGF0aCwgY2hhciAqcGF0aF9uZXcpCit7CisJaWYgKG1rZGlyKHBhdGgsIDA3Nzcp
ID09IC0xKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJta2RpciAlcyIsIHBh
dGgpOworCWlmIChtb3VudChuYW1lLCBwYXRoLCBmcywgMCwgb3B0aW9ucykgPT0gLTEpCisJCXRz
dF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm1vdW50ICVzIiwgcGF0aCk7CisJaWYgKG1r
ZGlyKHBhdGhfbmV3LCAwNzc3KSA9PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVh
bnVwLCAibWtkaXIgJXMiLCBwYXRoX25ldyk7Cit9CisKK3ZvaWQga3NtX3VzYWdlKHZvaWQpCit7
CisJcHJpbnRmKCIgIC1uICAgICAgTnVtYmVyIG9mIHByb2Nlc3Nlc1xuIik7CisJcHJpbnRmKCIg
IC1zICAgICAgTWVtb3J5IGFsbG9jYXRpb24gc2l6ZSBpbiBNQlxuIik7CisJcHJpbnRmKCIgIC11
ICAgICAgTWVtb3J5IGFsbG9jYXRpb24gdW5pdCBpbiBNQlxuIik7Cit9CisKK3ZvaWQgY2hlY2so
Y2hhciAqcGF0aCwgbG9uZyBpbnQgdmFsdWUpCit7CisJRklMRSAqZnA7CisJY2hhciBidWZbQlVG
U0laXTsKKworCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMlcyIsIFBBVEhfS1NNLCBwYXRoKTsK
KwlmcCA9IGZvcGVuKGJ1ZiwgInIiKTsKKwlpZiAoZnAgPT0gTlVMTCkKKwkJdHN0X2Jya20oVEJS
T0t8VEVSUk5PLCB0c3RfZXhpdCwgImZvcGVuIik7CisJaWYgKGZnZXRzKGJ1ZiwgQlVGU0laLCBm
cCkgPT0gTlVMTCkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgImZnZXRzIik7
CisJZmNsb3NlKGZwKTsKKworCXRzdF9yZXNtKFRJTkZPLCAiJXMgaXMgJWxkLiIsIHBhdGgsIGF0
b2woYnVmKSk7CisJaWYgKGF0b2woYnVmKSAhPSB2YWx1ZSkKKwkJdHN0X3Jlc20oVEZBSUwsICIl
cyBpcyBub3QgJWxkLiIsIHBhdGgsIHZhbHVlKTsKK30KKwordm9pZCB2ZXJpZnkoY2hhciB2YWx1
ZSwgaW50IHByb2MsIGludCBzdGFydCwgaW50IGVuZCwgaW50IHN0YXJ0MiwgaW50IGVuZDIpCit7
CisJaW50IGksIGo7CisJdm9pZCAqcyA9IE5VTEw7CisKKwlzID0gbWFsbG9jKChlbmQgLSBzdGFy
dCkgKiAoZW5kMiAtIHN0YXJ0MikpOworCWlmIChzID09IE5VTEwpCisJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgdHN0X2V4aXQsICJtYWxsb2MiKTsKKworCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQg
JWQgdmVyaWZpZXMgbWVtb3J5IGNvbnRlbnQuIiwgcHJvYyk7CisJbWVtc2V0KHMsIHZhbHVlLCAo
ZW5kIC0gc3RhcnQpICogKGVuZDIgLSBzdGFydDIpKTsKKwlpZiAobWVtY21wKG1lbW9yeVtwcm9j
XVtzdGFydF0sIHMsIChlbmQgLSBzdGFydCkgKiAoZW5kMiAtIHN0YXJ0MikpCisJCSE9IDApCisJ
CWZvciAoaiA9IHN0YXJ0OyBqIDwgZW5kOyBqKyspCisJCQlmb3IgKGkgPSBzdGFydDI7IGkgPCBl
bmQyOyBpKyspCisJCQkJaWYgKG1lbW9yeVtwcm9jXVtqXVtpXSAhPSB2YWx1ZSkKKwkJCQkJdHN0
X3Jlc20oVEZBSUwsICJjaGlsZCAlZCBoYXMgJWMgYXQgIgorCQkJCQkJIiVkLCVkLCVkLiIsCisJ
CQkJCQlwcm9jLCBtZW1vcnlbcHJvY11bal1baV0sIHByb2MsCisJCQkJCQlqLCBpKTsKKwlmcmVl
KHMpOworfQorCit2b2lkIGdyb3VwX2NoZWNrKGludCBydW4sIGludCBwYWdlc19zaGFyZWQsIGlu
dCBwYWdlc19zaGFyaW5nLAorCQlpbnQgcGFnZXNfdm9sYXRpbGUsIGludCBwYWdlc191bnNoYXJl
ZCwKKwkJaW50IHNsZWVwX21pbGxpc2VjcywgaW50IHBhZ2VzX3RvX3NjYW4pCit7CisgICAgICAg
IC8qIDUgc2Vjb25kcyBmb3Iga3NtIHRvIHNjYW4gcGFnZXMuICovCisJc2xlZXAoNSk7CisJdHN0
X3Jlc20oVElORk8sICJjaGVjayEiKTsKKwljaGVjaygicnVuIiwgcnVuKTsKKwljaGVjaygicGFn
ZXNfc2hhcmVkIiwgcGFnZXNfc2hhcmVkKTsKKwljaGVjaygicGFnZXNfc2hhcmluZyIsIHBhZ2Vz
X3NoYXJpbmcpOworCWNoZWNrKCJwYWdlc192b2xhdGlsZSIsIHBhZ2VzX3ZvbGF0aWxlKTsKKwlj
aGVjaygicGFnZXNfdW5zaGFyZWQiLCBwYWdlc191bnNoYXJlZCk7CisJY2hlY2soInNsZWVwX21p
bGxpc2VjcyIsIHNsZWVwX21pbGxpc2Vjcyk7CisJY2hlY2soInBhZ2VzX3RvX3NjYW4iLCBwYWdl
c190b19zY2FuKTsKK30KKwordm9pZCBjcmVhdGVfc2FtZV9tZW1vcnkoaW50IHNpemUsIGludCBu
dW0sIGludCB1bml0KQoreworCWNoYXIgYnVmW0JVRlNJWl0sIGJ1ZjJbQlVGU0laXTsKKwlpbnQg
aSwgaiwgazsKKwlpbnQgc3RhdHVzLCBmZDsKKwlpbnQgKmNoaWxkOworCisJY2hpbGQgPSBtYWxs
b2MobnVtKTsKKwlpZiAoY2hpbGQgPT0gTlVMTCkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBj
bGVhbnVwLCAibWFsbG9jIik7CisKKwltZW1vcnkgPSBtYWxsb2MobnVtICogc2l6ZW9mKCoqbWVt
b3J5KSk7CisJaWYgKG1lbW9yeSA9PSBOVUxMKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNs
ZWFudXAsICJtYWxsb2MiKTsKKworCS8qIERvbid0IGNhbGwgY2xlYW51cCBpbiB0aG9zZSBjaGls
ZHJlbi4gSW5zdGVhZCwgZG8gYSBjbGVhbnVwIGZyb20gdGhlCisJICAgcGFyZW50IGFmdGVyIGZl
dGNoZWQgY2hpbGRyZW4ncyBzdGF0dXMuKi8KKwlzd2l0Y2ggKGNoaWxkWzBdID0gZm9yaygpKSB7
CisJY2FzZSAtMToKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAiZm9yayIpOwor
CWNhc2UgMDoKKwkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAwIHN0b3BzLiIpOworCQlpZiAocmFp
c2UoU0lHU1RPUCkgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAi
a2lsbCIpOworCisJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMCBjb250aW51ZXMuLi4iKTsKKwkJ
dHN0X3Jlc20oVElORk8sICJjaGlsZCAwIGFsbG9jYXRlcyAlZCBNQiBmaWxsZWQgd2l0aCAnYycu
IiwKKwkJCXNpemUpOworCQltZW1vcnlbMF0gPSBtYWxsb2Moc2l6ZSAvIHVuaXQgKiBzaXplb2Yo
Km1lbW9yeSkpOworCQlpZiAobWVtb3J5WzBdID09IE5VTEwpCisJCQl0c3RfYnJrbShUQlJPS3xU
RVJSTk8sIHRzdF9leGl0LCAibWFsbG9jIik7CisJCWZvciAoaiA9IDA7IGogKiB1bml0IDwgc2l6
ZTsgaisrKSB7CisJCQltZW1vcnlbMF1bal0gPSBtbWFwKE5VTEwsIHVuaXQgKiBNQiwKKwkJCQkJ
UFJPVF9SRUFEfFBST1RfV1JJVEUsCisJCQkJCU1BUF9BTk9OWU1PVVN8TUFQX1BSSVZBVEUsIC0x
LCAwKTsKKwkJCWlmIChtZW1vcnlbMF1bal0gPT0gTUFQX0ZBSUxFRCkKKwkJCQl0c3RfYnJrbShU
QlJPS3xURVJSTk8sIHRzdF9leGl0LCAibW1hcCIpOworCQkJaWYgKG1hZHZpc2UobWVtb3J5WzBd
W2pdLCB1bml0ICogTUIsIE1BRFZfTUVSR0VBQkxFKQorCQkJCT09IC0xKQorCQkJCXRzdF9icmtt
KFRCUk9LfFRFUlJOTywgdHN0X2V4aXQsICJtYWR2aXNlIik7CisJCQlmb3IgKGkgPSAwOyBpIDwg
dW5pdCAqIE1COyBpKyspCisJCQkJbWVtb3J5WzBdW2pdW2ldID0gJ2MnOworCQl9CisJCXRzdF9y
ZXNtKFRJTkZPLCAiY2hpbGQgMCBzdG9wcy4iKTsKKwkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0x
KQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgImtpbGwiKTsKKworCQl0c3Rf
cmVzbShUSU5GTywgImNoaWxkIDAgY29udGludWVzLi4uIik7CisJCXZlcmlmeSgnYycsIDAsIDAs
IHNpemUgLyB1bml0LCAwLCB1bml0ICogTUIpOworCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDAg
Y2hhbmdlcyBtZW1vcnkgY29udGVudCB0byAnZCcuIik7CisJCWZvciAoaiA9IDA7IGogPCBzaXpl
IC8gdW5pdDsgaisrKSB7CisJCQlmb3IgKGkgPSAwOyBpIDwgdW5pdCAqIE1COyBpKyspCisJCQkJ
bWVtb3J5WzBdW2pdW2ldID0gJ2QnOworCQl9CisJCS8qIFVubWVyZ2UuICovCisJCXRzdF9yZXNt
KFRJTkZPLCAiY2hpbGQgMCBzdG9wcy4iKTsKKwkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQor
CQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgImtpbGwiKTsKKworCQl0c3RfcmVz
bShUSU5GTywgImNoaWxkIDAgY29udGludWVzLi4uIik7CisJCXZlcmlmeSgnZCcsIDAsIDAsIHNp
emUgLyB1bml0LCAwLCB1bml0ICogTUIpOworCQkvKiBTdG9wLiAqLworCQl0c3RfcmVzbShUSU5G
TywgImNoaWxkIDAgc3RvcHMuIik7CisJCWlmIChyYWlzZShTSUdTVE9QKSA9PSAtMSkKKwkJCXRz
dF9icmttKFRCUk9LfFRFUlJOTywgdHN0X2V4aXQsICJraWxsIik7CisJCXRzdF9yZXNtKFRJTkZP
LCAiY2hpbGQgMCBjb250aW51ZXMuLi4iKTsKKwkJZXhpdCgwKTsKKwl9CisJc3dpdGNoIChjaGls
ZFsxXSA9IGZvcmsoKSkgeworCWNhc2UgLTE6CisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xl
YW51cCwgImZvcmsiKTsKKwljYXNlIDA6CisJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMSBzdG9w
cy4iKTsKKwkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQorCQkJdHN0X2Jya20oVEJST0t8VEVS
Uk5PLCB0c3RfZXhpdCwgImtpbGwiKTsKKwkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAxIGNvbnRp
bnVlcy4uLiIpOworCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgYWxsb2NhdGVzICVkIE1CIGZp
bGxlZCB3aXRoICdhJy4iLAorCQkJc2l6ZSk7CisJCW1lbW9yeVsxXSA9IG1hbGxvYyhzaXplIC8g
dW5pdCAqIHNpemVvZigqbWVtb3J5KSk7CisJCWlmIChtZW1vcnlbMV0gPT0gTlVMTCkKKwkJCXRz
dF9icmttKFRCUk9LfFRFUlJOTywgdHN0X2V4aXQsICJtYWxsb2MiKTsKKwkJZm9yIChqID0gMDsg
aiA8IHNpemUgLyB1bml0OyBqKyspIHsKKwkJCW1lbW9yeVsxXVtqXSA9IG1tYXAoTlVMTCwgdW5p
dCAqIE1CLAorCQkJCQlQUk9UX1JFQUR8UFJPVF9XUklURSwKKwkJCQkJTUFQX0FOT05ZTU9VU3xN
QVBfUFJJVkFURSwgLTEsIDApOworCQkJaWYgKG1lbW9yeVsxXVtqXSA9PSBNQVBfRkFJTEVEKQor
CQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgdHN0X2V4aXQsICJtbWFwIik7CisJCQlpZiAobWFk
dmlzZShtZW1vcnlbMV1bal0sIHVuaXQgKiBNQiwgTUFEVl9NRVJHRUFCTEUpCisJCQkJPT0gLTEp
CisJCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgIm1hZHZpc2UiKTsKKwkJCWZv
ciAoaSA9IDA7IGkgPCB1bml0ICogTUI7IGkrKykKKwkJCQltZW1vcnlbMV1bal1baV0gPSAnYSc7
CisJCX0KKwkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAxIHN0b3BzLiIpOworCQlpZiAocmFpc2Uo
U0lHU1RPUCkgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAia2ls
bCIpOworCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEgY29udGludWVzLi4uIik7CisJCXZlcmlm
eSgnYScsIDEsIDAsIHNpemUgLyB1bml0LCAwLCB1bml0ICogTUIpOworCQl0c3RfcmVzbShUSU5G
TywgImNoaWxkIDEgY2hhbmdlcyBtZW1vcnkgY29udGVudCB0byAnYicuIik7CisJCWZvciAoaiA9
IDA7IGogPCBzaXplIC8gdW5pdDsgaisrKSB7CisJCQlmb3IgKGkgPSAwOyBpIDwgdW5pdCAqIE1C
OyBpKyspCisJCQkJbWVtb3J5WzFdW2pdW2ldID0gJ2InOworCQl9CisJCXRzdF9yZXNtKFRJTkZP
LCAiY2hpbGQgMSBzdG9wcy4iKTsKKwkJaWYgKHJhaXNlKFNJR1NUT1ApID09IC0xKQorCQkJdHN0
X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgImtpbGwiKTsKKwkJdHN0X3Jlc20oVElORk8s
ICJjaGlsZCAxIGNvbnRpbnVlcy4uLiIpOworCQl2ZXJpZnkoJ2InLCAxLCAwLCBzaXplIC8gdW5p
dCwgMCwgdW5pdCAqIE1CKTsKKwkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAxIGNoYW5nZXMgbWVt
b3J5IGNvbnRlbnQgdG8gJ2QnIik7CisJCWZvciAoaiA9IDA7IGogPCBzaXplIC8gdW5pdDsgaisr
KSB7CisJCQlmb3IgKGkgPSAwOyBpIDwgdW5pdCAqIE1COyBpKyspCisJCQkJbWVtb3J5WzFdW2pd
W2ldID0gJ2QnOworCQl9CisJCWlmIChyYWlzZShTSUdTVE9QKSA9PSAtMSkKKwkJCXRzdF9icmtt
KFRCUk9LfFRFUlJOTywgdHN0X2V4aXQsICJraWxsIik7CisKKwkJdHN0X3Jlc20oVElORk8sICJj
aGlsZCAxIGNvbnRpbnVlcy4uLiIpOworCQl2ZXJpZnkoJ2QnLCAxLCAwLCBzaXplIC8gdW5pdCwg
MCwgdW5pdCAqIE1CKTsKKwkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAxIGNoYW5nZXMgb25lIHBh
Z2UgdG8gJ2UnLiIpOworCQltZW1vcnlbMV1bc2l6ZSAvIHVuaXQgLSAxXVt1bml0ICogTUIgLSAx
XSA9ICdlJzsKKworCQkvKiBVbm1lcmdlLiAqLworCQl0c3RfcmVzbShUSU5GTywgImNoaWxkIDEg
c3RvcHMuIik7CisJCWlmIChyYWlzZShTSUdTVE9QKSA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgdHN0X2V4aXQsICJraWxsIik7CisJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgMSBj
b250aW51ZXMuLi4iKTsKKwkJdmVyaWZ5KCdlJywgMSwgc2l6ZSAvIHVuaXQgLSAxLCBzaXplIC8g
dW5pdCwKKwkJCXVuaXQgKiBNQiAtIDEsIHVuaXQgKiBNQik7CisJCXZlcmlmeSgnZCcsIDEsIDAs
IHNpemUgLyB1bml0IC0gMSwgMCwgdW5pdCAqIE1CIC0gMSk7CisKKwkJLyogU3RvcC4gKi8KKwkJ
dHN0X3Jlc20oVElORk8sICJjaGlsZCAxIHN0b3BzLiIpOworCQlpZiAocmFpc2UoU0lHU1RPUCkg
PT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAia2lsbCIpOworCQl0
c3RfcmVzbShUSU5GTywgImNoaWxkIDEgY29udGludWVzLi4uIik7CisJCWV4aXQoMCk7CisJfQor
CWZvciAoayA9IDI7IGsgPCBudW07IGsrKykgeworCQlzd2l0Y2ggKGNoaWxkW2tdID0gZm9yaygp
KSB7CisJCWNhc2UgLTE6CisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJmb3Jr
Iik7CisJCWNhc2UgMDoKKwkJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgc3RvcHMuIiwgayk7
CisJCQlpZiAocmFpc2UoU0lHU1RPUCkgPT0gLTEpCisJCQkJdHN0X2Jya20oVEJST0t8VEVSUk5P
LCB0c3RfZXhpdCwgImtpbGwiKTsKKwkJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgY29udGlu
dWVzLi4uIiwgayk7CisJCQl0c3RfcmVzbShUSU5GTywgImNoaWxkICVkIGFsbG9jYXRlcyAlZCAi
CisJCQkJIk1CIGZpbGxlZCB3aXRoICdhJy4iLCBrLCBzaXplKTsKKwkJCW1lbW9yeVtrXSA9IG1h
bGxvYyhzaXplIC8gdW5pdCAqIHNpemVvZigqbWVtb3J5KSk7CisJCQlpZiAobWVtb3J5W2tdID09
IE5VTEwpCisJCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgIm1hbGxvYyIpOwor
CQkJZm9yIChqID0gMDsgaiA8IHNpemUgLyB1bml0OyBqKyspIHsKKwkJCQltZW1vcnlba11bal0g
PSBtbWFwKE5VTEwsIHVuaXQgKiBNQiwKKwkJCQkJCVBST1RfUkVBRHxQUk9UX1dSSVRFLAorCQkJ
CQkJTUFQX0FOT05ZTU9VUworCQkJCQkJfE1BUF9QUklWQVRFLCAtMSwgMCk7CisJCQkJaWYgKG1l
bW9yeVtrXVtqXSA9PSBNQVBfRkFJTEVEKQorCQkJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNs
ZWFudXAsCisJCQkJCQkibW1hcCIpOworCQkJCWlmIChtYWR2aXNlKG1lbW9yeVtrXVtqXSwgdW5p
dCAqIE1CLAorCQkJCQkJTUFEVl9NRVJHRUFCTEUpID09IC0xKQorCQkJCQl0c3RfYnJrbShUQlJP
S3xURVJSTk8sIGNsZWFudXAsCisJCQkJCQkibWFkdmlzZSIpOworCQkJCWZvciAoaSA9IDA7IGkg
PCB1bml0ICogTUI7IGkrKykKKwkJCQkJbWVtb3J5W2tdW2pdW2ldID0gJ2EnOworCQkJfQorCQkJ
dHN0X3Jlc20oVElORk8sICJjaGlsZCAlZCBzdG9wcy4iLCBrKTsKKwkJCWlmIChyYWlzZShTSUdT
VE9QKSA9PSAtMSkKKwkJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAia2lsbCIp
OworCQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCAlZCBjb250aW51ZXMuLi4iLCBrKTsKKwkJCXRz
dF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgY2hhbmdlcyBtZW1vcnkgY29udGVudCB0byAiCisJCQkJ
IidkJyIsIGspOworCQkJZm9yIChqID0gMDsgaiA8IHNpemUgLyB1bml0OyBqKyspIHsKKwkJCQlm
b3IgKGkgPSAwOyBpIDwgdW5pdCAqIE1COyBpKyspCisJCQkJCW1lbW9yeVtrXVtqXVtpXSA9ICdk
JzsKKwkJICAgICAgICB9CisJCQkvKiBVbm1lcmdlLiAqLworCQkJdHN0X3Jlc20oVElORk8sICJj
aGlsZCAlZCBzdG9wcy4iLCBrKTsKKwkJCWlmIChyYWlzZShTSUdTVE9QKSA9PSAtMSkKKwkJCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIHRzdF9leGl0LCAia2lsbCIpOworCQkJdHN0X3Jlc20oVElO
Rk8sICJjaGlsZCAlZCBjb250aW51ZXMuLi4iLCBrKTsKKworCQkJLyogU3RvcC4gKi8KKwkJCXRz
dF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgc3RvcHMuIiwgayk7CisJCQlpZiAocmFpc2UoU0lHU1RP
UCkgPT0gLTEpCisJCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCB0c3RfZXhpdCwgImtpbGwiKTsK
KwkJCXRzdF9yZXNtKFRJTkZPLCAiY2hpbGQgJWQgY29udGludWVzLi4uIiwgayk7CisJCQlleGl0
KDApOworCQl9CisJfQorCXRzdF9yZXNtKFRJTkZPLCAiS1NNIG1lcmdpbmcuLi4iKTsKKwlzbnBy
aW50ZihidWYsIEJVRlNJWiwgIiVzJXMiLCBQQVRIX0tTTSwgInJ1biIpOworCWZkID0gb3Blbihi
dWYsIE9fV1JPTkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywg
Y2xlYW51cCwgIm9wZW4iKTsKKwlpZiAod3JpdGUoZmQsICIxIiwgMSkgIT0gMSkKKwkJdHN0X2Jy
a20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUiKTsKKwljbG9zZShmZCk7CisJc25wcmlu
dGYoYnVmLCBCVUZTSVosICIlcyVzIiwgUEFUSF9LU00sICJwYWdlc190b19zY2FuIik7CisJc25w
cmludGYoYnVmMiwgQlVGU0laLCAiJWQiLCBzaXplICogMjU2ICogbnVtKTsKKwlmZCA9IG9wZW4o
YnVmLCBPX1dST05MWSk7CisJaWYgKGZkID09IC0xKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8s
IGNsZWFudXAsICJvcGVuIik7CisJaWYgKHdyaXRlKGZkLCBidWYyLCBzdHJsZW4oYnVmMikpICE9
IHN0cmxlbihidWYyKSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUi
KTsKKwljbG9zZShmZCk7CisKKwlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVzJXMiLCBQQVRIX0tT
TSwgInNsZWVwX21pbGxpc2VjcyIpOworCWZkID0gb3BlbihidWYsIE9fV1JPTkxZKTsKKwlpZiAo
ZmQgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4iKTsKKwlp
ZiAod3JpdGUoZmQsICIwIiwgMSkgIT0gMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVh
bnVwLCAid3JpdGUiKTsKKwljbG9zZShmZCk7CisKKwl0c3RfcmVzbShUSU5GTywgIndhaXQgZm9y
IGFsbCBjaGlsZHJlbiB0byBzdG9wLiIpOworCWZvciAoayA9IDA7IGsgPCBudW07IGsrKykgewor
CQlpZiAod2FpdHBpZChjaGlsZFtrXSwgJnN0YXR1cywgV1VOVFJBQ0VEKSA9PSAtMSkKKwkJCXRz
dF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndhaXRwaWQiKTsKKwkJaWYgKCFXSUZTVE9Q
UEVEKHN0YXR1cykpCisJCQl0c3RfYnJrbShUQlJPSywgY2xlYW51cCwgImNoaWxkICVkIHdhcyBu
b3Qgc3RvcHBlZC4iLAorCQkJCWspOworCX0KKwl0c3RfcmVzbShUSU5GTywgInJlc3VtZSBhbGwg
Y2hpbGRyZW4uIik7CisJZm9yIChrID0gMDsgayA8IG51bTsgaysrKSB7CisJCWlmIChraWxsKGNo
aWxkW2tdLCBTSUdDT05UKSA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51
cCwgImtpbGwgY2hpbGRbJWRdIiwgayk7CisJfQorCWdyb3VwX2NoZWNrKDEsIDIsIHNpemUgKiBu
dW0gKiAyNTYgLSAyLCAwLCAwLCAwLCBzaXplICogMjU2ICogbnVtKTsKKworCXRzdF9yZXNtKFRJ
TkZPLCAid2FpdCBmb3IgY2hpbGQgMSB0byBzdG9wLiIpOworCWlmICh3YWl0cGlkKGNoaWxkWzFd
LCAmc3RhdHVzLCBXVU5UUkFDRUQpID09IC0xKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNs
ZWFudXAsICJ3YWl0cGlkIik7CisJaWYgKCFXSUZTVE9QUEVEKHN0YXR1cykpCisJCXRzdF9icmtt
KFRCUk9LLCBjbGVhbnVwLCAiY2hpbGQgMSB3YXMgbm90IHN0b3BwZWQuIik7CisKKwkvKiBDaGls
ZCAxIGNoYW5nZXMgYWxsIHBhZ2VzIHRvICdiJy4gKi8KKwl0c3RfcmVzbShUSU5GTywgInJlc3Vt
ZSBjaGlsZCAxLiIpOworCWlmIChraWxsKGNoaWxkWzFdLCBTSUdDT05UKSA9PSAtMSkKKwkJdHN0
X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAia2lsbCIpOworCWdyb3VwX2NoZWNrKDEsIDMs
IHNpemUgKiBudW0gKiAyNTYgLSAzLCAwLCAwLCAwLCBzaXplICogMjU2ICogbnVtKTsKKworCXRz
dF9yZXNtKFRJTkZPLCAid2FpdCBmb3IgY2hpbGQgMSB0byBzdG9wLiIpOworCWlmICh3YWl0cGlk
KGNoaWxkWzFdLCAmc3RhdHVzLCBXVU5UUkFDRUQpID09IC0xKQorCQl0c3RfYnJrbShUQlJPS3xU
RVJSTk8sIGNsZWFudXAsICJ3YWl0cGlkIik7CisJaWYgKCFXSUZTVE9QUEVEKHN0YXR1cykpCisJ
CXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiY2hpbGQgMSB3YXMgbm90IHN0b3BwZWQuIik7CisK
KwkvKiBBbGwgY2hpbGRyZW4gY2hhbmdlIHBhZ2VzIHRvICdkJy4gKi8KKwl0c3RfcmVzbShUSU5G
TywgInJlc3VtZSBhbGwgY2hpbGRyZW4uIik7CisJZm9yIChrID0gMDsgayA8IG51bTsgaysrKSB7
CisJCWlmIChraWxsKGNoaWxkW2tdLCBTSUdDT05UKSA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgY2xlYW51cCwgImtpbGwgY2hpbGRbJWRdIiwgayk7CisJfQorCWdyb3VwX2NoZWNr
KDEsIDEsIHNpemUgKiBudW0gKiAyNTYgLSAxLCAwLCAwLCAwLCBzaXplICogMjU2ICogbnVtKTsK
KworCXRzdF9yZXNtKFRJTkZPLCAid2FpdCBmb3IgYWxsIGNoaWxkcmVuIHRvIHN0b3AuIik7CisJ
Zm9yIChrID0gMDsgayA8IG51bTsgaysrKSB7CisJCWlmICh3YWl0cGlkKGNoaWxkW2tdLCAmc3Rh
dHVzLCBXVU5UUkFDRUQpID09IC0xKQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVw
LCAid2FpdHBpZCIpOworCQlpZiAoIVdJRlNUT1BQRUQoc3RhdHVzKSkKKwkJCXRzdF9icmttKFRC
Uk9LLCBjbGVhbnVwLCAiY2hpbGQgJWQgd2FzIG5vdCBzdG9wcGVkLiIsCisJCQkJayk7CisJfQor
CS8qIENoaWxkIDEgY2hhbmdlcyBwYWdlcyB0byAnZScuICovCisJdHN0X3Jlc20oVElORk8sICJy
ZXN1bWUgY2hpbGQgMS4iKTsKKwlpZiAoa2lsbChjaGlsZFsxXSwgU0lHQ09OVCkgPT0gLTEpCisJ
CXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgImtpbGwiKTsKKwlncm91cF9jaGVjaygx
LCAxLCBzaXplICogbnVtICogMjU2IC0gMiwgMCwgMSwgMCwgc2l6ZSAqIDI1NiAqIG51bSk7CisK
Kwl0c3RfcmVzbShUSU5GTywgIndhaXQgZm9yIGNoaWxkIDEgdG8gc3RvcC4iKTsKKwlpZiAod2Fp
dHBpZChjaGlsZFsxXSwgJnN0YXR1cywgV1VOVFJBQ0VEKSA9PSAtMSkKKwkJdHN0X2Jya20oVEJS
T0t8VEVSUk5PLCBjbGVhbnVwLCAid2FpdHBpZCIpOworCWlmICghV0lGU1RPUFBFRChzdGF0dXMp
KQorCQl0c3RfYnJrbShUQlJPSywgY2xlYW51cCwgImNoaWxkIDEgd2FzIG5vdCBzdG9wcGVkLiIp
OworCisJdHN0X3Jlc20oVElORk8sICJyZXN1bWUgYWxsIGNoaWxkcmVuLiIpOworCWZvciAoayA9
IDA7IGsgPCBudW07IGsrKykgeworCQlpZiAoa2lsbChjaGlsZFtrXSwgU0lHQ09OVCkgPT0gLTEp
CisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJraWxsIGNoaWxkWyVkXSIsIGsp
OworCX0KKwl0c3RfcmVzbShUSU5GTywgIktTTSB1bm1lcmdpbmcuLi4iKTsKKwlzbnByaW50Zihi
dWYsIEJVRlNJWiwgIiVzJXMiLCBQQVRIX0tTTSwgInJ1biIpOworCWZkID0gb3BlbihidWYsIE9f
V1JPTkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51
cCwgIm9wZW4iKTsKKwlpZiAod3JpdGUoZmQsICIyIiwgMSkgIT0gMSkKKwkJdHN0X2Jya20oVEJS
T0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUiKTsKKwlncm91cF9jaGVjaygyLCAwLCAwLCAwLCAw
LCAwLCBzaXplICogMjU2ICogbnVtKTsKKworCXRzdF9yZXNtKFRJTkZPLCAid2FpdCBmb3IgYWxs
IGNoaWxkcmVuIHRvIHN0b3AuIik7CisJZm9yIChrID0gMDsgayA8IG51bTsgaysrKSB7CisJCWlm
ICh3YWl0cGlkKGNoaWxkW2tdLCAmc3RhdHVzLCBXVU5UUkFDRUQpID09IC0xKQorCQkJdHN0X2Jy
a20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid2FpdHBpZCIpOworCQlpZiAoIVdJRlNUT1BQRUQo
c3RhdHVzKSkKKwkJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiY2hpbGQgJWQgd2FzIG5vdCBz
dG9wcGVkLiIsCisJCQkJayk7CisJfQorCXRzdF9yZXNtKFRJTkZPLCAicmVzdW1lIGFsbCBjaGls
ZHJlbi4iKTsKKwlmb3IgKGsgPSAwOyBrIDwgbnVtOyBrKyspIHsKKwkJaWYgKGtpbGwoY2hpbGRb
a10sIFNJR0NPTlQpID09IC0xKQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAi
a2lsbCBjaGlsZFslZF0iLCBrKTsKKwl9CisJdHN0X3Jlc20oVElORk8sICJzdG9wIEtTTS4iKTsK
KwlpZiAobHNlZWsoZmQsIDAsIFNFRUtfU0VUKSA9PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVS
Uk5PLCBjbGVhbnVwLCAibHNlZWsiKTsKKwlpZiAod3JpdGUoZmQsICIwIiwgMSkgIT0gMSkKKwkJ
dHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUiKTsKKwljbG9zZShmZCk7CisJ
Z3JvdXBfY2hlY2soMCwgMCwgMCwgMCwgMCwgMCwgc2l6ZSAqIDI1NiAqIG51bSk7CisJd2hpbGUg
KHdhaXRwaWQoLTEsICZzdGF0dXMsIFdVTlRSQUNFRCB8IFdDT05USU5VRUQpID4gMCkKKwkJaWYg
KFdFWElUU1RBVFVTKHN0YXR1cykgIT0gMCkKKwkJCXRzdF9yZXNtKFRGQUlMLCAiY2hpbGQgZXhp
dCBzdGF0dXMgaXMgJWQiLAorCQkJCVdFWElUU1RBVFVTKHN0YXR1cykpOworfQorCit2b2lkIGNo
ZWNrX2tzbV9vcHRpb25zKGludCAqc2l6ZSwgaW50ICpudW0sIGludCAqdW5pdCkKK3sKKwlpZiAo
b3B0X3NpemUpIHsKKwkJKnNpemUgPSBhdG9pKG9wdF9zaXplc3RyKTsKKwkJaWYgKCpzaXplIDwg
MSkKKwkJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLAorCQkJCSJzaXplIGNhbm5vdCBiZSBsZXNz
IHRoYW4gMS4iKTsKKwl9CisJaWYgKG9wdF91bml0KSB7CisJCSp1bml0ID0gYXRvaShvcHRfdW5p
dHN0cik7CisJCWlmICgqdW5pdCA+ICpzaXplKQorCQkJdHN0X2Jya20oVEJST0ssIGNsZWFudXAs
CisJCQkJInVuaXQgY2Fubm90IGJlIGdyZWF0ZXIgdGhhbiBzaXplLiIpOworCQlpZiAoKnNpemUg
JSAqdW5pdCAhPSAwKQorCQkJdHN0X2Jya20oVEJST0ssIGNsZWFudXAsCisJCQkJInRoZSByZW1h
aW5kZXIgb2YgZGl2aXNpb24gb2Ygc2l6ZSBieSB1bml0IGlzICIKKwkJCQkibm90IHplcm8uIik7
CisJfQorCWlmIChvcHRfbnVtKSB7CisJCSpudW0gPSBhdG9pKG9wdF9udW1zdHIpOworCQlpZiAo
Km51bSA8IDMpCisJCQl0c3RfYnJrbShUQlJPSywgY2xlYW51cCwKKwkJCQkicHJvY2VzcyBudW1i
ZXIgY2Fubm90IGJlIGxlc3MgMy4iKTsKKwl9Cit9Ci0tIAoxLjcuMy4yCgo=
------=_Part_37147_773432378.1295362686018
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
------=_Part_37147_773432378.1295362686018
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_37147_773432378.1295362686018--

