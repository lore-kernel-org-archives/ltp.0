From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 14 Oct 2015 16:21:19 +0800
Subject: [LTP] [PATCH v9 3/8] lib6/asapi_04.c: Cleanup
In-Reply-To: <1444810884-32508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <561CE0B0.2000801@oracle.com>
 <1444810884-32508-1-git-send-email-zenglg.jy@cn.fujitsu.com>
Message-ID: <1444810884-32508-3-git-send-email-zenglg.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Add 'static' before some functions and global variables.
* Remove useless comments.
* Use SAFE_XXX().
* Modify the format of ptab[] and cstab[].
* Use 'pthread_join()' instead of 'sem_*'.
* Rewrite 'csum_test()' and 'isocketpair()'.
* Remove cleanup().
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/lib6/asapi_04.c | 301 +++++++++++++++-----------------------
 1 file changed, 117 insertions(+), 184 deletions(-)

diff --git a/testcases/network/lib6/asapi_04.c b/testcases/network/lib6/asapi_04.c
index 76de26b..df26494 100644
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
@@ -48,33 +31,33 @@
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
 
-#define READ_TIMEOUT	5	/* secs */
+#define PTCOUNT		ARRAY_SIZE(ptab)
+#define READ_TIMEOUT	5
 
-void do_tests(void);
-void setup(void), cleanup(void);
-int csum_test(char *rhost);
+static void do_tests(void);
+static void setup(void);
+static void csum_test(void);
 
 int main(int argc, char *argv[])
 {
@@ -82,52 +65,48 @@ int main(int argc, char *argv[])
 
 	tst_parse_opts(argc, argv, 0, 0);
 
-	pid = getpid();
-
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc)
 		do_tests();
 
-	cleanup();
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
+	for (word = 0; word < 4; ++word) {
+		for (bit = 0; bit < 32; ++bit) {
+			uint32_t newbit = 1U << bit;
 
-				a1.s6_addr32[word] |= newbit;	/* unequal */
-				rv &= !IN6_ARE_ADDR_EQUAL(&a1, &a2);
-				a2.s6_addr32[word] |= newbit;	/* equal */
-				rv &= IN6_ARE_ADDR_EQUAL(&a1, &a2);
-			}
-		tst_resm(rv ? TPASS : TFAIL, "IN6_ARE_ADDR_EQUAL");
+			a1.s6_addr32[word] |= newbit;
+			rv &= !IN6_ARE_ADDR_EQUAL(&a1, &a2);
+			a2.s6_addr32[word] |= newbit;
+			rv &= IN6_ARE_ADDR_EQUAL(&a1, &a2);
+		}
 	}
+
+	tst_resm(rv ? TPASS : TFAIL, "IN6_ARE_ADDR_EQUAL");
 #endif /* IN6_ARE_ADDR_EQUAL */
 
 /* RFC 3542, Section 2.4 */
@@ -141,7 +120,7 @@ void do_tests(void)
 			 ptab[i].prt_name);
 	}
 /* RFC 3542, Section 3.1 */
-	csum_test("::1");
+	csum_test();
 }
 
 /*
@@ -162,10 +141,10 @@ struct tprot {
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
@@ -173,25 +152,24 @@ struct csent {
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
 
-static int recvtprot(int sd, unsigned char *packet, int psize)
+int TST_TOTAL = PTCOUNT + CSCOUNT;
+
+static int recvtprot(int sd, unsigned char *packet)
 {
 	struct tprot *tpt;
-	int cc, total, expected;
+	int cc;
+	unsigned int total, expected;
 	int gothead;
 
 	tpt = (struct tprot *)packet;
@@ -210,15 +188,17 @@ static int recvtprot(int sd, unsigned char *packet, int psize)
 				gothead = 1;
 				expected += ntohl(tpt->tp_dlen);
 			}
-		} else
+		} else {
 			break;
+		}
 	}
 	if (cc < 0)
 		return cc;
 	return total;
 }
 
-unsigned short csum(unsigned short partial, unsigned char *packet, int len)
+static unsigned short csum(unsigned short partial, unsigned char *packet,
+			   int len)
 {
 	unsigned long sum = partial;
 	unsigned short *ps;
@@ -234,7 +214,7 @@ unsigned short csum(unsigned short partial, unsigned char *packet, int len)
 	return ~sum;
 }
 
-struct ph {
+static struct ph {
 	struct in6_addr ph_sa;
 	struct in6_addr ph_da;
 	uint32_t ph_len;
@@ -242,13 +222,14 @@ struct ph {
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
@@ -259,11 +240,8 @@ static int client(int prot, int sfd)
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
@@ -322,9 +300,9 @@ static int client(int prot, int sfd)
 				 offset, len);
 			continue;
 		}
-		while ((cc = recvtprot(sfd, rpbuf, sizeof(rpbuf)))) {
-			if (htonl(prtp->tp_pid) == pid &&
-			    htonl(prtp->tp_seq) == seq)
+		while ((cc = recvtprot(sfd, rpbuf))) {
+			if (htonl(prtp->tp_pid) == (uint32_t)pid &&
+			    htonl(prtp->tp_seq) == (uint32_t)seq)
 				break;
 		}
 		rv = 1;
@@ -334,7 +312,7 @@ static int client(int prot, int sfd)
 				continue;
 			if (*p != 0xa5) {
 				tst_resm(TFAIL, "IPV6_CHECKSUM corrupt data "
-					 "0x%02x != 0xa5 at offset %d in packet",
+					 "0x%02x != 0xa5 at offset %zd in packet",
 					 *p, p - rpbuf);
 				rv = 0;
 				break;
@@ -356,99 +334,60 @@ static int client(int prot, int sfd)
 }
 
 static int listen_fd, connect_fd;
-sem_t ilsem;
 
-void *ilistener(void *arg)
+static void *ilistener(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	connect_fd = accept(listen_fd, 0, 0);
 	close(listen_fd);
-	sem_post(&ilsem);
 	return NULL;
 }
 
-int isocketpair(int pf, int type, int proto, int fd[2])
+static void isocketpair(int pf, int type, int proto, int fd[2])
 {
 	pthread_t thid;
 	struct sockaddr_in sin4;
 	socklen_t namelen;
 
-/* restrict to PF_INET for now */
-	if (pf != PF_INET) {
-		errno = EOPNOTSUPP;
-		return -1;
-	}
-	sem_init(&ilsem, 0, 0);
-	listen_fd = socket(pf, type, proto);
-	if (listen_fd < 0) {
-		perror("socket");
-		return -1;
-	}
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
-	sem_wait(&ilsem);
+
+	SAFE_CONNECT(NULL, fd[0], (struct sockaddr *)&sin4, sizeof(sin4));
+
+	pthread_join(thid, NULL);
+
 	fd[1] = connect_fd;
-	sem_destroy(&ilsem);
-	return 0;
 }
 
 #ifndef MAX
 #define MAX(a, b) (@ >= (b) ? (a) : (b))
 #endif /* MAX */
 
-int csum_test(char *rhost)
+static void csum_test(void)
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
@@ -457,16 +396,16 @@ int csum_test(char *rhost)
 
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
+		client(csd[0]);
+		return;
 	}
 
 	tv.tv_sec = READ_TIMEOUT;
@@ -478,7 +417,7 @@ int csum_test(char *rhost)
 			exit(0);
 		} else if (nfds == 0) {
 			fprintf(stderr, "server read timed out");
-			return -1;
+			return;
 		}
 		if (FD_ISSET(sd, &rset)) {
 			static char packet[2048];
@@ -499,9 +438,8 @@ int csum_test(char *rhost)
 			char buf[2048];
 
 			cc = read(csd[1], buf, sizeof(buf));
-			if (cc == 0) {
+			if (cc == 0)
 				exit(0);
-			}
 			if (cc < 0) {
 				perror("server read");
 				exit(1);
@@ -512,16 +450,11 @@ int csum_test(char *rhost)
 		tv.tv_sec = READ_TIMEOUT;
 		tv.tv_usec = 0;
 	}
-	return 0;
 }
 
-void setup(void)
+static void setup(void)
 {
-	TEST_PAUSE;		/* if -P option specified */
-}
+	TEST_PAUSE;
 
-void cleanup(void)
-{
+	pid = getpid();
 }
-
-int TST_TOTAL = PTCOUNT + CSCOUNT;
-- 
1.9.3

