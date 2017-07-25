From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 25 Jul 2017 10:36:57 +0200
Subject: [LTP] [PATCH] Add test for CVE-2017-7308 on a raw socket's ring
	buffer
Message-ID: <20170725083657.3581-1-rpalethorpe@suse.com>
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
 configure.ac                  |   3 ++
 m4/ltp-tpacket-v3.m4          |  22 +++++++++
 runtest/cve                   |   1 +
 testcases/cve/.gitignore      |   1 +
 testcases/cve/cve-2017-7308.c | 107 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 134 insertions(+)
 create mode 100644 m4/ltp-tpacket-v3.m4
 create mode 100644 testcases/cve/cve-2017-7308.c

diff --git a/configure.ac b/configure.ac
index 658003972..22b884078 100644
--- a/configure.ac
+++ b/configure.ac
@@ -38,6 +38,8 @@ AC_CHECK_HEADERS([ \
     pthread.h \
     sys/xattr.h \
     linux/genetlink.h \
+    linux/if_packet.h \
+    linux/if_ether.h \
     linux/mempolicy.h \
     linux/module.h \
     linux/netlink.h \
@@ -194,5 +196,6 @@ LTP_CHECK_SYNC_ADD_AND_FETCH
 LTP_CHECK_BUILTIN_CLEAR_CACHE
 LTP_CHECK_MMSGHDR
 LTP_CHECK_UNAME_DOMAINNAME
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
index ee0614a9c..24062cfa6 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -6,3 +6,4 @@ cve-2016-5195 dirtyc0w
 cve-2016-7117 cve-2016-7117
 cve-2017-5669 cve-2017-5669
 cve-2017-6951 cve-2017-6951
+cve-2017-7308 cve-2017-7308
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index bdb73f33b..eb2e0af5f 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -4,3 +4,4 @@ cve-2016-4997
 cve-2016-7117
 cve-2017-6951
 cve-2017-5669
+cve-2017-7308
diff --git a/testcases/cve/cve-2017-7308.c b/testcases/cve/cve-2017-7308.c
new file mode 100644
index 000000000..31df97d2a
--- /dev/null
+++ b/testcases/cve/cve-2017-7308.c
@@ -0,0 +1,107 @@
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
+ * this will cause an integer arithmatic overflow and the absurd
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
+static void run(void)
+{
+	int sk[2], i, ver = TPACKET_V3;
+	struct tpacket_req3 req = {};
+
+	req.tp_block_size = 4096;
+	req.tp_block_nr = 2;
+	req.tp_frame_size = req.tp_block_size;
+	req.tp_frame_nr = req.tp_block_nr;
+	req.tp_retire_blk_tov = 100;
+	req.tp_sizeof_priv = 1024;
+
+	for (i = 0; i < 2; i++) {
+		sk[i] = SAFE_SOCKET(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+		SAFE_SETSOCKOPT(sk[i], SOL_PACKET, PACKET_VERSION,
+				&ver, sizeof(ver));
+	}
+
+	TEST(setsockopt(sk[0], SOL_PACKET, PACKET_RX_RING, &req, sizeof(req)));
+	if (TEST_RETURN)
+		tst_brk(TBROK | TTERRNO,
+			"Can't create ring buffer with good settings");
+
+	req.tp_sizeof_priv += (3U << 30);
+	TEST(setsockopt(sk[1], SOL_PACKET, PACKET_RX_RING, &req, sizeof(req)));
+	if (TEST_RETURN && TEST_ERRNO == EINVAL)
+		tst_res(TPASS | TTERRNO, "Refused bad tp_sizeof_priv value");
+	else if (TEST_RETURN)
+		tst_brk(TBROK | TTERRNO, "Unexpected setsockopt() error");
+	else
+		tst_res(TFAIL, "Allowed bad tp_sizeof_priv value");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.needs_root = 1,
+};
-- 
2.13.3

