Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfTFZ-0003EU-Vb
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:18:41 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfTFX-0007hd-Ja
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:18:41 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0J8IYhK016363
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Jan 2011 03:18:34 -0500
Date: Wed, 19 Jan 2011 03:18:34 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1169511902.56392.1295425114163.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2045541013.56386.1295425108264.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_56391_2118165403.1295425114162"
Subject: [LTP] [PATCH 3/4] ksm04: KSM for Memory Resource Controller and NUMA
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

------=_Part_56391_2118165403.1295425114162
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/ksm/ksm04.c |  141 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 141 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/ksm/ksm04.c

diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
new file mode 100644
index 0000000..8bb791e
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -0,0 +1,141 @@
+/*
+ * Kernel Samepage Merging (KSM) for Memory Resource Controller and NUMA
+ *
+ * Basic tests were to start several programs with same and different
+ * memory contents and ensure only to merge the ones with the same
+ * contents. When changed the content of one of merged pages in a
+ * process and to the mode "unmerging", it should discard all merged
+ * pages there. Also tested it is possible to disable KSM. There are
+ * also command-line options to specify the memory allocation size, and
+ * number of processes have same memory contents so it is possible to
+ * test more advanced things like KSM + OOM etc.
+ *
+ * Prerequisites:
+ *
+ * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
+ *    distrub the testing as they also change some ksm tunables depends
+ *    on current workloads.
+ *
+ * The test steps are:
+ * - Check ksm feature and backup current run setting.
+ * - Change run setting to 1 - merging.
+ * - 3 memory allocation programs have the memory contents that 2 of
+ *   them are all 'a' and one is all 'b'.
+ * - Check ksm statistics and verify the content.
+ * - 1 program changes the memory content from all 'a' to all 'b'.
+ * - Check ksm statistics and verify the content.
+ * - All programs change the memory content to all 'd'.
+ * - Check ksm statistics and verify the content.
+ * - Change one page of a process.
+ * - Check ksm statistics and verify the content.
+ * - Change run setting to 2 - unmerging.
+ * - Check ksm statistics and verify the content.
+ * - Change run setting to 0 - stop.
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
+ *
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
+char *TCID = "ksm04";
+int TST_TOTAL = 1;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include <numaif.h>
+#include "../include/mem.h"
+
+option_t ksm_options[] = {
+        { "n:", &opt_num,       &opt_numstr},
+        { "s:", &opt_size,      &opt_sizestr},
+        { "u:", &opt_unit,      &opt_unitstr},
+        { NULL, NULL,           NULL}
+};
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+	int size = 128, num = 3, unit = 1;
+	unsigned long nnodes = 1;
+	unsigned long nmask = 2;
+
+	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	nnodes = count_numa();
+	if (count_numa() == 1)
+		tst_brkm(TCONF, NULL, "required a NUMA system.");
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		check_ksm_options(&size, &num, &unit);
+
+		write_memcg();
+
+		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
+		create_same_memory(size, num, unit);
+
+		write_cpusets();
+		create_same_memory(size, num, unit);
+	}
+	cleanup();
+	tst_exit();
+}
+
+void cleanup(void)
+{
+	umount_mem(CPATH, CPATH_NEW);
+	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	TEST_CLEANUP;
+}
+
+void setup(void)
+{
+	tst_require_root(NULL);
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
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
------=_Part_56391_2118165403.1295425114162
Content-Type: text/x-patch;
	name=0003-ksm04-KSM-for-Memory-Resource-Controller-and-NUMA.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0003-ksm04-KSM-for-Memory-Resource-Controller-and-NUMA.patch

RnJvbSAwMWIyYjkwOWM2YmNhMGQ3YzI3NTc1MTZlNzUxYmZkZWFjZjY2MDVhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBX
ZWQsIDE5IEphbiAyMDExIDE1OjUxOjIxICswODAwClN1YmplY3Q6IFtQQVRDSCAzLzRdIGtzbTA0
OiBLU00gZm9yIE1lbW9yeSBSZXNvdXJjZSBDb250cm9sbGVyIGFuZCBOVU1BCgoKU2lnbmVkLW9m
Zi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVs
L21lbS9rc20va3NtMDQuYyB8ICAxNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZXMgY2hhbmdlZCwgMTQxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0p
CiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9tZW0va3NtL2tzbTA0LmMKCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3NtMDQuYyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvbWVtL2tzbS9rc20wNC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAu
LjhiYjc5MWUKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3Nt
MDQuYwpAQCAtMCwwICsxLDE0MSBAQAorLyoKKyAqIEtlcm5lbCBTYW1lcGFnZSBNZXJnaW5nIChL
U00pIGZvciBNZW1vcnkgUmVzb3VyY2UgQ29udHJvbGxlciBhbmQgTlVNQQorICoKKyAqIEJhc2lj
IHRlc3RzIHdlcmUgdG8gc3RhcnQgc2V2ZXJhbCBwcm9ncmFtcyB3aXRoIHNhbWUgYW5kIGRpZmZl
cmVudAorICogbWVtb3J5IGNvbnRlbnRzIGFuZCBlbnN1cmUgb25seSB0byBtZXJnZSB0aGUgb25l
cyB3aXRoIHRoZSBzYW1lCisgKiBjb250ZW50cy4gV2hlbiBjaGFuZ2VkIHRoZSBjb250ZW50IG9m
IG9uZSBvZiBtZXJnZWQgcGFnZXMgaW4gYQorICogcHJvY2VzcyBhbmQgdG8gdGhlIG1vZGUgInVu
bWVyZ2luZyIsIGl0IHNob3VsZCBkaXNjYXJkIGFsbCBtZXJnZWQKKyAqIHBhZ2VzIHRoZXJlLiBB
bHNvIHRlc3RlZCBpdCBpcyBwb3NzaWJsZSB0byBkaXNhYmxlIEtTTS4gVGhlcmUgYXJlCisgKiBh
bHNvIGNvbW1hbmQtbGluZSBvcHRpb25zIHRvIHNwZWNpZnkgdGhlIG1lbW9yeSBhbGxvY2F0aW9u
IHNpemUsIGFuZAorICogbnVtYmVyIG9mIHByb2Nlc3NlcyBoYXZlIHNhbWUgbWVtb3J5IGNvbnRl
bnRzIHNvIGl0IGlzIHBvc3NpYmxlIHRvCisgKiB0ZXN0IG1vcmUgYWR2YW5jZWQgdGhpbmdzIGxp
a2UgS1NNICsgT09NIGV0Yy4KKyAqCisgKiBQcmVyZXF1aXNpdGVzOgorICoKKyAqIDEpIGtzbSBh
bmQga3NtdHVuZWQgZGFlbW9ucyBuZWVkIHRvIGJlIGRpc2FibGVkLiBPdGhlcndpc2UsIGl0IGNv
dWxkCisgKiAgICBkaXN0cnViIHRoZSB0ZXN0aW5nIGFzIHRoZXkgYWxzbyBjaGFuZ2Ugc29tZSBr
c20gdHVuYWJsZXMgZGVwZW5kcworICogICAgb24gY3VycmVudCB3b3JrbG9hZHMuCisgKgorICog
VGhlIHRlc3Qgc3RlcHMgYXJlOgorICogLSBDaGVjayBrc20gZmVhdHVyZSBhbmQgYmFja3VwIGN1
cnJlbnQgcnVuIHNldHRpbmcuCisgKiAtIENoYW5nZSBydW4gc2V0dGluZyB0byAxIC0gbWVyZ2lu
Zy4KKyAqIC0gMyBtZW1vcnkgYWxsb2NhdGlvbiBwcm9ncmFtcyBoYXZlIHRoZSBtZW1vcnkgY29u
dGVudHMgdGhhdCAyIG9mCisgKiAgIHRoZW0gYXJlIGFsbCAnYScgYW5kIG9uZSBpcyBhbGwgJ2In
LgorICogLSBDaGVjayBrc20gc3RhdGlzdGljcyBhbmQgdmVyaWZ5IHRoZSBjb250ZW50LgorICog
LSAxIHByb2dyYW0gY2hhbmdlcyB0aGUgbWVtb3J5IGNvbnRlbnQgZnJvbSBhbGwgJ2EnIHRvIGFs
bCAnYicuCisgKiAtIENoZWNrIGtzbSBzdGF0aXN0aWNzIGFuZCB2ZXJpZnkgdGhlIGNvbnRlbnQu
CisgKiAtIEFsbCBwcm9ncmFtcyBjaGFuZ2UgdGhlIG1lbW9yeSBjb250ZW50IHRvIGFsbCAnZCcu
CisgKiAtIENoZWNrIGtzbSBzdGF0aXN0aWNzIGFuZCB2ZXJpZnkgdGhlIGNvbnRlbnQuCisgKiAt
IENoYW5nZSBvbmUgcGFnZSBvZiBhIHByb2Nlc3MuCisgKiAtIENoZWNrIGtzbSBzdGF0aXN0aWNz
IGFuZCB2ZXJpZnkgdGhlIGNvbnRlbnQuCisgKiAtIENoYW5nZSBydW4gc2V0dGluZyB0byAyIC0g
dW5tZXJnaW5nLgorICogLSBDaGVjayBrc20gc3RhdGlzdGljcyBhbmQgdmVyaWZ5IHRoZSBjb250
ZW50LgorICogLSBDaGFuZ2UgcnVuIHNldHRpbmcgdG8gMCAtIHN0b3AuCisgKgorICogQ29weXJp
Z2h0IChDKSAyMDEwICBSZWQgSGF0LCBJbmMuCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUg
c29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcgorICogbW9kaWZ5IGl0IHVu
ZGVyIHRoZSB0ZXJtcyBvZiB2ZXJzaW9uIDIgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYworICog
TGljZW5zZSBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAq
CisgKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3b3Vs
ZCBiZSB1c2VmdWwsCisgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0
aGUgaW1wbGllZCB3YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9S
IEEgUEFSVElDVUxBUiBQVVJQT1NFLgorICoKKyAqIEZ1cnRoZXIsIHRoaXMgc29mdHdhcmUgaXMg
ZGlzdHJpYnV0ZWQgd2l0aG91dCBhbnkgd2FycmFudHkgdGhhdCBpdAorICogaXMgZnJlZSBvZiB0
aGUgcmlnaHRmdWwgY2xhaW0gb2YgYW55IHRoaXJkIHBlcnNvbiByZWdhcmRpbmcKKyAqIGluZnJp
bmdlbWVudCBvciB0aGUgbGlrZS4gIEFueSBsaWNlbnNlIHByb3ZpZGVkIGhlcmVpbiwgd2hldGhl
cgorICogaW1wbGllZCBvciBvdGhlcndpc2UsIGFwcGxpZXMgb25seSB0byB0aGlzIHNvZnR3YXJl
IGZpbGUuICBQYXRlbnQKKyAqIGxpY2Vuc2VzLCBpZiBhbnksIHByb3ZpZGVkIGhlcmVpbiBkbyBu
b3QgYXBwbHkgdG8gY29tYmluYXRpb25zIG9mCisgKiB0aGlzIHByb2dyYW0gd2l0aCBvdGhlciBz
b2Z0d2FyZSwgb3IgYW55IG90aGVyIHByb2R1Y3Qgd2hhdHNvZXZlci4KKyAqCisgKiBZb3Ugc2hv
dWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZQorICogYWxvbmcgd2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdGhlIEZyZWUgU29m
dHdhcmUKKyAqIEZvdW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxv
b3IsIEJvc3RvbiwgTUEKKyAqIDAyMTEwLTEzMDEsIFVTQS4KKyAqLworI2luY2x1ZGUgInRlc3Qu
aCIKKyNpbmNsdWRlICJ1c2N0ZXN0LmgiCisjaW5jbHVkZSAiY29uZmlnLmgiCisKK2NoYXIgKlRD
SUQgPSAia3NtMDQiOworaW50IFRTVF9UT1RBTCA9IDE7CisKKyNpZiBIQVZFX05VTUFfSCAmJiBI
QVZFX0xJTlVYX01FTVBPTElDWV9IICYmIEhBVkVfTlVNQUlGX0ggXAorCSYmIEhBVkVfTVBPTF9D
T05TVEFOVFMKKyNpbmNsdWRlIDxzeXMvc3RhdC5oPgorI2luY2x1ZGUgPHN5cy90eXBlcy5oPgor
I2luY2x1ZGUgPGZjbnRsLmg+CisjaW5jbHVkZSA8c2lnbmFsLmg+CisjaW5jbHVkZSA8dW5pc3Rk
Lmg+CisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDxlcnJuby5oPgorI2luY2x1ZGUgPG51
bWFpZi5oPgorI2luY2x1ZGUgIi4uL2luY2x1ZGUvbWVtLmgiCisKK29wdGlvbl90IGtzbV9vcHRp
b25zW10gPSB7CisgICAgICAgIHsgIm46IiwgJm9wdF9udW0sICAgICAgICZvcHRfbnVtc3RyfSwK
KyAgICAgICAgeyAiczoiLCAmb3B0X3NpemUsICAgICAgJm9wdF9zaXplc3RyfSwKKyAgICAgICAg
eyAidToiLCAmb3B0X3VuaXQsICAgICAgJm9wdF91bml0c3RyfSwKKyAgICAgICAgeyBOVUxMLCBO
VUxMLCAgICAgICAgICAgTlVMTH0KK307CisKK2ludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2
W10pCit7CisJaW50IGxjOworCWNoYXIgKm1zZzsKKwlpbnQgc2l6ZSA9IDEyOCwgbnVtID0gMywg
dW5pdCA9IDE7CisJdW5zaWduZWQgbG9uZyBubm9kZXMgPSAxOworCXVuc2lnbmVkIGxvbmcgbm1h
c2sgPSAyOworCisJbXNnID0gcGFyc2Vfb3B0cyhhcmdjLCBhcmd2LCBrc21fb3B0aW9ucywga3Nt
X3VzYWdlKTsKKwlpZiAobXNnICE9IE5VTEwpCisJCXRzdF9icmttKFRCUk9LLCBOVUxMLCAiT1BU
SU9OIFBBUlNJTkcgRVJST1IgLSAlcyIsIG1zZyk7CisKKwlubm9kZXMgPSBjb3VudF9udW1hKCk7
CisJaWYgKGNvdW50X251bWEoKSA9PSAxKQorCQl0c3RfYnJrbShUQ09ORiwgTlVMTCwgInJlcXVp
cmVkIGEgTlVNQSBzeXN0ZW0uIik7CisKKwlzZXR1cCgpOworCisJZm9yIChsYyA9IDA7IFRFU1Rf
TE9PUElORyhsYyk7IGxjKyspIHsKKwkJVHN0X2NvdW50ID0gMDsKKwkJY2hlY2tfa3NtX29wdGlv
bnMoJnNpemUsICZudW0sICZ1bml0KTsKKworCQl3cml0ZV9tZW1jZygpOworCisJCWlmIChzZXRf
bWVtcG9saWN5KE1QT0xfQklORCwgJm5tYXNrLCBNQVhOT0RFUykgPT0gLTEpCisJCQl0c3RfYnJr
bShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJzZXRfbWVtcG9saWN5Iik7CisJCWNyZWF0ZV9zYW1l
X21lbW9yeShzaXplLCBudW0sIHVuaXQpOworCisJCXdyaXRlX2NwdXNldHMoKTsKKwkJY3JlYXRl
X3NhbWVfbWVtb3J5KHNpemUsIG51bSwgdW5pdCk7CisJfQorCWNsZWFudXAoKTsKKwl0c3RfZXhp
dCgpOworfQorCit2b2lkIGNsZWFudXAodm9pZCkKK3sKKwl1bW91bnRfbWVtKENQQVRILCBDUEFU
SF9ORVcpOworCXVtb3VudF9tZW0oTUVNQ0dfUEFUSCwgTUVNQ0dfUEFUSF9ORVcpOworCVRFU1Rf
Q0xFQU5VUDsKK30KKwordm9pZCBzZXR1cCh2b2lkKQoreworCXRzdF9yZXF1aXJlX3Jvb3QoTlVM
TCk7CisKKwl0c3Rfc2lnKEZPUkssIERFRl9IQU5ETEVSLCBjbGVhbnVwKTsKKwlURVNUX1BBVVNF
OworCW1vdW50X21lbSgiY3B1c2V0IiwgImNwdXNldCIsIE5VTEwsIENQQVRILCBDUEFUSF9ORVcp
OworCW1vdW50X21lbSgibWVtY2ciLCAiY2dyb3VwIiwgIm1lbW9yeSIsIE1FTUNHX1BBVEgsIE1F
TUNHX1BBVEhfTkVXKTsKK30KKworI2Vsc2UgLyogbm8gTlVNQSAqLworaW50IG1haW4odm9pZCkK
K3sKKwl0c3RfcmVzbShUQ09ORiwgIm5vIE5VTUEgZGV2ZWxvcG1lbnQgcGFja2FnZXMgaW5zdGFs
bGVkLiIpOworCXRzdF9leGl0KCk7Cit9CisjZW5kaWYKLS0gCjEuNy4zLjIKCg==
------=_Part_56391_2118165403.1295425114162
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
------=_Part_56391_2118165403.1295425114162
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_56391_2118165403.1295425114162--

