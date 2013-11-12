Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1VgBhe-0005e6-Lz
	for ltp-list@lists.sourceforge.net; Tue, 12 Nov 2013 11:00:14 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VgBhc-00018o-Af
	for ltp-list@lists.sourceforge.net; Tue, 12 Nov 2013 11:00:14 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rACB05K0028746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Nov 2013 11:00:06 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rACB04La013825
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Nov 2013 11:00:05 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rACB0374003956
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Nov 2013 11:00:04 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Tue, 12 Nov 2013 18:59:57 +0800
Message-Id: <1384253997-965-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <20131111140824.GD12164@rei>
References: <20131111140824.GD12164@rei>
Subject: [LTP] [PATCH] move gethost from tools to sendfile01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Move tools/gethost.c to
 testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c
since sendfile01 is the only test that requires gethost.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/tcp_cmds/sendfile/Makefile       |   4 +-
 testcases/network/tcp_cmds/sendfile/sendfile01     |   4 +-
 .../network/tcp_cmds/sendfile/sendfile01_gethost.c | 107 +++++++++++++++++++++
 tools/gethost.c                                    | 107 ---------------------
 4 files changed, 111 insertions(+), 111 deletions(-)
 create mode 100644 testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c
 delete mode 100644 tools/gethost.c

diff --git a/testcases/network/tcp_cmds/sendfile/Makefile b/testcases/network/tcp_cmds/sendfile/Makefile
index a8b0736..7ba2d7a 100644
--- a/testcases/network/tcp_cmds/sendfile/Makefile
+++ b/testcases/network/tcp_cmds/sendfile/Makefile
@@ -27,9 +27,9 @@ include $(abs_srcdir)/../Makefile.inc
 
 CPPFLAGS		+= -I$(abs_srcdir)/../include
 
-INSTALL_TARGETS		:= sendfile01 sendfile01_server
+INSTALL_TARGETS		:= sendfile01 sendfile01_server sendfile01_gethost
 
-MAKE_TARGETS		+= testsf_c testsf_s testsf_c6 testsf_s6
+MAKE_TARGETS		+= testsf_c testsf_s testsf_c6 testsf_s6 sendfile01_gethost
 
 testsf_c6.o testsf_s6.o: CPPFLAGS += -DINET6
 
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01 b/testcases/network/tcp_cmds/sendfile/sendfile01
index ba61873..ebeb182 100755
--- a/testcases/network/tcp_cmds/sendfile/sendfile01
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01
@@ -59,9 +59,9 @@ do_setup()
 
     tst_setup
 
-    exists awk diff gethost grep rsh stat
+    exists awk diff sendfile01_gethost grep rsh stat
 
-    if ! IPADDR=$(gethost ${EXEC_SUFFIX:+6} $RHOST | awk 'BEGIN { ec=1 } /addresses:/ {print $2; ec=0 } END { exit ec }'); then
+    if ! IPADDR=$(sendfile01_gethost ${EXEC_SUFFIX:+6} $RHOST | awk 'BEGIN { ec=1 } /addresses:/ {print $2; ec=0 } END { exit ec }'); then
         # XXX (garrcoop): || exit 1 is there to prevent the test from hanging in the event of an install error.
         end_testcase "Failed to determine the appropriate IP address for the machine." || exit 1
     fi
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c b/testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c
new file mode 100644
index 0000000..5b9a790
--- /dev/null
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c
@@ -0,0 +1,107 @@
+/* host - print information about a host
+ * originally written by Paul Vixie @DEC WRL, January 1989
+ */
+
+/* DECWRL Header: host.c,v 1.1 89/04/05 15:41:12 vixie Locked $ */
+
+#include <sys/param.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <arpa/nameser.h>
+
+#include <stdio.h>
+#include <resolv.h>
+#include <netdb.h>
+#include <syslog.h>
+#include <string.h>
+#include <stdlib.h>
+
+#ifndef LOG_PERROR
+#define LOG_PERROR 0
+#endif
+
+int main(argc, argv)
+int argc;
+char **argv;
+{
+	u_char b_addr[IN6ADDRSZ];
+	struct hostent *host;
+	char **ap, **cp, *arg;
+	const char *prog = "amnesia";
+	int af = AF_INET;
+	int size = INADDRSZ;
+	int force = 0;
+
+	if (argc < 1) {
+usage:
+		printf("usage:  %s [-d] [-6] [-f] (hostname|ipaddr)\n", prog);
+		exit(1);
+	}
+	prog = *argv++;
+	argc--;
+#ifdef LOG_USER
+	openlog(prog, LOG_PERROR, LOG_USER);
+#else
+	openlog(prog, LOG_PERROR);
+#endif
+	res_init();
+
+	if (argc >= 1 && !strcmp(*argv, "-d")) {
+		_res.options |= RES_DEBUG;
+		argv++, argc--;
+	}
+	if (argc >= 1 && !strcmp(*argv, "-6")) {
+		af = AF_INET6, size = IN6ADDRSZ;
+		_res.options |= RES_USE_INET6;
+		argv++, argc--;
+	}
+	if (argc >= 1 && !strcmp(*argv, "-f")) {
+		force++;
+		argv++, argc--;
+	}
+
+	if (argc < 1)
+		goto usage;
+	arg = *argv++;
+	argc--;
+
+	if (inet_pton(af, arg, b_addr)) {
+		char p[sizeof "ffff:ffff:ffff:ffff:ffff:ffff:255.255.255.255"];
+
+		printf("[%s]\n", inet_ntop(af, b_addr, p, sizeof p));
+		if (!(host = gethostbyaddr((char *)b_addr, size, af))) {
+			herror("gethostbyaddr");
+			exit(1);
+		}
+	} else {
+		printf("{%s}\n", arg);
+		if (force)
+			host = gethostbyname2(arg, af);
+		else
+			host = gethostbyname(arg);
+		if (!host) {
+			herror("gethostbyname*");
+			exit(1);
+		}
+	}
+	printf("name: %s\n", host->h_name);
+	if (host->h_aliases && *host->h_aliases) {
+		printf("aliases:");
+		for (cp = (char **)host->h_aliases; *cp; cp++)
+			printf(" %s", *cp);
+		printf("\n");
+	}
+	if (host->h_addr_list && *host->h_addr_list) {
+		printf("addresses:");
+		for (ap = host->h_addr_list; *ap; ap++) {
+			char p[sizeof
+			       "ffff:ffff:ffff:ffff:ffff:ffff:255.255.255.255"];
+
+			printf(" %s", inet_ntop(host->h_addrtype,
+						*ap, p, sizeof p));
+		}
+		printf("\n");
+	}
+	exit(0);
+}
diff --git a/tools/gethost.c b/tools/gethost.c
deleted file mode 100644
index 5b9a790..0000000
--- a/tools/gethost.c
+++ /dev/null
@@ -1,107 +0,0 @@
-/* host - print information about a host
- * originally written by Paul Vixie @DEC WRL, January 1989
- */
-
-/* DECWRL Header: host.c,v 1.1 89/04/05 15:41:12 vixie Locked $ */
-
-#include <sys/param.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <arpa/nameser.h>
-
-#include <stdio.h>
-#include <resolv.h>
-#include <netdb.h>
-#include <syslog.h>
-#include <string.h>
-#include <stdlib.h>
-
-#ifndef LOG_PERROR
-#define LOG_PERROR 0
-#endif
-
-int main(argc, argv)
-int argc;
-char **argv;
-{
-	u_char b_addr[IN6ADDRSZ];
-	struct hostent *host;
-	char **ap, **cp, *arg;
-	const char *prog = "amnesia";
-	int af = AF_INET;
-	int size = INADDRSZ;
-	int force = 0;
-
-	if (argc < 1) {
-usage:
-		printf("usage:  %s [-d] [-6] [-f] (hostname|ipaddr)\n", prog);
-		exit(1);
-	}
-	prog = *argv++;
-	argc--;
-#ifdef LOG_USER
-	openlog(prog, LOG_PERROR, LOG_USER);
-#else
-	openlog(prog, LOG_PERROR);
-#endif
-	res_init();
-
-	if (argc >= 1 && !strcmp(*argv, "-d")) {
-		_res.options |= RES_DEBUG;
-		argv++, argc--;
-	}
-	if (argc >= 1 && !strcmp(*argv, "-6")) {
-		af = AF_INET6, size = IN6ADDRSZ;
-		_res.options |= RES_USE_INET6;
-		argv++, argc--;
-	}
-	if (argc >= 1 && !strcmp(*argv, "-f")) {
-		force++;
-		argv++, argc--;
-	}
-
-	if (argc < 1)
-		goto usage;
-	arg = *argv++;
-	argc--;
-
-	if (inet_pton(af, arg, b_addr)) {
-		char p[sizeof "ffff:ffff:ffff:ffff:ffff:ffff:255.255.255.255"];
-
-		printf("[%s]\n", inet_ntop(af, b_addr, p, sizeof p));
-		if (!(host = gethostbyaddr((char *)b_addr, size, af))) {
-			herror("gethostbyaddr");
-			exit(1);
-		}
-	} else {
-		printf("{%s}\n", arg);
-		if (force)
-			host = gethostbyname2(arg, af);
-		else
-			host = gethostbyname(arg);
-		if (!host) {
-			herror("gethostbyname*");
-			exit(1);
-		}
-	}
-	printf("name: %s\n", host->h_name);
-	if (host->h_aliases && *host->h_aliases) {
-		printf("aliases:");
-		for (cp = (char **)host->h_aliases; *cp; cp++)
-			printf(" %s", *cp);
-		printf("\n");
-	}
-	if (host->h_addr_list && *host->h_addr_list) {
-		printf("addresses:");
-		for (ap = host->h_addr_list; *ap; ap++) {
-			char p[sizeof
-			       "ffff:ffff:ffff:ffff:ffff:ffff:255.255.255.255"];
-
-			printf(" %s", inet_ntop(host->h_addrtype,
-						*ap, p, sizeof p));
-		}
-		printf("\n");
-	}
-	exit(0);
-}
-- 
1.8.4.2


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
