Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfD2E-00088x-As
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 14:59:50 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfD2D-0003ra-6L
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 14:59:50 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0IExh5i032001
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Jan 2011 09:59:43 -0500
Date: Tue, 18 Jan 2011 09:59:43 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1135841145.37240.1295362783543.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1788862855.37233.1295362778575.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_37239_1576277391.1295362783542"
Subject: [LTP] [PATCH 1/4] ksm04: KSM for Memory Resource Controller and NUMA
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

------=_Part_37239_1576277391.1295362783542
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/ksm/ksm04.c |  142 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 142 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/ksm/ksm04.c

diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
new file mode 100644
index 0000000..2ff3959
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -0,0 +1,142 @@
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
+extern int Tst_count;
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
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+	nnodes = count_numa();
+	if (count_numa() == 1)
+		tst_brkm(TCONF, tst_exit, "required a NUMA system.");
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
+}
+
+void cleanup(void)
+{
+	umount_mem(CPATH, CPATH_NEW);
+	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+void setup(void)
+{
+	tst_require_root(tst_exit);
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
------=_Part_37239_1576277391.1295362783542
Content-Type: text/x-patch;
	name=0001-ksm04-KSM-for-Memory-Resource-Controller-and-NUMA.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-ksm04-KSM-for-Memory-Resource-Controller-and-NUMA.patch

RnJvbSA2NjJiZjdlNzE5NjAxMzhiYzg3NmRkNThjMDZhM2YzYzRmZjU5NDFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDE4IEphbiAyMDExIDExOjEwOjAyICswODAwClN1YmplY3Q6IFtQQVRDSCAxLzRdIGtzbTA0
OiBLU00gZm9yIE1lbW9yeSBSZXNvdXJjZSBDb250cm9sbGVyIGFuZCBOVU1BCgoKU2lnbmVkLW9m
Zi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVs
L21lbS9rc20va3NtMDQuYyB8ICAxNDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIDEgZmlsZXMgY2hhbmdlZCwgMTQyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0p
CiBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9tZW0va3NtL2tzbTA0LmMKCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3NtMDQuYyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvbWVtL2tzbS9rc20wNC5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAu
LjJmZjM5NTkKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3Nt
MDQuYwpAQCAtMCwwICsxLDE0MiBAQAorLyoKKyAqIEtlcm5lbCBTYW1lcGFnZSBNZXJnaW5nIChL
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
SUQgPSAia3NtMDQiOworaW50IFRTVF9UT1RBTCA9IDE7CitleHRlcm4gaW50IFRzdF9jb3VudDsK
KworI2lmIEhBVkVfTlVNQV9IICYmIEhBVkVfTElOVVhfTUVNUE9MSUNZX0ggJiYgSEFWRV9OVU1B
SUZfSCBcCisJJiYgSEFWRV9NUE9MX0NPTlNUQU5UUworI2luY2x1ZGUgPHN5cy9zdGF0Lmg+Cisj
aW5jbHVkZSA8c3lzL3R5cGVzLmg+CisjaW5jbHVkZSA8ZmNudGwuaD4KKyNpbmNsdWRlIDxzaWdu
YWwuaD4KKyNpbmNsdWRlIDx1bmlzdGQuaD4KKyNpbmNsdWRlIDxzdGRpby5oPgorI2luY2x1ZGUg
PGVycm5vLmg+CisjaW5jbHVkZSA8bnVtYWlmLmg+CisjaW5jbHVkZSAiLi4vaW5jbHVkZS9tZW0u
aCIKKworb3B0aW9uX3Qga3NtX29wdGlvbnNbXSA9IHsKKyAgICAgICAgeyAibjoiLCAmb3B0X251
bSwgICAgICAgJm9wdF9udW1zdHJ9LAorICAgICAgICB7ICJzOiIsICZvcHRfc2l6ZSwgICAgICAm
b3B0X3NpemVzdHJ9LAorICAgICAgICB7ICJ1OiIsICZvcHRfdW5pdCwgICAgICAmb3B0X3VuaXRz
dHJ9LAorICAgICAgICB7IE5VTEwsIE5VTEwsICAgICAgICAgICBOVUxMfQorfTsKKworaW50IG1h
aW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKK3sKKwlpbnQgbGM7CisJY2hhciAqbXNnOworCWlu
dCBzaXplID0gMTI4LCBudW0gPSAzLCB1bml0ID0gMTsKKwl1bnNpZ25lZCBsb25nIG5ub2RlcyA9
IDE7CisJdW5zaWduZWQgbG9uZyBubWFzayA9IDI7CisKKwltc2cgPSBwYXJzZV9vcHRzKGFyZ2Ms
IGFyZ3YsIGtzbV9vcHRpb25zLCBrc21fdXNhZ2UpOworCWlmIChtc2cgIT0gTlVMTCkKKwkJdHN0
X2Jya20oVEJST0ssIHRzdF9leGl0LCAiT1BUSU9OIFBBUlNJTkcgRVJST1IgLSAlcyIsIG1zZyk7
CisKKwlubm9kZXMgPSBjb3VudF9udW1hKCk7CisJaWYgKGNvdW50X251bWEoKSA9PSAxKQorCQl0
c3RfYnJrbShUQ09ORiwgdHN0X2V4aXQsICJyZXF1aXJlZCBhIE5VTUEgc3lzdGVtLiIpOworCisJ
c2V0dXAoKTsKKworCWZvciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyBsYysrKSB7CisJCVRz
dF9jb3VudCA9IDA7CisJCWNoZWNrX2tzbV9vcHRpb25zKCZzaXplLCAmbnVtLCAmdW5pdCk7CisK
KwkJd3JpdGVfbWVtY2coKTsKKworCQlpZiAoc2V0X21lbXBvbGljeShNUE9MX0JJTkQsICZubWFz
aywgTUFYTk9ERVMpID09IC0xKQorCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAi
c2V0X21lbXBvbGljeSIpOworCQljcmVhdGVfc2FtZV9tZW1vcnkoc2l6ZSwgbnVtLCB1bml0KTsK
KworCQl3cml0ZV9jcHVzZXRzKCk7CisJCWNyZWF0ZV9zYW1lX21lbW9yeShzaXplLCBudW0sIHVu
aXQpOworCX0KKwljbGVhbnVwKCk7Cit9CisKK3ZvaWQgY2xlYW51cCh2b2lkKQoreworCXVtb3Vu
dF9tZW0oQ1BBVEgsIENQQVRIX05FVyk7CisJdW1vdW50X21lbShNRU1DR19QQVRILCBNRU1DR19Q
QVRIX05FVyk7CisJVEVTVF9DTEVBTlVQOworCXRzdF9leGl0KCk7Cit9CisKK3ZvaWQgc2V0dXAo
dm9pZCkKK3sKKwl0c3RfcmVxdWlyZV9yb290KHRzdF9leGl0KTsKKworCXRzdF9zaWcoRk9SSywg
REVGX0hBTkRMRVIsIGNsZWFudXApOworCVRFU1RfUEFVU0U7CisJbW91bnRfbWVtKCJjcHVzZXQi
LCAiY3B1c2V0IiwgTlVMTCwgQ1BBVEgsIENQQVRIX05FVyk7CisJbW91bnRfbWVtKCJtZW1jZyIs
ICJjZ3JvdXAiLCAibWVtb3J5IiwgTUVNQ0dfUEFUSCwgTUVNQ0dfUEFUSF9ORVcpOworfQorCisj
ZWxzZSAvKiBubyBOVU1BICovCitpbnQgbWFpbih2b2lkKQoreworCXRzdF9yZXNtKFRDT05GLCAi
bm8gTlVNQSBkZXZlbG9wbWVudCBwYWNrYWdlcyBpbnN0YWxsZWQuIik7CisJdHN0X2V4aXQoKTsK
K30KKyNlbmRpZgotLSAKMS43LjMuMgoK
------=_Part_37239_1576277391.1295362783542
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
------=_Part_37239_1576277391.1295362783542
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_37239_1576277391.1295362783542--

