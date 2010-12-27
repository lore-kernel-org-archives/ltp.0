Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PX4uV-00011V-QP
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 04:42:15 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PX4uU-00015A-MT
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 04:42:15 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBR4g88N002474
	for <ltp-list@lists.sourceforge.net>; Sun, 26 Dec 2010 23:42:08 -0500
Date: Sun, 26 Dec 2010 23:42:08 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <194658542.85169.1293424928222.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1619894829.85166.1293424917546.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_85168_1017724871.1293424928222"
Subject: [LTP] [PATCH v3 2/5] oom02: test OOM for NUMA using mempolicy and
	cpuset
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

------=_Part_85168_1017724871.1293424928222
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v3: use common functions.
v2: code cleanup and skip 32-bit since there is no guarantee of running out of
    virtual memory address space there.

 testcases/kernel/mem/oom/oom02.c |  129 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 129 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/oom02.c

diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
new file mode 100644
index 0000000..22b811d
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -0,0 +1,129 @@
+/*
+ * Out Of Memory (OOM) for NUMA
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
+char *TCID = "oom02";
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
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+#ifdef __i386__
+	tst_brkm(TCONF, tst_exit,
+		"this test is not designed for 32-bit system.");
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
+		tst_resm(TINFO, "process mempolicy.");
+		testoom(1, 0);
+
+		tst_resm(TINFO, "process cpuset.");
+		testoom(0, 0);
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
------=_Part_85168_1017724871.1293424928222
Content-Type: text/x-patch;
	name=0002-oom02-test-OOM-for-NUMA-using-mempolicy-and-cpuset.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0002-oom02-test-OOM-for-NUMA-using-mempolicy-and-cpuset.patch

RnJvbSA0OWY3Mjg2MzZlNGJmZTA0OGM3ZWNhNTM2YTE2NGVlNWY2YWJmM2JlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBN
b24sIDI3IERlYyAyMDEwIDEyOjI5OjA5ICswODAwClN1YmplY3Q6IFtQQVRDSCB2MyAyLzVdIG9v
bTAyOiB0ZXN0IE9PTSBmb3IgTlVNQSB1c2luZyBtZW1wb2xpY3kgYW5kIGNwdXNldAoKClNpZ25l
ZC1vZmYtYnk6IENBSSBRaWFuIDxjYWlxaWFuQHJlZGhhdC5jb20+Ci0tLQp2MzogdXNlIGNvbW1v
biBmdW5jdGlvbnMuCnYyOiBjb2RlIGNsZWFudXAgYW5kIHNraXAgMzItYml0IHNpbmNlIHRoZXJl
IGlzIG5vIGd1YXJhbnRlZSBvZiBydW5uaW5nIG91dCBvZgogICAgdmlydHVhbCBtZW1vcnkgYWRk
cmVzcyBzcGFjZSB0aGVyZS4KCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDIuYyB8ICAx
MjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZXMgY2hhbmdl
ZCwgMTI5IGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCiBjcmVhdGUgbW9kZSAxMDA2NDQg
dGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAyLmMKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL21lbS9vb20vb29tMDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMi5j
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjIyYjgxMWQKLS0tIC9kZXYvbnVs
bAorKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDIuYwpAQCAtMCwwICsxLDEyOSBA
QAorLyoKKyAqIE91dCBPZiBNZW1vcnkgKE9PTSkgZm9yIE5VTUEKKyAqCisgKiBUaGUgcHJvZ3Jh
bSBpcyBkZXNpZ25lZCB0byBjb3BlIHdpdGggdW5wcmVkaWN0YWJsZSBsaWtlIGFtb3VudCBhbmQK
KyAqIHN5c3RlbSBwaHlzaWNhbCBtZW1vcnksIHN3YXAgc2l6ZSBhbmQgb3RoZXIgVk1NIHRlY2hu
b2xvZ3kgbGlrZSBLU00sCisgKiBtZW1jZywgbWVtb3J5IGhvdHBsdWcgYW5kIHNvIG9uIHdoaWNo
IG1heSBhZmZlY3QgdGhlIE9PTQorICogYmVoYXZpb3Vycy4gSXQgc2ltcGx5IGluY3JlYXNlIHRo
ZSBtZW1vcnkgY29uc3VtcHRpb24gM0cgZWFjaCB0aW1lCisgKiB1bnRpbCBhbGwgdGhlIGF2YWls
YWJsZSBtZW1vcnkgaXMgY29uc3VtZWQgYW5kIE9PTSBpcyB0cmlnZ2VyZWQuCisgKgorICogQ29w
eXJpZ2h0IChDKSAyMDEwICBSZWQgSGF0LCBJbmMuCisgKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yCisgKiBtb2RpZnkgaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHZlcnNpb24gMiBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljCisgKiBM
aWNlbnNlIGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICoK
KyAqIFRoaXMgcHJvZ3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdvdWxk
IGJlIHVzZWZ1bCwKKyAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRo
ZSBpbXBsaWVkIHdhcnJhbnR5IG9mCisgKiBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1Ig
QSBQQVJUSUNVTEFSIFBVUlBPU0UuCisgKgorICogRnVydGhlciwgdGhpcyBzb2Z0d2FyZSBpcyBk
aXN0cmlidXRlZCB3aXRob3V0IGFueSB3YXJyYW50eSB0aGF0IGl0CisgKiBpcyBmcmVlIG9mIHRo
ZSByaWdodGZ1bCBjbGFpbSBvZiBhbnkgdGhpcmQgcGVyc29uIHJlZ2FyZGluZworICogaW5mcmlu
Z2VtZW50IG9yIHRoZSBsaWtlLiAgQW55IGxpY2Vuc2UgcHJvdmlkZWQgaGVyZWluLCB3aGV0aGVy
CisgKiBpbXBsaWVkIG9yIG90aGVyd2lzZSwgYXBwbGllcyBvbmx5IHRvIHRoaXMgc29mdHdhcmUg
ZmlsZS4gIFBhdGVudAorICogbGljZW5zZXMsIGlmIGFueSwgcHJvdmlkZWQgaGVyZWluIGRvIG5v
dCBhcHBseSB0byBjb21iaW5hdGlvbnMgb2YKKyAqIHRoaXMgcHJvZ3JhbSB3aXRoIG90aGVyIHNv
ZnR3YXJlLCBvciBhbnkgb3RoZXIgcHJvZHVjdCB3aGF0c29ldmVyLgorICoKKyAqIFlvdSBzaG91
bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNl
CisgKiBhbG9uZyB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCB3cml0ZSB0aGUgRnJlZSBTb2Z0
d2FyZQorICogRm91bmRhdGlvbiwgSW5jLiwgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9v
ciwgQm9zdG9uLCBNQQorICogMDIxMTAtMTMwMSwgVVNBLgorICovCisjaW5jbHVkZSAidGVzdC5o
IgorI2luY2x1ZGUgInVzY3Rlc3QuaCIKKyNpbmNsdWRlICJjb25maWcuaCIKKworY2hhciAqVENJ
RCA9ICJvb20wMiI7CitpbnQgVFNUX1RPVEFMID0gMTsKK2V4dGVybiBpbnQgVHN0X2NvdW50Owor
CisjaWYgSEFWRV9OVU1BX0ggJiYgSEFWRV9MSU5VWF9NRU1QT0xJQ1lfSCAmJiBIQVZFX05VTUFJ
Rl9IIFwKKwkmJiBIQVZFX01QT0xfQ09OU1RBTlRTCisjaW5jbHVkZSA8c3lzL3R5cGVzLmg+Cisj
aW5jbHVkZSA8c3lzL3N0YXQuaD4KKyNpbmNsdWRlIDxmY250bC5oPgorI2luY2x1ZGUgPHN0ZGlv
Lmg+CisjaW5jbHVkZSA8ZXJybm8uaD4KKyNpbmNsdWRlICJsaWIvb29tLmgiCisKK3N0YXRpYyB2
b2lkIHNldHVwKHZvaWQpOworCitpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQorewor
CWNoYXIgKm1zZzsKKwlpbnQgbGMsIGZkOworCXVuc2lnbmVkIGxvbmcgbm5vZGVzID0gMTsKKwor
CW1zZyA9IHBhcnNlX29wdHMoYXJnYywgYXJndiwgTlVMTCwgTlVMTCk7CisJaWYgKG1zZyAhPSBO
VUxMKQorCQl0c3RfYnJrbShUQlJPSywgdHN0X2V4aXQsICJPUFRJT04gUEFSU0lORyBFUlJPUiAt
ICVzIiwgbXNnKTsKKworI2lmZGVmIF9faTM4Nl9fCisJdHN0X2Jya20oVENPTkYsIHRzdF9leGl0
LAorCQkidGhpcyB0ZXN0IGlzIG5vdCBkZXNpZ25lZCBmb3IgMzItYml0IHN5c3RlbS4iKTsKKyNl
bmRpZiAvKiBfX2kzODZfXyAqLworCisJbm5vZGVzID0gY291bnRfbnVtYSgpOworCWlmIChjb3Vu
dF9udW1hKCkgPT0gMSkKKwkJdHN0X2Jya20oVENPTkYsIHRzdF9leGl0LCAicmVxdWlyZWQgYSBO
VU1BIHN5c3RlbS4iKTsKKworCXNldHVwKCk7CisKKwlmb3IgKGxjID0gMDsgVEVTVF9MT09QSU5H
KGxjKTsgbGMrKykgeworCQlUc3RfY291bnQgPSAwOworCQlmZCA9IG9wZW4oU1lTRlNfT1ZFUiwg
T19XUk9OTFkpOworCQlpZiAoZmQgPT0gLTEpCisJCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNs
ZWFudXAsICJvcGVuIik7CisJCWlmICh3cml0ZShmZCwgIjEiLCAxKSAhPSAxKQorCQkJdHN0X2Jy
a20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3JpdGUiKTsKKwkJY2xvc2UoZmQpOworCisJCXRz
dF9yZXNtKFRJTkZPLCAicHJvY2VzcyBtZW1wb2xpY3kuIik7CisJCXRlc3Rvb20oMSwgMCk7CisK
KwkJdHN0X3Jlc20oVElORk8sICJwcm9jZXNzIGNwdXNldC4iKTsKKwkJdGVzdG9vbSgwLCAwKTsK
Kwl9CisJY2xlYW51cCgpOworfQorCit2b2lkIHNldHVwKHZvaWQpCit7CisJaW50IGZkOworCisJ
dHN0X3NpZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7CisJVEVTVF9QQVVTRTsKKworCWZk
ID0gb3BlbihTWVNGU19PVkVSLCBPX1JET05MWSk7CisJaWYgKGZkID09IC0xKQorCQl0c3RfYnJr
bShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuIik7CisJaWYgKHJlYWQoZmQsICZvdmVyY29t
bWl0LCAxKSAhPSAxKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJyZWFkIik7
CisJY2xvc2UoZmQpOworCisJbW91bnRfbWVtKCJjcHVzZXQiLCAiY3B1c2V0IiwgTlVMTCwgQ1BB
VEgsIENQQVRIX05FVyk7Cit9CisKK3ZvaWQgY2xlYW51cCh2b2lkKQoreworCWludCBmZDsKKwor
CWZkID0gb3BlbihTWVNGU19PVkVSLCBPX1dST05MWSk7CisJaWYgKGZkID09IC0xKQorCQl0c3Rf
YnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJvcGVuIik7CisJaWYgKHdyaXRlKGZkLCAmb3Zl
cmNvbW1pdCwgMSkgIT0gMSkKKwkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAid3Jp
dGUiKTsKKwljbG9zZShmZCk7CisKKwl1bW91bnRfbWVtKENQQVRILCBDUEFUSF9ORVcpOworCisJ
VEVTVF9DTEVBTlVQOworCXRzdF9leGl0KCk7Cit9CisKKyNlbHNlIC8qIG5vIE5VTUEgKi8KK2lu
dCBtYWluKHZvaWQpCit7CisJdHN0X3Jlc20oVENPTkYsICJubyBOVU1BIGRldmVsb3BtZW50IHBh
Y2thZ2VzIGluc3RhbGxlZC4iKTsKKwl0c3RfZXhpdCgpOworfQorI2VuZGlmCi0tIAoxLjcuMy4y
Cgo=
------=_Part_85168_1017724871.1293424928222
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
------=_Part_85168_1017724871.1293424928222
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_85168_1017724871.1293424928222--

