From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 23 Mar 2018 18:37:29 +0300
Subject: [LTP] [PATCH v2 2/2] sctp: new regression test sctp_big_chunk for
	CVE-2018-5803
In-Reply-To: <1521819449-27489-1-git-send-email-alexey.kodanev@oracle.com>
References: <1521819449-27489-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1521819449-27489-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Added two test-cases in runtest/cve:
* cve-2018-5803 - over-sized INIT_ACK packet
* cve-2018-5803_2 - over-sized INIT packet

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: rename the test file and move it to testcases/network/sctp/

 include/lapi/socket.h                   |    4 +
 runtest/cve                             |    2 +
 testcases/network/.gitignore            |    1 +
 testcases/network/sctp/Makefile         |    2 +-
 testcases/network/sctp/sctp_big_chunk.c |  121 +++++++++++++++++++++++++++++++
 5 files changed, 129 insertions(+), 1 deletions(-)
 create mode 100644 testcases/network/sctp/sctp_big_chunk.c

diff --git a/include/lapi/socket.h b/include/lapi/socket.h
index 426906f..d58c460 100644
--- a/include/lapi/socket.h
+++ b/include/lapi/socket.h
@@ -45,6 +45,10 @@
 # define SOCK_CLOEXEC 02000000
 #endif
 
+#ifndef SOL_SCTP
+# define SOL_SCTP	132
+#endif
+
 #ifndef SOL_UDPLITE
 # define SOL_UDPLITE		136 /* UDP-Lite (RFC 3828) */
 #endif
diff --git a/runtest/cve b/runtest/cve
index 8b7cbe5..1d9569a 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -32,3 +32,5 @@ cve-2017-5754 meltdown
 cve-2017-17052 cve-2017-17052
 cve-2017-16939 cve-2017-16939
 cve-2017-17053 cve-2017-17053
+cve-2018-5803 sctp_big_chunk
+cve-2018-5803_2 sctp_big_chunk -a 10000
diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
index d4ed925..e952f6f 100644
--- a/testcases/network/.gitignore
+++ b/testcases/network/.gitignore
@@ -22,6 +22,7 @@
 /nfsv4/locks/locktests
 /rpc/basic_tests/rpc01/rpc1
 /rpc/basic_tests/rpc01/rpc_server
+/sctp/sctp_big_chunk
 /sockets/ltpClient
 /sockets/ltpServer
 /stress/ns-tools/ns-icmp_redirector
diff --git a/testcases/network/sctp/Makefile b/testcases/network/sctp/Makefile
index 914e389..0fa9125 100644
--- a/testcases/network/sctp/Makefile
+++ b/testcases/network/sctp/Makefile
@@ -15,7 +15,7 @@
 
 top_srcdir		?= ../../..
 
-include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/testcases.mk
 
 INSTALL_TARGETS		:= sctp01.sh
 
diff --git a/testcases/network/sctp/sctp_big_chunk.c b/testcases/network/sctp/sctp_big_chunk.c
new file mode 100644
index 0000000..55a2969
--- /dev/null
+++ b/testcases/network/sctp/sctp_big_chunk.c
@@ -0,0 +1,121 @@
+/*
+ * Copyright (c) 2018 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Regression test-case for the crash caused by over-sized SCTP chunk,
+ * fixed by upstream commit 07f2c7ab6f8d ("sctp: verify size of a new
+ * chunk in _sctp_make_chunk()")
+ */
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <netdb.h>
+#include <sys/syscall.h>
+#include <fcntl.h>
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+#include "lapi/netinet_in.h"
+#include "lapi/socket.h"
+#include "lapi/sctp.h"
+
+static int port;
+static int sfd, cfd;
+static struct sockaddr_in6 rmt, loc;
+
+static char *addr_param;
+static int addr_num = 3273;
+
+static void setup_server(void)
+{
+	loc.sin6_family = AF_INET6;
+	loc.sin6_addr = in6addr_loopback;
+
+	sfd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, IPPROTO_SCTP);
+	SAFE_BIND(sfd, (struct sockaddr *)&loc, sizeof(loc));
+
+	port = TST_GETSOCKPORT(sfd);
+	tst_res(TINFO, "sctp server listen on %d", port);
+
+	SAFE_LISTEN(sfd, 1);
+}
+
+static void setup_client(void)
+{
+	struct sockaddr_in6 addr_buf[addr_num];
+	int i;
+
+	cfd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, IPPROTO_SCTP);
+	rmt.sin6_family = AF_INET6;
+	rmt.sin6_addr = in6addr_loopback;
+	rmt.sin6_port = htons(port);
+
+	tst_res(TINFO, "bind %d additional IP addresses", addr_num);
+
+	memset(addr_buf, 0, sizeof(addr_buf));
+	for (i = 0; i < addr_num; ++i) {
+		addr_buf[i].sin6_family = AF_INET6;
+		addr_buf[i].sin6_addr = in6addr_loopback;
+	}
+
+	SAFE_SETSOCKOPT(cfd, SOL_SCTP, SCTP_SOCKOPT_BINDX_ADD, addr_buf,
+			sizeof(addr_buf));
+}
+
+static void setup(void)
+{
+	if (tst_parse_int(addr_param, &addr_num, 1, INT_MAX))
+		tst_brk(TBROK, "wrong address number '%s'", addr_param);
+
+	setup_server();
+	setup_client();
+}
+
+static void run(void)
+{
+	int pid = SAFE_FORK();
+
+	if (!pid) {
+		struct sockaddr_in6 addr6;
+		socklen_t addr_size = sizeof(addr6);
+
+		if (accept(sfd, (struct sockaddr *)&addr6, &addr_size) < 0)
+			tst_brk(TBROK | TERRNO, "accept() failed");
+		exit(0);
+	}
+
+	fcntl(cfd, F_SETFL, O_NONBLOCK);
+	connect(cfd, (struct sockaddr *)&rmt, sizeof(rmt));
+
+	SAFE_KILL(pid, SIGKILL);
+	SAFE_WAITPID(pid, NULL, 0);
+
+	tst_res(TPASS, "test doesn't cause crash");
+}
+
+static struct tst_option options[] = {
+	{"a:", &addr_param, "-a       number of additional IP address params"},
+	{NULL, NULL, NULL}
+};
+
+static struct tst_test test = {
+	.setup = setup,
+	.forks_child = 1,
+	.test_all = run,
+	.options = options
+};
-- 
1.7.1

