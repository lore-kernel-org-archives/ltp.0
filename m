Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfT7t-0001N6-P7
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:10:45 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfT7r-0003LO-Sj
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:10:45 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0J8Ac1N015767
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Jan 2011 03:10:38 -0500
Date: Wed, 19 Jan 2011 03:10:38 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <939890281.56169.1295424638444.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1653392548.56166.1295424632735.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_56168_654637866.1295424638443"
Subject: [LTP] [PATCH] fork13: pid reuse race
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

------=_Part_56168_654637866.1295424638443
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

From the mainline commit 5fdee8c4a5e1800489ce61963208f8cc55e42ea1:

A program that repeatedly forks and waits is susceptible to having the
same pid repeated, especially when it competes with another instance of
the same program.  This is really bad for bash implementation.
Furthermore, many shell scripts assume that pid numbers will not be used
for some length of time.

Race Description:

A                                B

// pid == offset == n            // pid == offset == n + 1
test_and_set_bit(offset, map->page)
                                 test_and_set_bit(offset, map->page);
                                 pid_ns->last_pid = pid;
pid_ns->last_pid = pid;
                                 // pid == n + 1 is freed (wait())

                                 // Next fork()...
                                 last = pid_ns->last_pid; // == n
                                 pid = last + 1;

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 runtest/syscalls                        |    1 +
 testcases/kernel/syscalls/fork/fork13.c |  179 +++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fork/fork13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 7683e39..bd7043e 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -274,6 +274,7 @@ fork08 fork08
 fork09 fork09
 fork10 fork10
 fork11 fork11
+fork13 fork13 -c 2 -i 10000000
 
 fpathconf01 fpathconf01
 
diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
new file mode 100644
index 0000000..7c72352
--- /dev/null
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -0,0 +1,179 @@
+/*
+ * a race in pid generation that causes pids to be reused immediately
+ *
+ * From the mainline commit 5fdee8c4a5e1800489ce61963208f8cc55e42ea1:
+ * 
+ * A program that repeatedly forks and waits is susceptible to having
+ * the same pid repeated, especially when it competes with another
+ * instance of the same program.  This is really bad for bash
+ * implementation.  Furthermore, many shell scripts assume that pid
+ * numbers will not be used for some length of time.
+ * 
+ * Race Description:
+ *
+ * A                                B
+ *
+ * // pid == offset == n            // pid == offset == n + 1
+ * test_and_set_bit(offset, map->page)
+ *                                  test_and_set_bit(offset, map->page);
+ *                                  pid_ns->last_pid = pid;
+ * pid_ns->last_pid = pid;
+ *                                  // pid == n + 1 is freed (wait())
+ *
+ *                                  // Next fork()...
+ *                                  last = pid_ns->last_pid; // == n
+ *                                  pid = last + 1;
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
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "fork13";
+int TST_TOTAL = 1;
+
+static char pid_max[BUFSIZ];
+
+#define PATH	"/proc/sys/kernel/pid_max"
+#define PIDMAX	32768
+#define RETURN	256
+
+static void setup(void);
+static int pid_distance(pid_t first, pid_t second);
+static void cleanup(void);
+static void check(void);
+
+int main(int argc, char* argv[])
+{
+	/* message returned from parse_opts */
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	check();
+	cleanup();
+	tst_exit();
+}
+
+void check(void)
+{
+	int lc;
+	pid_t last_pid = 0;
+	pid_t pid;
+	int child_exit_code, distance, reaped, status;
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		if (lc % PIDMAX == 0)
+			tst_resm(TINFO, "Iter: %d", lc/PIDMAX);
+		child_exit_code = lc % RETURN;
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		case 0:
+			exit(child_exit_code);
+		default:
+			if (lc > 0) {
+				tst_resm(TINFO, "last_pid = %d pid = %d",
+					last_pid, pid);
+				distance = pid_distance(last_pid, pid);
+				if (distance == 0)
+					tst_resm(TFAIL,
+						"Unexpected pid sequence: "
+						"previous fork: pid=%d, "
+						"current fork: pid=%d for "
+						"iteration=%d.", last_pid, pid,
+						lc);
+			}
+			last_pid = pid;
+
+			reaped = wait(&status);
+			if (reaped != pid)
+				tst_resm(TFAIL,
+					"Wait return value: expected pid=%d, "
+					"got %d, iteration %d.", pid, reaped,
+					lc);
+			else if (WEXITSTATUS(status) != child_exit_code)
+				tst_resm(TFAIL, "Unexpected exit status %x, "
+					"iteration %d.", WEXITSTATUS(status),
+					lc);
+		}
+	}
+}
+
+void setup(void)
+{
+	FILE *fp;
+	int fd;
+	char buf[BUFSIZ];
+
+	tst_require_root(NULL);
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	/* Backup pid_max value. */
+	fp = fopen(PATH, "r+");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(pid_max, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	fclose(fp);
+
+	fd = open(PATH, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TBROK|TERRNO, "open");
+	sprintf(buf, "%d", PIDMAX);
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_resm(TBROK|TERRNO, "write");
+	close(fd);
+}
+
+void cleanup(void)
+{
+	int fd;
+
+	fd = open(PATH, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open");
+	if (write(fd, pid_max, strlen(pid_max)) != strlen(pid_max))
+		tst_resm(TWARN|TERRNO, "write");
+	close(fd);
+
+	TEST_CLEANUP;
+}
+
+/* The distance mod 32768 between two pids, where the first pid is
+   expected to be smaller than the second. */
+int pid_distance(pid_t first, pid_t second)
+{
+	return (second + 32768 - first) % 32768;
+}
-- 
1.7.3.2
------=_Part_56168_654637866.1295424638443
Content-Type: text/x-patch; name=0001-fork13-pid-reuse-race.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-fork13-pid-reuse-race.patch

RnJvbSA1ZDdlMGU1YTQyM2RmM2MzMGQ1ZjVlODM5NWJhZGNkNWI5ODliMmNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBX
ZWQsIDE5IEphbiAyMDExIDE1OjQxOjAxICswODAwClN1YmplY3Q6IFtQQVRDSF0gZm9yazEzOiBw
aWQgcmV1c2UgcmFjZQoKRnJvbSB0aGUgbWFpbmxpbmUgY29tbWl0IDVmZGVlOGM0YTVlMTgwMDQ4
OWNlNjE5NjMyMDhmOGNjNTVlNDJlYTE6CgpBIHByb2dyYW0gdGhhdCByZXBlYXRlZGx5IGZvcmtz
IGFuZCB3YWl0cyBpcyBzdXNjZXB0aWJsZSB0byBoYXZpbmcgdGhlCnNhbWUgcGlkIHJlcGVhdGVk
LCBlc3BlY2lhbGx5IHdoZW4gaXQgY29tcGV0ZXMgd2l0aCBhbm90aGVyIGluc3RhbmNlIG9mCnRo
ZSBzYW1lIHByb2dyYW0uICBUaGlzIGlzIHJlYWxseSBiYWQgZm9yIGJhc2ggaW1wbGVtZW50YXRp
b24uCkZ1cnRoZXJtb3JlLCBtYW55IHNoZWxsIHNjcmlwdHMgYXNzdW1lIHRoYXQgcGlkIG51bWJl
cnMgd2lsbCBub3QgYmUgdXNlZApmb3Igc29tZSBsZW5ndGggb2YgdGltZS4KClJhY2UgRGVzY3Jp
cHRpb246CgpBICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBCCgovLyBwaWQgPT0gb2Zm
c2V0ID09IG4gICAgICAgICAgICAvLyBwaWQgPT0gb2Zmc2V0ID09IG4gKyAxCnRlc3RfYW5kX3Nl
dF9iaXQob2Zmc2V0LCBtYXAtPnBhZ2UpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHRlc3RfYW5kX3NldF9iaXQob2Zmc2V0LCBtYXAtPnBhZ2UpOwogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBwaWRfbnMtPmxhc3RfcGlkID0gcGlkOwpwaWRfbnMtPmxhc3RfcGlkID0g
cGlkOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyBwaWQgPT0gbiArIDEgaXMg
ZnJlZWQgKHdhaXQoKSkKCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8vIE5leHQg
Zm9yaygpLi4uCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxhc3QgPSBwaWRfbnMt
Pmxhc3RfcGlkOyAvLyA9PSBuCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBpZCA9
IGxhc3QgKyAxOwoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0LmNvbT4K
LS0tCiBydW50ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAxICsKIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMTMuYyB8ICAxNzkgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxODAgaW5zZXJ0aW9ucygrKSwg
MCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2ZvcmsvZm9yazEzLmMKCmRpZmYgLS1naXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIvcnVudGVz
dC9zeXNjYWxscwppbmRleCA3NjgzZTM5Li5iZDcwNDNlIDEwMDY0NAotLS0gYS9ydW50ZXN0L3N5
c2NhbGxzCisrKyBiL3J1bnRlc3Qvc3lzY2FsbHMKQEAgLTI3NCw2ICsyNzQsNyBAQCBmb3JrMDgg
Zm9yazA4CiBmb3JrMDkgZm9yazA5CiBmb3JrMTAgZm9yazEwCiBmb3JrMTEgZm9yazExCitmb3Jr
MTMgZm9yazEzIC1jIDIgLWkgMTAwMDAwMDAKIAogZnBhdGhjb25mMDEgZnBhdGhjb25mMDEKIApk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmsxMy5jIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmsxMy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAuLjdjNzIzNTIKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2ZvcmsvZm9yazEzLmMKQEAgLTAsMCArMSwxNzkgQEAKKy8qCisgKiBhIHJh
Y2UgaW4gcGlkIGdlbmVyYXRpb24gdGhhdCBjYXVzZXMgcGlkcyB0byBiZSByZXVzZWQgaW1tZWRp
YXRlbHkKKyAqCisgKiBGcm9tIHRoZSBtYWlubGluZSBjb21taXQgNWZkZWU4YzRhNWUxODAwNDg5
Y2U2MTk2MzIwOGY4Y2M1NWU0MmVhMToKKyAqIAorICogQSBwcm9ncmFtIHRoYXQgcmVwZWF0ZWRs
eSBmb3JrcyBhbmQgd2FpdHMgaXMgc3VzY2VwdGlibGUgdG8gaGF2aW5nCisgKiB0aGUgc2FtZSBw
aWQgcmVwZWF0ZWQsIGVzcGVjaWFsbHkgd2hlbiBpdCBjb21wZXRlcyB3aXRoIGFub3RoZXIKKyAq
IGluc3RhbmNlIG9mIHRoZSBzYW1lIHByb2dyYW0uICBUaGlzIGlzIHJlYWxseSBiYWQgZm9yIGJh
c2gKKyAqIGltcGxlbWVudGF0aW9uLiAgRnVydGhlcm1vcmUsIG1hbnkgc2hlbGwgc2NyaXB0cyBh
c3N1bWUgdGhhdCBwaWQKKyAqIG51bWJlcnMgd2lsbCBub3QgYmUgdXNlZCBmb3Igc29tZSBsZW5n
dGggb2YgdGltZS4KKyAqIAorICogUmFjZSBEZXNjcmlwdGlvbjoKKyAqCisgKiBBICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBCCisgKgorICogLy8gcGlkID09IG9mZnNldCA9PSBuICAg
ICAgICAgICAgLy8gcGlkID09IG9mZnNldCA9PSBuICsgMQorICogdGVzdF9hbmRfc2V0X2JpdChv
ZmZzZXQsIG1hcC0+cGFnZSkKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRl
c3RfYW5kX3NldF9iaXQob2Zmc2V0LCBtYXAtPnBhZ2UpOworICogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcGlkX25zLT5sYXN0X3BpZCA9IHBpZDsKKyAqIHBpZF9ucy0+bGFzdF9w
aWQgPSBwaWQ7CisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAvLyBwaWQgPT0g
biArIDEgaXMgZnJlZWQgKHdhaXQoKSkKKyAqCisgKiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAvLyBOZXh0IGZvcmsoKS4uLgorICogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgbGFzdCA9IHBpZF9ucy0+bGFzdF9waWQ7IC8vID09IG4KKyAqICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHBpZCA9IGxhc3QgKyAxOworICoKKyAqIENvcHlyaWdodCAoQykg
MjAxMCAgUmVkIEhhdCwgSW5jLgorICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlv
dSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vcgorICogbW9kaWZ5IGl0IHVuZGVyIHRoZSB0ZXJt
cyBvZiB2ZXJzaW9uIDIgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYworICogTGljZW5zZSBhcyBw
dWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyAqCisgKiBUaGlzIHBy
b2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3b3VsZCBiZSB1c2VmdWws
CisgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3
YXJyYW50eSBvZgorICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxB
UiBQVVJQT1NFLgorICoKKyAqIEZ1cnRoZXIsIHRoaXMgc29mdHdhcmUgaXMgZGlzdHJpYnV0ZWQg
d2l0aG91dCBhbnkgd2FycmFudHkgdGhhdCBpdAorICogaXMgZnJlZSBvZiB0aGUgcmlnaHRmdWwg
Y2xhaW0gb2YgYW55IHRoaXJkIHBlcnNvbiByZWdhcmRpbmcKKyAqIGluZnJpbmdlbWVudCBvciB0
aGUgbGlrZS4gIEFueSBsaWNlbnNlIHByb3ZpZGVkIGhlcmVpbiwgd2hldGhlcgorICogaW1wbGll
ZCBvciBvdGhlcndpc2UsIGFwcGxpZXMgb25seSB0byB0aGlzIHNvZnR3YXJlIGZpbGUuICBQYXRl
bnQKKyAqIGxpY2Vuc2VzLCBpZiBhbnksIHByb3ZpZGVkIGhlcmVpbiBkbyBub3QgYXBwbHkgdG8g
Y29tYmluYXRpb25zIG9mCisgKiB0aGlzIHByb2dyYW0gd2l0aCBvdGhlciBzb2Z0d2FyZSwgb3Ig
YW55IG90aGVyIHByb2R1Y3Qgd2hhdHNvZXZlci4KKyAqCisgKiBZb3Ugc2hvdWxkIGhhdmUgcmVj
ZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQorICogYWxvbmcg
d2l0aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdGhlIEZyZWUgU29mdHdhcmUKKyAqIEZv
dW5kYXRpb24sIEluYy4sIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3Rvbiwg
TUEKKyAqIDAyMTEwLTEzMDEsIFVTQS4KKyAqLworI2luY2x1ZGUgPHN5cy90eXBlcy5oPgorI2lu
Y2x1ZGUgPHN5cy9zdGF0Lmg+CisjaW5jbHVkZSA8c3lzL3dhaXQuaD4KKyNpbmNsdWRlIDxmY250
bC5oPgorI2luY2x1ZGUgPGVycm5vLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8
c3RkaW8uaD4KKyNpbmNsdWRlIDxzdGRsaWIuaD4KKyNpbmNsdWRlICJ0ZXN0LmgiCisjaW5jbHVk
ZSAidXNjdGVzdC5oIgorCitjaGFyICpUQ0lEID0gImZvcmsxMyI7CitpbnQgVFNUX1RPVEFMID0g
MTsKKworc3RhdGljIGNoYXIgcGlkX21heFtCVUZTSVpdOworCisjZGVmaW5lIFBBVEgJIi9wcm9j
L3N5cy9rZXJuZWwvcGlkX21heCIKKyNkZWZpbmUgUElETUFYCTMyNzY4CisjZGVmaW5lIFJFVFVS
TgkyNTYKKworc3RhdGljIHZvaWQgc2V0dXAodm9pZCk7CitzdGF0aWMgaW50IHBpZF9kaXN0YW5j
ZShwaWRfdCBmaXJzdCwgcGlkX3Qgc2Vjb25kKTsKK3N0YXRpYyB2b2lkIGNsZWFudXAodm9pZCk7
CitzdGF0aWMgdm9pZCBjaGVjayh2b2lkKTsKKworaW50IG1haW4oaW50IGFyZ2MsIGNoYXIqIGFy
Z3ZbXSkKK3sKKwkvKiBtZXNzYWdlIHJldHVybmVkIGZyb20gcGFyc2Vfb3B0cyAqLworCWNoYXIg
Km1zZzsKKworCW1zZyA9IHBhcnNlX29wdHMoYXJnYywgYXJndiwgTlVMTCwgTlVMTCk7CisJaWYg
KG1zZyAhPSBOVUxMKQorCQl0c3RfYnJrbShUQlJPSywgTlVMTCwgIk9QVElPTiBQQVJTSU5HIEVS
Uk9SIC0gJXMiLCBtc2cpOworCXNldHVwKCk7CisJY2hlY2soKTsKKwljbGVhbnVwKCk7CisJdHN0
X2V4aXQoKTsKK30KKwordm9pZCBjaGVjayh2b2lkKQoreworCWludCBsYzsKKwlwaWRfdCBsYXN0
X3BpZCA9IDA7CisJcGlkX3QgcGlkOworCWludCBjaGlsZF9leGl0X2NvZGUsIGRpc3RhbmNlLCBy
ZWFwZWQsIHN0YXR1czsKKworCWZvciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMpOyBsYysrKSB7
CisJCVRzdF9jb3VudCA9IDA7CisJCWlmIChsYyAlIFBJRE1BWCA9PSAwKQorCQkJdHN0X3Jlc20o
VElORk8sICJJdGVyOiAlZCIsIGxjL1BJRE1BWCk7CisJCWNoaWxkX2V4aXRfY29kZSA9IGxjICUg
UkVUVVJOOworCQlzd2l0Y2ggKHBpZCA9IGZvcmsoKSkgeworCQljYXNlIC0xOgorCQkJdHN0X2Jy
a20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAiZm9yayIpOworCQljYXNlIDA6CisJCQlleGl0KGNo
aWxkX2V4aXRfY29kZSk7CisJCWRlZmF1bHQ6CisJCQlpZiAobGMgPiAwKSB7CisJCQkJdHN0X3Jl
c20oVElORk8sICJsYXN0X3BpZCA9ICVkIHBpZCA9ICVkIiwKKwkJCQkJbGFzdF9waWQsIHBpZCk7
CisJCQkJZGlzdGFuY2UgPSBwaWRfZGlzdGFuY2UobGFzdF9waWQsIHBpZCk7CisJCQkJaWYgKGRp
c3RhbmNlID09IDApCisJCQkJCXRzdF9yZXNtKFRGQUlMLAorCQkJCQkJIlVuZXhwZWN0ZWQgcGlk
IHNlcXVlbmNlOiAiCisJCQkJCQkicHJldmlvdXMgZm9yazogcGlkPSVkLCAiCisJCQkJCQkiY3Vy
cmVudCBmb3JrOiBwaWQ9JWQgZm9yICIKKwkJCQkJCSJpdGVyYXRpb249JWQuIiwgbGFzdF9waWQs
IHBpZCwKKwkJCQkJCWxjKTsKKwkJCX0KKwkJCWxhc3RfcGlkID0gcGlkOworCisJCQlyZWFwZWQg
PSB3YWl0KCZzdGF0dXMpOworCQkJaWYgKHJlYXBlZCAhPSBwaWQpCisJCQkJdHN0X3Jlc20oVEZB
SUwsCisJCQkJCSJXYWl0IHJldHVybiB2YWx1ZTogZXhwZWN0ZWQgcGlkPSVkLCAiCisJCQkJCSJn
b3QgJWQsIGl0ZXJhdGlvbiAlZC4iLCBwaWQsIHJlYXBlZCwKKwkJCQkJbGMpOworCQkJZWxzZSBp
ZiAoV0VYSVRTVEFUVVMoc3RhdHVzKSAhPSBjaGlsZF9leGl0X2NvZGUpCisJCQkJdHN0X3Jlc20o
VEZBSUwsICJVbmV4cGVjdGVkIGV4aXQgc3RhdHVzICV4LCAiCisJCQkJCSJpdGVyYXRpb24gJWQu
IiwgV0VYSVRTVEFUVVMoc3RhdHVzKSwKKwkJCQkJbGMpOworCQl9CisJfQorfQorCit2b2lkIHNl
dHVwKHZvaWQpCit7CisJRklMRSAqZnA7CisJaW50IGZkOworCWNoYXIgYnVmW0JVRlNJWl07CisK
Kwl0c3RfcmVxdWlyZV9yb290KE5VTEwpOworCisJdHN0X3NpZyhGT1JLLCBERUZfSEFORExFUiwg
Y2xlYW51cCk7CisJVEVTVF9QQVVTRTsKKwkvKiBCYWNrdXAgcGlkX21heCB2YWx1ZS4gKi8KKwlm
cCA9IGZvcGVuKFBBVEgsICJyKyIpOworCWlmIChmcCA9PSBOVUxMKQorCQl0c3RfYnJrbShUQlJP
S3xURVJSTk8sIGNsZWFudXAsICJmb3BlbiIpOworCWlmIChmZ2V0cyhwaWRfbWF4LCBCVUZTSVos
IGZwKSA9PSBOVUxMKQorCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJmZ2V0cyIp
OworCWZjbG9zZShmcCk7CisKKwlmZCA9IG9wZW4oUEFUSCwgT19XUk9OTFkpOworCWlmIChmZCA9
PSAtMSkKKwkJdHN0X3Jlc20oVEJST0t8VEVSUk5PLCAib3BlbiIpOworCXNwcmludGYoYnVmLCAi
JWQiLCBQSURNQVgpOworCWlmICh3cml0ZShmZCwgYnVmLCBzdHJsZW4oYnVmKSkgIT0gc3RybGVu
KGJ1ZikpCisJCXRzdF9yZXNtKFRCUk9LfFRFUlJOTywgIndyaXRlIik7CisJY2xvc2UoZmQpOwor
fQorCit2b2lkIGNsZWFudXAodm9pZCkKK3sKKwlpbnQgZmQ7CisKKwlmZCA9IG9wZW4oUEFUSCwg
T19XUk9OTFkpOworCWlmIChmZCA9PSAtMSkKKwkJdHN0X3Jlc20oVFdBUk58VEVSUk5PLCAib3Bl
biIpOworCWlmICh3cml0ZShmZCwgcGlkX21heCwgc3RybGVuKHBpZF9tYXgpKSAhPSBzdHJsZW4o
cGlkX21heCkpCisJCXRzdF9yZXNtKFRXQVJOfFRFUlJOTywgIndyaXRlIik7CisJY2xvc2UoZmQp
OworCisJVEVTVF9DTEVBTlVQOworfQorCisvKiBUaGUgZGlzdGFuY2UgbW9kIDMyNzY4IGJldHdl
ZW4gdHdvIHBpZHMsIHdoZXJlIHRoZSBmaXJzdCBwaWQgaXMKKyAgIGV4cGVjdGVkIHRvIGJlIHNt
YWxsZXIgdGhhbiB0aGUgc2Vjb25kLiAqLworaW50IHBpZF9kaXN0YW5jZShwaWRfdCBmaXJzdCwg
cGlkX3Qgc2Vjb25kKQoreworCXJldHVybiAoc2Vjb25kICsgMzI3NjggLSBmaXJzdCkgJSAzMjc2
ODsKK30KLS0gCjEuNy4zLjIKCg==
------=_Part_56168_654637866.1295424638443
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
------=_Part_56168_654637866.1295424638443
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_56168_654637866.1295424638443--

