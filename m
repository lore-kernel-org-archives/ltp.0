Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PYTkM-00062t-5U
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 01:25:34 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PYTkK-0004M7-OR
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 01:25:34 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBV1PQxF004659
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Dec 2010 20:25:26 -0500
Date: Thu, 30 Dec 2010 20:25:26 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <2143623633.100802.1293758726857.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1702999856.100799.1293758720547.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_100801_390474574.1293758726857"
Subject: [LTP] [PATCH v2] zram01: add a new test for zram feature
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

------=_Part_100801_390474574.1293758726857
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

zram: generic RAM based compressed R/W block devices
http://lkml.org/lkml/2010/8/9/227

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: code cleanup

 testcases/kernel/mem/zram/Makefile |   22 +++++
 testcases/kernel/mem/zram/zram01.c |  158 ++++++++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+), 0 deletions(-)
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
index 0000000..e63cec4
--- /dev/null
+++ b/testcases/kernel/mem/zram/zram01.c
@@ -0,0 +1,158 @@
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
+extern int Tst_count;
+int modprobe = 0;
+
+#define PATH_ZRAM	"/sys/block/zram0"
+#define SIZE		(512 * 1024 * 1024)
+#define DEVICE		"/dev/zram0"
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
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
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
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
+}
+
+void setup(void)
+{
+	if (access(PATH_ZRAM, R_OK|W_OK|X_OK) == -1 && errno == ENOENT) {
+		system("modprobe zram");
+		modprobe = 1;
+		if (access(PATH_ZRAM, R_OK|W_OK|X_OK) == -1 && errno == ENOENT)
+			tst_brkm(TCONF, tst_exit, "system has no zram device.");
+		else
+			tst_brkm(TBROK|TERRNO, tst_exit, "access");
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
+	tst_exit();	
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
------=_Part_100801_390474574.1293758726857
Content-Type: text/x-patch;
	name=0001-zram01-add-a-new-test-for-zram-feature.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-zram01-add-a-new-test-for-zram-feature.patch

RnJvbSAwZmU3NzE1N2M3YjBiNDEyYWM2YTg5ZTQwMTQxN2RkZjg2ZDE4NTE5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBG
cmksIDMxIERlYyAyMDEwIDA5OjE4OjMyICswODAwClN1YmplY3Q6IFtQQVRDSCB2Ml0genJhbTAx
OiBhZGQgYSBuZXcgdGVzdCBmb3IgenJhbSBmZWF0dXJlCgp6cmFtOiBnZW5lcmljIFJBTSBiYXNl
ZCBjb21wcmVzc2VkIFIvVyBibG9jayBkZXZpY2VzCmh0dHA6Ly9sa21sLm9yZy9sa21sLzIwMTAv
OC85LzIyNwoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0LmNvbT4KLS0t
CnYyOiBjb2RlIGNsZWFudXAKCiB0ZXN0Y2FzZXMva2VybmVsL21lbS96cmFtL01ha2VmaWxlIHwg
ICAyMiArKysrKwogdGVzdGNhc2VzL2tlcm5lbC9tZW0venJhbS96cmFtMDEuYyB8ICAxNTggKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDE4MCBp
bnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNl
cy9rZXJuZWwvbWVtL3pyYW0vTWFrZWZpbGUKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMv
a2VybmVsL21lbS96cmFtL3pyYW0wMS5jCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0venJhbS9NYWtlZmlsZSBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3pyYW0vTWFrZWZpbGUKbmV3
IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uMzYzNDU3MAotLS0gL2Rldi9udWxsCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3pyYW0vTWFrZWZpbGUKQEAgLTAsMCArMSwyMiBAQAor
IworIyAgQ29weXJpZ2h0IChDKSAyMDEwICBSZWQgSGF0LCBJbmMuCisjCisjICBUaGlzIHByb2dy
YW0gaXMgZnJlZSBzb2Z0d2FyZTsgIHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkKKyMgIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgYXMgcHVibGlzaGVkIGJ5CisjICB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRo
ZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgorIyAgKGF0IHlvdXIgb3B0aW9uKSBhbnkg
bGF0ZXIgdmVyc2lvbi4KKyMKKyMgIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUg
aG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAorIyAgYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZ
OyAgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisjICBNRVJDSEFOVEFCSUxJ
VFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUKKyMgIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgorIworIyAgWW91IHNob3Vs
ZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UK
KyMgIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyAgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBT
b2Z0d2FyZQorIyAgRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0ZSAzMzAs
IEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EKKyMKKwordG9wX3NyY2RpciAgICAgICAgICAgICAg
Pz0gLi4vLi4vLi4vLi4KKworaW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvdGVzdGNh
c2VzLm1rCitpbmNsdWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9nZW5lcmljX2xlYWZfdGFy
Z2V0Lm1rCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS96cmFtL3pyYW0wMS5jIGIv
dGVzdGNhc2VzL2tlcm5lbC9tZW0venJhbS96cmFtMDEuYwpuZXcgZmlsZSBtb2RlIDEwMDY0NApp
bmRleCAwMDAwMDAwLi5lNjNjZWM0Ci0tLSAvZGV2L251bGwKKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9tZW0venJhbS96cmFtMDEuYwpAQCAtMCwwICsxLDE1OCBAQAorLyoKKyAqIHpyYW06IGdlbmVy
aWMgUkFNIGJhc2VkIGNvbXByZXNzZWQgUi9XIGJsb2NrIGRldmljZXMKKyAqIGh0dHA6Ly9sa21s
Lm9yZy9sa21sLzIwMTAvOC85LzIyNworICoKKyAqIENvcHlyaWdodCAoQykgMjAxMCAgUmVkIEhh
dCwgSW5jLgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0
cmlidXRlIGl0IGFuZC9vcgorICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB2ZXJzaW9u
IDIgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYworICogTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkg
dGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiBUaGlzIHByb2dyYW0gaXMgZGlz
dHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3b3VsZCBiZSB1c2VmdWwsCisgKiBidXQgV0lU
SE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgor
ICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQT1NFLgor
ICoKKyAqIEZ1cnRoZXIsIHRoaXMgc29mdHdhcmUgaXMgZGlzdHJpYnV0ZWQgd2l0aG91dCBhbnkg
d2FycmFudHkgdGhhdCBpdAorICogaXMgZnJlZSBvZiB0aGUgcmlnaHRmdWwgY2xhaW0gb2YgYW55
IHRoaXJkIHBlcnNvbiByZWdhcmRpbmcKKyAqIGluZnJpbmdlbWVudCBvciB0aGUgbGlrZS4gIEFu
eSBsaWNlbnNlIHByb3ZpZGVkIGhlcmVpbiwgd2hldGhlcgorICogaW1wbGllZCBvciBvdGhlcndp
c2UsIGFwcGxpZXMgb25seSB0byB0aGlzIHNvZnR3YXJlIGZpbGUuICBQYXRlbnQKKyAqIGxpY2Vu
c2VzLCBpZiBhbnksIHByb3ZpZGVkIGhlcmVpbiBkbyBub3QgYXBwbHkgdG8gY29tYmluYXRpb25z
IG9mCisgKiB0aGlzIHByb2dyYW0gd2l0aCBvdGhlciBzb2Z0d2FyZSwgb3IgYW55IG90aGVyIHBy
b2R1Y3Qgd2hhdHNvZXZlci4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogYWxvbmcgd2l0aCB0aGlzIHBy
b2dyYW07IGlmIG5vdCwgd3JpdGUgdGhlIEZyZWUgU29mdHdhcmUKKyAqIEZvdW5kYXRpb24sIElu
Yy4sIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEKKyAqIDAyMTEw
LTEzMDEsIFVTQS4KKyAqLworI2luY2x1ZGUgPHN5cy90eXBlcy5oPgorI2luY2x1ZGUgPHN5cy9z
dGF0Lmg+CisjaW5jbHVkZSA8c3lzL21tYW4uaD4KKyNpbmNsdWRlIDxmY250bC5oPgorI2luY2x1
ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8ZXJybm8uaD4KKyNpbmNsdWRlIDx1bmlzdGQuaD4KKyNp
bmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlICJ0ZXN0LmgiCisjaW5jbHVkZSAidXNjdGVzdC5o
IgorCitjaGFyICpUQ0lEID0gInpyYW0wMSI7CitpbnQgVFNUX1RPVEFMID0gMTsKK2V4dGVybiBp
bnQgVHN0X2NvdW50OworaW50IG1vZHByb2JlID0gMDsKKworI2RlZmluZSBQQVRIX1pSQU0JIi9z
eXMvYmxvY2svenJhbTAiCisjZGVmaW5lIFNJWkUJCSg1MTIgKiAxMDI0ICogMTAyNCkKKyNkZWZp
bmUgREVWSUNFCQkiL2Rldi96cmFtMCIKKworc3RhdGljIHZvaWQgc2V0dXAodm9pZCk7CitzdGF0
aWMgdm9pZCBjbGVhbnVwKHZvaWQpIExUUF9BVFRSSUJVVEVfTk9SRVRVUk47CitzdGF0aWMgdm9p
ZCBwcmludChjaGFyICpzdHJpbmcpOworc3RhdGljIHZvaWQgZHVtcF9pbmZvKHZvaWQpOworCitp
bnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQoreworCWludCBsYywgZmQ7CisJY2hhciAq
bXNnOworCWNoYXIgc2l6ZVtCVUZTSVpdOworCXZvaWQgKnM7CisKKwltc2cgPSBwYXJzZV9vcHRz
KGFyZ2MsIGFyZ3YsIE5VTEwsIE5VTEwpOworCWlmIChtc2cgIT0gTlVMTCkKKwkJdHN0X2Jya20o
VEJST0ssIHRzdF9leGl0LCAiT1BUSU9OIFBBUlNJTkcgRVJST1IgLSAlcyIsIG1zZyk7CisKKwlz
ZXR1cCgpOworCisJZm9yIChsYyA9IDA7IFRFU1RfTE9PUElORyhsYyk7IGxjKyspIHsKKwkJVHN0
X2NvdW50ID0gMDsKKwkJdHN0X3Jlc20oVElORk8sICJjcmVhdGUgYSB6cmFtIGRldmljZSB3aXRo
ICVkIGJ5dGVzIGluIHNpemUuIiwKKwkJCVNJWkUpOworCQlmZCA9IG9wZW4oUEFUSF9aUkFNICIv
ZGlza3NpemUiLCBPX1dST05MWSk7CisJCWlmIChmZCA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLAorCQkJCVBBVEhfWlJBTSAiL2Rpc2tzaXplIik7
CisJCXNwcmludGYoc2l6ZSwgIiVkIiwgU0laRSk7CisJCWlmICh3cml0ZShmZCwgc2l6ZSwgc3Ry
bGVuKHNpemUpKSAhPSBzdHJsZW4oc2l6ZSkpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNs
ZWFudXAsICJ3cml0ZSAlcyB0byAlcyIsIHNpemUsCisJCQkJUEFUSF9aUkFNICIvZGlza3NpemUi
KTsKKwkJY2xvc2UoZmQpOworCisJCXRzdF9yZXNtKFRJTkZPLCAibWFwIGl0IGludG8gbWVtb3J5
LiIpOworCQlmZCA9IG9wZW4oREVWSUNFLCBPX1JEV1IpOworCQlpZiAoZmQgPT0gLTEpCisJCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuICVzIiwgREVWSUNFKTsKKwkJcyA9
IG1tYXAoTlVMTCwgU0laRSwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFLCBmZCwg
MCk7CisJCWlmIChzID09IE1BUF9GQUlMRUQpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNs
ZWFudXAsICJtbWFwIik7CisKKwkJdHN0X3Jlc20oVElORk8sICJ3cml0ZSBhbGwgdGhlIG1lbW9y
eS4iKTsKKwkJbWVtc2V0KHMsIFNJWkUsICdhJyk7CisJCWNsb3NlKGZkKTsKKworCQlkdW1wX2lu
Zm8oKTsKKworCQl0c3RfcmVzbShUSU5GTywgInJlc2V0IGl0LiIpOworCQlmZCA9IG9wZW4oUEFU
SF9aUkFNICIvcmVzZXQiLCBPX1dST05MWSk7CisJCWlmIChmZCA9PSAtMSkKKwkJCXRzdF9icmtt
KFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4gJXMiLAorCQkJCVBBVEhfWlJBTSAiL3Jlc2V0
Iik7CisJCWlmICh3cml0ZShmZCwgIjEiLCAxKSAhPSAxKQorCQkJdHN0X2Jya20oVEJST0t8VEVS
Uk5PLCBjbGVhbnVwLCAid3JpdGUgMSB0byAlcyIsCisJCQkJUEFUSF9aUkFNICIvcmVzZXQiKTsK
KwkJY2xvc2UoZmQpOworCisJCWR1bXBfaW5mbygpOworCX0KKwljbGVhbnVwKCk7Cit9CisKK3Zv
aWQgc2V0dXAodm9pZCkKK3sKKwlpZiAoYWNjZXNzKFBBVEhfWlJBTSwgUl9PS3xXX09LfFhfT0sp
ID09IC0xICYmIGVycm5vID09IEVOT0VOVCkgeworCQlzeXN0ZW0oIm1vZHByb2JlIHpyYW0iKTsK
KwkJbW9kcHJvYmUgPSAxOworCQlpZiAoYWNjZXNzKFBBVEhfWlJBTSwgUl9PS3xXX09LfFhfT0sp
ID09IC0xICYmIGVycm5vID09IEVOT0VOVCkKKwkJCXRzdF9icmttKFRDT05GLCB0c3RfZXhpdCwg
InN5c3RlbSBoYXMgbm8genJhbSBkZXZpY2UuIik7CisJCWVsc2UKKwkJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgdHN0X2V4aXQsICJhY2Nlc3MiKTsKKwl9CisJdHN0X3NpZyhGT1JLLCBERUZfSEFO
RExFUiwgY2xlYW51cCk7CisJVEVTVF9QQVVTRTsKK30KKwordm9pZCBjbGVhbnVwKHZvaWQpCit7
CisJaWYgKG1vZHByb2JlID09IDEpCisJCXN5c3RlbSgicm1tb2QgenJhbSIpOworCisJVEVTVF9D
TEVBTlVQOworCXRzdF9leGl0KCk7CQorfQorCit2b2lkIHByaW50KGNoYXIgKnN0cmluZykKK3sK
KwlGSUxFICpmcDsKKwljaGFyIGJ1ZltCVUZTSVpdLCB2YWx1ZVtCVUZTSVpdOworCisJc3ByaW50
ZihidWYsICIlcy8lcyIsIFBBVEhfWlJBTSwgc3RyaW5nKTsKKwlmcCA9IGZvcGVuKGJ1ZiwgInIi
KTsKKwlpZiAoZnAgPT0gTlVMTCkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAi
Zm9wZW4gJXMiLCBidWYpOworCisJaWYgKGZnZXRzKHZhbHVlLCBCVUZTSVosIGZwKSA9PSBOVUxM
KQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJmZ2V0cyAlcyIsIGJ1Zik7CisJ
dmFsdWVbc3RybGVuKHZhbHVlKSAtIDFdID0gJ1wwJzsKKwlmY2xvc2UoZnApOworCisJdHN0X3Jl
c20oVElORk8sICIlcyBpcyAlcyIsIGJ1ZiwgdmFsdWUpOworfQorCit2b2lkIGR1bXBfaW5mbyh2
b2lkKQoreworCXByaW50KCJpbml0c3RhdGUiKTsKKwlwcmludCgiY29tcHJfZGF0YV9zaXplIik7
CisJcHJpbnQoIm9yaWdfZGF0YV9zaXplIik7CisJcHJpbnQoImRpc2tzaXplIik7CisJcHJpbnQo
Im1lbV91c2VkX3RvdGFsIik7CisJcHJpbnQoIm51bV9yZWFkcyIpOworCXByaW50KCJudW1fd3Jp
dGVzIik7CisJcHJpbnQoInplcm9fcGFnZXMiKTsKK30KLS0gCjEuNy4zLjIKCg==
------=_Part_100801_390474574.1293758726857
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
------=_Part_100801_390474574.1293758726857
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_100801_390474574.1293758726857--

