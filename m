Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PX4vD-00038v-D8
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 04:42:59 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PX4vB-0007h3-HX
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 04:42:59 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBR4gqAi002488
	for <ltp-list@lists.sourceforge.net>; Sun, 26 Dec 2010 23:42:52 -0500
Date: Sun, 26 Dec 2010 23:42:52 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1828825400.85178.1293424972116.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1725905397.85172.1293424963025.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_85177_2122957994.1293424972115"
Subject: [LTP] [PATCH v3 3/5] oom03: test OOM for memcg
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

------=_Part_85177_2122957994.1293424972115
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v3: use common functions.
v2: code cleanup and skip 32-bit since there is no guarantee of running out of
    virtual memory address space there.

 testcases/kernel/mem/oom/oom03.c |  133 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 133 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/oom03.c

diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
new file mode 100644
index 0000000..8b677d3
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -0,0 +1,133 @@
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
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <errno.h>
+#include "test.h"
+#include "usctest.h"
+#include "lib/oom.h"
+
+char *TCID = "oom03";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+static void setup(void);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
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
+	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	
+	TEST_CLEANUP;
+	tst_exit();
+}
-- 
1.7.3.2
------=_Part_85177_2122957994.1293424972115
Content-Type: text/x-patch; name=0003-oom03-test-OOM-for-memcg.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0003-oom03-test-OOM-for-memcg.patch

RnJvbSBjMTE4ZTY4MWE4MDNhMDU0YjZhYjUzZDJiNjM4ODhlZDdiNzdhNTJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBN
b24sIDI3IERlYyAyMDEwIDEyOjI5OjUwICswODAwClN1YmplY3Q6IFtQQVRDSCB2MyAzLzVdIG9v
bTAzOiB0ZXN0IE9PTSBmb3IgbWVtY2cKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlh
bkByZWRoYXQuY29tPgotLS0KdjM6IHVzZSBjb21tb24gZnVuY3Rpb25zLgp2MjogY29kZSBjbGVh
bnVwIGFuZCBza2lwIDMyLWJpdCBzaW5jZSB0aGVyZSBpcyBubyBndWFyYW50ZWUgb2YgcnVubmlu
ZyBvdXQgb2YKICAgIHZpcnR1YWwgbWVtb3J5IGFkZHJlc3Mgc3BhY2UgdGhlcmUuCgogdGVzdGNh
c2VzL2tlcm5lbC9tZW0vb29tL29vbTAzLmMgfCAgMTMzICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDEzMyBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9v
b20wMy5jCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAzLmMgYi90
ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDMuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwLi44YjY3N2QzCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vb29tL29vbTAzLmMKQEAgLTAsMCArMSwxMzMgQEAKKy8qCisgKiBPdXQgT2YgTWVtb3J5IChP
T00pIGZvciBNZW1vcnkgUmVzb3VyY2UgQ29udHJvbGxlcgorICoKKyAqIFRoZSBwcm9ncmFtIGlz
IGRlc2lnbmVkIHRvIGNvcGUgd2l0aCB1bnByZWRpY3RhYmxlIGxpa2UgYW1vdW50IGFuZAorICog
c3lzdGVtIHBoeXNpY2FsIG1lbW9yeSwgc3dhcCBzaXplIGFuZCBvdGhlciBWTU0gdGVjaG5vbG9n
eSBsaWtlIEtTTSwKKyAqIG1lbWNnLCBtZW1vcnkgaG90cGx1ZyBhbmQgc28gb24gd2hpY2ggbWF5
IGFmZmVjdCB0aGUgT09NCisgKiBiZWhhdmlvdXJzLiBJdCBzaW1wbHkgaW5jcmVhc2UgdGhlIG1l
bW9yeSBjb25zdW1wdGlvbiAzRyBlYWNoIHRpbWUKKyAqIHVudGlsIGFsbCB0aGUgYXZhaWxhYmxl
IG1lbW9yeSBpcyBjb25zdW1lZCBhbmQgT09NIGlzIHRyaWdnZXJlZC4KKyAqCisgKiBDb3B5cmln
aHQgKEMpIDIwMTAgIFJlZCBIYXQsIEluYy4KKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IKKyAqIG1vZGlmeSBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdmVyc2lvbiAyIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMKKyAqIExpY2Vu
c2UgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisgKgorICog
VGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd291bGQgYmUg
dXNlZnVsLAorICogYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGlt
cGxpZWQgd2FycmFudHkgb2YKKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBB
UlRJQ1VMQVIgUFVSUE9TRS4KKyAqCisgKiBGdXJ0aGVyLCB0aGlzIHNvZnR3YXJlIGlzIGRpc3Ry
aWJ1dGVkIHdpdGhvdXQgYW55IHdhcnJhbnR5IHRoYXQgaXQKKyAqIGlzIGZyZWUgb2YgdGhlIHJp
Z2h0ZnVsIGNsYWltIG9mIGFueSB0aGlyZCBwZXJzb24gcmVnYXJkaW5nCisgKiBpbmZyaW5nZW1l
bnQgb3IgdGhlIGxpa2UuICBBbnkgbGljZW5zZSBwcm92aWRlZCBoZXJlaW4sIHdoZXRoZXIKKyAq
IGltcGxpZWQgb3Igb3RoZXJ3aXNlLCBhcHBsaWVzIG9ubHkgdG8gdGhpcyBzb2Z0d2FyZSBmaWxl
LiAgUGF0ZW50CisgKiBsaWNlbnNlcywgaWYgYW55LCBwcm92aWRlZCBoZXJlaW4gZG8gbm90IGFw
cGx5IHRvIGNvbWJpbmF0aW9ucyBvZgorICogdGhpcyBwcm9ncmFtIHdpdGggb3RoZXIgc29mdHdh
cmUsIG9yIGFueSBvdGhlciBwcm9kdWN0IHdoYXRzb2V2ZXIuCisgKgorICogWW91IHNob3VsZCBo
YXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAq
IGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRoZSBGcmVlIFNvZnR3YXJl
CisgKiBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29yLCBC
b3N0b24sIE1BCisgKiAwMjExMC0xMzAxLCBVU0EuCisgKi8KKyNpbmNsdWRlIDxzeXMvdHlwZXMu
aD4KKyNpbmNsdWRlIDxzeXMvc3RhdC5oPgorI2luY2x1ZGUgPGZjbnRsLmg+CisjaW5jbHVkZSA8
c3RkaW8uaD4KKyNpbmNsdWRlIDxlcnJuby5oPgorI2luY2x1ZGUgInRlc3QuaCIKKyNpbmNsdWRl
ICJ1c2N0ZXN0LmgiCisjaW5jbHVkZSAibGliL29vbS5oIgorCitjaGFyICpUQ0lEID0gIm9vbTAz
IjsKK2ludCBUU1RfVE9UQUwgPSAxOworZXh0ZXJuIGludCBUc3RfY291bnQ7CisKK3N0YXRpYyB2
b2lkIHNldHVwKHZvaWQpOworCitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQorewor
CWNoYXIgKm1zZzsKKwlpbnQgbGMsIGZkOworCWNoYXIgYnVmW0JVRlNJWl0sIG1lbVtCVUZTSVpd
OworCisJbXNnID0gcGFyc2Vfb3B0cyhhcmdjLCBhcmd2LCBOVUxMLCBOVUxMKTsKKwlpZiAobXNn
ICE9IE5VTEwpCisJCXRzdF9icmttKFRCUk9LLCB0c3RfZXhpdCwgIk9QVElPTiBQQVJTSU5HIEVS
Uk9SIC0gJXMiLCBtc2cpOworCisjaWZkZWYgX19pMzg2X18KKwl0c3RfYnJrbShUQ09ORiwgdHN0
X2V4aXQsCisJCSJ0ZXN0IGlzIG5vdCBkZXNpZ25lZCBmb3IgMzItYml0IHN5c3RlbS4iKTsKKyNl
bmRpZiAvKiBfX2kzODZfXyAqLworCisJc2V0dXAoKTsKKworCWZvciAobGMgPSAwOyBURVNUX0xP
T1BJTkcobGMpOyBsYysrKSB7CisJCVRzdF9jb3VudCA9IDA7CisJCWZkID0gb3BlbihTWVNGU19P
VkVSLCBPX1dST05MWSk7CisJCWlmIChmZCA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgY2xlYW51cCwgIm9wZW4iKTsKKwkJaWYgKHdyaXRlKGZkLCAiMSIsIDEpICE9IDEpCisJCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSIpOworCQljbG9zZShmZCk7CisK
KwkJZmQgPSBvcGVuKE1FTUNHX1BBVEhfTkVXICIvbWVtb3J5LmxpbWl0X2luX2J5dGVzIiwgT19X
Uk9OTFkpOworCQlpZiAoZmQgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFu
dXAsICJvcGVuICVzIiwgYnVmKTsKKwkJc3ByaW50ZihtZW0sICIlbGQiLCBURVNUTUVNKTsKKwkJ
aWYgKHdyaXRlKGZkLCBtZW0sIHN0cmxlbihtZW0pKSAhPSBzdHJsZW4obWVtKSkKKwkJCXRzdF9i
cmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlICVzIiwgYnVmKTsKKwkJY2xvc2UoZmQp
OworCisJCWZkID0gb3BlbihNRU1DR19QQVRIX05FVyAiL3Rhc2tzIiwgT19XUk9OTFkpOworCQlp
ZiAoZmQgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuICVz
IiwgYnVmKTsKKwkJc25wcmludGYoYnVmLCBCVUZTSVosICIlZCIsIGdldHBpZCgpKTsKKwkJaWYg
KHdyaXRlKGZkLCBidWYsIHN0cmxlbihidWYpKSAhPSBzdHJsZW4oYnVmKSkKKwkJCXRzdF9icmtt
KFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlICVzIiwgYnVmKTsKKwkJY2xvc2UoZmQpOwor
CQl0ZXN0b29tKDAsIDApOworCisJCWZkID0gb3BlbihNRU1DR19QQVRIX05FVyAiL21lbW9yeS5t
ZW1zdy5saW1pdF9pbl9ieXRlcyIsCisJCQlPX1dST05MWSk7CisJCWlmIChmZCA9PSAtMSkKKwkJ
CXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOworCQlpZiAo
d3JpdGUoZmQsIG1lbSwgc3RybGVuKG1lbSkpICE9IHN0cmxlbihtZW0pKQorCQkJdHN0X2Jya20o
VEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUgJXMiLCBidWYpOworCQljbG9zZShmZCk7CisJ
CXRlc3Rvb20oMCwgMSk7CisJfQorCWNsZWFudXAoKTsKK30KKwordm9pZCBzZXR1cCh2b2lkKQor
eworCWludCBmZDsKKworCXRzdF9zaWcoRk9SSywgREVGX0hBTkRMRVIsIGNsZWFudXApOworCVRF
U1RfUEFVU0U7CisKKwlmZCA9IG9wZW4oU1lTRlNfT1ZFUiwgT19SRE9OTFkpOworCWlmIChmZCA9
PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiIpOworCWlmIChy
ZWFkKGZkLCAmb3ZlcmNvbW1pdCwgMSkgIT0gMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBj
bGVhbnVwLCAicmVhZCIpOworCWNsb3NlKGZkKTsKKworCW1vdW50X21lbSgibWVtY2ciLCAiY2dy
b3VwIiwgIm1lbW9yeSIsIE1FTUNHX1BBVEgsIE1FTUNHX1BBVEhfTkVXKTsKK30KKwordm9pZCBj
bGVhbnVwKHZvaWQpCit7CisJaW50IGZkOworCisJZmQgPSBvcGVuKFNZU0ZTX09WRVIsIE9fV1JP
TkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwg
Im9wZW4iKTsKKwlpZiAod3JpdGUoZmQsICZvdmVyY29tbWl0LCAxKSAhPSAxKQorCQl0c3RfYnJr
bShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSIpOworCWNsb3NlKGZkKTsKKworCXVtb3Vu
dF9tZW0oTUVNQ0dfUEFUSCwgTUVNQ0dfUEFUSF9ORVcpOworCQorCVRFU1RfQ0xFQU5VUDsKKwl0
c3RfZXhpdCgpOworfQotLSAKMS43LjMuMgoK
------=_Part_85177_2122957994.1293424972115
Content-Type: text/x-patch; name=0003-oom03-test-OOM-for-memcg.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0003-oom03-test-OOM-for-memcg.patch

RnJvbSBjMTE4ZTY4MWE4MDNhMDU0YjZhYjUzZDJiNjM4ODhlZDdiNzdhNTJlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBN
b24sIDI3IERlYyAyMDEwIDEyOjI5OjUwICswODAwClN1YmplY3Q6IFtQQVRDSCB2MyAzLzVdIG9v
bTAzOiB0ZXN0IE9PTSBmb3IgbWVtY2cKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlh
bkByZWRoYXQuY29tPgotLS0KdjM6IHVzZSBjb21tb24gZnVuY3Rpb25zLgp2MjogY29kZSBjbGVh
bnVwIGFuZCBza2lwIDMyLWJpdCBzaW5jZSB0aGVyZSBpcyBubyBndWFyYW50ZWUgb2YgcnVubmlu
ZyBvdXQgb2YKICAgIHZpcnR1YWwgbWVtb3J5IGFkZHJlc3Mgc3BhY2UgdGhlcmUuCgogdGVzdGNh
c2VzL2tlcm5lbC9tZW0vb29tL29vbTAzLmMgfCAgMTMzICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGVzIGNoYW5nZWQsIDEzMyBpbnNlcnRpb25zKCspLCAwIGRl
bGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9v
b20wMy5jCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAzLmMgYi90
ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDMuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRl
eCAwMDAwMDAwLi44YjY3N2QzCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vb29tL29vbTAzLmMKQEAgLTAsMCArMSwxMzMgQEAKKy8qCisgKiBPdXQgT2YgTWVtb3J5IChP
T00pIGZvciBNZW1vcnkgUmVzb3VyY2UgQ29udHJvbGxlcgorICoKKyAqIFRoZSBwcm9ncmFtIGlz
IGRlc2lnbmVkIHRvIGNvcGUgd2l0aCB1bnByZWRpY3RhYmxlIGxpa2UgYW1vdW50IGFuZAorICog
c3lzdGVtIHBoeXNpY2FsIG1lbW9yeSwgc3dhcCBzaXplIGFuZCBvdGhlciBWTU0gdGVjaG5vbG9n
eSBsaWtlIEtTTSwKKyAqIG1lbWNnLCBtZW1vcnkgaG90cGx1ZyBhbmQgc28gb24gd2hpY2ggbWF5
IGFmZmVjdCB0aGUgT09NCisgKiBiZWhhdmlvdXJzLiBJdCBzaW1wbHkgaW5jcmVhc2UgdGhlIG1l
bW9yeSBjb25zdW1wdGlvbiAzRyBlYWNoIHRpbWUKKyAqIHVudGlsIGFsbCB0aGUgYXZhaWxhYmxl
IG1lbW9yeSBpcyBjb25zdW1lZCBhbmQgT09NIGlzIHRyaWdnZXJlZC4KKyAqCisgKiBDb3B5cmln
aHQgKEMpIDIwMTAgIFJlZCBIYXQsIEluYy4KKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IKKyAqIG1vZGlmeSBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdmVyc2lvbiAyIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMKKyAqIExpY2Vu
c2UgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisgKgorICog
VGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd291bGQgYmUg
dXNlZnVsLAorICogYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGlt
cGxpZWQgd2FycmFudHkgb2YKKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBB
UlRJQ1VMQVIgUFVSUE9TRS4KKyAqCisgKiBGdXJ0aGVyLCB0aGlzIHNvZnR3YXJlIGlzIGRpc3Ry
aWJ1dGVkIHdpdGhvdXQgYW55IHdhcnJhbnR5IHRoYXQgaXQKKyAqIGlzIGZyZWUgb2YgdGhlIHJp
Z2h0ZnVsIGNsYWltIG9mIGFueSB0aGlyZCBwZXJzb24gcmVnYXJkaW5nCisgKiBpbmZyaW5nZW1l
bnQgb3IgdGhlIGxpa2UuICBBbnkgbGljZW5zZSBwcm92aWRlZCBoZXJlaW4sIHdoZXRoZXIKKyAq
IGltcGxpZWQgb3Igb3RoZXJ3aXNlLCBhcHBsaWVzIG9ubHkgdG8gdGhpcyBzb2Z0d2FyZSBmaWxl
LiAgUGF0ZW50CisgKiBsaWNlbnNlcywgaWYgYW55LCBwcm92aWRlZCBoZXJlaW4gZG8gbm90IGFw
cGx5IHRvIGNvbWJpbmF0aW9ucyBvZgorICogdGhpcyBwcm9ncmFtIHdpdGggb3RoZXIgc29mdHdh
cmUsIG9yIGFueSBvdGhlciBwcm9kdWN0IHdoYXRzb2V2ZXIuCisgKgorICogWW91IHNob3VsZCBo
YXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAq
IGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRoZSBGcmVlIFNvZnR3YXJl
CisgKiBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29yLCBC
b3N0b24sIE1BCisgKiAwMjExMC0xMzAxLCBVU0EuCisgKi8KKyNpbmNsdWRlIDxzeXMvdHlwZXMu
aD4KKyNpbmNsdWRlIDxzeXMvc3RhdC5oPgorI2luY2x1ZGUgPGZjbnRsLmg+CisjaW5jbHVkZSA8
c3RkaW8uaD4KKyNpbmNsdWRlIDxlcnJuby5oPgorI2luY2x1ZGUgInRlc3QuaCIKKyNpbmNsdWRl
ICJ1c2N0ZXN0LmgiCisjaW5jbHVkZSAibGliL29vbS5oIgorCitjaGFyICpUQ0lEID0gIm9vbTAz
IjsKK2ludCBUU1RfVE9UQUwgPSAxOworZXh0ZXJuIGludCBUc3RfY291bnQ7CisKK3N0YXRpYyB2
b2lkIHNldHVwKHZvaWQpOworCitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQorewor
CWNoYXIgKm1zZzsKKwlpbnQgbGMsIGZkOworCWNoYXIgYnVmW0JVRlNJWl0sIG1lbVtCVUZTSVpd
OworCisJbXNnID0gcGFyc2Vfb3B0cyhhcmdjLCBhcmd2LCBOVUxMLCBOVUxMKTsKKwlpZiAobXNn
ICE9IE5VTEwpCisJCXRzdF9icmttKFRCUk9LLCB0c3RfZXhpdCwgIk9QVElPTiBQQVJTSU5HIEVS
Uk9SIC0gJXMiLCBtc2cpOworCisjaWZkZWYgX19pMzg2X18KKwl0c3RfYnJrbShUQ09ORiwgdHN0
X2V4aXQsCisJCSJ0ZXN0IGlzIG5vdCBkZXNpZ25lZCBmb3IgMzItYml0IHN5c3RlbS4iKTsKKyNl
bmRpZiAvKiBfX2kzODZfXyAqLworCisJc2V0dXAoKTsKKworCWZvciAobGMgPSAwOyBURVNUX0xP
T1BJTkcobGMpOyBsYysrKSB7CisJCVRzdF9jb3VudCA9IDA7CisJCWZkID0gb3BlbihTWVNGU19P
VkVSLCBPX1dST05MWSk7CisJCWlmIChmZCA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJO
TywgY2xlYW51cCwgIm9wZW4iKTsKKwkJaWYgKHdyaXRlKGZkLCAiMSIsIDEpICE9IDEpCisJCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSIpOworCQljbG9zZShmZCk7CisK
KwkJZmQgPSBvcGVuKE1FTUNHX1BBVEhfTkVXICIvbWVtb3J5LmxpbWl0X2luX2J5dGVzIiwgT19X
Uk9OTFkpOworCQlpZiAoZmQgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFu
dXAsICJvcGVuICVzIiwgYnVmKTsKKwkJc3ByaW50ZihtZW0sICIlbGQiLCBURVNUTUVNKTsKKwkJ
aWYgKHdyaXRlKGZkLCBtZW0sIHN0cmxlbihtZW0pKSAhPSBzdHJsZW4obWVtKSkKKwkJCXRzdF9i
cmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlICVzIiwgYnVmKTsKKwkJY2xvc2UoZmQp
OworCisJCWZkID0gb3BlbihNRU1DR19QQVRIX05FVyAiL3Rhc2tzIiwgT19XUk9OTFkpOworCQlp
ZiAoZmQgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuICVz
IiwgYnVmKTsKKwkJc25wcmludGYoYnVmLCBCVUZTSVosICIlZCIsIGdldHBpZCgpKTsKKwkJaWYg
KHdyaXRlKGZkLCBidWYsIHN0cmxlbihidWYpKSAhPSBzdHJsZW4oYnVmKSkKKwkJCXRzdF9icmtt
KFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIndyaXRlICVzIiwgYnVmKTsKKwkJY2xvc2UoZmQpOwor
CQl0ZXN0b29tKDAsIDApOworCisJCWZkID0gb3BlbihNRU1DR19QQVRIX05FVyAiL21lbW9yeS5t
ZW1zdy5saW1pdF9pbl9ieXRlcyIsCisJCQlPX1dST05MWSk7CisJCWlmIChmZCA9PSAtMSkKKwkJ
CXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLCBidWYpOworCQlpZiAo
d3JpdGUoZmQsIG1lbSwgc3RybGVuKG1lbSkpICE9IHN0cmxlbihtZW0pKQorCQkJdHN0X2Jya20o
VEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUgJXMiLCBidWYpOworCQljbG9zZShmZCk7CisJ
CXRlc3Rvb20oMCwgMSk7CisJfQorCWNsZWFudXAoKTsKK30KKwordm9pZCBzZXR1cCh2b2lkKQor
eworCWludCBmZDsKKworCXRzdF9zaWcoRk9SSywgREVGX0hBTkRMRVIsIGNsZWFudXApOworCVRF
U1RfUEFVU0U7CisKKwlmZCA9IG9wZW4oU1lTRlNfT1ZFUiwgT19SRE9OTFkpOworCWlmIChmZCA9
PSAtMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiIpOworCWlmIChy
ZWFkKGZkLCAmb3ZlcmNvbW1pdCwgMSkgIT0gMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBj
bGVhbnVwLCAicmVhZCIpOworCWNsb3NlKGZkKTsKKworCW1vdW50X21lbSgibWVtY2ciLCAiY2dy
b3VwIiwgIm1lbW9yeSIsIE1FTUNHX1BBVEgsIE1FTUNHX1BBVEhfTkVXKTsKK30KKwordm9pZCBj
bGVhbnVwKHZvaWQpCit7CisJaW50IGZkOworCisJZmQgPSBvcGVuKFNZU0ZTX09WRVIsIE9fV1JP
TkxZKTsKKwlpZiAoZmQgPT0gLTEpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwg
Im9wZW4iKTsKKwlpZiAod3JpdGUoZmQsICZvdmVyY29tbWl0LCAxKSAhPSAxKQorCQl0c3RfYnJr
bShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJ3cml0ZSIpOworCWNsb3NlKGZkKTsKKworCXVtb3Vu
dF9tZW0oTUVNQ0dfUEFUSCwgTUVNQ0dfUEFUSF9ORVcpOworCQorCVRFU1RfQ0xFQU5VUDsKKwl0
c3RfZXhpdCgpOworfQotLSAKMS43LjMuMgoK
------=_Part_85177_2122957994.1293424972115
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
------=_Part_85177_2122957994.1293424972115
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_85177_2122957994.1293424972115--

