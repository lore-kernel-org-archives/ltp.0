Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Ycqx2-0007Aj-GH
	for ltp-list@lists.sourceforge.net; Tue, 31 Mar 2015 07:51:08 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ycqwv-0000uQ-Cs
	for ltp-list@lists.sourceforge.net; Tue, 31 Mar 2015 07:51:08 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t2V7npW4000378
	for <ltp-list@lists.sourceforge.net>; Tue, 31 Mar 2015 15:49:51 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Tue, 31 Mar 2015 15:46:11 +0800
Message-ID: <1427787975-10668-2-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/6] lib6/asapi_04.c: cleanup
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
To: ltp-list@lists.sourceforge.net

* Remove cleanup() function.
* Remove useless comments.
* Modify the format of ptab[] and cstab[].
* Move the test body from main() to (*testfunc[])().
* In every test function, using TINFO instead of TPASS
  marks the success of each inner test.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/network/lib6/asapi_04.c | 210 +++++++++++++++++++-------------------
 1 file changed, 103 insertions(+), 107 deletions(-)

diff --git a/testcases/network/lib6/asapi_04.c b/testcases/network/lib6/asapi_04.c
index 76de26b..58ed3bf 100644
--- a/testcases/network/lib6/asapi_04.c
+++ b/testcases/network/lib6/asapi_04.c
@@ -1,6 +1,7 @@
 /*
  *
  *   Copyright (c) International Business Machines  Corp., 2001
+ *   Author: David L Stevens
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -13,26 +14,13 @@
  *   the GNU General Public License for more details.
  *
  *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *   along with this program;  if not, write to the Free Software Foundation,
+ *   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
-
 /*
- * Test Name: asapi_04
- *
- * Test Description:
- *  Verify that in6 and sockaddr fields are present. Most of these are
- *  "PASS" if they just compile.
- *
- * Usage:  <for command-line>
- *  asapi_04
- *
- * HISTORY
- *	04/2005 written by David L Stevens
- *
- * RESTRICTIONS:
- *  None.
- *
+ *   Description:
+ *     Verify that in6 and sockaddr fields are present. Most of these are
+ *     "PASS" if they just compile.
  */
 
 #include <stdio.h>
@@ -49,36 +37,27 @@
 
 #include "test.h"
 
-char *TCID = "asapi_04";	/* Test program identifier.    */
+#define READ_TIMEOUT	5	/* secs */
 
 pid_t pid;
 
-struct {
-	char *prt_name;
-	int prt_value;
-} ptab[] = {
-	{
-	"hopopt", 0}, {
-	"ipv6", 41}, {
-	"ipv6-route", 43}, {
-	"ipv6-frag", 44}, {
-	"esp", 50}, {
-	"ah", 51}, {
-	"ipv6-icmp", 58}, {
-	"ipv6-nonxt", 59}, {
-"ipv6-opts", 60},};
-
-#define PTCOUNT	(sizeof(ptab)/sizeof(ptab[0]))
+static void setup(void);
+static void test_in6_are_addr_equal(void);
+static void test_protocols_entry(void);
+static int csum_test(char *rhost);
+static void test_ipv6_checksum(void);
 
-#define READ_TIMEOUT	5	/* secs */
 
-void do_tests(void);
-void setup(void), cleanup(void);
-int csum_test(char *rhost);
+static void (*testfunc[])(void) = { test_in6_are_addr_equal,
+	test_protocols_entry, test_ipv6_checksum };
+
+char *TCID = "asapi_04";
+int TST_TOTAL = ARRAY_SIZE(testfunc);
 
 int main(int argc, char *argv[])
 {
 	int lc;
+	int i;
 
 	tst_parse_opts(argc, argv, 0, 0);
 
@@ -86,22 +65,27 @@ int main(int argc, char *argv[])
 
 	setup();
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc)
-		do_tests();
+	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+		tst_count = 0;
 
-	cleanup();
+		for (i = 0; i < TST_TOTAL; i++)
+			(*testfunc[i])();
+	}
 
 	tst_exit();
 }
 
-void do_tests(void)
+void setup(void)
 {
-	int i;
+	TEST_PAUSE;
+}
 
 /* RFC 3542, Section 2.3 */
+void test_in6_are_addr_equal(void)
+{
 #ifndef IN6_ARE_ADDR_EQUAL
 	tst_resm(TBROK, "IN6_ARE_ADDR_EQUAL not present");
-#else /* IN6_ARE_ADDR_EQUAL */
+#else
 	/*
 	 * set each bit in an address and check for unequal; then set
 	 * in the second address and check for equal. Covers all bits, all
@@ -128,30 +112,56 @@ void do_tests(void)
 			}
 		tst_resm(rv ? TPASS : TFAIL, "IN6_ARE_ADDR_EQUAL");
 	}
-#endif /* IN6_ARE_ADDR_EQUAL */
+#endif
+}
+
+struct {
+	char *prt_name;
+	int prt_value;
+} ptab[] = {
+	{ "hopopt", 0 },
+	{ "ipv6", 41 },
+	{ "ipv6-route", 43 },
+	{ "ipv6-frag", 44 },
+	{ "esp", 50 },
+	{ "ah", 51 },
+	{ "ipv6-icmp", 58 },
+	{ "ipv6-nonxt", 59 },
+	{ "ipv6-opts", 60 },
+};
+
+#define PTCOUNT (sizeof(ptab)/sizeof(ptab[0]))
 
 /* RFC 3542, Section 2.4 */
+void test_protocols_entry(void)
+{
+	unsigned int i;
+
 	for (i = 0; i < PTCOUNT; ++i) {
 		struct protoent *pe;
 		int pass;
 
 		pe = getprotobyname(ptab[i].prt_name);
 		pass = pe && pe->p_proto == ptab[i].prt_value;
-		tst_resm(pass ? TPASS : TFAIL, "\"%s\" protocols entry",
-			 ptab[i].prt_name);
+		if (pass) {
+			tst_resm(TINFO, "\"%s\" protocols entry",
+				ptab[i].prt_name);
+		} else {
+			tst_resm(TFAIL, "\"%s\" protocols entry",
+				ptab[i].prt_name);
+			return;
+		}
 	}
+
+	tst_resm(TPASS, "protocols entry tests succeed");
+}
+
 /* RFC 3542, Section 3.1 */
+void test_ipv6_checksum(void)
+{
 	csum_test("::1");
 }
 
-/*
- * this next-header value shouldn't be a real protocol!!
- * 0x9f = 01 0 11111
- *         | |     |
- *         | |     |--- rest- ~0
- *         | |--------- chg - "no change enroute"
- *         |----------- act - "discard unknown"
- */
 #define	NH_TEST	0x9f
 
 struct tprot {
@@ -173,17 +183,13 @@ struct csent {
 	int cs_sndresult;	/* send expected result */
 	int cs_snderrno;	/* send expected errno */
 } cstab[] = {
-	{
-	0, 5, 0, 0, 0, 0}, {
-	6, 30, 0, 0, 0, 0}, {
-	3, 20, -1, EINVAL, -1, -1},	/* non-aligned offset */
-	{
-	4, 5, 0, 0, -1, EINVAL},	/* not enough space */
-	{
-	50, 5, 0, 0, -1, EINVAL},	/* outside of packet */
-	{
-	22, 30, 0, 0, 0, 0}, {
-	2000, 2004, 0, 0, 0, 0},	/* in a fragment (over Ethernet) */
+	{ 0, 5, 0, 0, 0, 0 },
+	{ 6, 30, 0, 0, 0, 0 },
+	{ 3, 20, -1, EINVAL, -1, -1 },	/* non-aligned offset */
+	{ 4, 5, 0, 0, -1, EINVAL },	/* not enough space */
+	{ 50, 5, 0, 0, -1, EINVAL },	/* outside of packet */
+	{ 22, 30, 0, 0, 0, 0 },
+	{ 2000, 2004, 0, 0, 0, 0 },	/* in a fragment (over Ethernet) */
 };
 
 #define CSCOUNT	(sizeof(cstab)/sizeof(cstab[0]))
@@ -197,7 +203,7 @@ static int recvtprot(int sd, unsigned char *packet, int psize)
 	tpt = (struct tprot *)packet;
 	total = cc = recv(sd, packet, sizeof(struct tprot), 0);
 	expected = sizeof(struct tprot);	/* until we get tp_dlen */
-	gothead = total >= sizeof(struct tprot);
+	gothead = (unsigned int)total >= sizeof(struct tprot);
 	if (gothead)
 		expected += ntohl(tpt->tp_dlen);
 	if (cc <= 0)
@@ -206,7 +212,8 @@ static int recvtprot(int sd, unsigned char *packet, int psize)
 		cc = recv(sd, &packet[total], expected - total, 0);
 		if (cc >= 0) {
 			total += cc;
-			if (!gothead && total >= sizeof(struct tprot)) {
+			if (!gothead && (unsigned int)total >=
+				sizeof(struct tprot)) {
 				gothead = 1;
 				expected += ntohl(tpt->tp_dlen);
 			}
@@ -248,7 +255,8 @@ static int client(int prot, int sfd)
 	struct tprot *prtp = (struct tprot *)rpbuf;
 	struct sockaddr_in6 rsin6;
 	static int seq;
-	int i, sd, cc, cs;
+	unsigned int i;
+	int sd, cc, cs;
 
 	memset(&rsin6, 0, sizeof(rsin6));
 	rsin6.sin6_family = AF_INET6;
@@ -261,8 +269,8 @@ static int client(int prot, int sfd)
 
 	sd = socket(PF_INET6, SOCK_RAW, NH_TEST);
 	if (sd < 0) {
-		tst_resm(TBROK, "can't create raw socket: %s", strerror(errno));
-		return -1;
+		tst_brkm(TBROK | TERRNO, NULL, "can't create raw socket: %s",
+			strerror(errno));
 	}
 	for (i = 0; i < CSCOUNT; ++i) {
 		int offset, len, xlen;
@@ -287,10 +295,10 @@ static int client(int prot, int sfd)
 				 "IPV6_CHECKSUM offset %d len %d "
 				 "- result %ld != %d", offset, len, TEST_RETURN,
 				 cstab[i].cs_setresult);
-			continue;
+			return -1;
 		}
 		if (TEST_RETURN < 0) {
-			tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d",
+			tst_resm(TINFO, "IPV6_CHECKSUM offset %d len %d",
 				 offset, len);
 			continue;
 		}
@@ -298,7 +306,7 @@ static int client(int prot, int sfd)
 			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d "
 				 "- errno %d != %d", offset, len,
 				 TEST_ERRNO, cstab[i].cs_seterrno);
-			continue;
+			return -1;
 		}
 		/* send packet */
 		TEST(sendto(sd, pttp, len, 0, (struct sockaddr *)&rsin6,
@@ -309,22 +317,22 @@ static int client(int prot, int sfd)
 				 "IPV6_CHECKSUM offset %d len %d "
 				 "- sndresult %ld != %d", offset, len,
 				 TEST_RETURN, xlen);
-			continue;
+			return -1;
 		}
 		if (TEST_RETURN < 0 && TEST_ERRNO != cstab[i].cs_snderrno) {
 			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d "
 				 "- snderrno %d != %d", offset, len,
 				 TEST_ERRNO, cstab[i].cs_snderrno);
-			continue;
+			return -1;
 		}
 		if (TEST_RETURN < 0) {
-			tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d",
+			tst_resm(TINFO, "IPV6_CHECKSUM offset %d len %d",
 				 offset, len);
 			continue;
 		}
 		while ((cc = recvtprot(sfd, rpbuf, sizeof(rpbuf)))) {
-			if (htonl(prtp->tp_pid) == pid &&
-			    htonl(prtp->tp_seq) == seq)
+			if (htonl(prtp->tp_pid) == (uint32_t)pid &&
+			    htonl(prtp->tp_seq) == (uint32_t)seq)
 				break;
 		}
 		rv = 1;
@@ -334,10 +342,10 @@ static int client(int prot, int sfd)
 				continue;
 			if (*p != 0xa5) {
 				tst_resm(TFAIL, "IPV6_CHECKSUM corrupt data "
-					 "0x%02x != 0xa5 at offset %d in packet",
+					 "0x%02x != 0xa5 at offset %ld in packet",
 					 *p, p - rpbuf);
 				rv = 0;
-				break;
+				return -1;
 			}
 		}
 		if (rv == 0)
@@ -348,10 +356,12 @@ static int client(int prot, int sfd)
 		if (!csum(0, rpbuf, xlen)) {
 			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d (bad "
 				 "checksum)", offset, len);
-			continue;
+			return -1;
 		}
-		tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d", offset, len);
+		tst_resm(TINFO, "IPV6_CHECKSUM offset %d len %d", offset, len);
 	}
+
+	tst_resm(TPASS, "IPV6_CHECKSUM tests succeed");
 	return 0;
 }
 
@@ -372,7 +382,7 @@ int isocketpair(int pf, int type, int proto, int fd[2])
 	struct sockaddr_in sin4;
 	socklen_t namelen;
 
-/* restrict to PF_INET for now */
+	/* restrict to PF_INET for now */
 	if (pf != PF_INET) {
 		errno = EOPNOTSUPP;
 		return -1;
@@ -420,7 +430,7 @@ int isocketpair(int pf, int type, int proto, int fd[2])
 
 #ifndef MAX
 #define MAX(a, b) ((a) >= (b) ? (a) : (b))
-#endif /* MAX */
+#endif
 
 int csum_test(char *rhost)
 {
@@ -429,25 +439,23 @@ int csum_test(char *rhost)
 	int sd, nfds, maxfd, cc;
 	struct timeval tv;
 
-/* rhost == loopback, for now */
+	/* rhost == loopback, for now */
 	if (strcmp(rhost, "::1")) {
-		tst_resm(TBROK, "invalid rhost \"%s\"", rhost);
-		return -1;
+		tst_brkm(TBROK, NULL, "invalid rhost \"%s\"", rhost);
 	}
 	if (isocketpair(PF_INET, SOCK_STREAM, 0, csd) < 0) {
-		tst_resm(TBROK, "socketpair: %s", strerror(errno));
-		return -1;
+		tst_brkm(TBROK, NULL, "socketpair: %s", strerror(errno));
 	}
 	sd = socket(PF_INET6, SOCK_RAW, NH_TEST);
 	if (sd < 0) {
 		int saved_errno = errno;
 
 		if (errno == EPERM && geteuid())
-			tst_resm(TBROK, "IPV6_CHECKSUM tests must run as root");
+			tst_brkm(TBROK, NULL, "IPV6_CHECKSUM tests must "
+				"run as root");
 		else
-			tst_resm(TBROK, "All IPv6_CHECKSUM tests broken: "
+			tst_brkm(TBROK, NULL, "All IPv6_CHECKSUM tests broken: "
 				 "socket: %s", strerror(saved_errno));
-		return -1;
 	}
 	FD_ZERO(&rset_save);
 	FD_SET(sd, &rset_save);
@@ -461,8 +469,7 @@ int csum_test(char *rhost)
 		close(csd[0]);
 		break;
 	case -1:
-		tst_resm(TBROK, "can't fork rserver");
-		return -1;
+		tst_brkm(TBROK, NULL, "can't fork rserver");
 	default:		/* parent */
 		close(sd);
 		close(csd[1]);
@@ -514,14 +521,3 @@ int csum_test(char *rhost)
 	}
 	return 0;
 }
-
-void setup(void)
-{
-	TEST_PAUSE;		/* if -P option specified */
-}
-
-void cleanup(void)
-{
-}
-
-int TST_TOTAL = PTCOUNT + CSCOUNT;
-- 
1.9.3


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
