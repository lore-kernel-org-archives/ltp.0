Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PUsFH-0003co-HH
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 02:46:35 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUsFF-0002xb-SW
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 02:46:35 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBL2kRE2012387
	for <ltp-list@lists.sourceforge.net>; Mon, 20 Dec 2010 21:46:27 -0500
Date: Mon, 20 Dec 2010 21:46:27 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <797632130.24592.1292899587873.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <890530690.24589.1292899563813.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24591_918114081.1292899587872"
Subject: [LTP] [PATCH v2 1/5] oom01: test OOM
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

------=_Part_24591_918114081.1292899587872
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

The previous version of this can be dropped.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: code cleanup and skip 32-bit since there is no guarantee of running out of
    virtual memory address space there.

 testcases/kernel/mem/oom/Makefile |   24 +++++
 testcases/kernel/mem/oom/oom01.c  |  186 +++++++++++++++++++++++++++++++++++++
 2 files changed, 210 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/Makefile
 create mode 100644 testcases/kernel/mem/oom/oom01.c

diff --git a/testcases/kernel/mem/oom/Makefile b/testcases/kernel/mem/oom/Makefile
new file mode 100644
index 0000000..2381ce2
--- /dev/null
+++ b/testcases/kernel/mem/oom/Makefile
@@ -0,0 +1,24 @@
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
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+LDLIBS 			+= $(NUMA_LIBS)
\ No newline at end of file
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
new file mode 100644
index 0000000..7c490ca
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -0,0 +1,186 @@
+/*
+ * Out Of Memory (OOM)
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
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <asm/types.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <signal.h>
+#include <unistd.h>
+#include <stdarg.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "oom01";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#define LENGTH		(3UL<<30)
+#define SYSFS_OVER	"/proc/sys/vm/overcommit_memory"
+#define OVERCOMMIT	1
+#define NORMAL		2
+#define MLOCK		3
+#define KSM		4
+
+static char overcommit[BUFSIZ];
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void oom(int testcase);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
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
+		tst_resm(TINFO, "start testing overcommit_memory=2.");
+		fd = open(SYSFS_OVER, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		if (write(fd, "2", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		oom(OVERCOMMIT);
+
+		tst_resm(TINFO, "start testing overcommit_memory=0.");
+		if (lseek(fd, SEEK_SET, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+		if (write(fd, "0", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		oom(OVERCOMMIT);
+
+		tst_resm(TINFO, "start normal OOM testing.");
+		if (lseek(fd, SEEK_SET, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		oom(NORMAL);
+
+		tst_resm(TINFO, "start OOM testing for mlocked pages.");
+		oom(MLOCK);
+
+		tst_resm(TINFO, "start OOM testing for KSM pages.");
+		oom(KSM);
+	}
+	cleanup();
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
+}
+
+void cleanup(void)
+{
+	int fd;
+
+	fd = open(SYSFS_OVER, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, &overcommit, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+void oom(int testcase)
+{
+	pid_t pid;
+	int status;
+	void *s; 
+
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		while(1) {
+			s = mmap(NULL, LENGTH, PROT_READ|PROT_WRITE,
+				MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+			if (s == MAP_FAILED) {
+				if (testcase == OVERCOMMIT && errno == ENOMEM)
+					break;
+				else
+					tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+			}
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
-- 
1.7.3.2
------=_Part_24591_918114081.1292899587872
Content-Type: text/x-patch; name=0001-oom01-test-OOM.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-oom01-test-OOM.patch

RnJvbSA5ODEwN2VmMzNmOTYyYzUyZDdjM2FjZWMzMzgzODgyMDI4ZTBlZTM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDIxIERlYyAyMDEwIDEwOjMxOjUzICswODAwClN1YmplY3Q6IFtQQVRDSCB2MiAxLzVdIG9v
bTAxOiB0ZXN0IE9PTQoKVGhlIHByZXZpb3VzIHZlcnNpb24gb2YgdGhpcyBjYW4gYmUgZHJvcHBl
ZC4KClNpZ25lZC1vZmYtYnk6IENBSSBRaWFuIDxjYWlxaWFuQHJlZGhhdC5jb20+Ci0tLQp2Mjog
Y29kZSBjbGVhbnVwIGFuZCBza2lwIDMyLWJpdCBzaW5jZSB0aGVyZSBpcyBubyBndWFyYW50ZWUg
b2YgcnVubmluZyBvdXQgb2YKICAgIHZpcnR1YWwgbWVtb3J5IGFkZHJlc3Mgc3BhY2UgdGhlcmUu
CgogdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL01ha2VmaWxlIHwgICAyNCArKysrKwogdGVzdGNh
c2VzL2tlcm5lbC9tZW0vb29tL29vbTAxLmMgIHwgIDE4NiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIxMCBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9N
YWtlZmlsZQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20w
MS5jCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL01ha2VmaWxlIGIvdGVz
dGNhc2VzL2tlcm5lbC9tZW0vb29tL01ha2VmaWxlCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4
IDAwMDAwMDAuLjIzODFjZTIKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL21l
bS9vb20vTWFrZWZpbGUKQEAgLTAsMCArMSwyNCBAQAorIworIyAgQ29weXJpZ2h0IChDKSAyMDEw
ICBSZWQgSGF0LCBJbmMuCisjCisjICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgIHlv
dSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyMgIGl0IHVuZGVyIHRoZSB0ZXJt
cyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CisjICB0
aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNl
bnNlLCBvcgorIyAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyMKKyMgIFRo
aXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNl
ZnVsLAorIyAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyAgd2l0aG91dCBldmVuIHRoZSBpbXBs
aWVkIHdhcnJhbnR5IG9mCisjICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJU
SUNVTEFSIFBVUlBPU0UuICBTZWUKKyMgIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBm
b3IgbW9yZSBkZXRhaWxzLgorIworIyAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBv
ZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyMgIGFsb25nIHdpdGggdGhpcyBwcm9n
cmFtOyAgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQorIyAgRm91bmRhdGlvbiwg
SW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBV
U0EKKyMKKwordG9wX3NyY2RpciAgICAgICAgICAgICAgPz0gLi4vLi4vLi4vLi4KKworaW5jbHVk
ZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvdGVzdGNhc2VzLm1rCitpbmNsdWRlICQodG9wX3Ny
Y2RpcikvaW5jbHVkZS9tay9nZW5lcmljX2xlYWZfdGFyZ2V0Lm1rCisKK0xETElCUyAJCQkrPSAk
KE5VTUFfTElCUykKXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCmRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9v
b20wMS5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjdjNDkwY2EKLS0tIC9k
ZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDEuYwpAQCAtMCwwICsx
LDE4NiBAQAorLyoKKyAqIE91dCBPZiBNZW1vcnkgKE9PTSkKKyAqCisgKiBUaGUgcHJvZ3JhbSBp
cyBkZXNpZ25lZCB0byBjb3BlIHdpdGggdW5wcmVkaWN0YWJsZSBsaWtlIGFtb3VudCBhbmQKKyAq
IHN5c3RlbSBwaHlzaWNhbCBtZW1vcnksIHN3YXAgc2l6ZSBhbmQgb3RoZXIgVk1NIHRlY2hub2xv
Z3kgbGlrZSBLU00sCisgKiBtZW1jZywgbWVtb3J5IGhvdHBsdWcgYW5kIHNvIG9uIHdoaWNoIG1h
eSBhZmZlY3QgdGhlIE9PTQorICogYmVoYXZpb3Vycy4gSXQgc2ltcGx5IGluY3JlYXNlIHRoZSBt
ZW1vcnkgY29uc3VtcHRpb24gM0cgZWFjaCB0aW1lCisgKiB1bnRpbCBhbGwgdGhlIGF2YWlsYWJs
ZSBtZW1vcnkgaXMgY29uc3VtZWQgYW5kIE9PTSBpcyB0cmlnZ2VyZWQuCisgKgorICogQ29weXJp
Z2h0IChDKSAyMDEwICBSZWQgSGF0LCBJbmMuCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0
d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yCisgKiBtb2RpZnkgaXQgdW5kZXIg
dGhlIHRlcm1zIG9mIHZlcnNpb24gMiBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljCisgKiBMaWNl
bnNlIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICoKKyAq
IFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdvdWxkIGJl
IHVzZWZ1bCwKKyAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBp
bXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSIFBVUlBPU0UuCisgKgorICogRnVydGhlciwgdGhpcyBzb2Z0d2FyZSBpcyBkaXN0
cmlidXRlZCB3aXRob3V0IGFueSB3YXJyYW50eSB0aGF0IGl0CisgKiBpcyBmcmVlIG9mIHRoZSBy
aWdodGZ1bCBjbGFpbSBvZiBhbnkgdGhpcmQgcGVyc29uIHJlZ2FyZGluZworICogaW5mcmluZ2Vt
ZW50IG9yIHRoZSBsaWtlLiAgQW55IGxpY2Vuc2UgcHJvdmlkZWQgaGVyZWluLCB3aGV0aGVyCisg
KiBpbXBsaWVkIG9yIG90aGVyd2lzZSwgYXBwbGllcyBvbmx5IHRvIHRoaXMgc29mdHdhcmUgZmls
ZS4gIFBhdGVudAorICogbGljZW5zZXMsIGlmIGFueSwgcHJvdmlkZWQgaGVyZWluIGRvIG5vdCBh
cHBseSB0byBjb21iaW5hdGlvbnMgb2YKKyAqIHRoaXMgcHJvZ3JhbSB3aXRoIG90aGVyIHNvZnR3
YXJlLCBvciBhbnkgb3RoZXIgcHJvZHVjdCB3aGF0c29ldmVyLgorICoKKyAqIFlvdSBzaG91bGQg
aGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisg
KiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0aGUgRnJlZSBTb2Z0d2Fy
ZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwg
Qm9zdG9uLCBNQQorICogMDIxMTAtMTMwMSwgVVNBLgorICovCisjaW5jbHVkZSA8c3lzL21tYW4u
aD4KKyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KKyNpbmNsdWRlIDxzeXMvc3RhdC5oPgorI2luY2x1
ZGUgPHN5cy93YWl0Lmg+CisjaW5jbHVkZSA8YXNtL3R5cGVzLmg+CisjaW5jbHVkZSA8ZmNudGwu
aD4KKyNpbmNsdWRlIDxzdGRpby5oPgorI2luY2x1ZGUgPGVycm5vLmg+CisjaW5jbHVkZSA8c3Rk
bGliLmg+CisjaW5jbHVkZSA8c3RyaW5nLmg+CisjaW5jbHVkZSA8c2lnbmFsLmg+CisjaW5jbHVk
ZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8c3RkYXJnLmg+CisjaW5jbHVkZSAidGVzdC5oIgorI2lu
Y2x1ZGUgInVzY3Rlc3QuaCIKKworY2hhciAqVENJRCA9ICJvb20wMSI7CitpbnQgVFNUX1RPVEFM
ID0gMTsKK2V4dGVybiBpbnQgVHN0X2NvdW50OworCisjZGVmaW5lIExFTkdUSAkJKDNVTDw8MzAp
CisjZGVmaW5lIFNZU0ZTX09WRVIJIi9wcm9jL3N5cy92bS9vdmVyY29tbWl0X21lbW9yeSIKKyNk
ZWZpbmUgT1ZFUkNPTU1JVAkxCisjZGVmaW5lIE5PUk1BTAkJMgorI2RlZmluZSBNTE9DSwkJMwor
I2RlZmluZSBLU00JCTQKKworc3RhdGljIGNoYXIgb3ZlcmNvbW1pdFtCVUZTSVpdOworCitzdGF0
aWMgdm9pZCBzZXR1cCh2b2lkKTsKK3N0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkgTFRQX0FUVFJJ
QlVURV9OT1JFVFVSTjsKK3N0YXRpYyB2b2lkIG9vbShpbnQgdGVzdGNhc2UpOworCitpbnQgbWFp
bihpbnQgYXJnYywgY2hhciAqYXJndltdKQoreworCWNoYXIgKm1zZzsKKwlpbnQgbGMsIGZkOwor
CisJbXNnID0gcGFyc2Vfb3B0cyhhcmdjLCBhcmd2LCBOVUxMLCBOVUxMKTsKKwlpZiAobXNnICE9
IChjaGFyICopTlVMTCkKKwkJdHN0X2Jya20oVEJST0ssIHRzdF9leGl0LCAiT1BUSU9OIFBBUlNJ
TkcgRVJST1IgLSAlcyIsIG1zZyk7CisKKyNpZmRlZiBfX2kzODZfXworCXRzdF9icmttKFRDT05G
LCB0c3RfZXhpdCwKKwkJInRlc3QgaXMgbm90IGRlc2lnbmVkIGZvciAzMi1iaXQgc3lzdGVtLiIp
OworI2VuZGlmIC8qIF9faTM4Nl9fICovCisKKwlzZXR1cCgpOworCisJZm9yIChsYyA9IDA7IFRF
U1RfTE9PUElORyhsYyk7IGxjKyspIHsKKwkJVHN0X2NvdW50ID0gMDsKKwkJdHN0X3Jlc20oVElO
Rk8sICJzdGFydCB0ZXN0aW5nIG92ZXJjb21taXRfbWVtb3J5PTIuIik7CisJCWZkID0gb3BlbihT
WVNGU19PVkVSLCBPX1dST05MWSk7CisJCWlmIChmZCA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgY2xlYW51cCwgIm9wZW4iKTsKKwkJaWYgKHdyaXRlKGZkLCAiMiIsIDEpICE9IDEp
CisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSIpOworCQlvb20oT1ZF
UkNPTU1JVCk7CisKKwkJdHN0X3Jlc20oVElORk8sICJzdGFydCB0ZXN0aW5nIG92ZXJjb21taXRf
bWVtb3J5PTAuIik7CisJCWlmIChsc2VlayhmZCwgU0VFS19TRVQsIDApID09IC0xKQorCQkJdHN0
X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAibHNlZWsiKTsKKwkJaWYgKHdyaXRlKGZkLCAi
MCIsIDEpICE9IDEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSIp
OworCQlvb20oT1ZFUkNPTU1JVCk7CisKKwkJdHN0X3Jlc20oVElORk8sICJzdGFydCBub3JtYWwg
T09NIHRlc3RpbmcuIik7CisJCWlmIChsc2VlayhmZCwgU0VFS19TRVQsIDApID09IC0xKQorCQkJ
dHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAibHNlZWsiKTsKKwkJaWYgKHdyaXRlKGZk
LCAiMSIsIDEpICE9IDEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0
ZSIpOworCQlvb20oTk9STUFMKTsKKworCQl0c3RfcmVzbShUSU5GTywgInN0YXJ0IE9PTSB0ZXN0
aW5nIGZvciBtbG9ja2VkIHBhZ2VzLiIpOworCQlvb20oTUxPQ0spOworCisJCXRzdF9yZXNtKFRJ
TkZPLCAic3RhcnQgT09NIHRlc3RpbmcgZm9yIEtTTSBwYWdlcy4iKTsKKwkJb29tKEtTTSk7CisJ
fQorCWNsZWFudXAoKTsKK30KKwordm9pZCBzZXR1cCh2b2lkKQoreworCWludCBmZDsKKworCXRz
dF9zaWcoRk9SSywgREVGX0hBTkRMRVIsIGNsZWFudXApOworCVRFU1RfUEFVU0U7CisKKwlmZCA9
IG9wZW4oU1lTRlNfT1ZFUiwgT19SRE9OTFkpOworCWlmIChmZCA9PSAtMSkKKwkJdHN0X2Jya20o
VEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiIpOworCWlmIChyZWFkKGZkLCAmb3ZlcmNvbW1p
dCwgMSkgIT0gMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAicmVhZCIpOwor
CWNsb3NlKGZkKTsKK30KKwordm9pZCBjbGVhbnVwKHZvaWQpCit7CisJaW50IGZkOworCisJZmQg
PSBvcGVuKFNZU0ZTX09WRVIsIE9fV1JPTkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9icmtt
KFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4iKTsKKwlpZiAod3JpdGUoZmQsICZvdmVyY29t
bWl0LCAxKSAhPSAxKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSIp
OworCWNsb3NlKGZkKTsKKworCVRFU1RfQ0xFQU5VUDsKKwl0c3RfZXhpdCgpOworfQorCit2b2lk
IG9vbShpbnQgdGVzdGNhc2UpCit7CisJcGlkX3QgcGlkOworCWludCBzdGF0dXM7CisJdm9pZCAq
czsgCisKKwlzd2l0Y2gocGlkID0gZm9yaygpKSB7CisJY2FzZSAtMToKKwkJdHN0X2Jya20oVEJS
T0t8VEVSUk5PLCBjbGVhbnVwLCAiZm9yayIpOworCWNhc2UgMDoKKwkJd2hpbGUoMSkgeworCQkJ
cyA9IG1tYXAoTlVMTCwgTEVOR1RILCBQUk9UX1JFQUR8UFJPVF9XUklURSwKKwkJCQlNQVBfQU5P
TllNT1VTfE1BUF9QUklWQVRFLCAtMSwgMCk7CisJCQlpZiAocyA9PSBNQVBfRkFJTEVEKSB7CisJ
CQkJaWYgKHRlc3RjYXNlID09IE9WRVJDT01NSVQgJiYgZXJybm8gPT0gRU5PTUVNKQorCQkJCQli
cmVhazsKKwkJCQllbHNlCisJCQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm1t
YXAiKTsKKwkJCX0KKwkJCWlmICh0ZXN0Y2FzZSA9PSBNTE9DSyAmJiBtbG9jayhzLCBMRU5HVEgp
ID09IC0xKQorCQkJCXRzdF9icmttKFRJTkZPfFRFUlJOTywgY2xlYW51cCwgIm1sb2NrIik7CisJ
CQlpZiAodGVzdGNhc2UgPT0gS1NNCisJCQkJJiYgbWFkdmlzZShzLCBMRU5HVEgsIE1BRFZfTUVS
R0VBQkxFKSA9PSAtMSkKKwkJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJtYWR2
aXNlIik7CisJCQltZW1zZXQocywgJ1xhJywgTEVOR1RIKTsKKwkJfQorCQlleGl0KDApOworCWRl
ZmF1bHQ6CisJCWJyZWFrOworCX0KKwl0c3RfcmVzbShUSU5GTywgImV4cGVjdGVkIHZpY3RpbSBp
cyAlZC4iLCBwaWQpOworCWlmICh3YWl0cGlkKC0xLCAmc3RhdHVzLCAwKSA9PSAtMSkKKwkJdHN0
X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid2FpdHBpZCIpOworCisJaWYgKHRlc3RjYXNl
ID09IE9WRVJDT01NSVQpIHsKKwkJaWYgKCFXSUZFWElURUQoc3RhdHVzKSB8fCBXRVhJVFNUQVRV
UyhzdGF0dXMpICE9IDApCisJCQl0c3RfcmVzbShURkFJTCwgInRoZSB2aWN0aW0gdW5leHBlY3Rl
ZGx5IGZhaWxlZDogJWQiLAorCQkJCXN0YXR1cyk7CisJfSBlbHNlIHsKKwkJaWYgKCFXSUZTSUdO
QUxFRChzdGF0dXMpIHx8IFdURVJNU0lHKHN0YXR1cykgIT0gU0lHS0lMTCkKKwkJCXRzdF9yZXNt
KFRGQUlMLCAidGhlIHZpY3RpbSB1bmV4cGVjdGVkbHkgZmFpbGVkOiAlZCIsCisJCQkJc3RhdHVz
KTsKKwl9Cit9Ci0tIAoxLjcuMy4yCgo=
------=_Part_24591_918114081.1292899587872
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
------=_Part_24591_918114081.1292899587872
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_24591_918114081.1292899587872--

