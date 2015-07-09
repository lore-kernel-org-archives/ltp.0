Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZD29O-0001y7-SF
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 03:05:26 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZD29K-0002ZQ-NN
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2015 03:05:26 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 9 Jul 2015 11:05:22 +0800
Message-ID: <1436411125-8012-8-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1436411125-8012-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <55842886.4090202@oracle.com>
	<1436411125-8012-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v4 08/11] lib6/asapi_06.c: Cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: alexey.kodanev@oracle.com
Cc: ltp-list@lists.sourceforge.net

* Add 'static' before some functions and global variables.
* Use 'tst_tmpdir' and 'tst_rmdir'.
* Remove useless comments.
* Use SAFE_XXX().
* Remove unused variables.
* Modify the format of sotab[] and cmtab[].
* Modify the initialization of sotab[].
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/lib6/asapi_06.c | 317 +++++++++++++++-----------------------
 1 file changed, 120 insertions(+), 197 deletions(-)

diff --git a/testcases/network/lib6/asapi_06.c b/testcases/network/lib6/asapi_06.c
index 960ebb5..204bf23 100644
--- a/testcases/network/lib6/asapi_06.c
+++ b/testcases/network/lib6/asapi_06.c
@@ -1,37 +1,21 @@
 /*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Copyright (c) International Business Machines  Corp., 2001
  *
- *   Copyright (c) International Business Machines  Corp., 2001
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
  *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
- */
-
-/*
- * Test Name: asapi_06
- *
- * Test Description:
- *  Tests for RFC 3542 section 4 socket options and ancillary data
- *
- * Usage:  <for command-line>
- *  asapi_06
- *
- * HISTORY
- *	05/2005 written by David L Stevens
- *
- * RESTRICTIONS:
- *  None.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
+ * Author: David L Stevens
  */
 
 #include "config.h"
@@ -57,25 +41,19 @@
 #include <arpa/inet.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
-char *TCID = "asapi_06";	/* Test program identifier.    */
+char *TCID = "asapi_06";
 
 int TST_TOTAL = 1;
 
-pid_t pid;
-
-struct {
-	char *prt_name;
-	int prt_value;
-} ptab[] = {
-};
-
-#define PTCOUNT	(sizeof(ptab)/sizeof(ptab[0]))
+static pid_t pid;
 
 #define READ_TIMEOUT	5	/* secs */
 
-void do_tests(void);
-void setup(void), cleanup(void);
+static void do_tests(void);
+static void setup(void);
+static void cleanup(void);
 
 int main(int argc, char *argv[])
 {
@@ -97,40 +75,40 @@ int main(int argc, char *argv[])
 #define NH_TEST	0x9f
 
 #ifndef IPV6_RECVPKTINFO
-#define IPV6_RECVPKTINFO	-1
+# define IPV6_RECVPKTINFO	-1
 #endif
 #ifndef IPV6_RECVHOPLIMIT
-#define IPV6_RECVHOPLIMIT	-1
+# define IPV6_RECVHOPLIMIT	-1
 #endif
 #ifndef IPV6_RECVRTHDR
-#define IPV6_RECVRTHDR		-1
+# define IPV6_RECVRTHDR		-1
 #endif
 #ifndef IPV6_RECVHOPOPTS
-#define IPV6_RECVHOPOPTS	-1
+# define IPV6_RECVHOPOPTS	-1
 #endif
 #ifndef IPV6_RECVDSTOPTS
-#define IPV6_RECVDSTOPTS	-1
+# define IPV6_RECVDSTOPTS	-1
 #endif
 #ifndef IPV6_RECVTCLASS
-#define IPV6_RECVTCLASS		-1
+# define IPV6_RECVTCLASS		-1
 #endif
 #ifndef IPV6_TCLASS
-#define IPV6_TCLASS		-1
+# define IPV6_TCLASS		-1
 #endif
 #ifndef IPV6_2292PKTINFO
-#define	IPV6_2292PKTINFO	-1
+# define	IPV6_2292PKTINFO	-1
 #endif
 #ifndef IPV6_2292HOPLIMIT
-#define	IPV6_2292HOPLIMIT	-1
+# define	IPV6_2292HOPLIMIT	-1
 #endif
 #ifndef IPV6_2292RTHDR
-#define	IPV6_2292RTHDR		-1
+# define	IPV6_2292RTHDR		-1
 #endif
 #ifndef IPV6_2292HOPOPTS
-#define	IPV6_2292HOPOPTS	-1
+# define	IPV6_2292HOPOPTS	-1
 #endif
 #ifndef IPV6_2292DSTOPTS
-#define	IPV6_2292DSTOPTS	-1
+# define	IPV6_2292DSTOPTS	-1
 #endif
 
 union soval {
@@ -150,7 +128,7 @@ union soval {
 #define IN6_ANY		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
 
 /* so_clrval and so_setval members are initilized in the body */
-struct soent {
+static struct soent {
 	char *so_tname;
 	int so_opt;
 	int so_dorecv;		/* do receive test? */
@@ -160,73 +138,52 @@ struct soent {
 	union soval so_setval;
 	socklen_t so_valsize;
 } sotab[] = {
-/* RFC 3542, Section 4 */
-	{
-		"IPV6_RECVPKTINFO", IPV6_RECVPKTINFO, 1, IPV6_PKTINFO, 1, { { { { {
-		0}}}}}, { { { { {
-	0}}}}}, sizeof(int)}, {
-		"IPV6_RECVHOPLIMIT", IPV6_RECVHOPLIMIT, 1, IPV6_HOPLIMIT, 1, { { { { {
-		0}}}}}, { { { { {
-	0}}}}}, sizeof(int)}, {
-		"IPV6_RECVRTHDR", IPV6_RECVRTHDR, 0, IPV6_RTHDR, 1, { { { { {
-		0}}}}}, { { { { {
-	0}}}}}, sizeof(int)}, {
-		"IPV6_RECVHOPOPTS", IPV6_RECVHOPOPTS, 0, IPV6_HOPOPTS, 1, { { { { {
-		0}}}}}, { { { { {
-	0}}}}}, sizeof(int)}, {
-		"IPV6_RECVDSTOPTS", IPV6_RECVDSTOPTS, 0, IPV6_DSTOPTS, 1, { { { { {
-		0}}}}}, { { { { {
-	0}}}}}, sizeof(int)}, {
-		"IPV6_RECVTCLASS", IPV6_RECVTCLASS, 1, IPV6_TCLASS, 1, { { { { {
-		0}}}}}, { { { { {
-	0}}}}}, sizeof(int)},
-/* make sure TCLASS stays when setting another opt */
-	{
-		"IPV6_RECVTCLASS (2)", IPV6_RECVHOPLIMIT, 1, IPV6_TCLASS, 0, { { { { {
-		0}}}}}, { { { { {
-	0}}}}}, sizeof(int)},
-/* OLD values */
-	{
-		"IPV6_2292PKTINFO", IPV6_2292PKTINFO, 1, IPV6_2292PKTINFO, 1, { { { { {
-		0}}}}}, { { { { {
-	0}}}}}, sizeof(int)}, {
-		"IPV6_2292HOPLIMIT", IPV6_2292HOPLIMIT, 1, IPV6_2292HOPLIMIT, 1, { { { { {
-		0}}}}}, { { { { {
-	0}}}}}, sizeof(int)}, {
-		"IPV6_2292RTHDR", IPV6_2292RTHDR, 0, IPV6_2292RTHDR, 1, { { { { {
-		0}}}}}, { { { { {
-	0}}}}}, sizeof(int)}, {
-		"IPV6_2292HOPOPTS", IPV6_2292HOPOPTS, 0, IPV6_2292HOPOPTS, 1, { { { { {
-		0}}}}}, { { { { {
-	0}}}}}, sizeof(int)}, {
-		"IPV6_2292DSTOPTS", IPV6_2292DSTOPTS, 0, IPV6_2292DSTOPTS, 1, { { { { {
-		0}}}}}, { { { { {
-0}}}}}, sizeof(int)},};
-
-#define SOCOUNT	(sizeof(sotab)/sizeof(sotab[0]))
+	/* RFC 3542, Section 4 */
+	{"IPV6_RECVPKTINFO", IPV6_RECVPKTINFO, 1, IPV6_PKTINFO, 1,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+	{"IPV6_RECVHOPLIMIT", IPV6_RECVHOPLIMIT, 1, IPV6_HOPLIMIT, 1,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+	{"IPV6_RECVRTHDR", IPV6_RECVRTHDR, 0, IPV6_RTHDR, 1,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+	{"IPV6_RECVHOPOPTS", IPV6_RECVHOPOPTS, 0, IPV6_HOPOPTS, 1,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+	{"IPV6_RECVDSTOPTS", IPV6_RECVDSTOPTS, 0, IPV6_DSTOPTS, 1,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+	{"IPV6_RECVTCLASS", IPV6_RECVTCLASS, 1, IPV6_TCLASS, 1,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+	/* make sure TCLASS stays when setting another opt */
+	{"IPV6_RECVTCLASS (2)", IPV6_RECVHOPLIMIT, 1, IPV6_TCLASS, 0,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+	/* OLD values */
+	{"IPV6_2292PKTINFO", IPV6_2292PKTINFO, 1, IPV6_2292PKTINFO, 1,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+	{"IPV6_2292HOPLIMIT", IPV6_2292HOPLIMIT, 1, IPV6_2292HOPLIMIT, 1,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+	{"IPV6_2292RTHDR", IPV6_2292RTHDR, 0, IPV6_2292RTHDR, 1,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+	{"IPV6_2292HOPOPTS", IPV6_2292HOPOPTS, 0, IPV6_2292HOPOPTS, 1,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+	{"IPV6_2292DSTOPTS", IPV6_2292DSTOPTS, 0, IPV6_2292DSTOPTS, 1,
+	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
+};
+
+#define SOCOUNT	ARRAY_SIZE(sotab)
 
 struct soprot {
-	int sop_pid;		/* sender PID */
-	int sop_seq;		/* sequence # */
-	int sop_dlen;		/* tp_dat length */
+	int sop_pid;			/* sender PID */
+	int sop_seq;			/* sequence # */
+	int sop_dlen;			/* tp_dat length */
 	unsigned char sop_dat[0];	/* user data */
 };
 
-unsigned char tpbuf[sizeof(struct soprot) + 2048];
-unsigned char rpbuf[sizeof(struct soprot) + 2048];
+static unsigned char tpbuf[sizeof(struct soprot) + 2048];
+static unsigned char rpbuf[sizeof(struct soprot) + 2048];
 
-unsigned char control[2048];
-int clen;
+static unsigned char control[2048];
 
-int seq;
+static int seq;
 
-int setupso(void)
-{
-/* add routing headers, other ancillary data here */
-	return 0;
-}
-
-struct cme {
+static struct cme {
 	int cm_len;
 	int cm_level;
 	int cm_type;
@@ -235,26 +192,21 @@ struct cme {
 		uint32_t cmu_hops;
 	} cmu;
 } cmtab[] = {
-	{
-		sizeof(uint32_t), SOL_IPV6, IPV6_TCLASS, {
-		0x12}
-	}
-	, {
-		sizeof(uint32_t), SOL_IPV6, IPV6_HOPLIMIT, {
-		0x21}
-	}
-,};
+	{sizeof(uint32_t), SOL_IPV6, IPV6_TCLASS, {0x12} },
+	{sizeof(uint32_t), SOL_IPV6, IPV6_HOPLIMIT, {0x21} },
+};
 
-#define CMCOUNT	(sizeof(cmtab)/sizeof(cmtab[0]))
+#define CMCOUNT	ARRAY_SIZE(cmtab)
 
-ssize_t sendall(int st)
+static ssize_t sendall(int st)
 {
 	struct sockaddr_in6 sin6;
 	struct msghdr msg;
 	struct iovec iov;
 	struct soprot *psop;
 	unsigned char *pd;
-	int i, ctotal;
+	unsigned int i;
+	int ctotal;
 
 	psop = (struct soprot *)tpbuf;
 	psop->sop_pid = htonl(getpid());
@@ -291,7 +243,7 @@ ssize_t sendall(int st)
 	return sendmsg(st, &msg, 0);
 }
 
-void so_test(struct soent *psoe)
+static void so_test(struct soent *psoe)
 {
 	struct sockaddr_in6 sin6;
 	union soval sobuf;
@@ -317,10 +269,9 @@ void so_test(struct soent *psoe)
 	memset(&sin6, 0, sizeof(sin6));
 	sin6.sin6_family = AF_INET6;
 	sin6.sin6_addr = in6addr_loopback;
-	if (bind(sr, (struct sockaddr *)&sin6, sizeof(sin6)) < 0) {
-		tst_resm(TBROK, "%s: bind: %s", psoe->so_tname,
-			 strerror(errno));
-	}
+
+	SAFE_BIND(NULL, sr, (struct sockaddr *)&sin6, sizeof(sin6));
+
 	if (setsockopt(sr, SOL_IPV6, psoe->so_opt, &psoe->so_clrval,
 		       psoe->so_valsize) < 0) {
 		tst_resm(TBROK, "%s: setsockopt: %s", psoe->so_tname,
@@ -345,12 +296,8 @@ void so_test(struct soent *psoe)
 	else
 		tst_resm(TPASS, "%s set-get", psoe->so_tname);
 
-	st = socket(PF_INET6, SOCK_RAW, NH_TEST);
-	if (st < 0) {
-		tst_resm(TBROK, "%s transmit socket: %s", psoe->so_tname,
-			 strerror(errno));
-		return;
-	}
+	st = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, NH_TEST);
+
 	if (sendall(st) < 0) {
 		tst_resm(TBROK, "%s transmit sendto: %s", psoe->so_tname,
 			 strerror(errno));
@@ -409,7 +356,7 @@ void so_test(struct soent *psoe)
 					 psoe->so_tname, strerror(errno));
 				return;
 			}
-/* check pid & seq here */
+			/* check pid & seq here */
 			break;
 		}
 		gotone = 0;
@@ -429,7 +376,7 @@ void so_test(struct soent *psoe)
 				return;
 			}
 		}
-/* check contents here */
+		/* check contents here */
 		if (psoe->so_dorecv)
 			tst_resm(gotone ? TPASS : TFAIL, "%s receive",
 				 psoe->so_tname);
@@ -451,20 +398,18 @@ static int ipv6_addr_scope(struct in6_addr *pin6)
 }
 #endif /* HAVE_IFADDRS_H */
 
-int getsock(char *tname, struct sockaddr_in6 *psin6_arg, int scope)
+static int getsock(char *tname, struct sockaddr_in6 *psin6_arg, int scope)
 {
 #ifdef HAVE_IFADDRS_H
 	static struct ifaddrs *pifa_head;
 	struct ifaddrs *pifa;
 	struct sockaddr_in6 *psin6;
-	char strbuf[128];
 	int ifindex = 0;
 	int s;
 
-	if (!pifa_head && getifaddrs(&pifa_head)) {
-		tst_resm(TBROK, "%s: getifaddrs failed", tname);
-		return -1;
-	}
+	if (!pifa_head && getifaddrs(&pifa_head))
+		tst_brkm(TBROK, NULL, "%s: getifaddrs failed", tname);
+
 	if (psin6_arg)
 		ifindex = psin6_arg->sin6_scope_id;
 
@@ -483,21 +428,16 @@ int getsock(char *tname, struct sockaddr_in6 *psin6_arg, int scope)
 		     (this_scope > 0 && this_scope != scope)))
 			continue;
 		psin6->sin6_scope_id = if_nametoindex(pifa->ifa_name);
-		if ((ifindex < 0 && -ifindex == psin6->sin6_scope_id) ||
-		    (ifindex > 0 && ifindex != psin6->sin6_scope_id))
+		if ((ifindex < 0 &&
+		     -(unsigned int)ifindex == psin6->sin6_scope_id) ||
+		    (ifindex > 0 &&
+		     (unsigned int)ifindex != psin6->sin6_scope_id))
 			continue;
-		s = socket(PF_INET6, SOCK_DGRAM, 0);
-		if (s < 0) {
-			tst_resm(TBROK, "%s: socket %s", tname,
-				 strerror(errno));
-			return -1;
-		}
-		if (bind(s, pifa->ifa_addr, sizeof(struct sockaddr_in6)) < 0) {
-			tst_resm(TBROK, "%s: bind \"%s\": %s", tname,
-				 inet_ntop(AF_INET6, &psin6->sin6_addr, strbuf,
-					   sizeof(strbuf)), strerror(errno));
-			return -1;
-		}
+
+		s = SAFE_SOCKET(NULL, PF_INET6, SOCK_DGRAM, 0);
+
+		SAFE_BIND(NULL, s, pifa->ifa_addr, sizeof(struct sockaddr_in6));
+
 		if (psin6_arg) {
 			*psin6_arg = *psin6;
 			psin6_arg->sin6_scope_id =
@@ -539,7 +479,10 @@ int getsock(char *tname, struct sockaddr_in6 *psin6_arg, int scope)
 	}
 	return -1;
 #else /* HAVE_IFADDRS_H */
+/*
 	return -1;
+*/
+	tst_brkm(TBROK, NULL, "HAVE_IFADDRS_H is not defined");
 #endif
 }
 
@@ -548,46 +491,28 @@ int getsock(char *tname, struct sockaddr_in6 *psin6_arg, int scope)
  * RFC 3542 IPV6_PKTINFO not in mainline yet (as of 2.6.15). The get/set
  * tests are below, and comments for some further tests to be added later
  */
-void test_pktinfo(void)
+static void test_pktinfo(void)
 {
-	int s_snd, s_rcv[3] = { -1, -1, -1 };
+	int s_snd;
 	struct sockaddr_in6 sa_rcv[3];
-	int s, i;
-	struct ifaddrs *pifa_head, *pifa;
-	struct sockaddr_in6 *psin6;
 	char strbuf[128];
 	char *tname = "IPV6_PKTINFO";
 	struct in6_pktinfo pi, pi_tmp;
-	int sinlen;
-	int optlen;
+	socklen_t optlen;
 
 	s_snd = getsock(tname, 0, IPV6_ADDR_GLOBAL);
-	if (s_snd < 0) {
-		tst_resm(TBROK, "%s: can't create send socket", tname);
-		return;
-	}
+
 	/* global-scope address, interface X */
 	sa_rcv[0].sin6_scope_id = 0;
-	s_rcv[0] = getsock(tname, &sa_rcv[0], IPV6_ADDR_GLOBAL);
-	if (s_rcv[0] == -1) {
-		tst_resm(TBROK, "%s: only link-scope addresses", tname);
-		return;
-	}
+	getsock(tname, &sa_rcv[0], IPV6_ADDR_GLOBAL);
+
 	/* link-local-scope address, interface X */
 	sa_rcv[1].sin6_scope_id = sa_rcv[0].sin6_scope_id;
-	s_rcv[1] = getsock(tname, &sa_rcv[1], IPV6_ADDR_LINK);
-	if (s_rcv[1] < 0) {
-		tst_resm(TBROK, "%s: no link-local address on ifindex %d",
-			 tname, sa_rcv[0].sin6_scope_id);
-		return;
-	}
+
+	getsock(tname, &sa_rcv[1], IPV6_ADDR_LINK);
 	/* link-local-scope address, interface Y */
 	sa_rcv[2].sin6_scope_id = -sa_rcv[0].sin6_scope_id;
-	s_rcv[2] = getsock(tname, &sa_rcv[2], IPV6_ADDR_LINK);
-	if (s_rcv[2] < 0) {
-		tst_resm(TBROK, "%s: only one interface?", tname);
-		return;
-	}
+	getsock(tname, &sa_rcv[2], IPV6_ADDR_LINK);
 	/* send to rcv1 to verify communication */
 	/* force to rcv2 w/ PKTINFO */
 /* TESTS: */
@@ -615,8 +540,8 @@ void test_pktinfo(void)
 				   sizeof(strbuf2)), pi.ipi6_ifindex);
 	} else
 		tst_resm(TPASS, "%s", tname);
-/* ancillary data override */
-/* link-local, wrong interface */
+	/* ancillary data override */
+	/* link-local, wrong interface */
 	tname = "IPV6_PKTINFO invalid {lladdr, intf}";
 	pi.ipi6_addr = sa_rcv[1].sin6_addr;
 	pi.ipi6_ifindex = sa_rcv[2].sin6_scope_id;
@@ -628,17 +553,12 @@ void test_pktinfo(void)
 		tst_resm(TFAIL, "%s errno %d != %d", tname, TEST_ERRNO, EINVAL);
 	else
 		tst_resm(TPASS, "%s", tname);
-/* nonexistent interface */
-/* non-local address */
-/* clear address */
-/* clear interface */
-/* sendmsg() sin6_scope differs with ancillary data interface */
 }
 #endif /* notyet */
 
-void do_tests(void)
+static void do_tests(void)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < SOCOUNT; ++i) {
 		sotab[i].so_clrval.sou_bool = 0;
@@ -650,11 +570,14 @@ void do_tests(void)
 #endif /* notyet - see test_pktinfo() comment above */
 }
 
-void setup(void)
+static void setup(void)
 {
-	TEST_PAUSE;		/* if -P option specified */
+	TEST_PAUSE;
+
+	tst_tmpdir();
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
+	tst_rmdir();
 }
-- 
1.9.3


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
