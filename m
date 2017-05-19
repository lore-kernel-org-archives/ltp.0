From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 19 May 2017 14:31:56 +0200
Subject: [LTP] [PATCH 10/10] Test for CVE-2017-2671 on ping sockets
In-Reply-To: <20170519123156.8462-1-rpalethorpe@suse.com>
References: <20170519123156.8462-1-rpalethorpe@suse.com>
Message-ID: <20170519123156.8462-10-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 runtest/cve                   |   1 +
 testcases/cve/.gitignore      |   1 +
 testcases/cve/Makefile        |   1 +
 testcases/cve/cve-2017-2671.c | 123 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 testcases/cve/cve-2017-2671.c

diff --git a/runtest/cve b/runtest/cve
index 359958ca9..5958d6c39 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -4,6 +4,7 @@ cve-2014-0196 cve-2014-0196
 cve-2016-4997 cve-2016-4997
 cve-2016-5195 dirtyc0w
 cve-2016-7117 cve-2016-7117
+cve-2017-2671 cve-2017-2671
 cve-2017-5669 cve-2017-5669
 cve-2017-6951 cve-2017-6951
 cve-2017-7277 cve-2017-7277
diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
index 516ea62a5..376964266 100644
--- a/testcases/cve/.gitignore
+++ b/testcases/cve/.gitignore
@@ -2,6 +2,7 @@ cve-2012-0957
 cve-2014-0196
 cve-2016-4997
 cve-2016-7117
+cve-2017-2671
 cve-2017-5669
 cve-2017-6951
 cve-2017-7277
diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
index d642b73b4..e9d9044d5 100644
--- a/testcases/cve/Makefile
+++ b/testcases/cve/Makefile
@@ -21,5 +21,6 @@ CFLAGS			+= -D_GNU_SOURCE
 
 cve-2014-0196:	LDFLAGS += -lpthread -lutil -lrt
 cve-2016-7117:	LDFLAGS += -lpthread -lrt
+cve-2017-2671:	LDFLAGS += -lpthread -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/cve/cve-2017-2671.c b/testcases/cve/cve-2017-2671.c
new file mode 100644
index 000000000..e76a87fd5
--- /dev/null
+++ b/testcases/cve/cve-2017-2671.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
+ * Original POC by Daniel Jiang
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
+/*
+ * Test for CVE-2017-2671 faulty locking on ping socket
+ *
+ * When sys_connect() is called with sockaddr.sin_family set to AF_UNSPEC on a
+ * ping socket; __udp_disconnect() gets called, which in turn calls the buggy
+ * function ping_unhashed(). This function does not obtain a rwlock before
+ * checking if the socket is hashed allowing the socket data to be pulled from
+ * underneath it in the time between calling sk_hashed() and gaining the write
+ * lock.
+ *
+ * Fixed in commit 43a6684519ab0a6c52024b5e25322476cabad893
+ *
+ * This test repeatedly 'connects' a ping socket correctly then calls
+ * connect() with AF_UNSPEC in two seperate threads to trigger the race
+ * condition. If the bug is present, then the test will most likely crash the
+ * system.
+ *
+ * The test requests root privileges so that it can ensure ping sockets are
+ * enabled. On distributions (including Android) where ping sockets are
+ * enabled by default, root privileges are not required.
+ */
+
+#include <stdio.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
+#include <stdlib.h>
+
+#include "tst_test.h"
+#include "tst_safe_net.h"
+#include "tst_safe_pthread.h"
+
+#include "tst_fuzzy_sync.h"
+
+#define ATTEMPTS 0xFFFF
+#define PING_SYSCTL_PATH "/proc/sys/net/ipv4/ping_group_range"
+
+static int sockfd;
+static unsigned int ping_min_grp = 1, ping_max_grp;
+static struct tst_fzsync_pair fzsync_pair = {
+	.delay_inc = 1,
+};
+static struct sockaddr_in iaddr, uaddr;
+
+static void setup(void)
+{
+	iaddr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+	uaddr = iaddr;
+	iaddr.sin_family = AF_INET;
+	uaddr.sin_family = AF_UNSPEC;
+	tst_fzsync_pair_init(&fzsync_pair);
+
+	SAFE_FILE_SCANF(PING_SYSCTL_PATH, "%u %u",
+			&ping_min_grp, &ping_max_grp);
+	SAFE_FILE_PRINTF(PING_SYSCTL_PATH, "0 0");
+}
+
+static void cleanup(void)
+{
+	if (ping_min_grp | ping_max_grp)
+		SAFE_FILE_PRINTF(PING_SYSCTL_PATH, "%u %u",
+				 ping_min_grp, ping_max_grp);
+}
+
+static void *connect_b(void * param LTP_ATTRIBUTE_UNUSED)
+{
+	tst_fzsync_delay_b(&fzsync_pair);
+	connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
+	tst_fzsync_time_b(&fzsync_pair);
+
+	return 0;
+}
+
+static void run(void)
+{
+	pthread_t thrd;
+	int i;
+
+	sockfd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, IPPROTO_ICMP);
+	tst_res(TINFO, "Created ping socket, attempting to race...");
+
+	for (i = 0; i < ATTEMPTS; i++) {
+		SAFE_CONNECT(sockfd,
+			     (struct sockaddr *)&iaddr, sizeof(iaddr));
+		SAFE_PTHREAD_CREATE(&thrd, 0, connect_b, 0);
+
+		tst_fzsync_delay_a(&fzsync_pair);
+		connect(sockfd, (struct sockaddr *)&uaddr, sizeof(uaddr));
+		tst_fzsync_time_a(&fzsync_pair);
+
+		SAFE_PTHREAD_JOIN(thrd, 0);
+		tst_fzsync_pair_update(i, &fzsync_pair);
+
+		if (!(i & 0x7FFF))
+			tst_fzsync_pair_info(&fzsync_pair);
+	}
+
+	tst_res(TPASS, "We didn't crash");
+}
+
+static struct tst_test test = {
+	.tid = "cve-2017-2671",
+	.setup = setup,
+	.test_all = run,
+	.cleanup = cleanup,
+	.needs_root = 1,
+};
-- 
2.12.2

