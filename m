Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PUb9o-0000vy-OY
	for ltp-list@lists.sourceforge.net; Mon, 20 Dec 2010 08:31:48 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUb9n-0002GV-40
	for ltp-list@lists.sourceforge.net; Mon, 20 Dec 2010 08:31:48 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBK8VfkX002564
	for <ltp-list@lists.sourceforge.net>; Mon, 20 Dec 2010 03:31:41 -0500
Date: Mon, 20 Dec 2010 03:31:41 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <715753312.10226.1292833901212.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <82849215.10223.1292833893533.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10225_1636689105.1292833901211"
Subject: [LTP] [PATCH] zram01: add a new test for zram feature.
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

------=_Part_10225_1636689105.1292833901211
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

zram: generic RAM based compressed R/W block devices
http://lkml.org/lkml/2010/8/9/227

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/zram/Makefile |   22 +++++
 testcases/kernel/mem/zram/zram01.c |  157 ++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+), 0 deletions(-)
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
index 0000000..aea24de
--- /dev/null
+++ b/testcases/kernel/mem/zram/zram01.c
@@ -0,0 +1,157 @@
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
+	char buf[BUFSIZ], size[BUFSIZ];
+	void *s;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != (char *)NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		tst_resm(TINFO, "create a zram device with %d bytes in size.",
+			SIZE);
+		sprintf(buf, "%s/disksize", PATH_ZRAM);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		sprintf(size, "%d", SIZE);
+		if (write(fd, size, strlen(size)) != strlen(size))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s to %s", size,
+				buf);
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
+		sprintf(buf, "%s/reset", PATH_ZRAM);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write 1 to %s", buf);
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
------=_Part_10225_1636689105.1292833901211
Content-Type: text/x-patch;
	name=0001-zram01-add-a-new-test-for-zram-feature.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-zram01-add-a-new-test-for-zram-feature.patch

RnJvbSA0YTNjZjFjOTg4Y2JkYTM0MWU3NTJkNjc0ZTk2YzM2YWQ4MTAzMzFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBN
b24sIDIwIERlYyAyMDEwIDE2OjI2OjQ2ICswODAwClN1YmplY3Q6IFtQQVRDSF0genJhbTAxOiBh
ZGQgYSBuZXcgdGVzdCBmb3IgenJhbSBmZWF0dXJlLgoKenJhbTogZ2VuZXJpYyBSQU0gYmFzZWQg
Y29tcHJlc3NlZCBSL1cgYmxvY2sgZGV2aWNlcwpodHRwOi8vbGttbC5vcmcvbGttbC8yMDEwLzgv
OS8yMjcKClNpZ25lZC1vZmYtYnk6IENBSSBRaWFuIDxjYWlxaWFuQHJlZGhhdC5jb20+Ci0tLQog
dGVzdGNhc2VzL2tlcm5lbC9tZW0venJhbS9NYWtlZmlsZSB8ICAgMjIgKysrKysKIHRlc3RjYXNl
cy9rZXJuZWwvbWVtL3pyYW0venJhbTAxLmMgfCAgMTU3ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxNzkgaW5zZXJ0aW9ucygrKSwgMCBkZWxl
dGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL21lbS96cmFtL01h
a2VmaWxlCiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9tZW0venJhbS96cmFt
MDEuYwoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3pyYW0vTWFrZWZpbGUgYi90
ZXN0Y2FzZXMva2VybmVsL21lbS96cmFtL01ha2VmaWxlCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cmlu
ZGV4IDAwMDAwMDAuLjM2MzQ1NzAKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVs
L21lbS96cmFtL01ha2VmaWxlCkBAIC0wLDAgKzEsMjIgQEAKKyMKKyMgIENvcHlyaWdodCAoQykg
MjAxMCAgUmVkIEhhdCwgSW5jLgorIworIyAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7
ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CisjICBpdCB1bmRlciB0aGUg
dGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQor
IyAgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgZWl0aGVyIHZlcnNpb24gMiBvZiB0aGUg
TGljZW5zZSwgb3IKKyMgIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCisjCisj
ICBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJl
IHVzZWZ1bCwKKyMgIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgIHdpdGhvdXQgZXZlbiB0aGUg
aW1wbGllZCB3YXJyYW50eSBvZgorIyAgTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEg
UEFSVElDVUxBUiBQVVJQT1NFLiAgU2VlCisjICB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vu
c2UgZm9yIG1vcmUgZGV0YWlscy4KKyMKKyMgIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNv
cHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisjICBhbG9uZyB3aXRoIHRoaXMg
cHJvZ3JhbTsgIGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUKKyMgIEZvdW5kYXRp
b24sIEluYy4sIDU5IFRlbXBsZSBQbGFjZSwgU3VpdGUgMzMwLCBCb3N0b24sIE1BIDAyMTExLTEz
MDcgVVNBCisjCisKK3RvcF9zcmNkaXIgICAgICAgICAgICAgID89IC4uLy4uLy4uLy4uCisKK2lu
Y2x1ZGUgJCh0b3Bfc3JjZGlyKS9pbmNsdWRlL21rL3Rlc3RjYXNlcy5taworaW5jbHVkZSAkKHRv
cF9zcmNkaXIpL2luY2x1ZGUvbWsvZ2VuZXJpY19sZWFmX3RhcmdldC5tawpkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9tZW0venJhbS96cmFtMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L3pyYW0venJhbTAxLmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uYWVhMjRk
ZQotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL3pyYW0venJhbTAxLmMK
QEAgLTAsMCArMSwxNTcgQEAKKy8qCisgKiB6cmFtOiBnZW5lcmljIFJBTSBiYXNlZCBjb21wcmVz
c2VkIFIvVyBibG9jayBkZXZpY2VzCisgKiBodHRwOi8vbGttbC5vcmcvbGttbC8yMDEwLzgvOS8y
MjcKKyAqCisgKiBDb3B5cmlnaHQgKEMpIDIwMTAgIFJlZCBIYXQsIEluYy4KKyAqIFRoaXMgcHJv
Z3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IKKyAq
IG1vZGlmeSBpdCB1bmRlciB0aGUgdGVybXMgb2YgdmVyc2lvbiAyIG9mIHRoZSBHTlUgR2VuZXJh
bCBQdWJsaWMKKyAqIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZv
dW5kYXRpb24uCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3Bl
IHRoYXQgaXQgd291bGQgYmUgdXNlZnVsLAorICogYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3
aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKKyAqIE1FUkNIQU5UQUJJTElUWSBv
ciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4KKyAqCisgKiBGdXJ0aGVyLCB0aGlz
IHNvZnR3YXJlIGlzIGRpc3RyaWJ1dGVkIHdpdGhvdXQgYW55IHdhcnJhbnR5IHRoYXQgaXQKKyAq
IGlzIGZyZWUgb2YgdGhlIHJpZ2h0ZnVsIGNsYWltIG9mIGFueSB0aGlyZCBwZXJzb24gcmVnYXJk
aW5nCisgKiBpbmZyaW5nZW1lbnQgb3IgdGhlIGxpa2UuICBBbnkgbGljZW5zZSBwcm92aWRlZCBo
ZXJlaW4sIHdoZXRoZXIKKyAqIGltcGxpZWQgb3Igb3RoZXJ3aXNlLCBhcHBsaWVzIG9ubHkgdG8g
dGhpcyBzb2Z0d2FyZSBmaWxlLiAgUGF0ZW50CisgKiBsaWNlbnNlcywgaWYgYW55LCBwcm92aWRl
ZCBoZXJlaW4gZG8gbm90IGFwcGx5IHRvIGNvbWJpbmF0aW9ucyBvZgorICogdGhpcyBwcm9ncmFt
IHdpdGggb3RoZXIgc29mdHdhcmUsIG9yIGFueSBvdGhlciBwcm9kdWN0IHdoYXRzb2V2ZXIuCisg
KgorICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwg
UHVibGljIExpY2Vuc2UKKyAqIGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRl
IHRoZSBGcmVlIFNvZnR3YXJlCisgKiBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdHJl
ZXQsIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BCisgKiAwMjExMC0xMzAxLCBVU0EuCisgKi8KKyNp
bmNsdWRlIDxzeXMvdHlwZXMuaD4KKyNpbmNsdWRlIDxzeXMvc3RhdC5oPgorI2luY2x1ZGUgPHN5
cy9tbWFuLmg+CisjaW5jbHVkZSA8ZmNudGwuaD4KKyNpbmNsdWRlIDxzdGRpby5oPgorI2luY2x1
ZGUgPGVycm5vLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8c3RyaW5nLmg+Cisj
aW5jbHVkZSAidGVzdC5oIgorI2luY2x1ZGUgInVzY3Rlc3QuaCIKKworY2hhciAqVENJRCA9ICJ6
cmFtMDEiOworaW50IFRTVF9UT1RBTCA9IDE7CitleHRlcm4gaW50IFRzdF9jb3VudDsKK2ludCBt
b2Rwcm9iZSA9IDA7CisKKyNkZWZpbmUgUEFUSF9aUkFNCSIvc3lzL2Jsb2NrL3pyYW0wIgorI2Rl
ZmluZSBTSVpFCQkoNTEyICogMTAyNCAqIDEwMjQpCisjZGVmaW5lIERFVklDRQkJIi9kZXYvenJh
bTAiCisKK3N0YXRpYyB2b2lkIHNldHVwKHZvaWQpOworc3RhdGljIHZvaWQgY2xlYW51cCh2b2lk
KSBMVFBfQVRUUklCVVRFX05PUkVUVVJOOworc3RhdGljIHZvaWQgcHJpbnQoY2hhciAqc3RyaW5n
KTsKK3N0YXRpYyB2b2lkIGR1bXBfaW5mbyh2b2lkKTsKKworaW50IG1haW4oaW50IGFyZ2MsIGNo
YXIgKmFyZ3ZbXSkKK3sKKwlpbnQgbGMsIGZkOworCWNoYXIgKm1zZzsKKwljaGFyIGJ1ZltCVUZT
SVpdLCBzaXplW0JVRlNJWl07CisJdm9pZCAqczsKKworCW1zZyA9IHBhcnNlX29wdHMoYXJnYywg
YXJndiwgTlVMTCwgTlVMTCk7CisJaWYgKG1zZyAhPSAoY2hhciAqKU5VTEwpCisJCXRzdF9icmtt
KFRCUk9LLCB0c3RfZXhpdCwgIk9QVElPTiBQQVJTSU5HIEVSUk9SIC0gJXMiLCBtc2cpOworCisJ
c2V0dXAoKTsKKworCWZvciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyBsYysrKSB7CisJCVRz
dF9jb3VudCA9IDA7CisJCXRzdF9yZXNtKFRJTkZPLCAiY3JlYXRlIGEgenJhbSBkZXZpY2Ugd2l0
aCAlZCBieXRlcyBpbiBzaXplLiIsCisJCQlTSVpFKTsKKwkJc3ByaW50ZihidWYsICIlcy9kaXNr
c2l6ZSIsIFBBVEhfWlJBTSk7CisJCWZkID0gb3BlbihidWYsIE9fV1JPTkxZKTsKKwkJaWYgKGZk
ID09IC0xKQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiAlcyIsIGJ1
Zik7CisJCXNwcmludGYoc2l6ZSwgIiVkIiwgU0laRSk7CisJCWlmICh3cml0ZShmZCwgc2l6ZSwg
c3RybGVuKHNpemUpKSAhPSBzdHJsZW4oc2l6ZSkpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8s
IGNsZWFudXAsICJ3cml0ZSAlcyB0byAlcyIsIHNpemUsCisJCQkJYnVmKTsKKwkJY2xvc2UoZmQp
OworCisJCXRzdF9yZXNtKFRJTkZPLCAibWFwIGl0IGludG8gbWVtb3J5LiIpOworCQlmZCA9IG9w
ZW4oREVWSUNFLCBPX1JEV1IpOworCQlpZiAoZmQgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xU
RVJSTk8sIGNsZWFudXAsICJvcGVuICVzIiwgREVWSUNFKTsKKwkJcyA9IG1tYXAoTlVMTCwgU0la
RSwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9QUklWQVRFLCBmZCwgMCk7CisJCWlmIChzID09
IE1BUF9GQUlMRUQpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJtbWFwIik7
CisKKwkJdHN0X3Jlc20oVElORk8sICJ3cml0ZSBhbGwgdGhlIG1lbW9yeS4iKTsKKwkJbWVtc2V0
KHMsIFNJWkUsICdhJyk7CisJCWNsb3NlKGZkKTsKKworCQlkdW1wX2luZm8oKTsKKworCQl0c3Rf
cmVzbShUSU5GTywgInJlc2V0IGl0LiIpOworCQlzcHJpbnRmKGJ1ZiwgIiVzL3Jlc2V0IiwgUEFU
SF9aUkFNKTsKKwkJZmQgPSBvcGVuKGJ1ZiwgT19XUk9OTFkpOworCQlpZiAoZmQgPT0gLTEpCisJ
CQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuICVzIiwgYnVmKTsKKwkJaWYg
KHdyaXRlKGZkLCAiMSIsIDEpICE9IDEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFu
dXAsICJ3cml0ZSAxIHRvICVzIiwgYnVmKTsKKwkJY2xvc2UoZmQpOworCisJCWR1bXBfaW5mbygp
OworCX0KKwljbGVhbnVwKCk7Cit9CisKK3ZvaWQgc2V0dXAodm9pZCkKK3sKKwlpZiAoYWNjZXNz
KFBBVEhfWlJBTSwgUl9PS3xXX09LfFhfT0spID09IC0xICYmIGVycm5vID09IEVOT0VOVCkgewor
CQlzeXN0ZW0oIm1vZHByb2JlIHpyYW0iKTsKKwkJbW9kcHJvYmUgPSAxOworCQlpZiAoYWNjZXNz
KFBBVEhfWlJBTSwgUl9PS3xXX09LfFhfT0spID09IC0xICYmIGVycm5vID09IEVOT0VOVCkKKwkJ
CXRzdF9icmttKFRDT05GLCB0c3RfZXhpdCwgInN5c3RlbSBoYXMgbm8genJhbSBkZXZpY2UuIik7
CisJCWVsc2UKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgdHN0X2V4aXQsICJhY2Nlc3MiKTsK
Kwl9CisJdHN0X3NpZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7CisJVEVTVF9QQVVTRTsK
K30KKwordm9pZCBjbGVhbnVwKHZvaWQpCit7CisJaWYgKG1vZHByb2JlID09IDEpCisJCXN5c3Rl
bSgicm1tb2QgenJhbSIpOworCisJVEVTVF9DTEVBTlVQOworCXRzdF9leGl0KCk7CQorfQorCit2
b2lkIHByaW50KGNoYXIgKnN0cmluZykKK3sKKwlGSUxFICpmcDsKKwljaGFyIGJ1ZltCVUZTSVpd
LCB2YWx1ZVtCVUZTSVpdOworCisJc3ByaW50ZihidWYsICIlcy8lcyIsIFBBVEhfWlJBTSwgc3Ry
aW5nKTsKKwlmcCA9IGZvcGVuKGJ1ZiwgInIiKTsKKwlpZiAoZnAgPT0gTlVMTCkKKwkJdHN0X2Jy
a20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAiZm9wZW4gJXMiLCBidWYpOworCisJaWYgKGZnZXRz
KHZhbHVlLCBCVUZTSVosIGZwKSA9PSBOVUxMKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNs
ZWFudXAsICJmZ2V0cyAlcyIsIGJ1Zik7CisJdmFsdWVbc3RybGVuKHZhbHVlKSAtIDFdID0gJ1ww
JzsKKwlmY2xvc2UoZnApOworCisJdHN0X3Jlc20oVElORk8sICIlcyBpcyAlcyIsIGJ1ZiwgdmFs
dWUpOworfQorCit2b2lkIGR1bXBfaW5mbyh2b2lkKQoreworCXByaW50KCJpbml0c3RhdGUiKTsK
KwlwcmludCgiY29tcHJfZGF0YV9zaXplIik7CisJcHJpbnQoIm9yaWdfZGF0YV9zaXplIik7CisJ
cHJpbnQoImRpc2tzaXplIik7CisJcHJpbnQoIm1lbV91c2VkX3RvdGFsIik7CisJcHJpbnQoIm51
bV9yZWFkcyIpOworCXByaW50KCJudW1fd3JpdGVzIik7CisJcHJpbnQoInplcm9fcGFnZXMiKTsK
K30KLS0gCjEuNy4zLjIKCg==
------=_Part_10225_1636689105.1292833901211
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
------=_Part_10225_1636689105.1292833901211
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_10225_1636689105.1292833901211--

