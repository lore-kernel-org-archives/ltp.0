Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZFbkY-0007tX-P9
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 05:30:26 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZFbkW-0000oj-9k
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 05:30:26 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 16 Jul 2015 13:30:42 +0800
Message-ID: <1437024647-2066-6-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <55A680FC.2010807@oracle.com>
	<1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v5 06/11] lib6/asapi_04.c: Cleanup
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
* Remove useless comments.
* Use SAFE_XXX().
* Modify the format of ptab[] and cstab[].
* Rewrite 'csum_test()' and 'isocketpair()'.
* Use 'tst_tmpdir' and 'tst_rmdir'.
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/lib6/asapi_04.c | 287 ++++++++++++++++----------------------
 1 file changed, 122 insertions(+), 165 deletions(-)

diff --git a/testcases/network/lib6/asapi_04.c b/testcases/network/lib6/asapi_04.c
index 76de26b..76e8f8e 100644
--- a/testcases/network/lib6/asapi_04.c
+++ b/testcases/network/lib6/asapi_04.c
@@ -1,38 +1,21 @@
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
+ * Author: David L Stevens
  */
 
 #include <stdio.h>
@@ -48,33 +31,35 @@
 #include <netinet/in.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
-char *TCID = "asapi_04";	/* Test program identifier.    */
+char *TCID = "asapi_04";
 
-pid_t pid;
+static pid_t pid;
 
-struct {
+static struct {
 	char *prt_name;
 	int prt_value;
 } ptab[] = {
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
+	{"hopopt", 0},
+	{"ipv6", 41},
+	{"ipv6-route", 43},
+	{"ipv6-frag", 44},
+	{"esp", 50},
+	{"ah", 51},
+	{"ipv6-icmp", 58},
+	{"ipv6-nonxt", 59},
+	{"ipv6-opts", 60},
+};
+
+#define PTCOUNT	ARRAY_SIZE(ptab)
 
 #define READ_TIMEOUT	5	/* secs */
 
-void do_tests(void);
-void setup(void), cleanup(void);
-int csum_test(char *rhost);
+static void do_tests(void);
+static void setup(void);
+static void cleanup(void);
+static int csum_test(void);
 
 int main(int argc, char *argv[])
 {
@@ -90,44 +75,41 @@ int main(int argc, char *argv[])
 		do_tests();
 
 	cleanup();
-
 	tst_exit();
 }
 
-void do_tests(void)
+static void do_tests(void)
 {
-	int i;
+	unsigned int i;
 
 /* RFC 3542, Section 2.3 */
 #ifndef IN6_ARE_ADDR_EQUAL
-	tst_resm(TBROK, "IN6_ARE_ADDR_EQUAL not present");
+	tst_resm(TCONF, "IN6_ARE_ADDR_EQUAL not present");
 #else /* IN6_ARE_ADDR_EQUAL */
 	/*
 	 * set each bit in an address and check for unequal; then set
 	 * in the second address and check for equal. Covers all bits, all
 	 * combinations.
 	 */
-	{
-		struct in6_addr a1, a2;
-		int word, bit;
-		int rv = 1;
+	struct in6_addr a1, a2;
+	int word, bit;
+	int rv = 1;
 
-		memset(&a1, 0, sizeof(a1));
-		memset(&a2, 0, sizeof(a2));
+	memset(&a1, 0, sizeof(a1));
+	memset(&a2, 0, sizeof(a2));
 
-		rv = IN6_ARE_ADDR_EQUAL(&a1, &a2);
+	rv = IN6_ARE_ADDR_EQUAL(&a1, &a2);
 
-		for (word = 0; word < 4; ++word)
-			for (bit = 0; bit < 32; ++bit) {
-				uint32_t newbit = 1 << bit;
+	for (word = 0; word < 4; ++word)
+		for (bit = 0; bit < 32; ++bit) {
+			uint32_t newbit = 1U << bit;
 
-				a1.s6_addr32[word] |= newbit;	/* unequal */
-				rv &= !IN6_ARE_ADDR_EQUAL(&a1, &a2);
-				a2.s6_addr32[word] |= newbit;	/* equal */
-				rv &= IN6_ARE_ADDR_EQUAL(&a1, &a2);
-			}
-		tst_resm(rv ? TPASS : TFAIL, "IN6_ARE_ADDR_EQUAL");
-	}
+			a1.s6_addr32[word] |= newbit;	/* unequal */
+			rv &= !IN6_ARE_ADDR_EQUAL(&a1, &a2);
+			a2.s6_addr32[word] |= newbit;	/* equal */
+			rv &= IN6_ARE_ADDR_EQUAL(&a1, &a2);
+		}
+	tst_resm(rv ? TPASS : TFAIL, "IN6_ARE_ADDR_EQUAL");
 #endif /* IN6_ARE_ADDR_EQUAL */
 
 /* RFC 3542, Section 2.4 */
@@ -141,7 +123,7 @@ void do_tests(void)
 			 ptab[i].prt_name);
 	}
 /* RFC 3542, Section 3.1 */
-	csum_test("::1");
+	csum_test();
 }
 
 /*
@@ -162,10 +144,10 @@ struct tprot {
 	unsigned char tp_dat[0];	/* user data */
 };
 
-unsigned char tpbuf[sizeof(struct tprot) + 2048];
-unsigned char rpbuf[sizeof(struct tprot) + 2048];
+static unsigned char tpbuf[sizeof(struct tprot) + 2048];
+static unsigned char rpbuf[sizeof(struct tprot) + 2048];
 
-struct csent {
+static struct csent {
 	int cs_offset;
 	int cs_dlen;
 	int cs_setresult;	/* setsockopt expected result */
@@ -173,25 +155,24 @@ struct csent {
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
+	{0, 5, 0, 0, 0, 0},
+	{6, 30, 0, 0, 0, 0},
+	{3, 20, -1, EINVAL, -1, -1},	/* non-aligned offset */
+	{4, 5, 0, 0, -1, EINVAL},	/* not enough space */
+	{50, 5, 0, 0, -1, EINVAL},	/* outside of packet */
+	{22, 30, 0, 0, 0, 0},
+	{2000, 2004, 0, 0, 0, 0},	/* in a fragment (over Ethernet) */
 };
 
-#define CSCOUNT	(sizeof(cstab)/sizeof(cstab[0]))
+#define CSCOUNT	ARRAY_SIZE(cstab)
+
+int TST_TOTAL = PTCOUNT + CSCOUNT;
 
-static int recvtprot(int sd, unsigned char *packet, int psize)
+static int recvtprot(int sd, unsigned char *packet)
 {
 	struct tprot *tpt;
-	int cc, total, expected;
+	int cc;
+	unsigned int total, expected;
 	int gothead;
 
 	tpt = (struct tprot *)packet;
@@ -218,7 +199,8 @@ static int recvtprot(int sd, unsigned char *packet, int psize)
 	return total;
 }
 
-unsigned short csum(unsigned short partial, unsigned char *packet, int len)
+static unsigned short csum(unsigned short partial, unsigned char *packet,
+			   int len)
 {
 	unsigned long sum = partial;
 	unsigned short *ps;
@@ -234,7 +216,7 @@ unsigned short csum(unsigned short partial, unsigned char *packet, int len)
 	return ~sum;
 }
 
-struct ph {
+static struct ph {
 	struct in6_addr ph_sa;
 	struct in6_addr ph_da;
 	uint32_t ph_len;
@@ -242,13 +224,14 @@ struct ph {
 	uint8_t ph_nh;
 } ph;
 
-static int client(int prot, int sfd)
+static int client(int sfd)
 {
 	struct tprot *pttp = (struct tprot *)tpbuf;
 	struct tprot *prtp = (struct tprot *)rpbuf;
 	struct sockaddr_in6 rsin6;
 	static int seq;
-	int i, sd, cc, cs;
+	unsigned int i;
+	int sd, cc, cs;
 
 	memset(&rsin6, 0, sizeof(rsin6));
 	rsin6.sin6_family = AF_INET6;
@@ -259,11 +242,8 @@ static int client(int prot, int sfd)
 	ph.ph_da = rsin6.sin6_addr;
 	ph.ph_nh = NH_TEST;
 
-	sd = socket(PF_INET6, SOCK_RAW, NH_TEST);
-	if (sd < 0) {
-		tst_resm(TBROK, "can't create raw socket: %s", strerror(errno));
-		return -1;
-	}
+	sd = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, NH_TEST);
+
 	for (i = 0; i < CSCOUNT; ++i) {
 		int offset, len, xlen;
 		int rv;
@@ -289,17 +269,20 @@ static int client(int prot, int sfd)
 				 cstab[i].cs_setresult);
 			continue;
 		}
+
 		if (TEST_RETURN < 0) {
 			tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d",
 				 offset, len);
 			continue;
 		}
+
 		if (TEST_RETURN && TEST_ERRNO != cstab[i].cs_seterrno) {
 			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d "
 				 "- errno %d != %d", offset, len,
 				 TEST_ERRNO, cstab[i].cs_seterrno);
 			continue;
 		}
+
 		/* send packet */
 		TEST(sendto(sd, pttp, len, 0, (struct sockaddr *)&rsin6,
 			    sizeof(rsin6)));
@@ -311,20 +294,23 @@ static int client(int prot, int sfd)
 				 TEST_RETURN, xlen);
 			continue;
 		}
+
 		if (TEST_RETURN < 0 && TEST_ERRNO != cstab[i].cs_snderrno) {
 			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d "
 				 "- snderrno %d != %d", offset, len,
 				 TEST_ERRNO, cstab[i].cs_snderrno);
 			continue;
 		}
+
 		if (TEST_RETURN < 0) {
 			tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d",
 				 offset, len);
 			continue;
 		}
-		while ((cc = recvtprot(sfd, rpbuf, sizeof(rpbuf)))) {
-			if (htonl(prtp->tp_pid) == pid &&
-			    htonl(prtp->tp_seq) == seq)
+
+		while ((cc = recvtprot(sfd, rpbuf))) {
+			if (htonl(prtp->tp_pid) == (uint32_t)pid &&
+			    htonl(prtp->tp_seq) == (uint32_t)seq)
 				break;
 		}
 		rv = 1;
@@ -334,7 +320,7 @@ static int client(int prot, int sfd)
 				continue;
 			if (*p != 0xa5) {
 				tst_resm(TFAIL, "IPV6_CHECKSUM corrupt data "
-					 "0x%02x != 0xa5 at offset %d in packet",
+					 "0x%02x != 0xa5 at offset %zd in packet",
 					 *p, p - rpbuf);
 				rv = 0;
 				break;
@@ -358,7 +344,7 @@ static int client(int prot, int sfd)
 static int listen_fd, connect_fd;
 sem_t ilsem;
 
-void *ilistener(void *arg)
+static void *ilistener(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	connect_fd = accept(listen_fd, 0, 0);
 	close(listen_fd);
@@ -366,7 +352,7 @@ void *ilistener(void *arg)
 	return NULL;
 }
 
-int isocketpair(int pf, int type, int proto, int fd[2])
+static void isocketpair(int pf, int type, int proto, int fd[2])
 {
 	pthread_t thid;
 	struct sockaddr_in sin4;
@@ -375,80 +361,51 @@ int isocketpair(int pf, int type, int proto, int fd[2])
 /* restrict to PF_INET for now */
 	if (pf != PF_INET) {
 		errno = EOPNOTSUPP;
-		return -1;
+		return;
 	}
+
 	sem_init(&ilsem, 0, 0);
-	listen_fd = socket(pf, type, proto);
-	if (listen_fd < 0) {
-		perror("socket");
-		return -1;
-	}
+
+	listen_fd = SAFE_SOCKET(NULL, pf, type, proto);
+
 	memset(&sin4, 0, sizeof(sin4));
-	if (bind(listen_fd, (struct sockaddr *)&sin4, sizeof(sin4)) < 0) {
-		perror("bind");
-		return -1;
-	}
-	if (listen(listen_fd, 10) < 0) {
-		perror("listen");
-		return -1;
-	}
+
+	SAFE_BIND(NULL, listen_fd, (struct sockaddr *)&sin4, sizeof(sin4));
+
+	SAFE_LISTEN(NULL, listen_fd, 10);
+
 	namelen = sizeof(sin4);
-	if (getsockname(listen_fd, (struct sockaddr *)&sin4, &namelen) < 0) {
-		perror("getsockname");
-		return -1;
-	}
-	if (pthread_create(&thid, 0, ilistener, 0) < 0) {
-		perror("pthread_create");
-		return -1;
-	}
+	SAFE_GETSOCKNAME(NULL, listen_fd, (struct sockaddr *)&sin4, &namelen);
+
+	if (pthread_create(&thid, 0, ilistener, 0) < 0)
+		tst_brkm(TBROK | TERRNO, NULL, "pthread_create error");
+
+	fd[0] = SAFE_SOCKET(NULL, pf, type, proto);
 
-	fd[0] = socket(pf, type, proto);
-	if (fd[0] < 0) {
-		perror("socket");
-		return -1;
-	}
 	sin4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-	if (connect(fd[0], (struct sockaddr *)&sin4, sizeof(sin4)) < 0) {
-		perror("connect");
-		return -1;
-	}
+
+	SAFE_CONNECT(NULL, fd[0], (struct sockaddr *)&sin4, sizeof(sin4));
+
 	sem_wait(&ilsem);
 	fd[1] = connect_fd;
 	sem_destroy(&ilsem);
-	return 0;
 }
 
 #ifndef MAX
 #define MAX(a, b) ((a) >= (b) ? (a) : (b))
 #endif /* MAX */
 
-int csum_test(char *rhost)
+static int csum_test(void)
 {
 	fd_set rset, rset_save;
 	int csd[2];		/* control sockets */
 	int sd, nfds, maxfd, cc;
 	struct timeval tv;
 
-/* rhost == loopback, for now */
-	if (strcmp(rhost, "::1")) {
-		tst_resm(TBROK, "invalid rhost \"%s\"", rhost);
-		return -1;
-	}
-	if (isocketpair(PF_INET, SOCK_STREAM, 0, csd) < 0) {
-		tst_resm(TBROK, "socketpair: %s", strerror(errno));
-		return -1;
-	}
-	sd = socket(PF_INET6, SOCK_RAW, NH_TEST);
-	if (sd < 0) {
-		int saved_errno = errno;
-
-		if (errno == EPERM && geteuid())
-			tst_resm(TBROK, "IPV6_CHECKSUM tests must run as root");
-		else
-			tst_resm(TBROK, "All IPv6_CHECKSUM tests broken: "
-				 "socket: %s", strerror(saved_errno));
-		return -1;
-	}
+	isocketpair(PF_INET, SOCK_STREAM, 0, csd);
+
+	sd = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, NH_TEST);
+
 	FD_ZERO(&rset_save);
 	FD_SET(sd, &rset_save);
 	FD_SET(csd[1], &rset_save);
@@ -457,16 +414,15 @@ int csum_test(char *rhost)
 
 	/* server socket set; now start the client */
 	switch (fork()) {
-	case 0:		/* child */
+	case 0:
 		close(csd[0]);
 		break;
 	case -1:
-		tst_resm(TBROK, "can't fork rserver");
-		return -1;
-	default:		/* parent */
+		tst_brkm(TBROK, NULL, "can't fork rserver");
+	default:
 		close(sd);
 		close(csd[1]);
-		return client(pid, csd[0]);
+		return client(csd[0]);
 	}
 
 	tv.tv_sec = READ_TIMEOUT;
@@ -515,13 +471,14 @@ int csum_test(char *rhost)
 	return 0;
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
-
-int TST_TOTAL = PTCOUNT + CSCOUNT;
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
