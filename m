Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PUsGv-0003gq-Jn
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 02:48:17 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUsGt-00037T-TQ
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 02:48:17 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBL2mAvr031806
	for <ltp-list@lists.sourceforge.net>; Mon, 20 Dec 2010 21:48:10 -0500
Date: Mon, 20 Dec 2010 21:48:10 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1650367088.24614.1292899690275.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <192690881.24611.1292899687435.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24613_921470515.1292899690274"
Subject: [LTP] [PATCH v2 3/5] oom03: test OOM for memcg
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

------=_Part_24613_921470515.1292899690274
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: code cleanup and skip 32-bit since there is no guarantee of running out of
    virtual memory address space there.

 testcases/kernel/mem/oom/oom03.c |  253 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 253 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/oom03.c

diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
new file mode 100644
index 0000000..a4dea9f
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -0,0 +1,253 @@
+/*
+ * Out Of Memory (OOM) for Memory Resource Controller
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
+#include <sys/mount.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "oom03";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#define LENGTH		(3UL<<30)
+#define NORMAL		1
+#define MLOCK		2
+#define KSM		3
+#define PATH		"/dev/cgroup"
+#define PATH_NEW	PATH "/1"
+#define TESTMEM		(1UL<<30)
+#define MB		(1UL<<20)
+#define SYSFS_OVER	"/proc/sys/vm/overcommit_memory"
+
+static char overcommit[BUFSIZ];
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void oom(int testcase, int lite);
+static void testoom(int lite);
+static void alloc_mem(long int length, int testcase);
+static void test_alloc(int testcase, int lite);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
+	char buf[BUFSIZ], mem[BUFSIZ];
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
+		snprintf(buf, BUFSIZ, "%s/memory.limit_in_bytes", PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		sprintf(mem, "%ld", TESTMEM);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/tasks", PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		snprintf(buf, BUFSIZ, "%d", getpid());
+		if (write(fd, buf, strlen(buf)) != strlen(buf))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(0);
+
+		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
+			PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(1);
+	}
+	cleanup();
+}
+
+void testoom(int lite)
+{
+	tst_resm(TINFO, "start normal OOM testing.");
+	oom(NORMAL, lite);
+
+	tst_resm(TINFO, "start OOM testing for mlocked pages.");
+	oom(MLOCK, lite);
+
+	tst_resm(TINFO, "start OOM testing for KSM pages.");
+	oom(KSM, lite);
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
+	if (mkdir(PATH, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+	if (mount("memcg", PATH, "cgroup", 0, "memory") == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount %s", PATH);
+	if (mkdir(PATH_NEW, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", PATH_NEW);
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
+	/* Move all processes in task to its parent memcg node. */
+	snprintf(s, BUFSIZ, "%s/tasks", PATH);
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open %s", s);
+	snprintf(s_new, BUFSIZ, "%s/tasks", PATH_NEW);
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
+	if (rmdir(PATH_NEW) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", PATH_NEW);
+	if (umount(PATH) == -1)
+		tst_resm(TWARN|TERRNO, "umount %s", PATH);
+	if (rmdir(PATH) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", PATH);
+	
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+void alloc_mem(long int length, int testcase)
+{
+	void *s;
+
+	tst_resm(TINFO, "allocating %ld bytes.", length);
+	s = mmap(NULL, length, PROT_READ|PROT_WRITE,
+		MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (s == MAP_FAILED) {
+			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+	}
+	if (testcase == MLOCK && mlock(s, length) == -1)
+		tst_brkm(TINFO|TERRNO, cleanup, "mlock");
+	if (testcase == KSM
+		&& madvise(s, length, MADV_MERGEABLE) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "madvise");
+	memset(s, '\a', length);
+}
+
+void test_alloc(int testcase, int lite)
+{
+	if (lite)
+		alloc_mem(TESTMEM + MB, testcase);
+	else
+		while(1)
+			alloc_mem(LENGTH, testcase);
+}
+
+void oom(int testcase, int lite)
+{
+	pid_t pid;
+	int status;
+
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		test_alloc(testcase, lite);
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
-- 
1.7.3.2
------=_Part_24613_921470515.1292899690274
Content-Type: text/x-patch; name=0003-oom03-test-OOM-for-memcg.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0003-oom03-test-OOM-for-memcg.patch

RnJvbSBiZDQyZmI0NWRiM2E3N2M2MGJmMjQwZmVlODY5M2M0MjY5MTI3YWUyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDIxIERlYyAyMDEwIDEwOjMzOjUyICswODAwClN1YmplY3Q6IFtQQVRDSCB2MiAzLzVdIG9v
bTAzOiB0ZXN0IE9PTSBmb3IgbWVtY2cKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlh
bkByZWRoYXQuY29tPgotLS0KdjI6IGNvZGUgY2xlYW51cCBhbmQgc2tpcCAzMi1iaXQgc2luY2Ug
dGhlcmUgaXMgbm8gZ3VhcmFudGVlIG9mIHJ1bm5pbmcgb3V0IG9mCiAgICB2aXJ0dWFsIG1lbW9y
eSBhZGRyZXNzIHNwYWNlIHRoZXJlLgoKIHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMy5j
IHwgIDI1MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlcyBj
aGFuZ2VkLCAyNTMgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDMuYwoKZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29v
bTAzLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uYTRkZWE5ZgotLS0gL2Rl
di9udWxsCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMy5jCkBAIC0wLDAgKzEs
MjUzIEBACisvKgorICogT3V0IE9mIE1lbW9yeSAoT09NKSBmb3IgTWVtb3J5IFJlc291cmNlIENv
bnRyb2xsZXIKKyAqCisgKiBUaGUgcHJvZ3JhbSBpcyBkZXNpZ25lZCB0byBjb3BlIHdpdGggdW5w
cmVkaWN0YWJsZSBsaWtlIGFtb3VudCBhbmQKKyAqIHN5c3RlbSBwaHlzaWNhbCBtZW1vcnksIHN3
YXAgc2l6ZSBhbmQgb3RoZXIgVk1NIHRlY2hub2xvZ3kgbGlrZSBLU00sCisgKiBtZW1jZywgbWVt
b3J5IGhvdHBsdWcgYW5kIHNvIG9uIHdoaWNoIG1heSBhZmZlY3QgdGhlIE9PTQorICogYmVoYXZp
b3Vycy4gSXQgc2ltcGx5IGluY3JlYXNlIHRoZSBtZW1vcnkgY29uc3VtcHRpb24gM0cgZWFjaCB0
aW1lCisgKiB1bnRpbCBhbGwgdGhlIGF2YWlsYWJsZSBtZW1vcnkgaXMgY29uc3VtZWQgYW5kIE9P
TSBpcyB0cmlnZ2VyZWQuCisgKgorICogQ29weXJpZ2h0IChDKSAyMDEwICBSZWQgSGF0LCBJbmMu
CisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUg
aXQgYW5kL29yCisgKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHZlcnNpb24gMiBvZiB0
aGUgR05VIEdlbmVyYWwgUHVibGljCisgKiBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJl
ZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRl
ZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdvdWxkIGJlIHVzZWZ1bCwKKyAqIGJ1dCBXSVRIT1VUIEFO
WSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuCisgKgorICog
RnVydGhlciwgdGhpcyBzb2Z0d2FyZSBpcyBkaXN0cmlidXRlZCB3aXRob3V0IGFueSB3YXJyYW50
eSB0aGF0IGl0CisgKiBpcyBmcmVlIG9mIHRoZSByaWdodGZ1bCBjbGFpbSBvZiBhbnkgdGhpcmQg
cGVyc29uIHJlZ2FyZGluZworICogaW5mcmluZ2VtZW50IG9yIHRoZSBsaWtlLiAgQW55IGxpY2Vu
c2UgcHJvdmlkZWQgaGVyZWluLCB3aGV0aGVyCisgKiBpbXBsaWVkIG9yIG90aGVyd2lzZSwgYXBw
bGllcyBvbmx5IHRvIHRoaXMgc29mdHdhcmUgZmlsZS4gIFBhdGVudAorICogbGljZW5zZXMsIGlm
IGFueSwgcHJvdmlkZWQgaGVyZWluIGRvIG5vdCBhcHBseSB0byBjb21iaW5hdGlvbnMgb2YKKyAq
IHRoaXMgcHJvZ3JhbSB3aXRoIG90aGVyIHNvZnR3YXJlLCBvciBhbnkgb3RoZXIgcHJvZHVjdCB3
aGF0c29ldmVyLgorICoKKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhl
IEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisgKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsg
aWYgbm90LCB3cml0ZSB0aGUgRnJlZSBTb2Z0d2FyZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTEg
RnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQQorICogMDIxMTAtMTMwMSwg
VVNBLgorICovCisjaW5jbHVkZSA8c3lzL21vdW50Lmg+CisjaW5jbHVkZSA8c3lzL21tYW4uaD4K
KyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KKyNpbmNsdWRlIDxzeXMvc3RhdC5oPgorI2luY2x1ZGUg
PHN5cy93YWl0Lmg+CisjaW5jbHVkZSA8ZmNudGwuaD4KKyNpbmNsdWRlIDxzdGRpby5oPgorI2lu
Y2x1ZGUgPGVycm5vLmg+CisjaW5jbHVkZSA8c3RkbGliLmg+CisjaW5jbHVkZSA8c3RyaW5nLmg+
CisjaW5jbHVkZSA8ZXJybm8uaD4KKyNpbmNsdWRlIDxzaWduYWwuaD4KKyNpbmNsdWRlIDx1bmlz
dGQuaD4KKyNpbmNsdWRlICJ0ZXN0LmgiCisjaW5jbHVkZSAidXNjdGVzdC5oIgorCitjaGFyICpU
Q0lEID0gIm9vbTAzIjsKK2ludCBUU1RfVE9UQUwgPSAxOworZXh0ZXJuIGludCBUc3RfY291bnQ7
CisKKyNkZWZpbmUgTEVOR1RICQkoM1VMPDwzMCkKKyNkZWZpbmUgTk9STUFMCQkxCisjZGVmaW5l
IE1MT0NLCQkyCisjZGVmaW5lIEtTTQkJMworI2RlZmluZSBQQVRICQkiL2Rldi9jZ3JvdXAiCisj
ZGVmaW5lIFBBVEhfTkVXCVBBVEggIi8xIgorI2RlZmluZSBURVNUTUVNCQkoMVVMPDwzMCkKKyNk
ZWZpbmUgTUIJCSgxVUw8PDIwKQorI2RlZmluZSBTWVNGU19PVkVSCSIvcHJvYy9zeXMvdm0vb3Zl
cmNvbW1pdF9tZW1vcnkiCisKK3N0YXRpYyBjaGFyIG92ZXJjb21taXRbQlVGU0laXTsKKworc3Rh
dGljIHZvaWQgc2V0dXAodm9pZCk7CitzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpIExUUF9BVFRS
SUJVVEVfTk9SRVRVUk47CitzdGF0aWMgdm9pZCBvb20oaW50IHRlc3RjYXNlLCBpbnQgbGl0ZSk7
CitzdGF0aWMgdm9pZCB0ZXN0b29tKGludCBsaXRlKTsKK3N0YXRpYyB2b2lkIGFsbG9jX21lbShs
b25nIGludCBsZW5ndGgsIGludCB0ZXN0Y2FzZSk7CitzdGF0aWMgdm9pZCB0ZXN0X2FsbG9jKGlu
dCB0ZXN0Y2FzZSwgaW50IGxpdGUpOworCitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltd
KQoreworCWNoYXIgKm1zZzsKKwlpbnQgbGMsIGZkOworCWNoYXIgYnVmW0JVRlNJWl0sIG1lbVtC
VUZTSVpdOworCisJbXNnID0gcGFyc2Vfb3B0cyhhcmdjLCBhcmd2LCBOVUxMLCBOVUxMKTsKKwlp
ZiAobXNnICE9IChjaGFyICopTlVMTCkKKwkJdHN0X2Jya20oVEJST0ssIHRzdF9leGl0LCAiT1BU
SU9OIFBBUlNJTkcgRVJST1IgLSAlcyIsIG1zZyk7CisKKyNpZmRlZiBfX2kzODZfXworCXRzdF9i
cmttKFRDT05GLCB0c3RfZXhpdCwKKwkJInRlc3QgaXMgbm90IGRlc2lnbmVkIGZvciAzMi1iaXQg
c3lzdGVtLiIpOworI2VuZGlmIC8qIF9faTM4Nl9fICovCisKKwlzZXR1cCgpOworCisJZm9yIChs
YyA9IDA7IFRFU1RfTE9PUElORyhsYyk7IGxjKyspIHsKKwkJVHN0X2NvdW50ID0gMDsKKwkJZmQg
PSBvcGVuKFNZU0ZTX09WRVIsIE9fV1JPTkxZKTsKKwkJaWYgKGZkID09IC0xKQorCQkJdHN0X2Jy
a20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiIpOworCQlpZiAod3JpdGUoZmQsICIxIiwg
MSkgIT0gMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlIik7CisJ
CWNsb3NlKGZkKTsKKworCQlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVzL21lbW9yeS5saW1pdF9p
bl9ieXRlcyIsIFBBVEhfTkVXKTsKKwkJZmQgPSBvcGVuKGJ1ZiwgT19XUk9OTFkpOworCQlpZiAo
ZmQgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuICVzIiwg
YnVmKTsKKwkJc3ByaW50ZihtZW0sICIlbGQiLCBURVNUTUVNKTsKKwkJaWYgKHdyaXRlKGZkLCBt
ZW0sIHN0cmxlbihtZW0pKSAhPSBzdHJsZW4obWVtKSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgY2xlYW51cCwgIndyaXRlICVzIiwgYnVmKTsKKwkJY2xvc2UoZmQpOworCisJCXNucHJpbnRm
KGJ1ZiwgQlVGU0laLCAiJXMvdGFza3MiLCBQQVRIX05FVyk7CisJCWZkID0gb3BlbihidWYsIE9f
V1JPTkxZKTsKKwkJaWYgKGZkID09IC0xKQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVh
bnVwLCAib3BlbiAlcyIsIGJ1Zik7CisJCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJWQiLCBnZXRw
aWQoKSk7CisJCWlmICh3cml0ZShmZCwgYnVmLCBzdHJsZW4oYnVmKSkgIT0gc3RybGVuKGJ1Zikp
CisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSAlcyIsIGJ1Zik7CisJ
CWNsb3NlKGZkKTsKKwkJdGVzdG9vbSgwKTsKKworCQlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVz
L21lbW9yeS5tZW1zdy5saW1pdF9pbl9ieXRlcyIsCisJCQlQQVRIX05FVyk7CisJCWZkID0gb3Bl
bihidWYsIE9fV1JPTkxZKTsKKwkJaWYgKGZkID09IC0xKQorCQkJdHN0X2Jya20oVEJST0t8VEVS
Uk5PLCBjbGVhbnVwLCAib3BlbiAlcyIsIGJ1Zik7CisJCWlmICh3cml0ZShmZCwgbWVtLCBzdHJs
ZW4obWVtKSkgIT0gc3RybGVuKG1lbSkpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFu
dXAsICJ3cml0ZSAlcyIsIGJ1Zik7CisJCWNsb3NlKGZkKTsKKwkJdGVzdG9vbSgxKTsKKwl9CisJ
Y2xlYW51cCgpOworfQorCit2b2lkIHRlc3Rvb20oaW50IGxpdGUpCit7CisJdHN0X3Jlc20oVElO
Rk8sICJzdGFydCBub3JtYWwgT09NIHRlc3RpbmcuIik7CisJb29tKE5PUk1BTCwgbGl0ZSk7CisK
Kwl0c3RfcmVzbShUSU5GTywgInN0YXJ0IE9PTSB0ZXN0aW5nIGZvciBtbG9ja2VkIHBhZ2VzLiIp
OworCW9vbShNTE9DSywgbGl0ZSk7CisKKwl0c3RfcmVzbShUSU5GTywgInN0YXJ0IE9PTSB0ZXN0
aW5nIGZvciBLU00gcGFnZXMuIik7CisJb29tKEtTTSwgbGl0ZSk7Cit9CisKK3ZvaWQgc2V0dXAo
dm9pZCkKK3sKKwlpbnQgZmQ7CisKKwl0c3Rfc2lnKEZPUkssIERFRl9IQU5ETEVSLCBjbGVhbnVw
KTsKKwlURVNUX1BBVVNFOworCisJZmQgPSBvcGVuKFNZU0ZTX09WRVIsIE9fUkRPTkxZKTsKKwlp
ZiAoZmQgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4iKTsK
KwlpZiAocmVhZChmZCwgJm92ZXJjb21taXQsIDEpICE9IDEpCisJCXRzdF9icmttKFRCUk9LfFRF
UlJOTywgY2xlYW51cCwgInJlYWQiKTsKKwljbG9zZShmZCk7CisKKwlpZiAobWtkaXIoUEFUSCwg
MDc3NykgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm1rZGlyIik7
CisJaWYgKG1vdW50KCJtZW1jZyIsIFBBVEgsICJjZ3JvdXAiLCAwLCAibWVtb3J5IikgPT0gLTEp
CisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm1vdW50ICVzIiwgUEFUSCk7CisJ
aWYgKG1rZGlyKFBBVEhfTkVXLCAwNzc3KSA9PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5P
LCBjbGVhbnVwLCAibWtkaXIgJXMiLCBQQVRIX05FVyk7Cit9CisKK3ZvaWQgY2xlYW51cCh2b2lk
KQoreworCUZJTEUgKmZwOworCWludCBmZDsKKwljaGFyIHNfbmV3W0JVRlNJWl0sIHNbQlVGU0la
XSwgdmFsdWVbQlVGU0laXTsKKworCWZkID0gb3BlbihTWVNGU19PVkVSLCBPX1dST05MWSk7CisJ
aWYgKGZkID09IC0xKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuIik7
CisJaWYgKHdyaXRlKGZkLCAmb3ZlcmNvbW1pdCwgMSkgIT0gMSkKKwkJdHN0X2Jya20oVEJST0t8
VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUiKTsKKwljbG9zZShmZCk7CisKKwkvKiBNb3ZlIGFsbCBw
cm9jZXNzZXMgaW4gdGFzayB0byBpdHMgcGFyZW50IG1lbWNnIG5vZGUuICovCisJc25wcmludGYo
cywgQlVGU0laLCAiJXMvdGFza3MiLCBQQVRIKTsKKwlmZCA9IG9wZW4ocywgT19XUk9OTFkpOwor
CWlmIChmZCA9PSAtMSkKKwkJdHN0X3Jlc20oVFdBUk58VEVSUk5PLCAib3BlbiAlcyIsIHMpOwor
CXNucHJpbnRmKHNfbmV3LCBCVUZTSVosICIlcy90YXNrcyIsIFBBVEhfTkVXKTsKKworCWZwID0g
Zm9wZW4oc19uZXcsICJyIik7CisJaWYgKGZwID09IE5VTEwpCisJCXRzdF9yZXNtKFRXQVJOfFRF
UlJOTywgImZvcGVuICVzIiwgc19uZXcpOworCWlmICgoZmQgIT0gLTEpICYmIChmcCAhPSBOVUxM
KSkgeworCQl3aGlsZSAoZmdldHModmFsdWUsIEJVRlNJWiwgZnApICE9IE5VTEwpCisJCQlpZiAo
d3JpdGUoZmQsIHZhbHVlLCBzdHJsZW4odmFsdWUpIC0gMSkKKwkJCQkhPSBzdHJsZW4odmFsdWUp
IC0gMSkKKwkJCQl0c3RfcmVzbShUV0FSTnxURVJSTk8sICJ3cml0ZSAlcyIsIHMpOworCX0KKwlp
ZiAoZmQgIT0gLTEpCisJCWNsb3NlKGZkKTsKKwlpZiAoZnAgIT0gTlVMTCkKKwkJZmNsb3NlKGZw
KTsKKwlpZiAocm1kaXIoUEFUSF9ORVcpID09IC0xKQorCQl0c3RfcmVzbShUV0FSTnxURVJSTk8s
ICJybWRpciAlcyIsIFBBVEhfTkVXKTsKKwlpZiAodW1vdW50KFBBVEgpID09IC0xKQorCQl0c3Rf
cmVzbShUV0FSTnxURVJSTk8sICJ1bW91bnQgJXMiLCBQQVRIKTsKKwlpZiAocm1kaXIoUEFUSCkg
PT0gLTEpCisJCXRzdF9yZXNtKFRXQVJOfFRFUlJOTywgInJtZGlyICVzIiwgUEFUSCk7CisJCisJ
VEVTVF9DTEVBTlVQOworCXRzdF9leGl0KCk7Cit9CisKK3ZvaWQgYWxsb2NfbWVtKGxvbmcgaW50
IGxlbmd0aCwgaW50IHRlc3RjYXNlKQoreworCXZvaWQgKnM7CisKKwl0c3RfcmVzbShUSU5GTywg
ImFsbG9jYXRpbmcgJWxkIGJ5dGVzLiIsIGxlbmd0aCk7CisJcyA9IG1tYXAoTlVMTCwgbGVuZ3Ro
LCBQUk9UX1JFQUR8UFJPVF9XUklURSwKKwkJTUFQX0FOT05ZTU9VU3xNQVBfUFJJVkFURSwgLTEs
IDApOworCWlmIChzID09IE1BUF9GQUlMRUQpIHsKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywg
Y2xlYW51cCwgIm1tYXAiKTsKKwl9CisJaWYgKHRlc3RjYXNlID09IE1MT0NLICYmIG1sb2NrKHMs
IGxlbmd0aCkgPT0gLTEpCisJCXRzdF9icmttKFRJTkZPfFRFUlJOTywgY2xlYW51cCwgIm1sb2Nr
Iik7CisJaWYgKHRlc3RjYXNlID09IEtTTQorCQkmJiBtYWR2aXNlKHMsIGxlbmd0aCwgTUFEVl9N
RVJHRUFCTEUpID09IC0xKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJtYWR2
aXNlIik7CisJbWVtc2V0KHMsICdcYScsIGxlbmd0aCk7Cit9CisKK3ZvaWQgdGVzdF9hbGxvYyhp
bnQgdGVzdGNhc2UsIGludCBsaXRlKQoreworCWlmIChsaXRlKQorCQlhbGxvY19tZW0oVEVTVE1F
TSArIE1CLCB0ZXN0Y2FzZSk7CisJZWxzZQorCQl3aGlsZSgxKQorCQkJYWxsb2NfbWVtKExFTkdU
SCwgdGVzdGNhc2UpOworfQorCit2b2lkIG9vbShpbnQgdGVzdGNhc2UsIGludCBsaXRlKQorewor
CXBpZF90IHBpZDsKKwlpbnQgc3RhdHVzOworCisJc3dpdGNoKHBpZCA9IGZvcmsoKSkgeworCWNh
c2UgLTE6CisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgImZvcmsiKTsKKwljYXNl
IDA6CisJCXRlc3RfYWxsb2ModGVzdGNhc2UsIGxpdGUpOworCQlleGl0KDApOworCWRlZmF1bHQ6
CisJCWJyZWFrOworCX0KKwl0c3RfcmVzbShUSU5GTywgImV4cGVjdGVkIHZpY3RpbSBpcyAlZC4i
LCBwaWQpOworCWlmICh3YWl0cGlkKC0xLCAmc3RhdHVzLCAwKSA9PSAtMSkKKwkJdHN0X2Jya20o
VEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid2FpdHBpZCIpOworCisJaWYgKCFXSUZTSUdOQUxFRChz
dGF0dXMpIHx8IFdURVJNU0lHKHN0YXR1cykgIT0gU0lHS0lMTCkKKwkJdHN0X3Jlc20oVEZBSUws
ICJ0aGUgdmljdGltIHVuZXhwZWN0ZWRseSBmYWlsZWQ6ICVkIiwgc3RhdHVzKTsKK30KLS0gCjEu
Ny4zLjIKCg==
------=_Part_24613_921470515.1292899690274
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
------=_Part_24613_921470515.1292899690274
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_24613_921470515.1292899690274--

