Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfTAg-0002e7-Ss
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:13:38 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfTAf-0006op-A2
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:13:38 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0J8DVQl015895
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Jan 2011 03:13:31 -0500
Date: Wed, 19 Jan 2011 03:13:31 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1974851619.56201.1295424811447.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1220355164.56198.1295424804831.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_56200_1126310211.1295424811446"
Subject: [LTP] [PATCH 1/4] ksm02: KSM for NUMA
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

------=_Part_56200_1126310211.1295424811446
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/ksm/ksm02.c |  137 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 137 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/ksm/ksm02.c

diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
new file mode 100644
index 0000000..33ed887
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -0,0 +1,137 @@
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
------=_Part_56200_1126310211.1295424811446
Content-Type: text/x-patch; name=0001-ksm02-KSM-for-NUMA.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-ksm02-KSM-for-NUMA.patch

RnJvbSBiZjQ1MmMwZjE4ZWNhMDY3ZWYzNTNiYTU2MDVkN2M1YTNiOWI3ZGYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBX
ZWQsIDE5IEphbiAyMDExIDE1OjUwOjM2ICswODAwClN1YmplY3Q6IFtQQVRDSCAxLzRdIGtzbTAy
OiBLU00gZm9yIE5VTUEKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQu
Y29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL2tzbS9rc20wMi5jIHwgIDEzNyArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlcyBjaGFuZ2VkLCAxMzcgaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMv
a2VybmVsL21lbS9rc20va3NtMDIuYwoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L2tzbS9rc20wMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0va3NtL2tzbTAyLmMKbmV3IGZpbGUg
bW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uMzNlZDg4NwotLS0gL2Rldi9udWxsCisrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL2tzbS9rc20wMi5jCkBAIC0wLDAgKzEsMTM3IEBACisvKgorICog
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
ImtzbTAyIjsKK2ludCBUU1RfVE9UQUwgPSAxOworCisjaWYgSEFWRV9OVU1BX0ggJiYgSEFWRV9M
SU5VWF9NRU1QT0xJQ1lfSCAmJiBIQVZFX05VTUFJRl9IIFwKKwkmJiBIQVZFX01QT0xfQ09OU1RB
TlRTCisjaW5jbHVkZSA8c3lzL3N0YXQuaD4KKyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KKyNpbmNs
dWRlIDxmY250bC5oPgorI2luY2x1ZGUgPHNpZ25hbC5oPgorI2luY2x1ZGUgPHVuaXN0ZC5oPgor
I2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8ZXJybm8uaD4KKyNpbmNsdWRlIDxudW1haWYu
aD4KKyNpbmNsdWRlICIuLi9pbmNsdWRlL21lbS5oIgorCitvcHRpb25fdCBrc21fb3B0aW9uc1td
ID0geworICAgICAgICB7ICJuOiIsICZvcHRfbnVtLCAgICAgICAmb3B0X251bXN0cn0sCisgICAg
ICAgIHsgInM6IiwgJm9wdF9zaXplLCAgICAgICZvcHRfc2l6ZXN0cn0sCisgICAgICAgIHsgInU6
IiwgJm9wdF91bml0LCAgICAgICZvcHRfdW5pdHN0cn0sCisgICAgICAgIHsgTlVMTCwgTlVMTCwg
ICAgICAgICAgIE5VTEx9Cit9OworCitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQor
eworCWludCBsYzsKKwljaGFyICptc2c7CisJaW50IHNpemUgPSAxMjgsIG51bSA9IDMsIHVuaXQg
PSAxOworCXVuc2lnbmVkIGxvbmcgbm5vZGVzID0gMTsKKwl1bnNpZ25lZCBsb25nIG5tYXNrID0g
MjsKKworCW1zZyA9IHBhcnNlX29wdHMoYXJnYywgYXJndiwga3NtX29wdGlvbnMsIGtzbV91c2Fn
ZSk7CisJaWYgKG1zZyAhPSBOVUxMKQorCQl0c3RfYnJrbShUQlJPSywgTlVMTCwgIk9QVElPTiBQ
QVJTSU5HIEVSUk9SIC0gJXMiLCBtc2cpOworCisJbm5vZGVzID0gY291bnRfbnVtYSgpOworCWlm
IChjb3VudF9udW1hKCkgPT0gMSkKKwkJdHN0X2Jya20oVENPTkYsIE5VTEwsICJyZXF1aXJlZCBh
IE5VTUEgc3lzdGVtLiIpOworCisJc2V0dXAoKTsKKworCWZvciAobGMgPSAwOyBURVNUX0xPT1BJ
TkcobGMpOyBsYysrKSB7CisJCVRzdF9jb3VudCA9IDA7CisJCWNoZWNrX2tzbV9vcHRpb25zKCZz
aXplLCAmbnVtLCAmdW5pdCk7CisKKwkJaWYgKHNldF9tZW1wb2xpY3koTVBPTF9CSU5ELCAmbm1h
c2ssIE1BWE5PREVTKSA9PSAtMSkKKwkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwg
InNldF9tZW1wb2xpY3kiKTsKKwkJY3JlYXRlX3NhbWVfbWVtb3J5KHNpemUsIG51bSwgdW5pdCk7
CisKKwkJd3JpdGVfY3B1c2V0cygpOworCQljcmVhdGVfc2FtZV9tZW1vcnkoc2l6ZSwgbnVtLCB1
bml0KTsKKwl9CisJY2xlYW51cCgpOworCXRzdF9leGl0KCk7Cit9CisKK3ZvaWQgY2xlYW51cCh2
b2lkKQoreworCXVtb3VudF9tZW0oQ1BBVEgsIENQQVRIX05FVyk7CisJVEVTVF9DTEVBTlVQOwor
fQorCit2b2lkIHNldHVwKHZvaWQpCit7CisJdHN0X3JlcXVpcmVfcm9vdChOVUxMKTsKKworCXRz
dF9zaWcoRk9SSywgREVGX0hBTkRMRVIsIGNsZWFudXApOworCVRFU1RfUEFVU0U7CisJbW91bnRf
bWVtKCJjcHVzZXQiLCAiY3B1c2V0IiwgTlVMTCwgQ1BBVEgsIENQQVRIX05FVyk7Cit9CisKKyNl
bHNlIC8qIG5vIE5VTUEgKi8KK2ludCBtYWluKHZvaWQpCit7CisJdHN0X3Jlc20oVENPTkYsICJu
byBOVU1BIGRldmVsb3BtZW50IHBhY2thZ2VzIGluc3RhbGxlZC4iKTsKKwl0c3RfZXhpdCgpOwor
fQorI2VuZGlmCi0tIAoxLjcuMy4yCgo=
------=_Part_56200_1126310211.1295424811446
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
------=_Part_56200_1126310211.1295424811446
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_56200_1126310211.1295424811446--

