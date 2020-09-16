From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 16 Sep 2020 17:23:45 +0200
Subject: [LTP] [PATCH] Add test for CVE 2020-14386
Message-ID: <20200916152345.10835-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #724

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

I'd like to include this test int the upcoming release if possible.

Tested on kernel v4.4, v4.12 and v5.3 both with and without fixes.

 runtest/cve                                 |   1 +
 runtest/syscalls                            |   1 +
 testcases/kernel/syscalls/sendto/.gitignore |   1 +
 testcases/kernel/syscalls/sendto/sendto03.c | 224 ++++++++++++++++++++
 4 files changed, 227 insertions(+)
 create mode 100644 testcases/kernel/syscalls/sendto/sendto03.c

diff --git a/runtest/cve b/runtest/cve
index 07c69e8ff..0bb1983bc 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -58,4 +58,5 @@ cve-2018-18559 bind06
 cve-2018-19854 crypto_user01
 cve-2019-8912 af_alg07
 cve-2020-11494 pty04
+cve-2020-14386 sendto03
 cve-2020-14416 pty03
diff --git a/runtest/syscalls b/runtest/syscalls
index ef1a1ba0b..91e6d55ca 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1206,6 +1206,7 @@ sendmmsg01 sendmmsg01
 
 sendto01 sendto01
 sendto02 sendto02
+sendto03 sendto03
 
 set_mempolicy01 set_mempolicy01
 set_mempolicy02 set_mempolicy02
diff --git a/testcases/kernel/syscalls/sendto/.gitignore b/testcases/kernel/syscalls/sendto/.gitignore
index 8d2bb6b5f..5fd24dfe6 100644
--- a/testcases/kernel/syscalls/sendto/.gitignore
+++ b/testcases/kernel/syscalls/sendto/.gitignore
@@ -1,2 +1,3 @@
 /sendto01
 /sendto02
+/sendto03
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
new file mode 100644
index 000000000..a6332ec52
--- /dev/null
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*
+ * CVE-2020-14386
+ *
+ * Check for vulnerability in tpacket_rcv() which allows an unprivileged user
+ * to write arbitrary data to a memory area outside the allocated packet
+ * buffer. Kernel crash fixed in:
+ *
+ *  commit acf69c946233259ab4d64f8869d4037a198c7f06
+ *  Author: Or Cohen <orcohen@paloaltonetworks.com>
+ *  Date:   Thu Sep 3 21:05:28 2020 -0700
+ *
+ *  net/packet: fix overflow in tpacket_rcv
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <limits.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <linux/if_packet.h>
+#include <net/if.h>
+#include <net/ethernet.h>
+#include <sched.h>
+
+#include "tst_test.h"
+#include "tst_net.h"
+
+#define BUFSIZE 1024
+
+static int dst_sock = -1, sock = -1;
+static unsigned char buf[BUFSIZE];
+static struct sockaddr_ll bind_addr, addr;
+
+static void setup(void)
+{
+	int real_uid = getuid();
+	int real_gid = getgid();
+	struct ifreq ifr;
+
+	SAFE_UNSHARE(CLONE_NEWUSER);
+	SAFE_UNSHARE(CLONE_NEWNET);
+	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
+	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
+	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
+
+	sock = SAFE_SOCKET(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	strcpy(ifr.ifr_name, "lo");
+	ifr.ifr_flags = IFF_UP;
+	SAFE_IOCTL(sock, SIOCSIFFLAGS, &ifr);
+	SAFE_IOCTL(sock, SIOCGIFINDEX, &ifr);
+	SAFE_CLOSE(sock);
+
+	memset(buf, 0x42, BUFSIZE);
+
+	bind_addr.sll_family = AF_PACKET;
+	bind_addr.sll_protocol = htons(ETH_P_ALL);
+	bind_addr.sll_ifindex = ifr.ifr_ifindex;
+
+	addr.sll_family = AF_PACKET;
+	addr.sll_ifindex = ifr.ifr_ifindex;
+	addr.sll_halen = ETH_ALEN;
+}
+
+/* Test for commit bcc5364bdcfe (cap PACKET_RESERVE to INT_MAX) */
+static int check_tiny_frame(void)
+{
+	unsigned int val = (UINT_MAX - TPACKET2_HDRLEN) + 1;
+	struct tpacket_req tpreq;
+
+	tpreq.tp_block_size = SAFE_SYSCONF(_SC_PAGESIZE);
+	tpreq.tp_frame_size = TPACKET_ALIGNMENT;
+	tpreq.tp_block_nr = 1;
+	tpreq.tp_frame_nr = (tpreq.tp_block_size * tpreq.tp_block_nr) /
+		tpreq.tp_frame_size;
+
+	dst_sock = SAFE_SOCKET(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	SAFE_SETSOCKOPT_INT(dst_sock, SOL_PACKET, PACKET_VERSION, TPACKET_V2);
+	TEST(setsockopt(dst_sock, SOL_PACKET, PACKET_RESERVE, &val,
+		sizeof(val)));
+
+	if (TST_RET == -1 && TST_ERR == EINVAL) {
+		SAFE_CLOSE(dst_sock);
+		tst_res(TPASS | TTERRNO,
+			"setsockopt(PACKET_RESERVE) value is capped");
+		return 0;
+	}
+
+	if (TST_RET == -1) {
+		tst_brk(TBROK | TTERRNO,
+			"setsockopt(PACKET_RESERVE): unexpected error");
+	}
+
+	if (TST_RET) {
+		tst_brk(TBROK | TTERRNO,
+			"Invalid setsockopt(PACKET_RESERVE) return value");
+	}
+
+	tst_res(TINFO, "setsockopt(PACKET_RESERVE) accepted too large value");
+	tst_res(TINFO, "Checking whether this will cause integer overflow...");
+	TEST(setsockopt(dst_sock, SOL_PACKET, PACKET_RX_RING, &tpreq,
+		sizeof(tpreq)));
+	SAFE_CLOSE(dst_sock);
+
+	if (!TST_RET) {
+		tst_res(TFAIL, "setsockopt(PACKET_RX_RING) accepted frame "
+			"size smaller than packet header");
+		return 0;
+	}
+
+	if (TST_RET != -1) {
+		tst_brk(TBROK | TTERRNO,
+			"Invalid setsockopt(PACKET_RX_RING) return value");
+	}
+
+	if (TST_ERR != EINVAL) {
+		tst_brk(TBROK | TTERRNO,
+			"setsockopt(PACKET_RX_RING): unexpeced error");
+	}
+
+	tst_res(TPASS | TTERRNO, "setsockopt(PACKET_RX_RING) frame size check "
+		"rejects values smaller than packet header");
+	/* This test case should not cause kernel taint, skip taint check */
+	return 0;
+}
+
+/* Test for commit acf69c946233 (drop packet if netoff overflows) */
+static int check_vnet_hdr(void)
+{
+	struct tpacket_req tpreq;
+	size_t blocksize = 0x800000, pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
+
+	/* Make sure blocksize is big enough and pagesize aligned */
+	if (blocksize % pagesize)
+		blocksize += pagesize - (blocksize % pagesize);
+
+	tpreq.tp_block_size = blocksize;
+	tpreq.tp_frame_size = 0x11000;
+	tpreq.tp_block_nr = 1;
+	tpreq.tp_frame_nr = (tpreq.tp_block_size * tpreq.tp_block_nr) /
+		tpreq.tp_frame_size;
+
+	dst_sock = SAFE_SOCKET(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
+	SAFE_SETSOCKOPT_INT(dst_sock, SOL_PACKET, PACKET_VERSION, TPACKET_V2);
+	SAFE_SETSOCKOPT_INT(dst_sock, SOL_PACKET, PACKET_VNET_HDR, 1);
+	SAFE_SETSOCKOPT_INT(dst_sock, SOL_PACKET, PACKET_RESERVE, 0xffff - 75);
+	TEST(setsockopt(dst_sock, SOL_PACKET, PACKET_RX_RING, &tpreq,
+		sizeof(tpreq)));
+
+	if (TST_RET == -1 && TST_ERR == EINVAL) {
+		SAFE_CLOSE(dst_sock);
+		tst_res(TCONF, "PACKET_VNET_HDR and PACKET_RX_RING not "
+			"supported together");
+		return 0;
+	}
+
+	if (TST_RET == -1) {
+		tst_brk(TBROK | TTERRNO,
+			"setsockopt(PACKET_RX_RING): unexpected error");
+	}
+
+	if (TST_RET) {
+		tst_brk(TBROK | TTERRNO,
+			"Invalid setsockopt(PACKET_RX_RING) return value");
+	}
+
+	SAFE_BIND(dst_sock, (struct sockaddr *)&bind_addr, sizeof(addr));
+
+	sock = SAFE_SOCKET(AF_PACKET, SOCK_RAW, IPPROTO_RAW);
+	SAFE_SENDTO(1, sock, buf, BUFSIZE, 0, (struct sockaddr *)&addr,
+		sizeof(addr));
+
+	SAFE_CLOSE(sock);
+	SAFE_CLOSE(dst_sock);
+	return 1; /* Continue to taint check */
+}
+
+static int (*testcase_list[])(void) = {check_tiny_frame, check_vnet_hdr};
+
+static void run(unsigned int n)
+{
+	if (!testcase_list[n]())
+		return;
+
+	if (tst_taint_check()) {
+		tst_res(TFAIL, "Kernel is vulnerable");
+		return;
+	}
+
+	tst_res(TPASS, "Nothing bad happened, probably");
+}
+
+static void cleanup(void)
+{
+	if (sock != -1)
+		SAFE_CLOSE(sock);
+
+	if (dst_sock != -1)
+		SAFE_CLOSE(dst_sock);
+}
+
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(testcase_list),
+	.setup = setup,
+	.cleanup = cleanup,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_USER_NS=y",
+		"CONFIG_NET_NS=y",
+		NULL
+	},
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "bcc5364bdcfe"},
+		{"linux-git", "acf69c946233"},
+		{"CVE", "2020-14386"},
+		{}
+	}
+};
-- 
2.28.0

