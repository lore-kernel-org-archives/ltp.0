Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfD3g-0006Sb-6A
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 15:01:20 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfD3e-0002xq-Pm
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 15:01:20 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0IF1DcO032400
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Jan 2011 10:01:13 -0500
Date: Tue, 18 Jan 2011 10:01:13 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <2052507461.37319.1295362873307.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <21716139.37316.1295362869011.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_37318_369937246.1295362873306"
Subject: [LTP] [PATCH 3/4] ksm02: KSM for NUMA
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

------=_Part_37318_369937246.1295362873306
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/ksm/ksm02.c |  138 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 138 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/ksm/ksm02.c

diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
new file mode 100644
index 0000000..78c8edb
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -0,0 +1,138 @@
+/*
+ * Kernel Samepage Merging (KSM) for NUMA
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
+char *TCID = "ksm02";
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
------=_Part_37318_369937246.1295362873306
Content-Type: text/x-patch; name=0003-ksm02-KSM-for-NUMA.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0003-ksm02-KSM-for-NUMA.patch

RnJvbSA4MWZhMTJjNWI1ZjEwYjk3YThjOGJjMTA4OGJlZjJiZTcyZDBhNGMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDE4IEphbiAyMDExIDExOjEwOjAyICswODAwClN1YmplY3Q6IFtQQVRDSCAzLzRdIGtzbTAy
OiBLU00gZm9yIE5VTUEKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQu
Y29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL2tzbS9rc20wMi5jIHwgIDEzOCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCAxMzggaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMv
a2VybmVsL21lbS9rc20va3NtMDIuYwoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L2tzbS9rc20wMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0va3NtL2tzbTAyLmMKbmV3IGZpbGUg
bW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNzhjOGVkYgotLS0gL2Rldi9udWxsCisrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2tzbS9rc20wMi5jCkBAIC0wLDAgKzEsMTM4IEBACisvKgorICog
S2VybmVsIFNhbWVwYWdlIE1lcmdpbmcgKEtTTSkgZm9yIE5VTUEKKyAqCisgKiBCYXNpYyB0ZXN0
cyB3ZXJlIHRvIHN0YXJ0IHNldmVyYWwgcHJvZ3JhbXMgd2l0aCBzYW1lIGFuZCBkaWZmZXJlbnQK
KyAqIG1lbW9yeSBjb250ZW50cyBhbmQgZW5zdXJlIG9ubHkgdG8gbWVyZ2UgdGhlIG9uZXMgd2l0
aCB0aGUgc2FtZQorICogY29udGVudHMuIFdoZW4gY2hhbmdlZCB0aGUgY29udGVudCBvZiBvbmUg
b2YgbWVyZ2VkIHBhZ2VzIGluIGEKKyAqIHByb2Nlc3MgYW5kIHRvIHRoZSBtb2RlICJ1bm1lcmdp
bmciLCBpdCBzaG91bGQgZGlzY2FyZCBhbGwgbWVyZ2VkCisgKiBwYWdlcyB0aGVyZS4gQWxzbyB0
ZXN0ZWQgaXQgaXMgcG9zc2libGUgdG8gZGlzYWJsZSBLU00uIFRoZXJlIGFyZQorICogYWxzbyBj
b21tYW5kLWxpbmUgb3B0aW9ucyB0byBzcGVjaWZ5IHRoZSBtZW1vcnkgYWxsb2NhdGlvbiBzaXpl
LCBhbmQKKyAqIG51bWJlciBvZiBwcm9jZXNzZXMgaGF2ZSBzYW1lIG1lbW9yeSBjb250ZW50cyBz
byBpdCBpcyBwb3NzaWJsZSB0bworICogdGVzdCBtb3JlIGFkdmFuY2VkIHRoaW5ncyBsaWtlIEtT
TSArIE9PTSBldGMuCisgKgorICogUHJlcmVxdWlzaXRlczoKKyAqCisgKiAxKSBrc20gYW5kIGtz
bXR1bmVkIGRhZW1vbnMgbmVlZCB0byBiZSBkaXNhYmxlZC4gT3RoZXJ3aXNlLCBpdCBjb3VsZAor
ICogICAgZGlzdHJ1YiB0aGUgdGVzdGluZyBhcyB0aGV5IGFsc28gY2hhbmdlIHNvbWUga3NtIHR1
bmFibGVzIGRlcGVuZHMKKyAqICAgIG9uIGN1cnJlbnQgd29ya2xvYWRzLgorICoKKyAqIFRoZSB0
ZXN0IHN0ZXBzIGFyZToKKyAqIC0gQ2hlY2sga3NtIGZlYXR1cmUgYW5kIGJhY2t1cCBjdXJyZW50
IHJ1biBzZXR0aW5nLgorICogLSBDaGFuZ2UgcnVuIHNldHRpbmcgdG8gMSAtIG1lcmdpbmcuCisg
KiAtIDMgbWVtb3J5IGFsbG9jYXRpb24gcHJvZ3JhbXMgaGF2ZSB0aGUgbWVtb3J5IGNvbnRlbnRz
IHRoYXQgMiBvZgorICogICB0aGVtIGFyZSBhbGwgJ2EnIGFuZCBvbmUgaXMgYWxsICdiJy4KKyAq
IC0gQ2hlY2sga3NtIHN0YXRpc3RpY3MgYW5kIHZlcmlmeSB0aGUgY29udGVudC4KKyAqIC0gMSBw
cm9ncmFtIGNoYW5nZXMgdGhlIG1lbW9yeSBjb250ZW50IGZyb20gYWxsICdhJyB0byBhbGwgJ2In
LgorICogLSBDaGVjayBrc20gc3RhdGlzdGljcyBhbmQgdmVyaWZ5IHRoZSBjb250ZW50LgorICog
LSBBbGwgcHJvZ3JhbXMgY2hhbmdlIHRoZSBtZW1vcnkgY29udGVudCB0byBhbGwgJ2QnLgorICog
LSBDaGVjayBrc20gc3RhdGlzdGljcyBhbmQgdmVyaWZ5IHRoZSBjb250ZW50LgorICogLSBDaGFu
Z2Ugb25lIHBhZ2Ugb2YgYSBwcm9jZXNzLgorICogLSBDaGVjayBrc20gc3RhdGlzdGljcyBhbmQg
dmVyaWZ5IHRoZSBjb250ZW50LgorICogLSBDaGFuZ2UgcnVuIHNldHRpbmcgdG8gMiAtIHVubWVy
Z2luZy4KKyAqIC0gQ2hlY2sga3NtIHN0YXRpc3RpY3MgYW5kIHZlcmlmeSB0aGUgY29udGVudC4K
KyAqIC0gQ2hhbmdlIHJ1biBzZXR0aW5nIHRvIDAgLSBzdG9wLgorICoKKyAqIENvcHlyaWdodCAo
QykgMjAxMCAgUmVkIEhhdCwgSW5jLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
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
b3N0b24sIE1BCisgKiAwMjExMC0xMzAxLCBVU0EuCisgKi8KKyNpbmNsdWRlICJ0ZXN0LmgiCisj
aW5jbHVkZSAidXNjdGVzdC5oIgorI2luY2x1ZGUgImNvbmZpZy5oIgorCitjaGFyICpUQ0lEID0g
ImtzbTAyIjsKK2ludCBUU1RfVE9UQUwgPSAxOworZXh0ZXJuIGludCBUc3RfY291bnQ7CisKKyNp
ZiBIQVZFX05VTUFfSCAmJiBIQVZFX0xJTlVYX01FTVBPTElDWV9IICYmIEhBVkVfTlVNQUlGX0gg
XAorCSYmIEhBVkVfTVBPTF9DT05TVEFOVFMKKyNpbmNsdWRlIDxzeXMvc3RhdC5oPgorI2luY2x1
ZGUgPHN5cy90eXBlcy5oPgorI2luY2x1ZGUgPGZjbnRsLmg+CisjaW5jbHVkZSA8c2lnbmFsLmg+
CisjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8c3RkaW8uaD4KKyNpbmNsdWRlIDxlcnJu
by5oPgorI2luY2x1ZGUgPG51bWFpZi5oPgorI2luY2x1ZGUgIi4uL2luY2x1ZGUvbWVtLmgiCisK
K29wdGlvbl90IGtzbV9vcHRpb25zW10gPSB7CisgICAgICAgIHsgIm46IiwgJm9wdF9udW0sICAg
ICAgICZvcHRfbnVtc3RyfSwKKyAgICAgICAgeyAiczoiLCAmb3B0X3NpemUsICAgICAgJm9wdF9z
aXplc3RyfSwKKyAgICAgICAgeyAidToiLCAmb3B0X3VuaXQsICAgICAgJm9wdF91bml0c3RyfSwK
KyAgICAgICAgeyBOVUxMLCBOVUxMLCAgICAgICAgICAgTlVMTH0KK307CisKK2ludCBtYWluKGlu
dCBhcmdjLCBjaGFyICphcmd2W10pCit7CisJaW50IGxjOworCWNoYXIgKm1zZzsKKwlpbnQgc2l6
ZSA9IDEyOCwgbnVtID0gMywgdW5pdCA9IDE7CisJdW5zaWduZWQgbG9uZyBubm9kZXMgPSAxOwor
CXVuc2lnbmVkIGxvbmcgbm1hc2sgPSAyOworCisJbXNnID0gcGFyc2Vfb3B0cyhhcmdjLCBhcmd2
LCBrc21fb3B0aW9ucywga3NtX3VzYWdlKTsKKwlpZiAobXNnICE9IE5VTEwpCisJCXRzdF9icmtt
KFRCUk9LLCB0c3RfZXhpdCwgIk9QVElPTiBQQVJTSU5HIEVSUk9SIC0gJXMiLCBtc2cpOworCisJ
bm5vZGVzID0gY291bnRfbnVtYSgpOworCWlmIChjb3VudF9udW1hKCkgPT0gMSkKKwkJdHN0X2Jy
a20oVENPTkYsIHRzdF9leGl0LCAicmVxdWlyZWQgYSBOVU1BIHN5c3RlbS4iKTsKKworCXNldHVw
KCk7CisKKwlmb3IgKGxjID0gMDsgVEVTVF9MT09QSU5HKGxjKTsgbGMrKykgeworCQlUc3RfY291
bnQgPSAwOworCQljaGVja19rc21fb3B0aW9ucygmc2l6ZSwgJm51bSwgJnVuaXQpOworCisJCWlm
IChzZXRfbWVtcG9saWN5KE1QT0xfQklORCwgJm5tYXNrLCBNQVhOT0RFUykgPT0gLTEpCisJCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJzZXRfbWVtcG9saWN5Iik7CisJCWNyZWF0
ZV9zYW1lX21lbW9yeShzaXplLCBudW0sIHVuaXQpOworCisJCXdyaXRlX2NwdXNldHMoKTsKKwkJ
Y3JlYXRlX3NhbWVfbWVtb3J5KHNpemUsIG51bSwgdW5pdCk7CisJfQorCWNsZWFudXAoKTsKK30K
Kwordm9pZCBjbGVhbnVwKHZvaWQpCit7CisJdW1vdW50X21lbShDUEFUSCwgQ1BBVEhfTkVXKTsK
KwlURVNUX0NMRUFOVVA7CisJdHN0X2V4aXQoKTsKK30KKwordm9pZCBzZXR1cCh2b2lkKQorewor
CXRzdF9yZXF1aXJlX3Jvb3QodHN0X2V4aXQpOworCisJdHN0X3NpZyhGT1JLLCBERUZfSEFORExF
UiwgY2xlYW51cCk7CisJVEVTVF9QQVVTRTsKKwltb3VudF9tZW0oImNwdXNldCIsICJjcHVzZXQi
LCBOVUxMLCBDUEFUSCwgQ1BBVEhfTkVXKTsKK30KKworI2Vsc2UgLyogbm8gTlVNQSAqLworaW50
IG1haW4odm9pZCkKK3sKKwl0c3RfcmVzbShUQ09ORiwgIm5vIE5VTUEgZGV2ZWxvcG1lbnQgcGFj
a2FnZXMgaW5zdGFsbGVkLiIpOworCXRzdF9leGl0KCk7Cit9CisjZW5kaWYKLS0gCjEuNy4zLjIK
Cg==
------=_Part_37318_369937246.1295362873306
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
------=_Part_37318_369937246.1295362873306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_37318_369937246.1295362873306--

