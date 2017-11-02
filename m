From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu,  2 Nov 2017 14:39:43 +0100
Subject: [LTP] [PATCH v7] Add test for CVE-2017-7308 on a raw socket's ring
	buffer
Message-ID: <20171102133943.22297-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test uses a Linux only interface which has not been fully integrated into
glibc and it is not clear if it ever will be. So I have kept the fallback
logic relatively simple and use only the Linux headers if they are present or
just define what is needed in the test.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 configure.ac                                       |   3 +
 m4/ltp-tpacket-v3.m4                               |  22 ++++
 runtest/cve                                        |   3 +-
 runtest/syscalls                                   |   2 +-
 testcases/kernel/syscalls/.gitignore               |   1 +
 .../kernel/syscalls/setsockopt/setsockopt02.c      | 145 +++++++++++++++++++++
 6 files changed, 174 insertions(+), 2 deletions(-)
 create mode 100644 m4/ltp-tpacket-v3.m4
 create mode 100644 testcases/kernel/syscalls/setsockopt/setsockopt02.c

diff --git a/configure.ac b/configure.ac
index 5f1cd3bfb..ffcbf57c5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -36,6 +36,8 @@ AC_CHECK_HEADERS([ \
     linux/can.h \
     linux/genetlink.h \
     linux/keyctl.h \
+    linux/if_packet.h \
+    linux/if_ether.h \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
@@ -199,5 +201,6 @@ LTP_CHECK_MMSGHDR
 LTP_CHECK_UNAME_DOMAINNAME
 LTP_CHECK_X_TABLES
 LTP_CHECK_ATOMIC_MEMORY_MODEL
+LTP_CHECK_TPACKET_V3
 
 AC_OUTPUT
diff --git a/m4/ltp-tpacket-v3.m4 b/m4/ltp-tpacket-v3.m4
new file mode 100644
index 000000000..fce2e0ebf
--- /dev/null
+++ b/m4/ltp-tpacket-v3.m4
@@ -0,0 +1,22 @@
+dnl Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+dnl You should have received a copy of the GNU General Public License
+dnl along with this program. If not, see <http://www.gnu.org/licenses/>.
+
+AC_DEFUN([LTP_CHECK_TPACKET_V3],[
+AC_CHECK_TYPES([struct tpacket_req3],,,[
+#ifdef HAVE_LINUX_IF_PACKET_H
+# include <linux/if_packet.h>
+#endif
+])
+])
diff --git a/runtest/cve b/runtest/cve
index bea7b3b5b..766e6fb8e 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -13,10 +13,11 @@ cve-2016-7042 cve-2016-7042
 cve-2016-7117 cve-2016-7117
 cve-2016-9604 keyctl08
 cve-2016-10044 cve-2016-10044
-cve-2017-2618 cve-2017-2618
+cve-2017-2618 setsockopt02
 cve-2017-2671 cve-2017-2671
 cve-2017-5669 cve-2017-5669
 cve-2017-6951 cve-2017-6951
+cve-2017-7308 cve-2017-7308
 cve-2017-7472 keyctl04
 cve-2017-12192 keyctl07
 cve-2017-15274 add_key02
diff --git a/runtest/syscalls b/runtest/syscalls
index 5688aebae..ed30c0f86 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1159,7 +1159,7 @@ set_tid_address01 set_tid_address01
 setsid01 setsid01
 
 setsockopt01 setsockopt01
-cve-2016-4997 cve-2016-4997
+setsockopt02 setsockopt02
 
 settimeofday01 settimeofday01
 settimeofday02 settimeofday02
diff --git a/testcases/kernel/syscalls/.gitignore b/testcases/kernel/syscalls/.gitignore
index e725c804d..0ba38465f 100644
--- a/testcases/kernel/syscalls/.gitignore
+++ b/testcases/kernel/syscalls/.gitignore
@@ -940,6 +940,7 @@
 /setrlimit/setrlimit05
 /setsid/setsid01
 /setsockopt/setsockopt01
+/setsockopt/setsockopt02
 /settimeofday/settimeofday01
 /settimeofday/settimeofday02
 /setuid/setuid01
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt02.c b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
new file mode 100644
index 000000000..22dc43ade
--- /dev/null
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt02.c
@@ -0,0 +1,145 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+/* Test for CVE-2017-7308 on a raw socket's ring buffer
+ *
+ * Try to set tpacket_req3.tp_sizeof_priv to a value with the high bit set. So
+ * that tp_block_size < tp_sizeof_priv. If the vulnerability is present then
+ * this will cause an integer arithmetic overflow and the absurd
+ * tp_sizeof_priv value will be allowed. If it has been fixed then setsockopt
+ * will fail with EINVAL.
+ *
+ * We also try a good configuration to make sure it is not failing with EINVAL
+ * for some other reason.
+ *
+ * For a better and more interesting discussion of this CVE see:
+ * https://googleprojectzero.blogspot.com/2017/05/exploiting-linux-kernel-via-packet.html
+ */
+
+#include <errno.h>
+#include "tst_test.h"
+#include "tst_safe_net.h"
+#include "config.h"
+
+#ifdef HAVE_LINUX_IF_PACKET_H
+# include <linux/if_packet.h>
+#endif
+
+#ifdef HAVE_LINUX_IF_ETHER_H
+# include <linux/if_ether.h>
+#endif
+
+#ifndef ETH_P_ALL
+# define ETH_P_ALL 0x0003
+#endif
+
+#ifndef PACKET_RX_RING
+# define PACKET_RX_RING 5
+#endif
+
+#ifndef PACKET_VERSION
+# define PACKET_VERSION 10
+#endif
+
+#ifndef HAVE_STRUCT_TPACKET_REQ3
+# define TPACKET_V3 2
+
+struct tpacket_req3 {
+	unsigned int	tp_block_size;
+	unsigned int	tp_block_nr;
+	unsigned int	tp_frame_size;
+	unsigned int	tp_frame_nr;
+	unsigned int	tp_retire_blk_tov;
+	unsigned int	tp_sizeof_priv;
+	unsigned int	tp_feature_req_word;
+};
+#endif
+
+static int sk;
+static long pgsz;
+
+static void setup(void)
+{
+	pgsz = SAFE_SYSCONF(_SC_PAGESIZE);
+}
+
+static void cleanup(void)
+{
+	if (sk > 0)
+		SAFE_CLOSE(sk);
+}
+
+static int create_skbuf(unsigned int sizeof_priv)
+{
+	int ver = TPACKET_V3;
+	struct tpacket_req3 req = {};
+
+	req.tp_block_size = pgsz;
+	req.tp_block_nr = 2;
+	req.tp_frame_size = req.tp_block_size;
+	req.tp_frame_nr = req.tp_block_nr;
+	req.tp_retire_blk_tov = 100;
+
+	req.tp_sizeof_priv = sizeof_priv;
+
+	sk = SAFE_SOCKET(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	TEST(setsockopt(sk, SOL_PACKET, PACKET_VERSION, &ver, sizeof(ver)));
+	if (TEST_RETURN && TEST_ERRNO == EINVAL)
+		tst_brk(TCONF | TTERRNO, "TPACKET_V3 not supported");
+	if (TEST_RETURN)
+		tst_brk(TBROK | TTERRNO, "setsockopt(sk, SOL_PACKET, PACKET_VERSION, TPACKET_V3)");
+
+	return setsockopt(sk, SOL_PACKET, PACKET_RX_RING, &req, sizeof(req));
+}
+
+static void good_size(void)
+{
+	TEST(create_skbuf(512));
+	if (TEST_RETURN)
+		tst_brk(TBROK | TTERRNO, "Can't create ring buffer with good settings");
+
+	tst_res(TPASS, "Can create ring buffer with good settinegs");
+}
+
+static void bad_size(void)
+{
+	TEST(create_skbuf(3U << 30));
+	if (TEST_RETURN && TEST_ERRNO != EINVAL)
+		tst_brk(TBROK | TTERRNO, "Unexpected setsockopt() error");
+	if (TEST_RETURN)
+		tst_res(TPASS | TTERRNO, "Refused bad tp_sizeof_priv value");
+	else
+		tst_res(TFAIL, "Allowed bad tp_sizeof_priv value");
+}
+
+static void run(unsigned int i)
+{
+	if (i == 0)
+		good_size();
+	else
+		bad_size();
+
+	SAFE_CLOSE(sk);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = 2,
+	.needs_root = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.min_kver = "3.2",
+};
-- 
2.14.3

