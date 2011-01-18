Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfD2w-0003R3-Up
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 15:00:34 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfD2v-00044y-Gb
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 15:00:34 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0IF0SMg032329
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Jan 2011 10:00:28 -0500
Date: Tue, 18 Jan 2011 10:00:28 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1848061538.37293.1295362828087.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <967465795.37290.1295362823013.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_37292_1448035506.1295362828086"
Subject: [LTP] [PATCH 2/4] ksm03: KSM for Memory Resource Controller
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

------=_Part_37292_1448035506.1295362828086
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/ksm/ksm03.c |  118 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 118 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/ksm/ksm03.c

diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
new file mode 100644
index 0000000..732c2c9
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -0,0 +1,118 @@
+/*
+ * Kernel Samepage Merging (KSM) for Memory Resource Controller
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
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include "test.h"
+#include "usctest.h"
+#include "../include/mem.h"
+
+char *TCID = "ksm03";
+int TST_TOTAL = 1;
+extern int Tst_count;
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
+
+	msg = parse_opts(argc, argv, ksm_options, ksm_usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		check_ksm_options(&size, &num, &unit);
+		write_memcg();
+		create_same_memory(size, num, unit);
+	}
+	cleanup();
+}
+
+void setup(void)
+{
+	tst_require_root(tst_exit);
+
+	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+	tst_sig(FORK, DEF_HANDLER, NULL);
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+	TEST_CLEANUP;
+	tst_exit();
+}
-- 
1.7.3.2
------=_Part_37292_1448035506.1295362828086
Content-Type: text/x-patch;
	name=0002-ksm03-KSM-for-Memory-Resource-Controller.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0002-ksm03-KSM-for-Memory-Resource-Controller.patch

RnJvbSBlZWFhZjYwMmIzZWQxMTAxYTUzYzRlNjI1NmMzODQ2Y2ExYWQ2N2EyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDE4IEphbiAyMDExIDExOjEwOjAyICswODAwClN1YmplY3Q6IFtQQVRDSCAyLzRdIGtzbTAz
OiBLU00gZm9yIE1lbW9yeSBSZXNvdXJjZSBDb250cm9sbGVyCgoKU2lnbmVkLW9mZi1ieTogQ0FJ
IFFpYW4gPGNhaXFpYW5AcmVkaGF0LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9rc20v
a3NtMDMuYyB8ICAxMTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZXMgY2hhbmdlZCwgMTE4IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUg
bW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9tZW0va3NtL2tzbTAzLmMKCmRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3NtMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L2tzbS9rc20wMy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjczMmMyYzkK
LS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3NtMDMuYwpAQCAt
MCwwICsxLDExOCBAQAorLyoKKyAqIEtlcm5lbCBTYW1lcGFnZSBNZXJnaW5nIChLU00pIGZvciBN
ZW1vcnkgUmVzb3VyY2UgQ29udHJvbGxlcgorICoKKyAqIEJhc2ljIHRlc3RzIHdlcmUgdG8gc3Rh
cnQgc2V2ZXJhbCBwcm9ncmFtcyB3aXRoIHNhbWUgYW5kIGRpZmZlcmVudAorICogbWVtb3J5IGNv
bnRlbnRzIGFuZCBlbnN1cmUgb25seSB0byBtZXJnZSB0aGUgb25lcyB3aXRoIHRoZSBzYW1lCisg
KiBjb250ZW50cy4gV2hlbiBjaGFuZ2VkIHRoZSBjb250ZW50IG9mIG9uZSBvZiBtZXJnZWQgcGFn
ZXMgaW4gYQorICogcHJvY2VzcyBhbmQgdG8gdGhlIG1vZGUgInVubWVyZ2luZyIsIGl0IHNob3Vs
ZCBkaXNjYXJkIGFsbCBtZXJnZWQKKyAqIHBhZ2VzIHRoZXJlLiBBbHNvIHRlc3RlZCBpdCBpcyBw
b3NzaWJsZSB0byBkaXNhYmxlIEtTTS4gVGhlcmUgYXJlCisgKiBhbHNvIGNvbW1hbmQtbGluZSBv
cHRpb25zIHRvIHNwZWNpZnkgdGhlIG1lbW9yeSBhbGxvY2F0aW9uIHNpemUsIGFuZAorICogbnVt
YmVyIG9mIHByb2Nlc3NlcyBoYXZlIHNhbWUgbWVtb3J5IGNvbnRlbnRzIHNvIGl0IGlzIHBvc3Np
YmxlIHRvCisgKiB0ZXN0IG1vcmUgYWR2YW5jZWQgdGhpbmdzIGxpa2UgS1NNICsgT09NIGV0Yy4K
KyAqCisgKiBQcmVyZXF1aXNpdGVzOgorICoKKyAqIDEpIGtzbSBhbmQga3NtdHVuZWQgZGFlbW9u
cyBuZWVkIHRvIGJlIGRpc2FibGVkLiBPdGhlcndpc2UsIGl0IGNvdWxkCisgKiAgICBkaXN0cnVi
IHRoZSB0ZXN0aW5nIGFzIHRoZXkgYWxzbyBjaGFuZ2Ugc29tZSBrc20gdHVuYWJsZXMgZGVwZW5k
cworICogICAgb24gY3VycmVudCB3b3JrbG9hZHMuCisgKgorICogVGhlIHRlc3Qgc3RlcHMgYXJl
OgorICogLSBDaGVjayBrc20gZmVhdHVyZSBhbmQgYmFja3VwIGN1cnJlbnQgcnVuIHNldHRpbmcu
CisgKiAtIENoYW5nZSBydW4gc2V0dGluZyB0byAxIC0gbWVyZ2luZy4KKyAqIC0gMyBtZW1vcnkg
YWxsb2NhdGlvbiBwcm9ncmFtcyBoYXZlIHRoZSBtZW1vcnkgY29udGVudHMgdGhhdCAyIG9mCisg
KiAgIHRoZW0gYXJlIGFsbCAnYScgYW5kIG9uZSBpcyBhbGwgJ2InLgorICogLSBDaGVjayBrc20g
c3RhdGlzdGljcyBhbmQgdmVyaWZ5IHRoZSBjb250ZW50LgorICogLSAxIHByb2dyYW0gY2hhbmdl
cyB0aGUgbWVtb3J5IGNvbnRlbnQgZnJvbSBhbGwgJ2EnIHRvIGFsbCAnYicuCisgKiAtIENoZWNr
IGtzbSBzdGF0aXN0aWNzIGFuZCB2ZXJpZnkgdGhlIGNvbnRlbnQuCisgKiAtIEFsbCBwcm9ncmFt
cyBjaGFuZ2UgdGhlIG1lbW9yeSBjb250ZW50IHRvIGFsbCAnZCcuCisgKiAtIENoZWNrIGtzbSBz
dGF0aXN0aWNzIGFuZCB2ZXJpZnkgdGhlIGNvbnRlbnQuCisgKiAtIENoYW5nZSBvbmUgcGFnZSBv
ZiBhIHByb2Nlc3MuCisgKiAtIENoZWNrIGtzbSBzdGF0aXN0aWNzIGFuZCB2ZXJpZnkgdGhlIGNv
bnRlbnQuCisgKiAtIENoYW5nZSBydW4gc2V0dGluZyB0byAyIC0gdW5tZXJnaW5nLgorICogLSBD
aGVjayBrc20gc3RhdGlzdGljcyBhbmQgdmVyaWZ5IHRoZSBjb250ZW50LgorICogLSBDaGFuZ2Ug
cnVuIHNldHRpbmcgdG8gMCAtIHN0b3AuCisgKgorICogQ29weXJpZ2h0IChDKSAyMDEwICBSZWQg
SGF0LCBJbmMuCisgKgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4g
cmVkaXN0cmlidXRlIGl0IGFuZC9vcgorICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB2
ZXJzaW9uIDIgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYworICogTGljZW5zZSBhcyBwdWJsaXNo
ZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiBUaGlzIHByb2dyYW0g
aXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3b3VsZCBiZSB1c2VmdWwsCisgKiBi
dXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50
eSBvZgorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQ
T1NFLgorICoKKyAqIEZ1cnRoZXIsIHRoaXMgc29mdHdhcmUgaXMgZGlzdHJpYnV0ZWQgd2l0aG91
dCBhbnkgd2FycmFudHkgdGhhdCBpdAorICogaXMgZnJlZSBvZiB0aGUgcmlnaHRmdWwgY2xhaW0g
b2YgYW55IHRoaXJkIHBlcnNvbiByZWdhcmRpbmcKKyAqIGluZnJpbmdlbWVudCBvciB0aGUgbGlr
ZS4gIEFueSBsaWNlbnNlIHByb3ZpZGVkIGhlcmVpbiwgd2hldGhlcgorICogaW1wbGllZCBvciBv
dGhlcndpc2UsIGFwcGxpZXMgb25seSB0byB0aGlzIHNvZnR3YXJlIGZpbGUuICBQYXRlbnQKKyAq
IGxpY2Vuc2VzLCBpZiBhbnksIHByb3ZpZGVkIGhlcmVpbiBkbyBub3QgYXBwbHkgdG8gY29tYmlu
YXRpb25zIG9mCisgKiB0aGlzIHByb2dyYW0gd2l0aCBvdGhlciBzb2Z0d2FyZSwgb3IgYW55IG90
aGVyIHByb2R1Y3Qgd2hhdHNvZXZlci4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQg
YSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogYWxvbmcgd2l0aCB0
aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdGhlIEZyZWUgU29mdHdhcmUKKyAqIEZvdW5kYXRp
b24sIEluYy4sIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEKKyAq
IDAyMTEwLTEzMDEsIFVTQS4KKyAqLworI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CisjaW5jbHVkZSA8
c3lzL21tYW4uaD4KKyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KKyNpbmNsdWRlIDxzeXMvd2FpdC5o
PgorI2luY2x1ZGUgPHN5cy90eXBlcy5oPgorI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CisjaW5jbHVk
ZSA8ZmNudGwuaD4KKyNpbmNsdWRlIDxzaWduYWwuaD4KKyNpbmNsdWRlIDxzdGRsaWIuaD4KKyNp
bmNsdWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlIDx1bmlzdGQuaD4KKyNpbmNsdWRlIDxzdGRpby5o
PgorI2luY2x1ZGUgPGVycm5vLmg+CisjaW5jbHVkZSAidGVzdC5oIgorI2luY2x1ZGUgInVzY3Rl
c3QuaCIKKyNpbmNsdWRlICIuLi9pbmNsdWRlL21lbS5oIgorCitjaGFyICpUQ0lEID0gImtzbTAz
IjsKK2ludCBUU1RfVE9UQUwgPSAxOworZXh0ZXJuIGludCBUc3RfY291bnQ7CisKK29wdGlvbl90
IGtzbV9vcHRpb25zW10gPSB7CisgICAgICAgIHsgIm46IiwgJm9wdF9udW0sICAgICAgICZvcHRf
bnVtc3RyfSwKKyAgICAgICAgeyAiczoiLCAmb3B0X3NpemUsICAgICAgJm9wdF9zaXplc3RyfSwK
KyAgICAgICAgeyAidToiLCAmb3B0X3VuaXQsICAgICAgJm9wdF91bml0c3RyfSwKKyAgICAgICAg
eyBOVUxMLCBOVUxMLCAgICAgICAgICAgTlVMTH0KK307CisKK2ludCBtYWluKGludCBhcmdjLCBj
aGFyICphcmd2W10pCit7CisJaW50IGxjOworCWNoYXIgKm1zZzsKKwlpbnQgc2l6ZSA9IDEyOCwg
bnVtID0gMywgdW5pdCA9IDE7CisKKwltc2cgPSBwYXJzZV9vcHRzKGFyZ2MsIGFyZ3YsIGtzbV9v
cHRpb25zLCBrc21fdXNhZ2UpOworCWlmIChtc2cgIT0gTlVMTCkKKwkJdHN0X2Jya20oVEJST0ss
IHRzdF9leGl0LCAiT1BUSU9OIFBBUlNJTkcgRVJST1IgLSAlcyIsIG1zZyk7CisJc2V0dXAoKTsK
Kwlmb3IgKGxjID0gMDsgVEVTVF9MT09QSU5HKGxjKTsgbGMrKykgeworCQlUc3RfY291bnQgPSAw
OworCQljaGVja19rc21fb3B0aW9ucygmc2l6ZSwgJm51bSwgJnVuaXQpOworCQl3cml0ZV9tZW1j
ZygpOworCQljcmVhdGVfc2FtZV9tZW1vcnkoc2l6ZSwgbnVtLCB1bml0KTsKKwl9CisJY2xlYW51
cCgpOworfQorCit2b2lkIHNldHVwKHZvaWQpCit7CisJdHN0X3JlcXVpcmVfcm9vdCh0c3RfZXhp
dCk7CisKKwltb3VudF9tZW0oIm1lbWNnIiwgImNncm91cCIsICJtZW1vcnkiLCBNRU1DR19QQVRI
LCBNRU1DR19QQVRIX05FVyk7CisJdHN0X3NpZyhGT1JLLCBERUZfSEFORExFUiwgTlVMTCk7CisJ
VEVTVF9QQVVTRTsKK30KKwordm9pZCBjbGVhbnVwKHZvaWQpCit7CisJdW1vdW50X21lbShNRU1D
R19QQVRILCBNRU1DR19QQVRIX05FVyk7CisJVEVTVF9DTEVBTlVQOworCXRzdF9leGl0KCk7Cit9
Ci0tIAoxLjcuMy4yCgo=
------=_Part_37292_1448035506.1295362828086
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
------=_Part_37292_1448035506.1295362828086
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_37292_1448035506.1295362828086--

