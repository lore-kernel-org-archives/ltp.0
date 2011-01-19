Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfTA0-0002a3-9G
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:12:56 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfT9y-0000rQ-MQ
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:12:56 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0J8Cnse004784
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Jan 2011 03:12:49 -0500
Date: Wed, 19 Jan 2011 03:12:49 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1589333791.56189.1295424769221.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1064791416.56186.1295424761697.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_56188_1039912611.1295424769220"
Subject: [LTP] [PATCH] zram01: add a new test for zram feature
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

------=_Part_56188_1039912611.1295424769220
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

zram: generic RAM based compressed R/W block devices
http://lkml.org/lkml/2010/8/9/227

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/zram/Makefile |   22 +++++
 testcases/kernel/mem/zram/zram01.c |  159 ++++++++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/zram/Makefile
 create mode 100644 testcases/kernel/mem/zram/zram01.c

diff --git a/testcases/kernel/mem/zram/Makefile b/testcases/kernel/mem/zram/Makefile
new file mode 100644
index 0000000..3634570
--- /dev/null
+++ b/testcases/kernel/mem/zram/Makefile
@@ -0,0 +1,22 @@
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
diff --git a/testcases/kernel/mem/zram/zram01.c b/testcases/kernel/mem/zram/zram01.c
new file mode 100644
index 0000000..e0a0361
--- /dev/null
+++ b/testcases/kernel/mem/zram/zram01.c
@@ -0,0 +1,159 @@
+/*
+ * zram: generic RAM based compressed R/W block devices
+ * http://lkml.org/lkml/2010/8/9/227
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
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <errno.h>
+#include <unistd.h>
+#include <string.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "zram01";
+int TST_TOTAL = 1;
+int modprobe = 0;
+
+#define PATH_ZRAM	"/sys/block/zram0"
+#define SIZE		(512 * 1024 * 1024)
+#define DEVICE		"/dev/zram0"
+
+static void setup(void);
+static void cleanup(void);
+static void print(char *string);
+static void dump_info(void);
+
+int main(int argc, char *argv[])
+{
+	int lc, fd;
+	char *msg;
+	char size[BUFSIZ];
+	void *s;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		tst_resm(TINFO, "create a zram device with %d bytes in size.",
+			SIZE);
+		fd = open(PATH_ZRAM "/disksize", O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s",
+				PATH_ZRAM "/disksize");
+		sprintf(size, "%d", SIZE);
+		if (write(fd, size, strlen(size)) != strlen(size))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s to %s", size,
+				PATH_ZRAM "/disksize");
+		close(fd);
+
+		tst_resm(TINFO, "map it into memory.");
+		fd = open(DEVICE, O_RDWR);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", DEVICE);
+		s = mmap(NULL, SIZE, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
+		if (s == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+
+		tst_resm(TINFO, "write all the memory.");
+		memset(s, SIZE, 'a');
+		close(fd);
+
+		dump_info();
+
+		tst_resm(TINFO, "reset it.");
+		fd = open(PATH_ZRAM "/reset", O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s",
+				PATH_ZRAM "/reset");
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write 1 to %s",
+				PATH_ZRAM "/reset");
+		close(fd);
+
+		dump_info();
+	}
+	cleanup();
+	tst_exit();
+}
+
+void setup(void)
+{
+	tst_require_root(NULL);
+
+	if (access(PATH_ZRAM, R_OK|W_OK|X_OK) == -1 && errno == ENOENT) {
+		system("modprobe zram");
+		modprobe = 1;
+		if (access(PATH_ZRAM, R_OK|W_OK|X_OK) == -1 && errno == ENOENT)
+			tst_brkm(TCONF, NULL, "system has no zram device.");
+		else
+			tst_brkm(TBROK|TERRNO, NULL, "access");
+	}
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+	if (modprobe == 1)
+		system("rmmod zram");
+
+	TEST_CLEANUP;
+}
+
+void print(char *string)
+{
+	FILE *fp;
+	char buf[BUFSIZ], value[BUFSIZ];
+
+	sprintf(buf, "%s/%s", PATH_ZRAM, string);
+	fp = fopen(buf, "r");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen %s", buf);
+
+	if (fgets(value, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets %s", buf);
+	value[strlen(value) - 1] = '\0';
+	fclose(fp);
+
+	tst_resm(TINFO, "%s is %s", buf, value);
+}
+
+void dump_info(void)
+{
+	print("initstate");
+	print("compr_data_size");
+	print("orig_data_size");
+	print("disksize");
+	print("mem_used_total");
+	print("num_reads");
+	print("num_writes");
+	print("zero_pages");
+}
-- 
1.7.3.2
------=_Part_56188_1039912611.1295424769220
Content-Type: text/x-patch;
	name=0001-zram01-add-a-new-test-for-zram-feature.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-zram01-add-a-new-test-for-zram-feature.patch

RnJvbSAyNjliNDI1YjVjZjg3NjE5NzFjZThkYmVkZjNkZjcwYmU4MDgwNTlkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBX
ZWQsIDE5IEphbiAyMDExIDE1OjU4OjA5ICswODAwClN1YmplY3Q6IFtQQVRDSF0genJhbTAxOiBh
ZGQgYSBuZXcgdGVzdCBmb3IgenJhbSBmZWF0dXJlCgp6cmFtOiBnZW5lcmljIFJBTSBiYXNlZCBj
b21wcmVzc2VkIFIvVyBibG9jayBkZXZpY2VzCmh0dHA6Ly9sa21sLm9yZy9sa21sLzIwMTAvOC85
LzIyNwoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0LmNvbT4KLS0tCiB0
ZXN0Y2FzZXMva2VybmVsL21lbS96cmFtL01ha2VmaWxlIHwgICAyMiArKysrKwogdGVzdGNhc2Vz
L2tlcm5lbC9tZW0venJhbS96cmFtMDEuYyB8ICAxNTkgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE4MSBpbnNlcnRpb25zKCspLCAwIGRlbGV0
aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvbWVtL3pyYW0vTWFr
ZWZpbGUKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL21lbS96cmFtL3pyYW0w
MS5jCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0venJhbS9NYWtlZmlsZSBiL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL3pyYW0vTWFrZWZpbGUKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5k
ZXggMDAwMDAwMC4uMzYzNDU3MAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
bWVtL3pyYW0vTWFrZWZpbGUKQEAgLTAsMCArMSwyMiBAQAorIworIyAgQ29weXJpZ2h0IChDKSAy
MDEwICBSZWQgSGF0LCBJbmMuCisjCisjICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsg
IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKKyMgIGl0IHVuZGVyIHRoZSB0
ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5Cisj
ICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBM
aWNlbnNlLCBvcgorIyAgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KKyMKKyMg
IFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUg
dXNlZnVsLAorIyAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyAgd2l0aG91dCBldmVuIHRoZSBp
bXBsaWVkIHdhcnJhbnR5IG9mCisjICBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQ
QVJUSUNVTEFSIFBVUlBPU0UuICBTZWUKKyMgIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBmb3IgbW9yZSBkZXRhaWxzLgorIworIyAgWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29w
eSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyMgIGFsb25nIHdpdGggdGhpcyBw
cm9ncmFtOyAgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZQorIyAgRm91bmRhdGlv
biwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMw
NyBVU0EKKyMKKwordG9wX3NyY2RpciAgICAgICAgICAgICAgPz0gLi4vLi4vLi4vLi4KKworaW5j
bHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvdGVzdGNhc2VzLm1rCitpbmNsdWRlICQodG9w
X3NyY2RpcikvaW5jbHVkZS9tay9nZW5lcmljX2xlYWZfdGFyZ2V0Lm1rCmRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL21lbS96cmFtL3pyYW0wMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0v
enJhbS96cmFtMDEuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwLi5lMGEwMzYx
Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0venJhbS96cmFtMDEuYwpA
QCAtMCwwICsxLDE1OSBAQAorLyoKKyAqIHpyYW06IGdlbmVyaWMgUkFNIGJhc2VkIGNvbXByZXNz
ZWQgUi9XIGJsb2NrIGRldmljZXMKKyAqIGh0dHA6Ly9sa21sLm9yZy9sa21sLzIwMTAvOC85LzIy
NworICoKKyAqIENvcHlyaWdodCAoQykgMjAxMCAgUmVkIEhhdCwgSW5jLgorICogVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcgorICog
bW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB2ZXJzaW9uIDIgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYworICogTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91
bmRhdGlvbi4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3b3VsZCBiZSB1c2VmdWwsCisgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdp
dGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZIG9y
IEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLgorICoKKyAqIEZ1cnRoZXIsIHRoaXMg
c29mdHdhcmUgaXMgZGlzdHJpYnV0ZWQgd2l0aG91dCBhbnkgd2FycmFudHkgdGhhdCBpdAorICog
aXMgZnJlZSBvZiB0aGUgcmlnaHRmdWwgY2xhaW0gb2YgYW55IHRoaXJkIHBlcnNvbiByZWdhcmRp
bmcKKyAqIGluZnJpbmdlbWVudCBvciB0aGUgbGlrZS4gIEFueSBsaWNlbnNlIHByb3ZpZGVkIGhl
cmVpbiwgd2hldGhlcgorICogaW1wbGllZCBvciBvdGhlcndpc2UsIGFwcGxpZXMgb25seSB0byB0
aGlzIHNvZnR3YXJlIGZpbGUuICBQYXRlbnQKKyAqIGxpY2Vuc2VzLCBpZiBhbnksIHByb3ZpZGVk
IGhlcmVpbiBkbyBub3QgYXBwbHkgdG8gY29tYmluYXRpb25zIG9mCisgKiB0aGlzIHByb2dyYW0g
d2l0aCBvdGhlciBzb2Z0d2FyZSwgb3IgYW55IG90aGVyIHByb2R1Y3Qgd2hhdHNvZXZlci4KKyAq
CisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQ
dWJsaWMgTGljZW5zZQorICogYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUg
dGhlIEZyZWUgU29mdHdhcmUKKyAqIEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0cmVl
dCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEKKyAqIDAyMTEwLTEzMDEsIFVTQS4KKyAqLworI2lu
Y2x1ZGUgPHN5cy90eXBlcy5oPgorI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CisjaW5jbHVkZSA8c3lz
L21tYW4uaD4KKyNpbmNsdWRlIDxmY250bC5oPgorI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVk
ZSA8ZXJybm8uaD4KKyNpbmNsdWRlIDx1bmlzdGQuaD4KKyNpbmNsdWRlIDxzdHJpbmcuaD4KKyNp
bmNsdWRlICJ0ZXN0LmgiCisjaW5jbHVkZSAidXNjdGVzdC5oIgorCitjaGFyICpUQ0lEID0gInpy
YW0wMSI7CitpbnQgVFNUX1RPVEFMID0gMTsKK2ludCBtb2Rwcm9iZSA9IDA7CisKKyNkZWZpbmUg
UEFUSF9aUkFNCSIvc3lzL2Jsb2NrL3pyYW0wIgorI2RlZmluZSBTSVpFCQkoNTEyICogMTAyNCAq
IDEwMjQpCisjZGVmaW5lIERFVklDRQkJIi9kZXYvenJhbTAiCisKK3N0YXRpYyB2b2lkIHNldHVw
KHZvaWQpOworc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKTsKK3N0YXRpYyB2b2lkIHByaW50KGNo
YXIgKnN0cmluZyk7CitzdGF0aWMgdm9pZCBkdW1wX2luZm8odm9pZCk7CisKK2ludCBtYWluKGlu
dCBhcmdjLCBjaGFyICphcmd2W10pCit7CisJaW50IGxjLCBmZDsKKwljaGFyICptc2c7CisJY2hh
ciBzaXplW0JVRlNJWl07CisJdm9pZCAqczsKKworCW1zZyA9IHBhcnNlX29wdHMoYXJnYywgYXJn
diwgTlVMTCwgTlVMTCk7CisJaWYgKG1zZyAhPSBOVUxMKQorCQl0c3RfYnJrbShUQlJPSywgTlVM
TCwgIk9QVElPTiBQQVJTSU5HIEVSUk9SIC0gJXMiLCBtc2cpOworCisJc2V0dXAoKTsKKworCWZv
ciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyBsYysrKSB7CisJCVRzdF9jb3VudCA9IDA7CisJ
CXRzdF9yZXNtKFRJTkZPLCAiY3JlYXRlIGEgenJhbSBkZXZpY2Ugd2l0aCAlZCBieXRlcyBpbiBz
aXplLiIsCisJCQlTSVpFKTsKKwkJZmQgPSBvcGVuKFBBVEhfWlJBTSAiL2Rpc2tzaXplIiwgT19X
Uk9OTFkpOworCQlpZiAoZmQgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFu
dXAsICJvcGVuICVzIiwKKwkJCQlQQVRIX1pSQU0gIi9kaXNrc2l6ZSIpOworCQlzcHJpbnRmKHNp
emUsICIlZCIsIFNJWkUpOworCQlpZiAod3JpdGUoZmQsIHNpemUsIHN0cmxlbihzaXplKSkgIT0g
c3RybGVuKHNpemUpKQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUg
JXMgdG8gJXMiLCBzaXplLAorCQkJCVBBVEhfWlJBTSAiL2Rpc2tzaXplIik7CisJCWNsb3NlKGZk
KTsKKworCQl0c3RfcmVzbShUSU5GTywgIm1hcCBpdCBpbnRvIG1lbW9yeS4iKTsKKwkJZmQgPSBv
cGVuKERFVklDRSwgT19SRFdSKTsKKwkJaWYgKGZkID09IC0xKQorCQkJdHN0X2Jya20oVEJST0t8
VEVSUk5PLCBjbGVhbnVwLCAib3BlbiAlcyIsIERFVklDRSk7CisJCXMgPSBtbWFwKE5VTEwsIFNJ
WkUsIFBST1RfUkVBRHxQUk9UX1dSSVRFLCBNQVBfUFJJVkFURSwgZmQsIDApOworCQlpZiAocyA9
PSBNQVBfRkFJTEVEKQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAibW1hcCIp
OworCisJCXRzdF9yZXNtKFRJTkZPLCAid3JpdGUgYWxsIHRoZSBtZW1vcnkuIik7CisJCW1lbXNl
dChzLCBTSVpFLCAnYScpOworCQljbG9zZShmZCk7CisKKwkJZHVtcF9pbmZvKCk7CisKKwkJdHN0
X3Jlc20oVElORk8sICJyZXNldCBpdC4iKTsKKwkJZmQgPSBvcGVuKFBBVEhfWlJBTSAiL3Jlc2V0
IiwgT19XUk9OTFkpOworCQlpZiAoZmQgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8s
IGNsZWFudXAsICJvcGVuICVzIiwKKwkJCQlQQVRIX1pSQU0gIi9yZXNldCIpOworCQlpZiAod3Jp
dGUoZmQsICIxIiwgMSkgIT0gMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwg
IndyaXRlIDEgdG8gJXMiLAorCQkJCVBBVEhfWlJBTSAiL3Jlc2V0Iik7CisJCWNsb3NlKGZkKTsK
KworCQlkdW1wX2luZm8oKTsKKwl9CisJY2xlYW51cCgpOworCXRzdF9leGl0KCk7Cit9CisKK3Zv
aWQgc2V0dXAodm9pZCkKK3sKKwl0c3RfcmVxdWlyZV9yb290KE5VTEwpOworCisJaWYgKGFjY2Vz
cyhQQVRIX1pSQU0sIFJfT0t8V19PS3xYX09LKSA9PSAtMSAmJiBlcnJubyA9PSBFTk9FTlQpIHsK
KwkJc3lzdGVtKCJtb2Rwcm9iZSB6cmFtIik7CisJCW1vZHByb2JlID0gMTsKKwkJaWYgKGFjY2Vz
cyhQQVRIX1pSQU0sIFJfT0t8V19PS3xYX09LKSA9PSAtMSAmJiBlcnJubyA9PSBFTk9FTlQpCisJ
CQl0c3RfYnJrbShUQ09ORiwgTlVMTCwgInN5c3RlbSBoYXMgbm8genJhbSBkZXZpY2UuIik7CisJ
CWVsc2UKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgTlVMTCwgImFjY2VzcyIpOworCX0KKwl0
c3Rfc2lnKEZPUkssIERFRl9IQU5ETEVSLCBjbGVhbnVwKTsKKwlURVNUX1BBVVNFOworfQorCit2
b2lkIGNsZWFudXAodm9pZCkKK3sKKwlpZiAobW9kcHJvYmUgPT0gMSkKKwkJc3lzdGVtKCJybW1v
ZCB6cmFtIik7CisKKwlURVNUX0NMRUFOVVA7Cit9CisKK3ZvaWQgcHJpbnQoY2hhciAqc3RyaW5n
KQoreworCUZJTEUgKmZwOworCWNoYXIgYnVmW0JVRlNJWl0sIHZhbHVlW0JVRlNJWl07CisKKwlz
cHJpbnRmKGJ1ZiwgIiVzLyVzIiwgUEFUSF9aUkFNLCBzdHJpbmcpOworCWZwID0gZm9wZW4oYnVm
LCAiciIpOworCWlmIChmcCA9PSBOVUxMKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFu
dXAsICJmb3BlbiAlcyIsIGJ1Zik7CisKKwlpZiAoZmdldHModmFsdWUsIEJVRlNJWiwgZnApID09
IE5VTEwpCisJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgImZnZXRzICVzIiwgYnVm
KTsKKwl2YWx1ZVtzdHJsZW4odmFsdWUpIC0gMV0gPSAnXDAnOworCWZjbG9zZShmcCk7CisKKwl0
c3RfcmVzbShUSU5GTywgIiVzIGlzICVzIiwgYnVmLCB2YWx1ZSk7Cit9CisKK3ZvaWQgZHVtcF9p
bmZvKHZvaWQpCit7CisJcHJpbnQoImluaXRzdGF0ZSIpOworCXByaW50KCJjb21wcl9kYXRhX3Np
emUiKTsKKwlwcmludCgib3JpZ19kYXRhX3NpemUiKTsKKwlwcmludCgiZGlza3NpemUiKTsKKwlw
cmludCgibWVtX3VzZWRfdG90YWwiKTsKKwlwcmludCgibnVtX3JlYWRzIik7CisJcHJpbnQoIm51
bV93cml0ZXMiKTsKKwlwcmludCgiemVyb19wYWdlcyIpOworfQotLSAKMS43LjMuMgoK
------=_Part_56188_1039912611.1295424769220
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
------=_Part_56188_1039912611.1295424769220
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_56188_1039912611.1295424769220--

