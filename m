From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 21 Apr 2020 17:12:33 +0200
Subject: [LTP] [PATCH] Add test for CVE 2017-1000112
Message-ID: <20200421151233.20726-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #494

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Oh noes! UFOs are attacking the kernel!!1! XD

 runtest/cve                                   |  1 +
 runtest/syscalls                              |  1 +
 .../kernel/syscalls/setsockopt/.gitignore     |  1 +
 .../kernel/syscalls/setsockopt/setsockopt05.c | 92 +++++++++++++++++++
 4 files changed, 95 insertions(+)
 create mode 100644 testcases/kernel/syscalls/setsockopt/setsockopt05.c

diff --git a/runtest/cve b/runtest/cve
index 629cf7035..e55b7a7e3 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -38,6 +38,7 @@ cve-2017-16939 cve-2017-16939
 cve-2017-16995 bpf_prog03
 cve-2017-17053 cve-2017-17053
 cve-2017-18075 pcrypt_aead01
+cve-2017-1000112 setsockopt05
 cve-2017-1000380 snd_timer01
 cve-2018-5803 sctp_big_chunk
 cve-2018-7566 snd_seq01
diff --git a/runtest/syscalls b/runtest/syscalls
index 9bb72beb2..b67968d95 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1320,6 +1320,7 @@ setsockopt01 setsockopt01
 setsockopt02 setsockopt02
 setsockopt03 setsockopt03
 setsockopt04 setsockopt04
+setsockopt05 setsockopt05
 
 settimeofday01 settimeofday01
 settimeofday02 settimeofday02
diff --git a/testcases/kernel/syscalls/setsockopt/.gitignore b/testcases/kernel/syscalls/setsockopt/.gitignore
index 603e2ad7a..f4eabd92b 100644
--- a/testcases/kernel/syscalls/setsockopt/.gitignore
+++ b/testcases/kernel/syscalls/setsockopt/.gitignore
@@ -2,3 +2,4 @@
 /setsockopt02
 /setsockopt03
 /setsockopt04
+/setsockopt05
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
new file mode 100644
index 000000000..23d96967f
--- /dev/null
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2019 SUSE LLC <mdoucha@suse.cz>
+ */
+
+/*
+ * CVE-2017-1000112
+ *
+ * Check that UDP fragmentation offload doesn't cause memory corruption
+ * if the userspace process turns off UFO in between two send() calls.
+ * Kernel crash fixed in:
+ * 
+ *  commit 85f1bd9a7b5a79d5baa8bf44af19658f7bf77bfa
+ *  Author: Willem de Bruijn <willemb@google.com>
+ *  Date:   Thu Aug 10 12:29:19 2017 -0400
+ *
+ *  udp: consistently apply ufo or fragmentation
+ */
+
+#define _GNU_SOURCE
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <sys/ioctl.h>
+#include <net/if.h>
+#include <sched.h>
+
+#include "tst_test.h"
+#include "tst_net.h"
+#include "tst_taint.h"
+
+#define BUFSIZE 4000
+
+static struct sockaddr_in addr;
+
+static void setup(void)
+{
+	int real_uid = getuid();
+	int real_gid = getgid();
+	int sock;
+	struct ifreq ifr;
+
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
+
+	SAFE_UNSHARE(CLONE_NEWUSER);
+	SAFE_UNSHARE(CLONE_NEWNET);
+	SAFE_FILE_PRINTF("/proc/self/setgroups", "deny");
+	SAFE_FILE_PRINTF("/proc/self/uid_map", "0 %d 1", real_uid);
+	SAFE_FILE_PRINTF("/proc/self/gid_map", "0 %d 1", real_gid);
+
+	tst_init_sockaddr_inet_bin(&addr, INADDR_LOOPBACK, 12345);
+	sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
+	strcpy(ifr.ifr_name, "lo");
+	ifr.ifr_mtu = 1500;
+	SAFE_IOCTL(sock, SIOCSIFMTU, &ifr);
+	ifr.ifr_flags = IFF_UP;
+	SAFE_IOCTL(sock, SIOCSIFFLAGS, &ifr);
+	SAFE_CLOSE(sock);
+}
+
+static void run(void)
+{
+	int sock, i;
+	char buf[BUFSIZE];
+	memset(buf, 0x42, BUFSIZE);
+
+	for (i = 0; i < 1000; i++) {
+		sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
+		SAFE_CONNECT(sock, (struct sockaddr *)&addr, sizeof(addr));
+		SAFE_SEND(1, sock, buf, BUFSIZE, MSG_MORE);
+		SAFE_SETSOCKOPT_INT(sock, SOL_SOCKET, SO_NO_CHECK, 1);
+		send(sock, buf, 1, 0);
+		SAFE_CLOSE(sock);
+
+		if (tst_taint_check()) {
+			tst_res(TFAIL, "Kernel is vulnerable");
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Nothing bad happened, probably");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "85f1bd9a7b5a"},
+		{"CVE", "2017-1000112"},
+		{}
+	}
+};
-- 
2.26.0

