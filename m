Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VgeGM-0000p1-VU
	for ltp-list@lists.sourceforge.net; Wed, 13 Nov 2013 17:29:59 +0000
Date: Wed, 13 Nov 2013 18:29:44 +0100
From: chrubis@suse.cz
Message-ID: <20131113172944.GD12406@rei.Home>
References: <CAARHBVt_=_LFY1zdDyi1BeZnKPdpgJbG2Jhc7JK-G9t+eO+T=g@mail.gmail.com>
	<20131113171303.GC12406@rei.Home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20131113171303.GC12406@rei.Home>
Subject: Re: [LTP] LTP networking multicast test fail
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
To: Vincent Hsu <vincent.hsu@linaro.org>
Cc: ltp-list@lists.sourceforge.net, Linaro Networking <linaro-networking@linaro.org>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> Ah, I've failed to cover all cases when I was greping for the gethost
> usage, sorry.
> 
> It's used in a few multicast testcases as well.
> 
> The list is:
> 
> network/multicast/mc_cmds/mc_cmds
> network/multicast/mc_commo/mc_commo
> network/multicast/mc_member/mc_member
> network/multicast/mc_opts/mc_opts
> 
> I will fix that.

Can you please test attached patch?

-- 
Cyril Hrubis
chrubis@suse.cz

--huq684BweRXVnRxX
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Fix-743f2fcd5744744d649496d8f0524cf5ca7d3859.patch"

From 845fe8ac48308334c97f4683f8e31663e4133564 Mon Sep 17 00:00:00 2001
From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 13 Nov 2013 18:25:50 +0100
Subject: [PATCH] Fix 743f2fcd5744744d649496d8f0524cf5ca7d3859.

The gethost is called from multicast testcases too, which I failed to
find, apologies everyone.

This commit moves the gethost to muticast directory and renames it to
mc_gethost and fixes all usages accordingly.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/network/multicast/mc_cmds/mc_cmds        |  11 +--
 testcases/network/multicast/mc_commo/mc_commo      |   9 +-
 testcases/network/multicast/mc_gethost/Makefile    |  22 +++++
 .../network/multicast/mc_gethost/mc_gethost.c      | 107 +++++++++++++++++++++
 testcases/network/multicast/mc_member/mc_member    |   3 +-
 testcases/network/multicast/mc_opts/mc_opts        |   2 +-
 testcases/network/tcp_cmds/sendfile/Makefile       |   4 +-
 testcases/network/tcp_cmds/sendfile/sendfile01     |   4 +-
 .../network/tcp_cmds/sendfile/sendfile01_gethost.c | 107 ---------------------
 9 files changed, 139 insertions(+), 130 deletions(-)
 create mode 100644 testcases/network/multicast/mc_gethost/Makefile
 create mode 100644 testcases/network/multicast/mc_gethost/mc_gethost.c
 delete mode 100644 testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c

diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
index d27f669..fda26a3 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -36,15 +36,6 @@ $trace_logic
 
 TC=mc_cmds
 PING_OUT=/tmp/${TC}_out
-# Set the LTPROOT variable to the correct path
-# from the ltp/testcases/bin directory or the
-# /ltp/testcases/network/multicast/mc_cmds directory
-pwd | grep -q bin
-if [ $? -eq 0 ]; then
-  LTPROOT=${LTPROOT:-../..}
-else
-  LTPROOT=${LTPROOT:-../../../..}
-fi
 HOSTNAME=`hostname`
 CLEANUP=${CLEANUP:-ON}
 #*******************************************************************************
@@ -63,7 +54,7 @@ do_test()
 
    IFNAME=${IFNAME:-$(netstat -i -n | grep "^[b-z]\{2,4\}[0-9][^*]"|\
       awk '{print $1}')}
-   INTERFACE=${INTERFACE:-$("$LTPROOT/bin/gethost" `hostname` | grep addresses: | awk '{print $2}')}
+   INTERFACE=${INTERFACE:-$(mc_gethost `hostname` | grep addresses: | awk '{print $2}')}
 
    echo "Testing ifconfig and netstat"
 
diff --git a/testcases/network/multicast/mc_commo/mc_commo b/testcases/network/multicast/mc_commo/mc_commo
index 50fa6b9..031d3d2 100755
--- a/testcases/network/multicast/mc_commo/mc_commo
+++ b/testcases/network/multicast/mc_commo/mc_commo
@@ -41,15 +41,12 @@ $trace_logic
 TC=mc_commo
 TCtmp=${TCtmp:-"/tmp/mc_commo.$$"}
 CLEANUP=${CLEANUP:-ON}
-EXECUTABLES="mc_recv"
-REMOTE_EXEC="mc_send"
-LTPROOT=${LTPROOT:-../../../..}
 TTL=10
 PORT=3333
 RHOST=${RHOST:-`hostname`}
 OUTFILE=$TCtmp/mc_commo_out
 NUMLOOPS=${NUMLOOPS:-2}
-INTERFACE=${INTERFACE:-$("$LTPROOT/bin/gethost" `hostname` | grep addresses: | awk '{print $2}')}
+INTERFACE=${INTERFACE:-$(mc_gethost `hostname` | grep addresses: | awk '{print $2}')}
 
 this_file=${0##*/}
 trap "interrupt_test" 2
@@ -85,7 +82,7 @@ do_test ()
       # Start up the recv on local host
       echo "Starting mc_recv on $GROUP_ADDR $INTERFACE $PORT"
 
-      "$LTPROOT/testcases/bin/$EXECUTABLES" $GROUP_ADDR $INTERFACE $PORT \
+      mc_recv $GROUP_ADDR $INTERFACE $PORT \
 	>> $OUTFILE &
       SERVER_PID=$!
       sleep 5
@@ -128,7 +125,7 @@ do_test ()
       do
          echo "Running on $HOST mc_send $GROUP_ADDR $HOST $PORT $TTL"
 
-         rsh -n -l root $HOST "$LTPROOT/testcases/bin/$REMOTE_EXEC" $GROUP_ADDR \
+         rsh -n -l root $HOST mc_send $GROUP_ADDR \
 	 $HOST $PORT $TTL >/dev/null &
          sleep 10
 	rsh -n -l root $HOST "ps -ewf | grep mc_send | grep -v grep"
diff --git a/testcases/network/multicast/mc_gethost/Makefile b/testcases/network/multicast/mc_gethost/Makefile
new file mode 100644
index 0000000..d5eaf84
--- /dev/null
+++ b/testcases/network/multicast/mc_gethost/Makefile
@@ -0,0 +1,22 @@
+#
+#    Copyright (C) 2013, Linux Test Project
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/multicast/mc_gethost/mc_gethost.c b/testcases/network/multicast/mc_gethost/mc_gethost.c
new file mode 100644
index 0000000..5b9a790
--- /dev/null
+++ b/testcases/network/multicast/mc_gethost/mc_gethost.c
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
diff --git a/testcases/network/multicast/mc_member/mc_member b/testcases/network/multicast/mc_member/mc_member
index 0e79cdb..ee0ca07 100755
--- a/testcases/network/multicast/mc_member/mc_member
+++ b/testcases/network/multicast/mc_member/mc_member
@@ -42,10 +42,9 @@ TCsrc=${TCsrc:-`pwd`}
 TCtmp=${TCtmp:-$TCsrc/$TC$$}
 CLEANUP=${CLEANUP:-ON}
 
-LTPROOT=${LTPROOT:-"../../../../"}
 EXECUTABLES=${EXECUTABLES:-"member"}
 NUMLOOPS=${NUMLOOPS:-2}
-INTERFACE=${INTERFACE:-$("$LTPROOT/bin/gethost" `hostname`| grep address |awk '{ print $2 }')}
+INTERFACE=${INTERFACE:-$(mc_gethost `hostname`| grep address |awk '{ print $2 }')}
 GLIST=${GLIST:-$TCsrc/ManyGroups}
 TooManyGLIST=${TooManyGLIST:-$TCsrc/TooManyGroups}
 ERRFILE=${ERRFILE:-$TCtmp/errors}
diff --git a/testcases/network/multicast/mc_opts/mc_opts b/testcases/network/multicast/mc_opts/mc_opts
index 41e1d68..6f36c26 100755
--- a/testcases/network/multicast/mc_opts/mc_opts
+++ b/testcases/network/multicast/mc_opts/mc_opts
@@ -47,7 +47,7 @@ TCtmp=${TCtmp:-$LTPROOT/bin/$TC$$}
 CLEANUP=${CLEANUP:-ON}
 EXECUTABLES=${EXECUTABLES:-"opts opts_e"}
 NUMLOOPS=${NUMLOOPS:-10}
-IPADDR=${IPADDR:-$("$LTPROOT/bin/gethost" `hostname`| grep address |awk '{ print $2 }')}
+IPADDR=${IPADDR:-$(mc_gethost `hostname`| grep address |awk '{ print $2 }')}
 
 this_file=${0##*/}
 trap "interrupt_test" 2
diff --git a/testcases/network/tcp_cmds/sendfile/Makefile b/testcases/network/tcp_cmds/sendfile/Makefile
index 7ba2d7a..a8b0736 100644
--- a/testcases/network/tcp_cmds/sendfile/Makefile
+++ b/testcases/network/tcp_cmds/sendfile/Makefile
@@ -27,9 +27,9 @@ include $(abs_srcdir)/../Makefile.inc
 
 CPPFLAGS		+= -I$(abs_srcdir)/../include
 
-INSTALL_TARGETS		:= sendfile01 sendfile01_server sendfile01_gethost
+INSTALL_TARGETS		:= sendfile01 sendfile01_server
 
-MAKE_TARGETS		+= testsf_c testsf_s testsf_c6 testsf_s6 sendfile01_gethost
+MAKE_TARGETS		+= testsf_c testsf_s testsf_c6 testsf_s6
 
 testsf_c6.o testsf_s6.o: CPPFLAGS += -DINET6
 
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01 b/testcases/network/tcp_cmds/sendfile/sendfile01
index ebeb182..1598106 100755
--- a/testcases/network/tcp_cmds/sendfile/sendfile01
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01
@@ -59,9 +59,9 @@ do_setup()
 
     tst_setup
 
-    exists awk diff sendfile01_gethost grep rsh stat
+    exists awk diff mc_gethost grep rsh stat
 
-    if ! IPADDR=$(sendfile01_gethost ${EXEC_SUFFIX:+6} $RHOST | awk 'BEGIN { ec=1 } /addresses:/ {print $2; ec=0 } END { exit ec }'); then
+    if ! IPADDR=$(mc_gethost ${EXEC_SUFFIX:+6} $RHOST | awk 'BEGIN { ec=1 } /addresses:/ {print $2; ec=0 } END { exit ec }'); then
         # XXX (garrcoop): || exit 1 is there to prevent the test from hanging in the event of an install error.
         end_testcase "Failed to determine the appropriate IP address for the machine." || exit 1
     fi
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c b/testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c
deleted file mode 100644
index 5b9a790..0000000
--- a/testcases/network/tcp_cmds/sendfile/sendfile01_gethost.c
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
1.8.1.5


--huq684BweRXVnRxX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
--huq684BweRXVnRxX
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--huq684BweRXVnRxX--

