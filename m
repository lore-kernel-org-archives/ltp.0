Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PUsG9-0006aB-Rc
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 02:47:29 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUsG7-0006kL-S9
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 02:47:29 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBL2lLJ4012414
	for <ltp-list@lists.sourceforge.net>; Mon, 20 Dec 2010 21:47:21 -0500
Date: Mon, 20 Dec 2010 21:47:21 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1662204911.24601.1292899641904.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1256633228.24598.1292899638530.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24600_1085531968.1292899641904"
Subject: [LTP] [PATCH v2 2/5] oom02: test OOM for NUMA using mempolicy and
	cpuset
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

------=_Part_24600_1085531968.1292899641904
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: code cleanup and skip 32-bit since there is no guarantee of running out of
    virtual memory address space there.

 testcases/kernel/mem/oom/oom02.c |  312 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 312 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/oom02.c

diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
new file mode 100644
index 0000000..d5f241a
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -0,0 +1,312 @@
+/*
+ * Out Of Memory (OOM) for NUMA
+ *
+ * The program is designed to cope with unpredictable like amount and
+ * system physical memory, swap size and other VMM technology like KSM,
+ * memcg, memory hotplug and so on which may affect the OOM
+ * behaviours. It simply increase the memory consumption 3G each time
+ * until all the available memory is consumed and OOM is triggered.
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+#include "test.h"
+#include "usctest.h"
+#include "config.h"
+
+char *TCID = "oom02";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <sys/mount.h>
+#include <numaif.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <unistd.h>
+#include <stdarg.h>
+
+#define SYSFS_OVER		"/proc/sys/vm/overcommit_memory"
+#define MAXNODES		512
+#define CPATH			"/dev/cpuset"
+#define CPATH_NEW		CPATH "/1"
+#define _PATH_SYS_SYSTEM	"/sys/devices/system"
+#define LENGTH			(3UL<<30)
+#define NORMAL			1
+#define MLOCK			2
+#define KSM			3
+
+static char overcommit[BUFSIZ];
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void oom(int testcase, int mempolicy);
+static long count_numa(void);
+static int path_exist(const char *path, ...);
+static void testoom(int mempolicy);
+static void gather_cpus(char *cpus);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
+	unsigned long nnodes = 1;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != (char *)NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+#ifdef __i386__
+	tst_brkm(TCONF, tst_exit,
+		"test is not designed for 32-bit system.");
+#endif /* __i386__ */
+
+	nnodes = count_numa();
+	if (count_numa() == 1)
+		tst_brkm(TCONF, tst_exit, "required a NUMA system.");
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		fd = open(SYSFS_OVER, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		close(fd);
+
+		tst_resm(TINFO, "process mempolicy.");
+		testoom(1);
+
+		tst_resm(TINFO, "process cpuset.");
+		testoom(0);
+	}
+	cleanup();
+}
+
+void testoom(int mempolicy)
+{
+	int fd;
+	char buf[BUFSIZ] = "";
+	char cpus[BUFSIZ] = "";
+
+	if (!mempolicy) {
+		gather_cpus(cpus);
+		tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
+
+		snprintf(buf, BUFSIZ, "%s/cpuset.mems", CPATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/cpuset.cpus", CPATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/tasks", CPATH);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		snprintf(buf, BUFSIZ, "%d", getpid());
+		if (write(fd, buf, strlen(buf)) != strlen(buf))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+	}
+	tst_resm(TINFO, "start normal OOM testing.");
+	oom(NORMAL, mempolicy);
+
+	tst_resm(TINFO, "start OOM testing for mlocked pages.");
+	oom(MLOCK, mempolicy);
+
+	tst_resm(TINFO, "start OOM testing for KSM pages.");
+	oom(KSM, mempolicy);
+}
+
+void setup(void)
+{
+	int fd;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+
+	fd = open(SYSFS_OVER, O_RDONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (read(fd, &overcommit, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "read");
+	close(fd);
+
+	if (mkdir(CPATH, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", CPATH);
+	if (mount("cpuset", CPATH, "cpuset", 0, NULL) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount %s", CPATH);
+	if (mkdir(CPATH_NEW, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", CPATH_NEW);
+}
+
+void cleanup(void)
+{
+	FILE *fp;
+	int fd;
+	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+
+	fd = open(SYSFS_OVER, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, &overcommit, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	/* Move all processes in task to its parent cpuset node. */
+	snprintf(s, BUFSIZ, "%s/tasks", CPATH);
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open %s", s);
+	snprintf(s_new, BUFSIZ, "%s/tasks", CPATH_NEW);
+
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
+	if (rmdir(CPATH_NEW) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", CPATH_NEW);
+	if (umount(CPATH) == -1)
+		tst_resm(TWARN|TERRNO, "umount %s", CPATH);
+	if (rmdir(CPATH) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", CPATH);
+
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+void oom(int testcase, int mempolicy)
+{
+	pid_t pid;
+	int status;
+	void *s;
+	unsigned long nmask = 2;
+
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		if (mempolicy)
+			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"set_mempolicy");
+		while(1) {
+			s = mmap(NULL, LENGTH, PROT_READ|PROT_WRITE,
+				MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+			if (s == MAP_FAILED)
+				tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+			if (testcase == MLOCK && mlock(s, LENGTH) == -1)
+				tst_brkm(TINFO|TERRNO, cleanup, "mlock");
+			if (testcase == KSM
+				&& madvise(s, LENGTH, MADV_MERGEABLE) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "madvise");
+			memset(s, '\a', LENGTH);
+		}
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+
+	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+		tst_resm(TFAIL, "the victim unexpectedly failed: %d", status);
+}
+
+long count_numa(void)
+{
+	int nnodes = 0;
+
+	while(path_exist(_PATH_SYS_SYSTEM "/node/node%d", nnodes))
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
+	while(path_exist(_PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+		ncpus++;
+
+	for (i = 0; i < ncpus; i++)
+		if (path_exist(_PATH_SYS_SYSTEM "/node/node1/cpu%d", i)) {
+			sprintf(buf, "%d,", i);
+			strcat(cpus, buf);
+		}
+	/* Remove the trailing comma. */
+	cpus[strlen(cpus) - 1] = '\0';
+}
+
+#else /* no NUMA */
+int main(void) {
+	tst_resm(TCONF, "no NUMA development packages installed.");
+	tst_exit();
+}
+#endif
-- 
1.7.3.2
------=_Part_24600_1085531968.1292899641904
Content-Type: text/x-patch;
	name=0002-oom02-test-OOM-for-NUMA-using-mempolicy-and-cpuset.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0002-oom02-test-OOM-for-NUMA-using-mempolicy-and-cpuset.patch

RnJvbSBkYTkyMzBiOWQzZWJiMDA5ZWY5ZTkyMWI3NjRmYzE0MDIwYmJmOTc3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDIxIERlYyAyMDEwIDEwOjMyOjU5ICswODAwClN1YmplY3Q6IFtQQVRDSCB2MiAyLzVdIG9v
bTAyOiB0ZXN0IE9PTSBmb3IgTlVNQSB1c2luZyBtZW1wb2xpY3kgYW5kIGNwdXNldAoKClNpZ25l
ZC1vZmYtYnk6IENBSSBRaWFuIDxjYWlxaWFuQHJlZGhhdC5jb20+Ci0tLQp2MjogY29kZSBjbGVh
bnVwIGFuZCBza2lwIDMyLWJpdCBzaW5jZSB0aGVyZSBpcyBubyBndWFyYW50ZWUgb2YgcnVubmlu
ZyBvdXQgb2YKICAgIHZpcnR1YWwgbWVtb3J5IGFkZHJlc3Mgc3BhY2UgdGhlcmUuCgogdGVzdGNh
c2VzL2tlcm5lbC9tZW0vb29tL29vbTAyLmMgfCAgMzEyICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDMxMiBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9v
b20wMi5jCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAyLmMgYi90
ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDIuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwLi5kNWYyNDFhCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vb29tL29vbTAyLmMKQEAgLTAsMCArMSwzMTIgQEAKKy8qCisgKiBPdXQgT2YgTWVtb3J5IChP
T00pIGZvciBOVU1BCisgKgorICogVGhlIHByb2dyYW0gaXMgZGVzaWduZWQgdG8gY29wZSB3aXRo
IHVucHJlZGljdGFibGUgbGlrZSBhbW91bnQgYW5kCisgKiBzeXN0ZW0gcGh5c2ljYWwgbWVtb3J5
LCBzd2FwIHNpemUgYW5kIG90aGVyIFZNTSB0ZWNobm9sb2d5IGxpa2UgS1NNLAorICogbWVtY2cs
IG1lbW9yeSBob3RwbHVnIGFuZCBzbyBvbiB3aGljaCBtYXkgYWZmZWN0IHRoZSBPT00KKyAqIGJl
aGF2aW91cnMuIEl0IHNpbXBseSBpbmNyZWFzZSB0aGUgbWVtb3J5IGNvbnN1bXB0aW9uIDNHIGVh
Y2ggdGltZQorICogdW50aWwgYWxsIHRoZSBhdmFpbGFibGUgbWVtb3J5IGlzIGNvbnN1bWVkIGFu
ZCBPT00gaXMgdHJpZ2dlcmVkLgorICoKKyAqIENvcHlyaWdodCAoQykgMjAxMCAgUmVkIEhhdCwg
SW5jLgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmli
dXRlIGl0IGFuZC9vcgorICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB2ZXJzaW9uIDIg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYworICogTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkgdGhl
IEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJp
YnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3b3VsZCBiZSB1c2VmdWwsCisgKiBidXQgV0lUSE9V
VCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICog
TUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLgorICoK
KyAqIEZ1cnRoZXIsIHRoaXMgc29mdHdhcmUgaXMgZGlzdHJpYnV0ZWQgd2l0aG91dCBhbnkgd2Fy
cmFudHkgdGhhdCBpdAorICogaXMgZnJlZSBvZiB0aGUgcmlnaHRmdWwgY2xhaW0gb2YgYW55IHRo
aXJkIHBlcnNvbiByZWdhcmRpbmcKKyAqIGluZnJpbmdlbWVudCBvciB0aGUgbGlrZS4gIEFueSBs
aWNlbnNlIHByb3ZpZGVkIGhlcmVpbiwgd2hldGhlcgorICogaW1wbGllZCBvciBvdGhlcndpc2Us
IGFwcGxpZXMgb25seSB0byB0aGlzIHNvZnR3YXJlIGZpbGUuICBQYXRlbnQKKyAqIGxpY2Vuc2Vz
LCBpZiBhbnksIHByb3ZpZGVkIGhlcmVpbiBkbyBub3QgYXBwbHkgdG8gY29tYmluYXRpb25zIG9m
CisgKiB0aGlzIHByb2dyYW0gd2l0aCBvdGhlciBzb2Z0d2FyZSwgb3IgYW55IG90aGVyIHByb2R1
Y3Qgd2hhdHNvZXZlci4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9m
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogYWxvbmcgd2l0aCB0aGlzIHByb2dy
YW07IGlmIG5vdCwgd3JpdGUgdGhlIEZyZWUgU29mdHdhcmUKKyAqIEZvdW5kYXRpb24sIEluYy4s
IDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEKKyAqIDAyMTEwLTEz
MDEsIFVTQS4KKyAqLworI2luY2x1ZGUgInRlc3QuaCIKKyNpbmNsdWRlICJ1c2N0ZXN0LmgiCisj
aW5jbHVkZSAiY29uZmlnLmgiCisKK2NoYXIgKlRDSUQgPSAib29tMDIiOworaW50IFRTVF9UT1RB
TCA9IDE7CitleHRlcm4gaW50IFRzdF9jb3VudDsKKworI2lmIEhBVkVfTlVNQV9IICYmIEhBVkVf
TElOVVhfTUVNUE9MSUNZX0ggJiYgSEFWRV9OVU1BSUZfSCBcCisJJiYgSEFWRV9NUE9MX0NPTlNU
QU5UUworI2luY2x1ZGUgPHN5cy9tbWFuLmg+CisjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CisjaW5j
bHVkZSA8c3lzL3N0YXQuaD4KKyNpbmNsdWRlIDxzeXMvd2FpdC5oPgorI2luY2x1ZGUgPHN5cy9t
b3VudC5oPgorI2luY2x1ZGUgPG51bWFpZi5oPgorI2luY2x1ZGUgPGZjbnRsLmg+CisjaW5jbHVk
ZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDx1bmlzdGQuaD4KKyNpbmNsdWRlIDxlcnJuby5oPgorI2lu
Y2x1ZGUgPHN0ZGxpYi5oPgorI2luY2x1ZGUgPHN0cmluZy5oPgorI2luY2x1ZGUgPGVycm5vLmg+
CisjaW5jbHVkZSA8c2lnbmFsLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8c3Rk
YXJnLmg+CisKKyNkZWZpbmUgU1lTRlNfT1ZFUgkJIi9wcm9jL3N5cy92bS9vdmVyY29tbWl0X21l
bW9yeSIKKyNkZWZpbmUgTUFYTk9ERVMJCTUxMgorI2RlZmluZSBDUEFUSAkJCSIvZGV2L2NwdXNl
dCIKKyNkZWZpbmUgQ1BBVEhfTkVXCQlDUEFUSCAiLzEiCisjZGVmaW5lIF9QQVRIX1NZU19TWVNU
RU0JIi9zeXMvZGV2aWNlcy9zeXN0ZW0iCisjZGVmaW5lIExFTkdUSAkJCSgzVUw8PDMwKQorI2Rl
ZmluZSBOT1JNQUwJCQkxCisjZGVmaW5lIE1MT0NLCQkJMgorI2RlZmluZSBLU00JCQkzCisKK3N0
YXRpYyBjaGFyIG92ZXJjb21taXRbQlVGU0laXTsKKworc3RhdGljIHZvaWQgc2V0dXAodm9pZCk7
CitzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpIExUUF9BVFRSSUJVVEVfTk9SRVRVUk47CitzdGF0
aWMgdm9pZCBvb20oaW50IHRlc3RjYXNlLCBpbnQgbWVtcG9saWN5KTsKK3N0YXRpYyBsb25nIGNv
dW50X251bWEodm9pZCk7CitzdGF0aWMgaW50IHBhdGhfZXhpc3QoY29uc3QgY2hhciAqcGF0aCwg
Li4uKTsKK3N0YXRpYyB2b2lkIHRlc3Rvb20oaW50IG1lbXBvbGljeSk7CitzdGF0aWMgdm9pZCBn
YXRoZXJfY3B1cyhjaGFyICpjcHVzKTsKKworaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3Zb
XSkKK3sKKwljaGFyICptc2c7CisJaW50IGxjLCBmZDsKKwl1bnNpZ25lZCBsb25nIG5ub2RlcyA9
IDE7CisKKwltc2cgPSBwYXJzZV9vcHRzKGFyZ2MsIGFyZ3YsIE5VTEwsIE5VTEwpOworCWlmICht
c2cgIT0gKGNoYXIgKilOVUxMKQorCQl0c3RfYnJrbShUQlJPSywgdHN0X2V4aXQsICJPUFRJT04g
UEFSU0lORyBFUlJPUiAtICVzIiwgbXNnKTsKKworI2lmZGVmIF9faTM4Nl9fCisJdHN0X2Jya20o
VENPTkYsIHRzdF9leGl0LAorCQkidGVzdCBpcyBub3QgZGVzaWduZWQgZm9yIDMyLWJpdCBzeXN0
ZW0uIik7CisjZW5kaWYgLyogX19pMzg2X18gKi8KKworCW5ub2RlcyA9IGNvdW50X251bWEoKTsK
KwlpZiAoY291bnRfbnVtYSgpID09IDEpCisJCXRzdF9icmttKFRDT05GLCB0c3RfZXhpdCwgInJl
cXVpcmVkIGEgTlVNQSBzeXN0ZW0uIik7CisKKwlzZXR1cCgpOworCisJZm9yIChsYyA9IDA7IFRF
U1RfTE9PUElORyhsYyk7IGxjKyspIHsKKwkJVHN0X2NvdW50ID0gMDsKKwkJZmQgPSBvcGVuKFNZ
U0ZTX09WRVIsIE9fV1JPTkxZKTsKKwkJaWYgKGZkID09IC0xKQorCQkJdHN0X2Jya20oVEJST0t8
VEVSUk5PLCBjbGVhbnVwLCAib3BlbiIpOworCQlpZiAod3JpdGUoZmQsICIxIiwgMSkgIT0gMSkK
KwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlIik7CisJCWNsb3NlKGZk
KTsKKworCQl0c3RfcmVzbShUSU5GTywgInByb2Nlc3MgbWVtcG9saWN5LiIpOworCQl0ZXN0b29t
KDEpOworCisJCXRzdF9yZXNtKFRJTkZPLCAicHJvY2VzcyBjcHVzZXQuIik7CisJCXRlc3Rvb20o
MCk7CisJfQorCWNsZWFudXAoKTsKK30KKwordm9pZCB0ZXN0b29tKGludCBtZW1wb2xpY3kpCit7
CisJaW50IGZkOworCWNoYXIgYnVmW0JVRlNJWl0gPSAiIjsKKwljaGFyIGNwdXNbQlVGU0laXSA9
ICIiOworCisJaWYgKCFtZW1wb2xpY3kpIHsKKwkJZ2F0aGVyX2NwdXMoY3B1cyk7CisJCXRzdF9y
ZXNtKFRJTkZPLCAiQ1BVIGxpc3QgZm9yIDJuZCBub2RlIGlzICVzLiIsIGNwdXMpOworCisJCXNu
cHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMvY3B1c2V0Lm1lbXMiLCBDUEFUSF9ORVcpOworCQlmZCA9
IG9wZW4oYnVmLCBPX1dST05MWSk7CisJCWlmIChmZCA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOworCQlpZiAod3JpdGUoZmQsICIxIiwg
MSkgIT0gMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlICVzIiwg
YnVmKTsKKwkJY2xvc2UoZmQpOworCisJCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJXMvY3B1c2V0
LmNwdXMiLCBDUEFUSF9ORVcpOworCQlmZCA9IG9wZW4oYnVmLCBPX1dST05MWSk7CisJCWlmIChm
ZCA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBi
dWYpOworCQlpZiAod3JpdGUoZmQsIGNwdXMsIHN0cmxlbihjcHVzKSkgIT0gc3RybGVuKGNwdXMp
KQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUgJXMiLCBidWYpOwor
CQljbG9zZShmZCk7CisKKwkJc25wcmludGYoYnVmLCBCVUZTSVosICIlcy90YXNrcyIsIENQQVRI
KTsKKwkJZmQgPSBvcGVuKGJ1ZiwgT19XUk9OTFkpOworCQlpZiAoZmQgPT0gLTEpCisJCQl0c3Rf
YnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuICVzIiwgYnVmKTsKKwkJc25wcmludGYo
YnVmLCBCVUZTSVosICIlZCIsIGdldHBpZCgpKTsKKwkJaWYgKHdyaXRlKGZkLCBidWYsIHN0cmxl
bihidWYpKSAhPSBzdHJsZW4oYnVmKSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51
cCwgIndyaXRlICVzIiwgYnVmKTsKKwkJY2xvc2UoZmQpOworCX0KKwl0c3RfcmVzbShUSU5GTywg
InN0YXJ0IG5vcm1hbCBPT00gdGVzdGluZy4iKTsKKwlvb20oTk9STUFMLCBtZW1wb2xpY3kpOwor
CisJdHN0X3Jlc20oVElORk8sICJzdGFydCBPT00gdGVzdGluZyBmb3IgbWxvY2tlZCBwYWdlcy4i
KTsKKwlvb20oTUxPQ0ssIG1lbXBvbGljeSk7CisKKwl0c3RfcmVzbShUSU5GTywgInN0YXJ0IE9P
TSB0ZXN0aW5nIGZvciBLU00gcGFnZXMuIik7CisJb29tKEtTTSwgbWVtcG9saWN5KTsKK30KKwor
dm9pZCBzZXR1cCh2b2lkKQoreworCWludCBmZDsKKworCXRzdF9zaWcoRk9SSywgREVGX0hBTkRM
RVIsIGNsZWFudXApOworCVRFU1RfUEFVU0U7CisKKwlmZCA9IG9wZW4oU1lTRlNfT1ZFUiwgT19S
RE9OTFkpOworCWlmIChmZCA9PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVw
LCAib3BlbiIpOworCWlmIChyZWFkKGZkLCAmb3ZlcmNvbW1pdCwgMSkgIT0gMSkKKwkJdHN0X2Jy
a20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAicmVhZCIpOworCWNsb3NlKGZkKTsKKworCWlmICht
a2RpcihDUEFUSCwgMDc3NykgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51
cCwgIm1rZGlyICVzIiwgQ1BBVEgpOworCWlmIChtb3VudCgiY3B1c2V0IiwgQ1BBVEgsICJjcHVz
ZXQiLCAwLCBOVUxMKSA9PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAi
bW91bnQgJXMiLCBDUEFUSCk7CisJaWYgKG1rZGlyKENQQVRIX05FVywgMDc3NykgPT0gLTEpCisJ
CXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm1rZGlyICVzIiwgQ1BBVEhfTkVXKTsK
K30KKwordm9pZCBjbGVhbnVwKHZvaWQpCit7CisJRklMRSAqZnA7CisJaW50IGZkOworCWNoYXIg
c19uZXdbQlVGU0laXSwgc1tCVUZTSVpdLCB2YWx1ZVtCVUZTSVpdOworCisJZmQgPSBvcGVuKFNZ
U0ZTX09WRVIsIE9fV1JPTkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRF
UlJOTywgY2xlYW51cCwgIm9wZW4iKTsKKwlpZiAod3JpdGUoZmQsICZvdmVyY29tbWl0LCAxKSAh
PSAxKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSIpOworCWNsb3Nl
KGZkKTsKKworCS8qIE1vdmUgYWxsIHByb2Nlc3NlcyBpbiB0YXNrIHRvIGl0cyBwYXJlbnQgY3B1
c2V0IG5vZGUuICovCisJc25wcmludGYocywgQlVGU0laLCAiJXMvdGFza3MiLCBDUEFUSCk7CisJ
ZmQgPSBvcGVuKHMsIE9fV1JPTkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9yZXNtKFRXQVJO
fFRFUlJOTywgIm9wZW4gJXMiLCBzKTsKKwlzbnByaW50ZihzX25ldywgQlVGU0laLCAiJXMvdGFz
a3MiLCBDUEFUSF9ORVcpOworCisJZnAgPSBmb3BlbihzX25ldywgInIiKTsKKwlpZiAoZnAgPT0g
TlVMTCkKKwkJdHN0X3Jlc20oVFdBUk58VEVSUk5PLCAiZm9wZW4gJXMiLCBzX25ldyk7CisJaWYg
KChmZCAhPSAtMSkgJiYgKGZwICE9IE5VTEwpKSB7CisJCXdoaWxlIChmZ2V0cyh2YWx1ZSwgQlVG
U0laLCBmcCkgIT0gTlVMTCkKKwkJCWlmICh3cml0ZShmZCwgdmFsdWUsIHN0cmxlbih2YWx1ZSkg
LSAxKQorCQkJCSE9IHN0cmxlbih2YWx1ZSkgLSAxKQorCQkJCXRzdF9yZXNtKFRXQVJOfFRFUlJO
TywgIndyaXRlICVzIiwgcyk7CisJfQorCWlmIChmZCAhPSAtMSkKKwkJY2xvc2UoZmQpOworCWlm
IChmcCAhPSBOVUxMKQorCQlmY2xvc2UoZnApOworCWlmIChybWRpcihDUEFUSF9ORVcpID09IC0x
KQorCQl0c3RfcmVzbShUV0FSTnxURVJSTk8sICJybWRpciAlcyIsIENQQVRIX05FVyk7CisJaWYg
KHVtb3VudChDUEFUSCkgPT0gLTEpCisJCXRzdF9yZXNtKFRXQVJOfFRFUlJOTywgInVtb3VudCAl
cyIsIENQQVRIKTsKKwlpZiAocm1kaXIoQ1BBVEgpID09IC0xKQorCQl0c3RfcmVzbShUV0FSTnxU
RVJSTk8sICJybWRpciAlcyIsIENQQVRIKTsKKworCVRFU1RfQ0xFQU5VUDsKKwl0c3RfZXhpdCgp
OworfQorCit2b2lkIG9vbShpbnQgdGVzdGNhc2UsIGludCBtZW1wb2xpY3kpCit7CisJcGlkX3Qg
cGlkOworCWludCBzdGF0dXM7CisJdm9pZCAqczsKKwl1bnNpZ25lZCBsb25nIG5tYXNrID0gMjsK
KworCXN3aXRjaChwaWQgPSBmb3JrKCkpIHsKKwljYXNlIC0xOgorCQl0c3RfYnJrbShUQlJPS3xU
RVJSTk8sIGNsZWFudXAsICJmb3JrIik7CisJY2FzZSAwOgorCQlpZiAobWVtcG9saWN5KQorCQkJ
aWYgKHNldF9tZW1wb2xpY3koTVBPTF9CSU5ELCAmbm1hc2ssIE1BWE5PREVTKSA9PSAtMSkKKwkJ
CQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsCisJCQkJCSJzZXRfbWVtcG9saWN5Iik7
CisJCXdoaWxlKDEpIHsKKwkJCXMgPSBtbWFwKE5VTEwsIExFTkdUSCwgUFJPVF9SRUFEfFBST1Rf
V1JJVEUsCisJCQkJTUFQX0FOT05ZTU9VU3xNQVBfUFJJVkFURSwgLTEsIDApOworCQkJaWYgKHMg
PT0gTUFQX0ZBSUxFRCkKKwkJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJtbWFw
Iik7CisJCQlpZiAodGVzdGNhc2UgPT0gTUxPQ0sgJiYgbWxvY2socywgTEVOR1RIKSA9PSAtMSkK
KwkJCQl0c3RfYnJrbShUSU5GT3xURVJSTk8sIGNsZWFudXAsICJtbG9jayIpOworCQkJaWYgKHRl
c3RjYXNlID09IEtTTQorCQkJCSYmIG1hZHZpc2UocywgTEVOR1RILCBNQURWX01FUkdFQUJMRSkg
PT0gLTEpCisJCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAibWFkdmlzZSIpOwor
CQkJbWVtc2V0KHMsICdcYScsIExFTkdUSCk7CisJCX0KKwkJZXhpdCgwKTsKKwlkZWZhdWx0Ogor
CQlicmVhazsKKwl9CisJdHN0X3Jlc20oVElORk8sICJleHBlY3RlZCB2aWN0aW0gaXMgJWQuIiwg
cGlkKTsKKwlpZiAod2FpdHBpZCgtMSwgJnN0YXR1cywgMCkgPT0gLTEpCisJCXRzdF9icmttKFRC
Uk9LfFRFUlJOTywgY2xlYW51cCwgIndhaXRwaWQiKTsKKworCWlmICghV0lGU0lHTkFMRUQoc3Rh
dHVzKSB8fCBXVEVSTVNJRyhzdGF0dXMpICE9IFNJR0tJTEwpCisJCXRzdF9yZXNtKFRGQUlMLCAi
dGhlIHZpY3RpbSB1bmV4cGVjdGVkbHkgZmFpbGVkOiAlZCIsIHN0YXR1cyk7Cit9CisKK2xvbmcg
Y291bnRfbnVtYSh2b2lkKQoreworCWludCBubm9kZXMgPSAwOworCisJd2hpbGUocGF0aF9leGlz
dChfUEFUSF9TWVNfU1lTVEVNICIvbm9kZS9ub2RlJWQiLCBubm9kZXMpKQorCQlubm9kZXMrKzsK
KworCXJldHVybiBubm9kZXM7Cit9CisKK2ludCBwYXRoX2V4aXN0KGNvbnN0IGNoYXIgKnBhdGgs
IC4uLikKK3sKKwl2YV9saXN0IGFwOworCWNoYXIgcGF0aGJ1ZltQQVRIX01BWF07CisKKwl2YV9z
dGFydChhcCwgcGF0aCk7CisJdnNucHJpbnRmKHBhdGhidWYsIHNpemVvZihwYXRoYnVmKSwgcGF0
aCwgYXApOworCXZhX2VuZChhcCk7CisKKwlyZXR1cm4gYWNjZXNzKHBhdGhidWYsIEZfT0spID09
IDA7Cit9CisKK3ZvaWQgZ2F0aGVyX2NwdXMoY2hhciAqY3B1cykKK3sKKwlpbnQgbmNwdXMgPSAw
OworCWludCBpOworCWNoYXIgYnVmW0JVRlNJWl07CisKKwl3aGlsZShwYXRoX2V4aXN0KF9QQVRI
X1NZU19TWVNURU0gIi9jcHUvY3B1JWQiLCBuY3B1cykpCisJCW5jcHVzKys7CisKKwlmb3IgKGkg
PSAwOyBpIDwgbmNwdXM7IGkrKykKKwkJaWYgKHBhdGhfZXhpc3QoX1BBVEhfU1lTX1NZU1RFTSAi
L25vZGUvbm9kZTEvY3B1JWQiLCBpKSkgeworCQkJc3ByaW50ZihidWYsICIlZCwiLCBpKTsKKwkJ
CXN0cmNhdChjcHVzLCBidWYpOworCQl9CisJLyogUmVtb3ZlIHRoZSB0cmFpbGluZyBjb21tYS4g
Ki8KKwljcHVzW3N0cmxlbihjcHVzKSAtIDFdID0gJ1wwJzsKK30KKworI2Vsc2UgLyogbm8gTlVN
QSAqLworaW50IG1haW4odm9pZCkgeworCXRzdF9yZXNtKFRDT05GLCAibm8gTlVNQSBkZXZlbG9w
bWVudCBwYWNrYWdlcyBpbnN0YWxsZWQuIik7CisJdHN0X2V4aXQoKTsKK30KKyNlbmRpZgotLSAK
MS43LjMuMgoK
------=_Part_24600_1085531968.1292899641904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
------=_Part_24600_1085531968.1292899641904
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_24600_1085531968.1292899641904--

