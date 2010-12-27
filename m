Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PX4vz-0002FJ-HK
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 04:43:47 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PX4vy-00019i-8d
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 04:43:47 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBR4heJP002517
	for <ltp-list@lists.sourceforge.net>; Sun, 26 Dec 2010 23:43:40 -0500
Date: Sun, 26 Dec 2010 23:43:38 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1813665402.85184.1293425018385.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1664525907.85181.1293425008998.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_85183_16609378.1293425018384"
Subject: [LTP] [PATCH v3 4/5] oom04: test OOM for NUMA with memcg
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

------=_Part_85183_16609378.1293425018384
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v3: use common functions.
v2: code cleanup and skip 32-bit since there is no guarantee of running out of
    virtual memory address space there.

 testcases/kernel/mem/oom/oom04.c |  174 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 174 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/oom04.c

diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
new file mode 100644
index 0000000..11b9769
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -0,0 +1,174 @@
+/*
+ * Out Of Memory (OOM) for Memory Resource Controller and NUMA
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
+char *TCID = "oom04";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <errno.h>
+#include "lib/oom.h"
+
+static void setup(void);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
+	unsigned long nnodes = 1;
+	char buf[BUFSIZ], mem[BUFSIZ];
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
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
+		fd = open(MEMCG_PATH_NEW "/memory.limit_in_bytes", O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		sprintf(mem, "%ld", TESTMEM);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		fd = open(MEMCG_PATH_NEW "/tasks", O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		snprintf(buf, BUFSIZ, "%d", getpid());
+		if (write(fd, buf, strlen(buf)) != strlen(buf))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		tst_resm(TINFO, "process mempolicy.");
+		testoom(1, 0);
+
+		fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
+			O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(1, 1);
+
+		tst_resm(TINFO, "process cpuset.");
+		fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
+			O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		sprintf(mem, "%ld", TESTMEM);
+		if (write(fd, "-1", 2) != 2)
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(0, 0);
+
+		fd = open(MEMCG_PATH_NEW "/memory.memsw.limit_in_bytes",
+			O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(0, 1);
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
+
+	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
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
+	umount_mem(CPATH, CPATH_NEW);
+	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+#else /* no NUMA */
+int main(void)
+{
+	tst_resm(TCONF, "no NUMA development packages installed.");
+	tst_exit();
+}
+#endif
-- 
1.7.3.2
------=_Part_85183_16609378.1293425018384
Content-Type: text/x-patch; name=0004-oom04-test-OOM-for-NUMA-with-memcg.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0004-oom04-test-OOM-for-NUMA-with-memcg.patch

RnJvbSBjNDliMGY4ZDNhNzIzZjcxODIwZjNlZWIxZDBlN2QzYjdjZDE3NzNkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBN
b24sIDI3IERlYyAyMDEwIDEyOjMwOjI3ICswODAwClN1YmplY3Q6IFtQQVRDSCB2MyA0LzVdIG9v
bTA0OiB0ZXN0IE9PTSBmb3IgTlVNQSB3aXRoIG1lbWNnCgoKU2lnbmVkLW9mZi1ieTogQ0FJIFFp
YW4gPGNhaXFpYW5AcmVkaGF0LmNvbT4KLS0tCnYzOiB1c2UgY29tbW9uIGZ1bmN0aW9ucy4KdjI6
IGNvZGUgY2xlYW51cCBhbmQgc2tpcCAzMi1iaXQgc2luY2UgdGhlcmUgaXMgbm8gZ3VhcmFudGVl
IG9mIHJ1bm5pbmcgb3V0IG9mCiAgICB2aXJ0dWFsIG1lbW9yeSBhZGRyZXNzIHNwYWNlIHRoZXJl
LgoKIHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wNC5jIHwgIDE3NCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCAxNzQgaW5zZXJ0aW9u
cygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVs
L21lbS9vb20vb29tMDQuYwoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9v
b20wNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTA0LmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMC4uMTFiOTc2OQotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvbWVtL29vbS9vb20wNC5jCkBAIC0wLDAgKzEsMTc0IEBACisvKgorICogT3V0IE9m
IE1lbW9yeSAoT09NKSBmb3IgTWVtb3J5IFJlc291cmNlIENvbnRyb2xsZXIgYW5kIE5VTUEKKyAq
CisgKiBUaGUgcHJvZ3JhbSBpcyBkZXNpZ25lZCB0byBjb3BlIHdpdGggdW5wcmVkaWN0YWJsZSBs
aWtlIGFtb3VudCBhbmQKKyAqIHN5c3RlbSBwaHlzaWNhbCBtZW1vcnksIHN3YXAgc2l6ZSBhbmQg
b3RoZXIgVk1NIHRlY2hub2xvZ3kgbGlrZSBLU00sCisgKiBtZW1jZywgbWVtb3J5IGhvdHBsdWcg
YW5kIHNvIG9uIHdoaWNoIG1heSBhZmZlY3QgdGhlIE9PTQorICogYmVoYXZpb3Vycy4gSXQgc2lt
cGx5IGluY3JlYXNlIHRoZSBtZW1vcnkgY29uc3VtcHRpb24gM0cgZWFjaCB0aW1lCisgKiB1bnRp
bCBhbGwgdGhlIGF2YWlsYWJsZSBtZW1vcnkgaXMgY29uc3VtZWQgYW5kIE9PTSBpcyB0cmlnZ2Vy
ZWQuCisgKgorICogQ29weXJpZ2h0IChDKSAyMDEwICBSZWQgSGF0LCBJbmMuCisgKiBUaGlzIHBy
b2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yCisg
KiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHZlcnNpb24gMiBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljCisgKiBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBG
b3VuZGF0aW9uLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9w
ZSB0aGF0IGl0IHdvdWxkIGJlIHVzZWZ1bCwKKyAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsg
d2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJDSEFOVEFCSUxJVFkg
b3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuCisgKgorICogRnVydGhlciwgdGhp
cyBzb2Z0d2FyZSBpcyBkaXN0cmlidXRlZCB3aXRob3V0IGFueSB3YXJyYW50eSB0aGF0IGl0Cisg
KiBpcyBmcmVlIG9mIHRoZSByaWdodGZ1bCBjbGFpbSBvZiBhbnkgdGhpcmQgcGVyc29uIHJlZ2Fy
ZGluZworICogaW5mcmluZ2VtZW50IG9yIHRoZSBsaWtlLiAgQW55IGxpY2Vuc2UgcHJvdmlkZWQg
aGVyZWluLCB3aGV0aGVyCisgKiBpbXBsaWVkIG9yIG90aGVyd2lzZSwgYXBwbGllcyBvbmx5IHRv
IHRoaXMgc29mdHdhcmUgZmlsZS4gIFBhdGVudAorICogbGljZW5zZXMsIGlmIGFueSwgcHJvdmlk
ZWQgaGVyZWluIGRvIG5vdCBhcHBseSB0byBjb21iaW5hdGlvbnMgb2YKKyAqIHRoaXMgcHJvZ3Jh
bSB3aXRoIG90aGVyIHNvZnR3YXJlLCBvciBhbnkgb3RoZXIgcHJvZHVjdCB3aGF0c29ldmVyLgor
ICoKKyAqIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlCisgKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0
ZSB0aGUgRnJlZSBTb2Z0d2FyZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3Ry
ZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQQorICogMDIxMTAtMTMwMSwgVVNBLgorICovCisj
aW5jbHVkZSAidGVzdC5oIgorI2luY2x1ZGUgInVzY3Rlc3QuaCIKKyNpbmNsdWRlICJjb25maWcu
aCIKKworY2hhciAqVENJRCA9ICJvb20wNCI7CitpbnQgVFNUX1RPVEFMID0gMTsKK2V4dGVybiBp
bnQgVHN0X2NvdW50OworCisjaWYgSEFWRV9OVU1BX0ggJiYgSEFWRV9MSU5VWF9NRU1QT0xJQ1lf
SCAmJiBIQVZFX05VTUFJRl9IIFwKKwkmJiBIQVZFX01QT0xfQ09OU1RBTlRTCisjaW5jbHVkZSA8
c3lzL3R5cGVzLmg+CisjaW5jbHVkZSA8c3lzL3N0YXQuaD4KKyNpbmNsdWRlIDxmY250bC5oPgor
I2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8ZXJybm8uaD4KKyNpbmNsdWRlICJsaWIvb29t
LmgiCisKK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpOworCitpbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqYXJndltdKQoreworCWNoYXIgKm1zZzsKKwlpbnQgbGMsIGZkOworCXVuc2lnbmVkIGxvbmcg
bm5vZGVzID0gMTsKKwljaGFyIGJ1ZltCVUZTSVpdLCBtZW1bQlVGU0laXTsKKworCW1zZyA9IHBh
cnNlX29wdHMoYXJnYywgYXJndiwgTlVMTCwgTlVMTCk7CisJaWYgKG1zZyAhPSBOVUxMKQorCQl0
c3RfYnJrbShUQlJPSywgdHN0X2V4aXQsICJPUFRJT04gUEFSU0lORyBFUlJPUiAtICVzIiwgbXNn
KTsKKworI2lmZGVmIF9faTM4Nl9fCisJdHN0X2Jya20oVENPTkYsIHRzdF9leGl0LAorCQkidGVz
dCBpcyBub3QgZGVzaWduZWQgZm9yIDMyLWJpdCBzeXN0ZW0uIik7CisjZW5kaWYgLyogX19pMzg2
X18gKi8KKworCW5ub2RlcyA9IGNvdW50X251bWEoKTsKKwlpZiAoY291bnRfbnVtYSgpID09IDEp
CisJCXRzdF9icmttKFRDT05GLCB0c3RfZXhpdCwgInJlcXVpcmVkIGEgTlVNQSBzeXN0ZW0uIik7
CisKKwlzZXR1cCgpOworCisJZm9yIChsYyA9IDA7IFRFU1RfTE9PUElORyhsYyk7IGxjKyspIHsK
KwkJVHN0X2NvdW50ID0gMDsKKwkJZmQgPSBvcGVuKFNZU0ZTX09WRVIsIE9fV1JPTkxZKTsKKwkJ
aWYgKGZkID09IC0xKQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiIp
OworCQlpZiAod3JpdGUoZmQsICIxIiwgMSkgIT0gMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgY2xlYW51cCwgIndyaXRlIik7CisJCWNsb3NlKGZkKTsKKworCQlmZCA9IG9wZW4oTUVNQ0df
UEFUSF9ORVcgIi9tZW1vcnkubGltaXRfaW5fYnl0ZXMiLCBPX1dST05MWSk7CisJCWlmIChmZCA9
PSAtMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYp
OworCQlzcHJpbnRmKG1lbSwgIiVsZCIsIFRFU1RNRU0pOworCQlpZiAod3JpdGUoZmQsIG1lbSwg
c3RybGVuKG1lbSkpICE9IHN0cmxlbihtZW0pKQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBj
bGVhbnVwLCAid3JpdGUgJXMiLCBidWYpOworCQljbG9zZShmZCk7CisKKwkJZmQgPSBvcGVuKE1F
TUNHX1BBVEhfTkVXICIvdGFza3MiLCBPX1dST05MWSk7CisJCWlmIChmZCA9PSAtMSkKKwkJCXRz
dF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOworCQlzbnByaW50
ZihidWYsIEJVRlNJWiwgIiVkIiwgZ2V0cGlkKCkpOworCQlpZiAod3JpdGUoZmQsIGJ1Ziwgc3Ry
bGVuKGJ1ZikpICE9IHN0cmxlbihidWYpKQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVh
bnVwLCAid3JpdGUgJXMiLCBidWYpOworCQljbG9zZShmZCk7CisKKwkJdHN0X3Jlc20oVElORk8s
ICJwcm9jZXNzIG1lbXBvbGljeS4iKTsKKwkJdGVzdG9vbSgxLCAwKTsKKworCQlmZCA9IG9wZW4o
TUVNQ0dfUEFUSF9ORVcgIi9tZW1vcnkubWVtc3cubGltaXRfaW5fYnl0ZXMiLAorCQkJT19XUk9O
TFkpOworCQlpZiAoZmQgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAs
ICJvcGVuICVzIiwgYnVmKTsKKwkJaWYgKHdyaXRlKGZkLCBtZW0sIHN0cmxlbihtZW0pKSAhPSBz
dHJsZW4obWVtKSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlICVz
IiwgYnVmKTsKKwkJY2xvc2UoZmQpOworCQl0ZXN0b29tKDEsIDEpOworCisJCXRzdF9yZXNtKFRJ
TkZPLCAicHJvY2VzcyBjcHVzZXQuIik7CisJCWZkID0gb3BlbihNRU1DR19QQVRIX05FVyAiL21l
bW9yeS5tZW1zdy5saW1pdF9pbl9ieXRlcyIsCisJCQlPX1dST05MWSk7CisJCWlmIChmZCA9PSAt
MSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOwor
CQlzcHJpbnRmKG1lbSwgIiVsZCIsIFRFU1RNRU0pOworCQlpZiAod3JpdGUoZmQsICItMSIsIDIp
ICE9IDIpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSAlcyIsIGJ1
Zik7CisJCWNsb3NlKGZkKTsKKwkJdGVzdG9vbSgwLCAwKTsKKworCQlmZCA9IG9wZW4oTUVNQ0df
UEFUSF9ORVcgIi9tZW1vcnkubWVtc3cubGltaXRfaW5fYnl0ZXMiLAorCQkJT19XUk9OTFkpOwor
CQlpZiAoZmQgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVu
ICVzIiwgYnVmKTsKKwkJaWYgKHdyaXRlKGZkLCBtZW0sIHN0cmxlbihtZW0pKSAhPSBzdHJsZW4o
bWVtKSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlICVzIiwgYnVm
KTsKKwkJY2xvc2UoZmQpOworCQl0ZXN0b29tKDAsIDEpOworCX0KKwljbGVhbnVwKCk7Cit9CisK
K3ZvaWQgc2V0dXAodm9pZCkKK3sKKwlpbnQgZmQ7CisKKwl0c3Rfc2lnKEZPUkssIERFRl9IQU5E
TEVSLCBjbGVhbnVwKTsKKwlURVNUX1BBVVNFOworCisJZmQgPSBvcGVuKFNZU0ZTX09WRVIsIE9f
UkRPTkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51
cCwgIm9wZW4iKTsKKwlpZiAocmVhZChmZCwgJm92ZXJjb21taXQsIDEpICE9IDEpCisJCXRzdF9i
cmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgInJlYWQiKTsKKwljbG9zZShmZCk7CisKKwltb3Vu
dF9tZW0oImNwdXNldCIsICJjcHVzZXQiLCBOVUxMLCBDUEFUSCwgQ1BBVEhfTkVXKTsKKwltb3Vu
dF9tZW0oIm1lbWNnIiwgImNncm91cCIsICJtZW1vcnkiLCBNRU1DR19QQVRILCBNRU1DR19QQVRI
X05FVyk7Cit9CisKK3ZvaWQgY2xlYW51cCh2b2lkKQoreworCWludCBmZDsKKworCWZkID0gb3Bl
bihTWVNGU19PVkVSLCBPX1dST05MWSk7CisJaWYgKGZkID09IC0xKQorCQl0c3RfYnJrbShUQlJP
S3xURVJSTk8sIGNsZWFudXAsICJvcGVuIik7CisJaWYgKHdyaXRlKGZkLCAmb3ZlcmNvbW1pdCwg
MSkgIT0gMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUiKTsKKwlj
bG9zZShmZCk7CisKKwl1bW91bnRfbWVtKENQQVRILCBDUEFUSF9ORVcpOworCXVtb3VudF9tZW0o
TUVNQ0dfUEFUSCwgTUVNQ0dfUEFUSF9ORVcpOworCisJVEVTVF9DTEVBTlVQOworCXRzdF9leGl0
KCk7Cit9CisKKyNlbHNlIC8qIG5vIE5VTUEgKi8KK2ludCBtYWluKHZvaWQpCit7CisJdHN0X3Jl
c20oVENPTkYsICJubyBOVU1BIGRldmVsb3BtZW50IHBhY2thZ2VzIGluc3RhbGxlZC4iKTsKKwl0
c3RfZXhpdCgpOworfQorI2VuZGlmCi0tIAoxLjcuMy4yCgo=
------=_Part_85183_16609378.1293425018384
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
------=_Part_85183_16609378.1293425018384
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_85183_16609378.1293425018384--

