From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 21 Oct 2015 11:15:28 +0800
Subject: [LTP] [PATCH v10 7/8] lib6: Rename
In-Reply-To: <1445397329-23582-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <5625F654.7090602@oracle.com>
 <1445397329-23582-1-git-send-email-zenglg.jy@cn.fujitsu.com>
Message-ID: <1445397329-23582-7-git-send-email-zenglg.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

rename:    asapi_04.c -> asapi_01.c
rename:    asapi_05.c -> asapi_02.c
rename:    asapi_06.c -> asapi_03.c

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 runtest/ipv6_lib                  |   6 +-
 testcases/network/.gitignore      |   6 +-
 testcases/network/lib6/asapi_01.c | 460 ++++++++++++++++++++++++++++++++++++++
 testcases/network/lib6/asapi_02.c | 261 +++++++++++++++++++++
 testcases/network/lib6/asapi_03.c | 385 +++++++++++++++++++++++++++++++
 testcases/network/lib6/asapi_04.c | 460 --------------------------------------
 testcases/network/lib6/asapi_05.c | 261 ---------------------
 testcases/network/lib6/asapi_06.c | 385 -------------------------------
 8 files changed, 1112 insertions(+), 1112 deletions(-)
 create mode 100644 testcases/network/lib6/asapi_01.c
 create mode 100644 testcases/network/lib6/asapi_02.c
 create mode 100644 testcases/network/lib6/asapi_03.c
 delete mode 100644 testcases/network/lib6/asapi_04.c
 delete mode 100644 testcases/network/lib6/asapi_05.c
 delete mode 100644 testcases/network/lib6/asapi_06.c

diff --git a/runtest/ipv6_lib b/runtest/ipv6_lib
index 203e275..636232b 100644
--- a/runtest/ipv6_lib
+++ b/runtest/ipv6_lib
@@ -2,6 +2,6 @@
 in6_01 in6_01
 in6_02 in6_02
 getaddrinfo_01 getaddrinfo_01
-asapi_04 asapi_04
-asapi_05 asapi_05
-asapi_06 asapi_06
+asapi_01 asapi_01
+asapi_02 asapi_02
+asapi_03 asapi_03
diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
index 18b0203..77a350b 100644
--- a/testcases/network/.gitignore
+++ b/testcases/network/.gitignore
@@ -1,9 +1,9 @@
 /can/filter-tests/can_filter
 /can/filter-tests/can_rcv_own_msgs
 /datafiles/
-/lib6/asapi_04
-/lib6/asapi_05
-/lib6/asapi_06
+/lib6/asapi_01
+/lib6/asapi_02
+/lib6/asapi_03
 /lib6/getaddrinfo_01
 /lib6/in6_01
 /lib6/in6_02
diff --git a/testcases/network/lib6/asapi_01.c b/testcases/network/lib6/asapi_01.c
new file mode 100644
index 0000000..ff310ea
--- /dev/null
+++ b/testcases/network/lib6/asapi_01.c
@@ -0,0 +1,460 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Copyright (c) International Business Machines  Corp., 2001
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: David L Stevens
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <netdb.h>
+#include <libgen.h>
+#include <pthread.h>
+#include <semaphore.h>
+
+#include <sys/time.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+
+#include "test.h"
+#include "safe_macros.h"
+
+char *TCID = "asapi_04";
+
+static pid_t pid;
+
+static struct {
+	char *prt_name;
+	int prt_value;
+} ptab[] = {
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
+#define PTCOUNT		ARRAY_SIZE(ptab)
+#define READ_TIMEOUT	5
+
+static void do_tests(void);
+static void setup(void);
+static void csum_test(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+
+	tst_parse_opts(argc, argv, 0, 0);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); ++lc)
+		do_tests();
+
+	tst_exit();
+}
+
+static void do_tests(void)
+{
+	unsigned int i;
+
+/* RFC 3542, Section 2.3 */
+#ifndef IN6_ARE_ADDR_EQUAL
+	tst_resm(TCONF, "IN6_ARE_ADDR_EQUAL not present");
+#else /* IN6_ARE_ADDR_EQUAL */
+	/*
+	 * set each bit in an address and check for unequal; then set
+	 * in the second address and check for equal. Covers all bits, all
+	 * combinations.
+	 */
+	struct in6_addr a1, a2;
+	int word, bit;
+	int rv = 1;
+
+	memset(&a1, 0, sizeof(a1));
+	memset(&a2, 0, sizeof(a2));
+
+	rv = IN6_ARE_ADDR_EQUAL(&a1, &a2);
+
+	for (word = 0; word < 4; ++word) {
+		for (bit = 0; bit < 32; ++bit) {
+			uint32_t newbit = 1U << bit;
+
+			a1.s6_addr32[word] |= newbit;
+			rv &= !IN6_ARE_ADDR_EQUAL(&a1, &a2);
+			a2.s6_addr32[word] |= newbit;
+			rv &= IN6_ARE_ADDR_EQUAL(&a1, &a2);
+		}
+	}
+
+	tst_resm(rv ? TPASS : TFAIL, "IN6_ARE_ADDR_EQUAL");
+#endif /* IN6_ARE_ADDR_EQUAL */
+
+/* RFC 3542, Section 2.4 */
+	for (i = 0; i < PTCOUNT; ++i) {
+		struct protoent *pe;
+		int pass;
+
+		pe = getprotobyname(ptab[i].prt_name);
+		pass = pe && pe->p_proto == ptab[i].prt_value;
+		tst_resm(pass ? TPASS : TFAIL, "\"%s\" protocols entry",
+			 ptab[i].prt_name);
+	}
+/* RFC 3542, Section 3.1 */
+	csum_test();
+}
+
+/*
+ * this next-header value shouldn't be a real protocol!!
+ * 0x9f = 01 0 11111
+ *         | |     |
+ *         | |     |--- rest- ~0
+ *         | |--------- chg - "no change enroute"
+ *         |----------- act - "discard unknown"
+ */
+#define	NH_TEST	0x9f
+
+struct tprot {
+	int tp_pid;		/* sender PID */
+	int tp_seq;		/* sequence # */
+	int tp_offset;		/* offset of cksum */
+	int tp_dlen;		/* tp_dat length */
+	unsigned char tp_dat[0];	/* user data */
+};
+
+static unsigned char tpbuf[sizeof(struct tprot) + 2048];
+static unsigned char rpbuf[sizeof(struct tprot) + 2048];
+
+static struct csent {
+	int cs_offset;
+	int cs_dlen;
+	int cs_setresult;	/* setsockopt expected result */
+	int cs_seterrno;	/* setsockopt expected errno */
+	int cs_sndresult;	/* send expected result */
+	int cs_snderrno;	/* send expected errno */
+} cstab[] = {
+	{0, 5, 0, 0, 0, 0},
+	{6, 30, 0, 0, 0, 0},
+	{3, 20, -1, EINVAL, -1, -1},	/* non-aligned offset */
+	{4, 5, 0, 0, -1, EINVAL},	/* not enough space */
+	{50, 5, 0, 0, -1, EINVAL},	/* outside of packet */
+	{22, 30, 0, 0, 0, 0},
+	{2000, 2004, 0, 0, 0, 0},	/* in a fragment (over Ethernet) */
+};
+
+#define CSCOUNT	ARRAY_SIZE(cstab)
+
+int TST_TOTAL = PTCOUNT + CSCOUNT;
+
+static int recvtprot(int sd, unsigned char *packet)
+{
+	struct tprot *tpt;
+	int cc;
+	unsigned int total, expected;
+	int gothead;
+
+	tpt = (struct tprot *)packet;
+	total = cc = recv(sd, packet, sizeof(struct tprot), 0);
+	expected = sizeof(struct tprot);	/* until we get tp_dlen */
+	gothead = total >= sizeof(struct tprot);
+	if (gothead)
+		expected += ntohl(tpt->tp_dlen);
+	if (cc <= 0)
+		return cc;
+	while (cc > 0 && total < expected) {
+		cc = recv(sd, &packet[total], expected - total, 0);
+		if (cc >= 0) {
+			total += cc;
+			if (!gothead && total >= sizeof(struct tprot)) {
+				gothead = 1;
+				expected += ntohl(tpt->tp_dlen);
+			}
+		} else {
+			break;
+		}
+	}
+	if (cc < 0)
+		return cc;
+	return total;
+}
+
+static unsigned short csum(unsigned short partial, unsigned char *packet,
+			   int len)
+{
+	unsigned long sum = partial;
+	unsigned short *ps;
+	int i;
+
+	ps = (unsigned short *)packet;
+	for (i = 0; i < len / 2; ++i)
+		sum += *ps++;
+	if (len & 1)
+		sum += htons(packet[len - 1] << 8);
+	sum = (sum >> 16) + (sum & 0xffff);
+	sum += (sum >> 16);
+	return ~sum;
+}
+
+static struct ph {
+	struct in6_addr ph_sa;
+	struct in6_addr ph_da;
+	uint32_t ph_len;
+	uint8_t ph_mbz[3];
+	uint8_t ph_nh;
+} ph;
+
+static int client(int sfd)
+{
+	struct tprot *pttp = (struct tprot *)tpbuf;
+	struct tprot *prtp = (struct tprot *)rpbuf;
+	struct sockaddr_in6 rsin6;
+	static int seq;
+	unsigned int i;
+	int sd, cc, cs;
+
+	memset(&rsin6, 0, sizeof(rsin6));
+	rsin6.sin6_family = AF_INET6;
+	rsin6.sin6_addr = in6addr_loopback;
+
+	memset(&ph, 0, sizeof(ph));
+	ph.ph_sa = rsin6.sin6_addr;
+	ph.ph_da = rsin6.sin6_addr;
+	ph.ph_nh = NH_TEST;
+
+	sd = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, NH_TEST);
+
+	for (i = 0; i < CSCOUNT; ++i) {
+		int offset, len, xlen;
+		int rv;
+		unsigned char *p, *pend;
+
+		offset = sizeof(struct tprot) + cstab[i].cs_offset;
+		len = sizeof(struct tprot) + cstab[i].cs_dlen;
+
+		memset(pttp, 0, sizeof(*pttp));
+		memset(pttp->tp_dat, 0xA5, cstab[i].cs_dlen);
+
+		pttp->tp_pid = htonl(pid);
+		pttp->tp_offset = ntohl(offset);
+		pttp->tp_dlen = ntohl(cstab[i].cs_dlen);
+		pttp->tp_seq = ntohl(++seq);
+
+		TEST(setsockopt(sd, IPPROTO_IPV6, IPV6_CHECKSUM, &offset,
+				sizeof(offset)));
+		if (TEST_RETURN != cstab[i].cs_setresult) {
+			tst_resm(TFAIL | TTERRNO,
+				 "IPV6_CHECKSUM offset %d len %d "
+				 "- result %ld != %d", offset, len, TEST_RETURN,
+				 cstab[i].cs_setresult);
+			continue;
+		}
+		if (TEST_RETURN < 0) {
+			tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d",
+				 offset, len);
+			continue;
+		}
+		if (TEST_RETURN && TEST_ERRNO != cstab[i].cs_seterrno) {
+			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d "
+				 "- errno %d != %d", offset, len,
+				 TEST_ERRNO, cstab[i].cs_seterrno);
+			continue;
+		}
+		/* send packet */
+		TEST(sendto(sd, pttp, len, 0, (struct sockaddr *)&rsin6,
+			    sizeof(rsin6)));
+		xlen = (cstab[i].cs_sndresult < 0) ? -1 : len;
+		if (TEST_RETURN != xlen) {
+			tst_resm(TFAIL | TTERRNO,
+				 "IPV6_CHECKSUM offset %d len %d "
+				 "- sndresult %ld != %d", offset, len,
+				 TEST_RETURN, xlen);
+			continue;
+		}
+		if (TEST_RETURN < 0 && TEST_ERRNO != cstab[i].cs_snderrno) {
+			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d "
+				 "- snderrno %d != %d", offset, len,
+				 TEST_ERRNO, cstab[i].cs_snderrno);
+			continue;
+		}
+		if (TEST_RETURN < 0) {
+			tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d",
+				 offset, len);
+			continue;
+		}
+		while ((cc = recvtprot(sfd, rpbuf))) {
+			if (htonl(prtp->tp_pid) == (uint32_t)pid &&
+			    htonl(prtp->tp_seq) == (uint32_t)seq)
+				break;
+		}
+		rv = 1;
+		pend = rpbuf + sizeof(struct tprot) + ntohl(prtp->tp_dlen);
+		for (p = &prtp->tp_dat[0]; p < pend; ++p) {
+			if (p == &rpbuf[offset] || p == &rpbuf[offset + 1])
+				continue;
+			if (*p != 0xa5) {
+				tst_resm(TFAIL, "IPV6_CHECKSUM corrupt data "
+					 "0x%02x != 0xa5, offset %zd in packet",
+					 *p, p - rpbuf);
+				rv = 0;
+				break;
+			}
+		}
+		if (rv == 0)
+			continue;
+		ph.ph_len = htonl(xlen);
+		cs = csum(0, (unsigned char *)&ph, sizeof(ph));
+		cs = csum(~cs, rpbuf, xlen);
+		if (!csum(0, rpbuf, xlen)) {
+			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d (bad "
+				 "checksum)", offset, len);
+			continue;
+		}
+		tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d", offset, len);
+	}
+	return 0;
+}
+
+static int listen_fd, connect_fd;
+
+static void *ilistener(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	connect_fd = accept(listen_fd, 0, 0);
+	close(listen_fd);
+	return NULL;
+}
+
+static void isocketpair(int pf, int type, int proto, int fd[2])
+{
+	pthread_t thid;
+	struct sockaddr_in sin4;
+	socklen_t namelen;
+
+	listen_fd = SAFE_SOCKET(NULL, pf, type, proto);
+
+	memset(&sin4, 0, sizeof(sin4));
+
+	SAFE_BIND(NULL, listen_fd, (struct sockaddr *)&sin4, sizeof(sin4));
+
+	SAFE_LISTEN(NULL, listen_fd, 10);
+
+	namelen = sizeof(sin4);
+	SAFE_GETSOCKNAME(NULL, listen_fd, (struct sockaddr *)&sin4, &namelen);
+
+	if (pthread_create(&thid, 0, ilistener, 0) < 0)
+		tst_brkm(TBROK | TERRNO, NULL, "pthread_create error");
+
+	fd[0] = SAFE_SOCKET(NULL, pf, type, proto);
+
+	sin4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
+
+	SAFE_CONNECT(NULL, fd[0], (struct sockaddr *)&sin4, sizeof(sin4));
+
+	pthread_join(thid, NULL);
+
+	fd[1] = connect_fd;
+}
+
+#ifndef MAX
+#define MAX(a, b) (@ >= (b) ? (a) : (b))
+#endif /* MAX */
+
+static void csum_test(void)
+{
+	fd_set rset, rset_save;
+	int csd[2];		/* control sockets */
+	int sd, nfds, maxfd, cc;
+	struct timeval tv;
+
+	isocketpair(PF_INET, SOCK_STREAM, 0, csd);
+
+	sd = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, NH_TEST);
+
+	FD_ZERO(&rset_save);
+	FD_SET(sd, &rset_save);
+	FD_SET(csd[1], &rset_save);
+	memcpy(&rset, &rset_save, sizeof(rset));
+	maxfd = MAX(sd, csd[1]);
+
+	/* server socket set; now start the client */
+	switch (fork()) {
+	case 0:
+		close(csd[0]);
+		break;
+	case -1:
+		tst_brkm(TBROK, NULL, "can't fork rserver");
+	default:
+		close(sd);
+		close(csd[1]);
+		client(csd[0]);
+		return;
+	}
+
+	tv.tv_sec = READ_TIMEOUT;
+	tv.tv_usec = 0;
+	while ((nfds = select(maxfd + 1, &rset, 0, 0, &tv)) >= 0) {
+		if (nfds < 0) {
+			if (errno == EINTR)
+				continue;
+			exit(0);
+		} else if (nfds == 0) {
+			fprintf(stderr, "server read timed out");
+			return;
+		}
+		if (FD_ISSET(sd, &rset)) {
+			static char packet[2048];
+
+			cc = recv(sd, packet, sizeof(packet), 0);
+			if (cc < 0) {
+				perror("server recvtprot");
+				exit(1);
+			}
+			if (cc == 0)
+				exit(0);
+			if (write(csd[1], packet, cc) < 0) {
+				perror("server write UNIX socket");
+				exit(0);
+			}
+		}
+		if (FD_ISSET(csd[1], &rset)) {
+			char buf[2048];
+
+			cc = read(csd[1], buf, sizeof(buf));
+			if (cc == 0)
+				exit(0);
+			if (cc < 0) {
+				perror("server read");
+				exit(1);
+			}
+			/* handle commands here, if any added later */
+		}
+		memcpy(&rset, &rset_save, sizeof(rset));
+		tv.tv_sec = READ_TIMEOUT;
+		tv.tv_usec = 0;
+	}
+}
+
+static void setup(void)
+{
+	TEST_PAUSE;
+
+	pid = getpid();
+}
diff --git a/testcases/network/lib6/asapi_02.c b/testcases/network/lib6/asapi_02.c
new file mode 100644
index 0000000..f8c30f1
--- /dev/null
+++ b/testcases/network/lib6/asapi_02.c
@@ -0,0 +1,261 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Copyright (c) International Business Machines  Corp., 2001
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: David L Stevens
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include <sys/wait.h>
+#include <sys/socket.h>
+
+#include <netinet/in.h>
+#include <netinet/ip6.h>
+#include <netinet/icmp6.h>
+
+#include "test.h"
+#include "safe_macros.h"
+
+char *TCID = "asapi_05";
+
+static void setup(void);
+
+static void icmp6_ft(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); ++lc)
+		icmp6_ft();
+
+	tst_exit();
+}
+
+static void setup(void)
+{
+	TEST_PAUSE;
+	tst_require_root();
+}
+
+enum tt {
+	T_WILLPASS,
+	T_WILLBLOCK,
+	T_SETPASS,
+	T_SETBLOCK,
+	T_SETPASSALL,
+	T_SETBLOCKALL
+};
+
+static struct ftent {
+	char *ft_tname;			/* test name, for logging */
+	unsigned char ft_sndtype;	/* send type field */
+	unsigned char ft_flttype;	/* filter type field */
+	enum tt ft_test;		/* what macro to test */
+	int ft_expected;		/* packet should pass? */
+} ftab[] = {
+	{"ICMP6_FILTER_SETPASS s 20 f 20", 20, 20, T_SETPASS, 1},
+	{"ICMP6_FILTER_SETPASS s 20 f 21", 20, 21, T_SETPASS, 0},
+	{"ICMP6_FILTER_SETBLOCK s 20 f 20", 20, 20, T_SETBLOCK, 0},
+	{"ICMP6_FILTER_SETBLOCK s 20 f 21", 20, 21, T_SETBLOCK, 1},
+	{"ICMP6_FILTER_PASSALL s 20", 20, 0, T_SETPASSALL, 1},
+	{"ICMP6_FILTER_PASSALL s 20", 21, 0, T_SETPASSALL, 1},
+	{"ICMP6_FILTER_BLOCKALL s 20", 20, 0, T_SETBLOCKALL, 0},
+	{"ICMP6_FILTER_BLOCKALL s 20", 21, 0, T_SETBLOCKALL, 0},
+	{"ICMP6_FILTER_WILLBLOCK s 20 f 21", 20, 21, T_WILLBLOCK, 0},
+	{"ICMP6_FILTER_WILLBLOCK s 20 f 20", 20, 20, T_WILLBLOCK, 1},
+	{"ICMP6_FILTER_WILLPASS s 20 f 21", 20, 21, T_WILLPASS, 0},
+	{"ICMP6_FILTER_WILLPASS s 22 f 22", 22, 22, T_WILLPASS, 1},
+};
+
+#define FTCOUNT	ARRAY_SIZE(ftab)
+
+static int ic6_send1(char *tname, unsigned char type)
+{
+	struct sockaddr_in6 sin6;
+	struct icmp6_hdr ic6;
+	int s;
+
+	s = SAFE_SOCKET(NULL, AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
+
+	memset(&ic6, 0, sizeof(ic6));
+	ic6.icmp6_type = type;
+	ic6.icmp6_data32[0] = htonl(getpid());
+
+	memset(&sin6, 0, sizeof(sin6));
+	sin6.sin6_family = AF_INET6;
+	sin6.sin6_addr = in6addr_loopback;
+	if (sendto(s, &ic6, sizeof(ic6), 0, (struct sockaddr *)&sin6,
+		   sizeof(sin6)) == -1) {
+		tst_resm(TBROK | TERRNO, "%s: sendto failed", tname);
+		return 1;
+	}
+	return 0;
+}
+
+static int ic6_recv1(char *tname, int sall, int sf)
+{
+	fd_set readfds, readfds_saved;
+	struct timeval tv;
+	int maxfd, nfds;
+	int gotall, gotone;
+	int cc;
+	static unsigned char rbuf[2048];
+
+	tv.tv_sec = 0;
+	tv.tv_usec = 250000;
+
+	FD_ZERO(&readfds_saved);
+	FD_SET(sall, &readfds_saved);
+	FD_SET(sf, &readfds_saved);
+	maxfd = MAX(sall, sf);
+
+	memcpy(&readfds, &readfds_saved, sizeof(readfds));
+
+	gotall = gotone = 0;
+	/*
+	 * Note: this relies on linux-specific behavior (select
+	 * updating tv with time elapsed)
+	 */
+	while (!gotall || !gotone) {
+		struct icmp6_hdr *pic6 = (struct icmp6_hdr *)rbuf;
+
+		nfds = select(maxfd + 1, &readfds, 0, 0, &tv);
+		if (nfds == 0)
+			break;	/* timed out */
+		if (nfds < 0) {
+			if (errno == EINTR)
+				continue;
+			tst_resm(TBROK | TERRNO, "%s: select failed", tname);
+		}
+		if (FD_ISSET(sall, &readfds)) {
+			cc = recv(sall, rbuf, sizeof(rbuf), 0);
+			if (cc < 0) {
+				tst_resm(TBROK | TERRNO,
+					 "%s: recv(sall, ..) failed", tname);
+				return -1;
+			}
+			/* if packet check succeeds... */
+			if (htonl(pic6->icmp6_data32[0]) == (uint32_t)getpid())
+				gotall = 1;
+		}
+		if (FD_ISSET(sf, &readfds)) {
+			cc = recv(sf, rbuf, sizeof(rbuf), 0);
+			if (cc < 0) {
+				tst_resm(TBROK | TERRNO,
+					 "%s: recv(sf, ..) failed", tname);
+				return -1;
+			}
+			/* if packet check succeeds... */
+			if (htonl(pic6->icmp6_data32[0]) == (uint32_t)getpid())
+				gotone = 1;
+		}
+		memcpy(&readfds, &readfds_saved, sizeof(readfds));
+	}
+	if (!gotall) {
+		tst_resm(TBROK, "%s: recv all timed out", tname);
+		return -1;
+	}
+	if (gotone)
+		return 1;
+	return 0;
+}
+
+/* functional tests */
+static void icmp6_ft(void)
+{
+	struct icmp6_filter i6f;
+	int sall, sf;
+	unsigned int i;
+
+	sall = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
+
+	ICMP6_FILTER_SETPASSALL(&i6f);
+	if (setsockopt(sall, IPPROTO_ICMPV6, ICMP6_FILTER, &i6f,
+		       sizeof(i6f)) < 0) {
+		tst_resm(TBROK | TERRNO,
+			 "setsockopt pass all ICMP6_FILTER failed");
+	}
+
+	sf = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
+
+	int rv;
+
+	for (i = 0; i < FTCOUNT; ++i) {
+
+		rv = -1;
+
+		switch (ftab[i].ft_test) {
+		case T_SETPASS:
+			ICMP6_FILTER_SETBLOCKALL(&i6f);
+			ICMP6_FILTER_SETPASS(ftab[i].ft_flttype, &i6f);
+			break;
+		case T_SETPASSALL:
+			ICMP6_FILTER_SETPASSALL(&i6f);
+			break;
+		case T_SETBLOCK:
+			ICMP6_FILTER_SETPASSALL(&i6f);
+			ICMP6_FILTER_SETBLOCK(ftab[i].ft_flttype, &i6f);
+			break;
+		case T_SETBLOCKALL:
+			ICMP6_FILTER_SETBLOCKALL(&i6f);
+			break;
+		case T_WILLBLOCK:
+			ICMP6_FILTER_SETPASSALL(&i6f);
+			ICMP6_FILTER_SETBLOCK(ftab[i].ft_flttype, &i6f);
+			rv = ICMP6_FILTER_WILLBLOCK(ftab[i].ft_sndtype, &i6f);
+			break;
+		case T_WILLPASS:
+			ICMP6_FILTER_SETBLOCKALL(&i6f);
+			ICMP6_FILTER_SETPASS(ftab[i].ft_flttype, &i6f);
+			rv = ICMP6_FILTER_WILLPASS(ftab[i].ft_sndtype, &i6f);
+			break;
+		default:
+			tst_resm(TBROK, "%s: unknown test type %d",
+				 ftab[i].ft_tname, ftab[i].ft_test);
+			continue;
+		}
+		if (ftab[i].ft_test != T_WILLBLOCK &&
+		    ftab[i].ft_test != T_WILLPASS) {
+			if (setsockopt(sf, IPPROTO_ICMPV6, ICMP6_FILTER, &i6f,
+				       sizeof(i6f)) < 0) {
+				tst_resm(TFAIL | TERRNO,
+					 "setsockopt ICMP6_FILTER");
+				continue;
+			}
+			if (ic6_send1(ftab[i].ft_tname, ftab[i].ft_sndtype))
+				continue;
+			rv = ic6_recv1(ftab[i].ft_tname, sall, sf);
+		} else {
+			rv = -1;
+		}
+
+		if (rv < 0)
+			continue;
+		if (rv != ftab[i].ft_expected)
+			tst_resm(TFAIL, "%s: rv %d != expected %d",
+				 ftab[i].ft_tname, rv, ftab[i].ft_expected);
+		else
+			tst_resm(TPASS, "%s", ftab[i].ft_tname);
+	}
+}
diff --git a/testcases/network/lib6/asapi_03.c b/testcases/network/lib6/asapi_03.c
new file mode 100644
index 0000000..c6e2c8e
--- /dev/null
+++ b/testcases/network/lib6/asapi_03.c
@@ -0,0 +1,385 @@
+/*
+ * Copyright (c) 2015 Fujitsu Ltd.
+ * Copyright (c) International Business Machines  Corp., 2001
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 3 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Author: David L Stevens
+ */
+
+#include "config.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <netdb.h>
+#include <libgen.h>
+#include <pthread.h>
+#include <semaphore.h>
+
+#include <sys/time.h>
+#include <netinet/in.h>
+#include <netinet/ip6.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#include <sys/ioctl.h>
+#ifdef HAVE_IFADDRS_H
+#include <ifaddrs.h>
+#endif
+#include <arpa/inet.h>
+
+#include "test.h"
+#include "safe_macros.h"
+
+char *TCID = "asapi_06";
+
+int TST_TOTAL = 1;
+
+#define READ_TIMEOUT	5	/* secs */
+
+static void do_tests(void);
+static void setup(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); ++lc)
+		do_tests();
+
+	tst_exit();
+}
+
+#define NH_TEST	0x9f
+
+#ifndef IPV6_RECVPKTINFO
+#define IPV6_RECVPKTINFO	-1
+#endif
+#ifndef IPV6_RECVHOPLIMIT
+#define IPV6_RECVHOPLIMIT	-1
+#endif
+#ifndef IPV6_RECVRTHDR
+#define IPV6_RECVRTHDR		-1
+#endif
+#ifndef IPV6_RECVHOPOPTS
+#define IPV6_RECVHOPOPTS	-1
+#endif
+#ifndef IPV6_RECVDSTOPTS
+#define IPV6_RECVDSTOPTS	-1
+#endif
+#ifndef IPV6_RECVTCLASS
+#define IPV6_RECVTCLASS		-1
+#endif
+#ifndef IPV6_TCLASS
+#define IPV6_TCLASS		-1
+#endif
+#ifndef IPV6_2292PKTINFO
+#define	IPV6_2292PKTINFO	-1
+#endif
+#ifndef IPV6_2292HOPLIMIT
+#define	IPV6_2292HOPLIMIT	-1
+#endif
+#ifndef IPV6_2292RTHDR
+#define	IPV6_2292RTHDR		-1
+#endif
+#ifndef IPV6_2292HOPOPTS
+#define	IPV6_2292HOPOPTS	-1
+#endif
+#ifndef IPV6_2292DSTOPTS
+#define	IPV6_2292DSTOPTS	-1
+#endif
+
+union soval {
+	struct in6_pktinfo sou_pktinfo;
+	int sou_hoplimit;
+	struct sockaddr_in6 sou_nexthop;
+	struct ip6_rthdr sou_rthdr;
+	struct ip6_hbh sou_hopopts;
+	struct ip6_dest sou_dstopts;
+	struct ip6_dest sou_rthdrdstopts;
+	int sou_tclass;
+	int sou_bool;
+};
+
+/* in6_addr initializer for loopback interface */
+#define IN6_LOOP	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 }
+#define IN6_ANY		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
+
+/* so_clrval and so_setval members are initilized in the body */
+static struct soent {
+	char *so_tname;
+	int so_opt;
+	int so_dorecv;		/* do receive test? */
+	int so_cmtype;
+	int so_clear;		/* get fresh socket? */
+	union soval so_clrval;
+	union soval so_setval;
+	socklen_t so_valsize;
+} sotab[] = {
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
+
+struct soprot {
+	int sop_pid;			/* sender PID */
+	int sop_seq;			/* sequence # */
+	int sop_dlen;			/* tp_dat length */
+	unsigned char sop_dat[0];	/* user data */
+};
+
+static unsigned char tpbuf[sizeof(struct soprot) + 2048];
+static unsigned char rpbuf[sizeof(struct soprot) + 2048];
+
+static unsigned char control[2048];
+
+static int seq;
+
+static struct cme {
+	int cm_len;
+	int cm_level;
+	int cm_type;
+	union {
+		uint32_t cmu_tclass;
+		uint32_t cmu_hops;
+	} cmu;
+} cmtab[] = {
+	{sizeof(uint32_t), SOL_IPV6, IPV6_TCLASS, {0x12} },
+	{sizeof(uint32_t), SOL_IPV6, IPV6_HOPLIMIT, {0x21} },
+};
+
+#define CMCOUNT	ARRAY_SIZE(cmtab)
+
+static ssize_t sendall(int st)
+{
+	struct sockaddr_in6 sin6;
+	struct msghdr msg;
+	struct iovec iov;
+	struct soprot *psop;
+	unsigned char *pd;
+	unsigned int i;
+	int ctotal;
+
+	psop = (struct soprot *)tpbuf;
+	psop->sop_pid = htonl(getpid());
+	psop->sop_seq = ++seq;
+	psop->sop_dlen = 0;
+
+	memset(&sin6, 0, sizeof(sin6));
+	sin6.sin6_family = AF_INET6;
+	sin6.sin6_addr = in6addr_loopback;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_name = &sin6;
+	msg.msg_namelen = sizeof(sin6);
+	iov.iov_base = tpbuf;
+	iov.iov_len = sizeof(struct soprot) + ntohl(psop->sop_dlen);
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+
+	pd = control;
+	ctotal = 0;
+	for (i = 0; i < CMCOUNT; ++i) {
+		struct cmsghdr *pcmsg = (struct cmsghdr *)pd;
+
+		pcmsg->cmsg_len = CMSG_LEN(cmtab[i].cm_len);
+		pcmsg->cmsg_level = cmtab[i].cm_level;
+		pcmsg->cmsg_type = cmtab[i].cm_type;
+		memcpy(CMSG_DATA(pcmsg), &cmtab[i].cmu, cmtab[i].cm_len);
+		pd += CMSG_SPACE(cmtab[i].cm_len);
+		ctotal += CMSG_SPACE(cmtab[i].cm_len);
+	}
+	msg.msg_control = ctotal ? control : 0;
+	msg.msg_controllen = ctotal;
+
+	return sendmsg(st, &msg, 0);
+}
+
+static void so_test(struct soent *psoe)
+{
+	struct sockaddr_in6 sin6;
+	union soval sobuf;
+	socklen_t valsize;
+	static int sr = -1;
+	int st;
+
+	if (psoe->so_opt == -1) {
+		tst_brkm(TBROK | TERRNO, NULL, "%s not present at compile time",
+			 psoe->so_tname);
+	}
+	if (psoe->so_clear || sr < 0) {
+		if (sr < 0)
+			close(sr);
+		sr = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, NH_TEST);
+	}
+	memset(&sin6, 0, sizeof(sin6));
+	sin6.sin6_family = AF_INET6;
+	sin6.sin6_addr = in6addr_loopback;
+
+	SAFE_BIND(NULL, sr, (struct sockaddr *)&sin6, sizeof(sin6));
+
+	if (setsockopt(sr, SOL_IPV6, psoe->so_opt, &psoe->so_clrval,
+		       psoe->so_valsize) < 0) {
+		tst_brkm(TBROK | TERRNO, NULL, "%s: setsockopt",
+			 psoe->so_tname);
+	}
+
+	TEST(setsockopt(sr, SOL_IPV6, psoe->so_opt, &psoe->so_setval,
+			psoe->so_valsize));
+	if (TEST_RETURN != 0) {
+		tst_resm(TFAIL | TERRNO, "%s set-get: setsockopt",
+			 psoe->so_tname);
+		return;
+	}
+
+	valsize = psoe->so_valsize;
+	TEST(getsockopt(sr, SOL_IPV6, psoe->so_opt, &sobuf, &valsize));
+	if (TEST_RETURN != 0) {
+		tst_brkm(TBROK | TERRNO, NULL, "%s set-get: getsockopt",
+			 psoe->so_tname);
+	} else if (memcmp(&psoe->so_setval, &sobuf, psoe->so_valsize)) {
+		tst_resm(TFAIL, "%s set-get optval != setval", psoe->so_tname);
+	} else {
+		tst_resm(TPASS, "%s set-get", psoe->so_tname);
+	}
+
+	st = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, NH_TEST);
+
+	if (sendall(st) < 0)
+		tst_brkm(TBROK | TERRNO, NULL, "%s transmit sendto",
+			 psoe->so_tname);
+
+	close(st);
+
+	/* receiver processing */
+	{
+		fd_set rfds, rfds_saved;
+		int nfds, cc;
+		int gotone;
+		struct timeval tv;
+		struct msghdr msg;
+		unsigned char cmsg[2048];
+		struct cmsghdr *pcmsg;
+		struct iovec iov;
+
+		FD_ZERO(&rfds_saved);
+		FD_SET(sr, &rfds_saved);
+
+		tv.tv_sec = 0;
+		tv.tv_usec = 250000;
+
+		while (1) {
+			memcpy(&rfds, &rfds_saved, sizeof(rfds));
+			nfds = select(sr + 1, &rfds, 0, 0, &tv);
+			if (nfds < 0) {
+				if (errno == EINTR)
+					continue;
+				tst_brkm(TBROK | TERRNO, NULL, "%s select",
+					 psoe->so_tname);
+			}
+			if (nfds == 0) {
+				tst_brkm(TBROK, NULL, "%s recvmsg timed out",
+					 psoe->so_tname);
+				return;
+			}
+			/* else, nfds == 1 */
+			if (!FD_ISSET(sr, &rfds))
+				continue;
+
+			memset(&msg, 0, sizeof(msg));
+			iov.iov_base = rpbuf;
+			iov.iov_len = sizeof(rpbuf);
+			msg.msg_iov = &iov;
+			msg.msg_iovlen = 1;
+			msg.msg_control = cmsg;
+			msg.msg_controllen = sizeof(cmsg);
+
+			cc = recvmsg(sr, &msg, 0);
+			if (cc < 0) {
+				tst_brkm(TBROK | TERRNO, NULL, "%s recvmsg",
+					 psoe->so_tname);
+			}
+			/* check pid & seq here */
+			break;
+		}
+		gotone = 0;
+		for (pcmsg = CMSG_FIRSTHDR(&msg); pcmsg != NULL;
+		     pcmsg = CMSG_NXTHDR(&msg, pcmsg)) {
+			if (!psoe->so_dorecv)
+				break;
+			gotone = pcmsg->cmsg_level == SOL_IPV6 &&
+			    pcmsg->cmsg_type == psoe->so_cmtype;
+			if (gotone) {
+				break;
+			} else if (psoe->so_clear) {
+				tst_resm(TFAIL, "%s receive: extraneous data "
+					 "in control: level %d type %d len %zu",
+					 psoe->so_tname, pcmsg->cmsg_level,
+					 pcmsg->cmsg_type, pcmsg->cmsg_len);
+				return;
+			}
+		}
+		/* check contents here */
+		if (psoe->so_dorecv)
+			tst_resm(gotone ? TPASS : TFAIL, "%s receive",
+				 psoe->so_tname);
+	}
+}
+
+static void do_tests(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < SOCOUNT; ++i) {
+		sotab[i].so_clrval.sou_bool = 0;
+		sotab[i].so_setval.sou_bool = 1;
+		so_test(&sotab[i]);
+	}
+}
+
+static void setup(void)
+{
+	TEST_PAUSE;
+}
diff --git a/testcases/network/lib6/asapi_04.c b/testcases/network/lib6/asapi_04.c
deleted file mode 100644
index ff310ea..0000000
--- a/testcases/network/lib6/asapi_04.c
+++ /dev/null
@@ -1,460 +0,0 @@
-/*
- * Copyright (c) 2015 Fujitsu Ltd.
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * Author: David L Stevens
- */
-
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <netdb.h>
-#include <libgen.h>
-#include <pthread.h>
-#include <semaphore.h>
-
-#include <sys/time.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "asapi_04";
-
-static pid_t pid;
-
-static struct {
-	char *prt_name;
-	int prt_value;
-} ptab[] = {
-	{"hopopt", 0},
-	{"ipv6", 41},
-	{"ipv6-route", 43},
-	{"ipv6-frag", 44},
-	{"esp", 50},
-	{"ah", 51},
-	{"ipv6-icmp", 58},
-	{"ipv6-nonxt", 59},
-	{"ipv6-opts", 60},
-};
-
-#define PTCOUNT		ARRAY_SIZE(ptab)
-#define READ_TIMEOUT	5
-
-static void do_tests(void);
-static void setup(void);
-static void csum_test(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, 0, 0);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc)
-		do_tests();
-
-	tst_exit();
-}
-
-static void do_tests(void)
-{
-	unsigned int i;
-
-/* RFC 3542, Section 2.3 */
-#ifndef IN6_ARE_ADDR_EQUAL
-	tst_resm(TCONF, "IN6_ARE_ADDR_EQUAL not present");
-#else /* IN6_ARE_ADDR_EQUAL */
-	/*
-	 * set each bit in an address and check for unequal; then set
-	 * in the second address and check for equal. Covers all bits, all
-	 * combinations.
-	 */
-	struct in6_addr a1, a2;
-	int word, bit;
-	int rv = 1;
-
-	memset(&a1, 0, sizeof(a1));
-	memset(&a2, 0, sizeof(a2));
-
-	rv = IN6_ARE_ADDR_EQUAL(&a1, &a2);
-
-	for (word = 0; word < 4; ++word) {
-		for (bit = 0; bit < 32; ++bit) {
-			uint32_t newbit = 1U << bit;
-
-			a1.s6_addr32[word] |= newbit;
-			rv &= !IN6_ARE_ADDR_EQUAL(&a1, &a2);
-			a2.s6_addr32[word] |= newbit;
-			rv &= IN6_ARE_ADDR_EQUAL(&a1, &a2);
-		}
-	}
-
-	tst_resm(rv ? TPASS : TFAIL, "IN6_ARE_ADDR_EQUAL");
-#endif /* IN6_ARE_ADDR_EQUAL */
-
-/* RFC 3542, Section 2.4 */
-	for (i = 0; i < PTCOUNT; ++i) {
-		struct protoent *pe;
-		int pass;
-
-		pe = getprotobyname(ptab[i].prt_name);
-		pass = pe && pe->p_proto == ptab[i].prt_value;
-		tst_resm(pass ? TPASS : TFAIL, "\"%s\" protocols entry",
-			 ptab[i].prt_name);
-	}
-/* RFC 3542, Section 3.1 */
-	csum_test();
-}
-
-/*
- * this next-header value shouldn't be a real protocol!!
- * 0x9f = 01 0 11111
- *         | |     |
- *         | |     |--- rest- ~0
- *         | |--------- chg - "no change enroute"
- *         |----------- act - "discard unknown"
- */
-#define	NH_TEST	0x9f
-
-struct tprot {
-	int tp_pid;		/* sender PID */
-	int tp_seq;		/* sequence # */
-	int tp_offset;		/* offset of cksum */
-	int tp_dlen;		/* tp_dat length */
-	unsigned char tp_dat[0];	/* user data */
-};
-
-static unsigned char tpbuf[sizeof(struct tprot) + 2048];
-static unsigned char rpbuf[sizeof(struct tprot) + 2048];
-
-static struct csent {
-	int cs_offset;
-	int cs_dlen;
-	int cs_setresult;	/* setsockopt expected result */
-	int cs_seterrno;	/* setsockopt expected errno */
-	int cs_sndresult;	/* send expected result */
-	int cs_snderrno;	/* send expected errno */
-} cstab[] = {
-	{0, 5, 0, 0, 0, 0},
-	{6, 30, 0, 0, 0, 0},
-	{3, 20, -1, EINVAL, -1, -1},	/* non-aligned offset */
-	{4, 5, 0, 0, -1, EINVAL},	/* not enough space */
-	{50, 5, 0, 0, -1, EINVAL},	/* outside of packet */
-	{22, 30, 0, 0, 0, 0},
-	{2000, 2004, 0, 0, 0, 0},	/* in a fragment (over Ethernet) */
-};
-
-#define CSCOUNT	ARRAY_SIZE(cstab)
-
-int TST_TOTAL = PTCOUNT + CSCOUNT;
-
-static int recvtprot(int sd, unsigned char *packet)
-{
-	struct tprot *tpt;
-	int cc;
-	unsigned int total, expected;
-	int gothead;
-
-	tpt = (struct tprot *)packet;
-	total = cc = recv(sd, packet, sizeof(struct tprot), 0);
-	expected = sizeof(struct tprot);	/* until we get tp_dlen */
-	gothead = total >= sizeof(struct tprot);
-	if (gothead)
-		expected += ntohl(tpt->tp_dlen);
-	if (cc <= 0)
-		return cc;
-	while (cc > 0 && total < expected) {
-		cc = recv(sd, &packet[total], expected - total, 0);
-		if (cc >= 0) {
-			total += cc;
-			if (!gothead && total >= sizeof(struct tprot)) {
-				gothead = 1;
-				expected += ntohl(tpt->tp_dlen);
-			}
-		} else {
-			break;
-		}
-	}
-	if (cc < 0)
-		return cc;
-	return total;
-}
-
-static unsigned short csum(unsigned short partial, unsigned char *packet,
-			   int len)
-{
-	unsigned long sum = partial;
-	unsigned short *ps;
-	int i;
-
-	ps = (unsigned short *)packet;
-	for (i = 0; i < len / 2; ++i)
-		sum += *ps++;
-	if (len & 1)
-		sum += htons(packet[len - 1] << 8);
-	sum = (sum >> 16) + (sum & 0xffff);
-	sum += (sum >> 16);
-	return ~sum;
-}
-
-static struct ph {
-	struct in6_addr ph_sa;
-	struct in6_addr ph_da;
-	uint32_t ph_len;
-	uint8_t ph_mbz[3];
-	uint8_t ph_nh;
-} ph;
-
-static int client(int sfd)
-{
-	struct tprot *pttp = (struct tprot *)tpbuf;
-	struct tprot *prtp = (struct tprot *)rpbuf;
-	struct sockaddr_in6 rsin6;
-	static int seq;
-	unsigned int i;
-	int sd, cc, cs;
-
-	memset(&rsin6, 0, sizeof(rsin6));
-	rsin6.sin6_family = AF_INET6;
-	rsin6.sin6_addr = in6addr_loopback;
-
-	memset(&ph, 0, sizeof(ph));
-	ph.ph_sa = rsin6.sin6_addr;
-	ph.ph_da = rsin6.sin6_addr;
-	ph.ph_nh = NH_TEST;
-
-	sd = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, NH_TEST);
-
-	for (i = 0; i < CSCOUNT; ++i) {
-		int offset, len, xlen;
-		int rv;
-		unsigned char *p, *pend;
-
-		offset = sizeof(struct tprot) + cstab[i].cs_offset;
-		len = sizeof(struct tprot) + cstab[i].cs_dlen;
-
-		memset(pttp, 0, sizeof(*pttp));
-		memset(pttp->tp_dat, 0xA5, cstab[i].cs_dlen);
-
-		pttp->tp_pid = htonl(pid);
-		pttp->tp_offset = ntohl(offset);
-		pttp->tp_dlen = ntohl(cstab[i].cs_dlen);
-		pttp->tp_seq = ntohl(++seq);
-
-		TEST(setsockopt(sd, IPPROTO_IPV6, IPV6_CHECKSUM, &offset,
-				sizeof(offset)));
-		if (TEST_RETURN != cstab[i].cs_setresult) {
-			tst_resm(TFAIL | TTERRNO,
-				 "IPV6_CHECKSUM offset %d len %d "
-				 "- result %ld != %d", offset, len, TEST_RETURN,
-				 cstab[i].cs_setresult);
-			continue;
-		}
-		if (TEST_RETURN < 0) {
-			tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d",
-				 offset, len);
-			continue;
-		}
-		if (TEST_RETURN && TEST_ERRNO != cstab[i].cs_seterrno) {
-			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d "
-				 "- errno %d != %d", offset, len,
-				 TEST_ERRNO, cstab[i].cs_seterrno);
-			continue;
-		}
-		/* send packet */
-		TEST(sendto(sd, pttp, len, 0, (struct sockaddr *)&rsin6,
-			    sizeof(rsin6)));
-		xlen = (cstab[i].cs_sndresult < 0) ? -1 : len;
-		if (TEST_RETURN != xlen) {
-			tst_resm(TFAIL | TTERRNO,
-				 "IPV6_CHECKSUM offset %d len %d "
-				 "- sndresult %ld != %d", offset, len,
-				 TEST_RETURN, xlen);
-			continue;
-		}
-		if (TEST_RETURN < 0 && TEST_ERRNO != cstab[i].cs_snderrno) {
-			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d "
-				 "- snderrno %d != %d", offset, len,
-				 TEST_ERRNO, cstab[i].cs_snderrno);
-			continue;
-		}
-		if (TEST_RETURN < 0) {
-			tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d",
-				 offset, len);
-			continue;
-		}
-		while ((cc = recvtprot(sfd, rpbuf))) {
-			if (htonl(prtp->tp_pid) == (uint32_t)pid &&
-			    htonl(prtp->tp_seq) == (uint32_t)seq)
-				break;
-		}
-		rv = 1;
-		pend = rpbuf + sizeof(struct tprot) + ntohl(prtp->tp_dlen);
-		for (p = &prtp->tp_dat[0]; p < pend; ++p) {
-			if (p == &rpbuf[offset] || p == &rpbuf[offset + 1])
-				continue;
-			if (*p != 0xa5) {
-				tst_resm(TFAIL, "IPV6_CHECKSUM corrupt data "
-					 "0x%02x != 0xa5, offset %zd in packet",
-					 *p, p - rpbuf);
-				rv = 0;
-				break;
-			}
-		}
-		if (rv == 0)
-			continue;
-		ph.ph_len = htonl(xlen);
-		cs = csum(0, (unsigned char *)&ph, sizeof(ph));
-		cs = csum(~cs, rpbuf, xlen);
-		if (!csum(0, rpbuf, xlen)) {
-			tst_resm(TFAIL, "IPV6_CHECKSUM offset %d len %d (bad "
-				 "checksum)", offset, len);
-			continue;
-		}
-		tst_resm(TPASS, "IPV6_CHECKSUM offset %d len %d", offset, len);
-	}
-	return 0;
-}
-
-static int listen_fd, connect_fd;
-
-static void *ilistener(void *arg LTP_ATTRIBUTE_UNUSED)
-{
-	connect_fd = accept(listen_fd, 0, 0);
-	close(listen_fd);
-	return NULL;
-}
-
-static void isocketpair(int pf, int type, int proto, int fd[2])
-{
-	pthread_t thid;
-	struct sockaddr_in sin4;
-	socklen_t namelen;
-
-	listen_fd = SAFE_SOCKET(NULL, pf, type, proto);
-
-	memset(&sin4, 0, sizeof(sin4));
-
-	SAFE_BIND(NULL, listen_fd, (struct sockaddr *)&sin4, sizeof(sin4));
-
-	SAFE_LISTEN(NULL, listen_fd, 10);
-
-	namelen = sizeof(sin4);
-	SAFE_GETSOCKNAME(NULL, listen_fd, (struct sockaddr *)&sin4, &namelen);
-
-	if (pthread_create(&thid, 0, ilistener, 0) < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "pthread_create error");
-
-	fd[0] = SAFE_SOCKET(NULL, pf, type, proto);
-
-	sin4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
-
-	SAFE_CONNECT(NULL, fd[0], (struct sockaddr *)&sin4, sizeof(sin4));
-
-	pthread_join(thid, NULL);
-
-	fd[1] = connect_fd;
-}
-
-#ifndef MAX
-#define MAX(a, b) (@ >= (b) ? (a) : (b))
-#endif /* MAX */
-
-static void csum_test(void)
-{
-	fd_set rset, rset_save;
-	int csd[2];		/* control sockets */
-	int sd, nfds, maxfd, cc;
-	struct timeval tv;
-
-	isocketpair(PF_INET, SOCK_STREAM, 0, csd);
-
-	sd = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, NH_TEST);
-
-	FD_ZERO(&rset_save);
-	FD_SET(sd, &rset_save);
-	FD_SET(csd[1], &rset_save);
-	memcpy(&rset, &rset_save, sizeof(rset));
-	maxfd = MAX(sd, csd[1]);
-
-	/* server socket set; now start the client */
-	switch (fork()) {
-	case 0:
-		close(csd[0]);
-		break;
-	case -1:
-		tst_brkm(TBROK, NULL, "can't fork rserver");
-	default:
-		close(sd);
-		close(csd[1]);
-		client(csd[0]);
-		return;
-	}
-
-	tv.tv_sec = READ_TIMEOUT;
-	tv.tv_usec = 0;
-	while ((nfds = select(maxfd + 1, &rset, 0, 0, &tv)) >= 0) {
-		if (nfds < 0) {
-			if (errno == EINTR)
-				continue;
-			exit(0);
-		} else if (nfds == 0) {
-			fprintf(stderr, "server read timed out");
-			return;
-		}
-		if (FD_ISSET(sd, &rset)) {
-			static char packet[2048];
-
-			cc = recv(sd, packet, sizeof(packet), 0);
-			if (cc < 0) {
-				perror("server recvtprot");
-				exit(1);
-			}
-			if (cc == 0)
-				exit(0);
-			if (write(csd[1], packet, cc) < 0) {
-				perror("server write UNIX socket");
-				exit(0);
-			}
-		}
-		if (FD_ISSET(csd[1], &rset)) {
-			char buf[2048];
-
-			cc = read(csd[1], buf, sizeof(buf));
-			if (cc == 0)
-				exit(0);
-			if (cc < 0) {
-				perror("server read");
-				exit(1);
-			}
-			/* handle commands here, if any added later */
-		}
-		memcpy(&rset, &rset_save, sizeof(rset));
-		tv.tv_sec = READ_TIMEOUT;
-		tv.tv_usec = 0;
-	}
-}
-
-static void setup(void)
-{
-	TEST_PAUSE;
-
-	pid = getpid();
-}
diff --git a/testcases/network/lib6/asapi_05.c b/testcases/network/lib6/asapi_05.c
deleted file mode 100644
index f8c30f1..0000000
--- a/testcases/network/lib6/asapi_05.c
+++ /dev/null
@@ -1,261 +0,0 @@
-/*
- * Copyright (c) 2015 Fujitsu Ltd.
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * Author: David L Stevens
- */
-
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-
-#include <sys/wait.h>
-#include <sys/socket.h>
-
-#include <netinet/in.h>
-#include <netinet/ip6.h>
-#include <netinet/icmp6.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "asapi_05";
-
-static void setup(void);
-
-static void icmp6_ft(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc)
-		icmp6_ft();
-
-	tst_exit();
-}
-
-static void setup(void)
-{
-	TEST_PAUSE;
-	tst_require_root();
-}
-
-enum tt {
-	T_WILLPASS,
-	T_WILLBLOCK,
-	T_SETPASS,
-	T_SETBLOCK,
-	T_SETPASSALL,
-	T_SETBLOCKALL
-};
-
-static struct ftent {
-	char *ft_tname;			/* test name, for logging */
-	unsigned char ft_sndtype;	/* send type field */
-	unsigned char ft_flttype;	/* filter type field */
-	enum tt ft_test;		/* what macro to test */
-	int ft_expected;		/* packet should pass? */
-} ftab[] = {
-	{"ICMP6_FILTER_SETPASS s 20 f 20", 20, 20, T_SETPASS, 1},
-	{"ICMP6_FILTER_SETPASS s 20 f 21", 20, 21, T_SETPASS, 0},
-	{"ICMP6_FILTER_SETBLOCK s 20 f 20", 20, 20, T_SETBLOCK, 0},
-	{"ICMP6_FILTER_SETBLOCK s 20 f 21", 20, 21, T_SETBLOCK, 1},
-	{"ICMP6_FILTER_PASSALL s 20", 20, 0, T_SETPASSALL, 1},
-	{"ICMP6_FILTER_PASSALL s 20", 21, 0, T_SETPASSALL, 1},
-	{"ICMP6_FILTER_BLOCKALL s 20", 20, 0, T_SETBLOCKALL, 0},
-	{"ICMP6_FILTER_BLOCKALL s 20", 21, 0, T_SETBLOCKALL, 0},
-	{"ICMP6_FILTER_WILLBLOCK s 20 f 21", 20, 21, T_WILLBLOCK, 0},
-	{"ICMP6_FILTER_WILLBLOCK s 20 f 20", 20, 20, T_WILLBLOCK, 1},
-	{"ICMP6_FILTER_WILLPASS s 20 f 21", 20, 21, T_WILLPASS, 0},
-	{"ICMP6_FILTER_WILLPASS s 22 f 22", 22, 22, T_WILLPASS, 1},
-};
-
-#define FTCOUNT	ARRAY_SIZE(ftab)
-
-static int ic6_send1(char *tname, unsigned char type)
-{
-	struct sockaddr_in6 sin6;
-	struct icmp6_hdr ic6;
-	int s;
-
-	s = SAFE_SOCKET(NULL, AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
-
-	memset(&ic6, 0, sizeof(ic6));
-	ic6.icmp6_type = type;
-	ic6.icmp6_data32[0] = htonl(getpid());
-
-	memset(&sin6, 0, sizeof(sin6));
-	sin6.sin6_family = AF_INET6;
-	sin6.sin6_addr = in6addr_loopback;
-	if (sendto(s, &ic6, sizeof(ic6), 0, (struct sockaddr *)&sin6,
-		   sizeof(sin6)) == -1) {
-		tst_resm(TBROK | TERRNO, "%s: sendto failed", tname);
-		return 1;
-	}
-	return 0;
-}
-
-static int ic6_recv1(char *tname, int sall, int sf)
-{
-	fd_set readfds, readfds_saved;
-	struct timeval tv;
-	int maxfd, nfds;
-	int gotall, gotone;
-	int cc;
-	static unsigned char rbuf[2048];
-
-	tv.tv_sec = 0;
-	tv.tv_usec = 250000;
-
-	FD_ZERO(&readfds_saved);
-	FD_SET(sall, &readfds_saved);
-	FD_SET(sf, &readfds_saved);
-	maxfd = MAX(sall, sf);
-
-	memcpy(&readfds, &readfds_saved, sizeof(readfds));
-
-	gotall = gotone = 0;
-	/*
-	 * Note: this relies on linux-specific behavior (select
-	 * updating tv with time elapsed)
-	 */
-	while (!gotall || !gotone) {
-		struct icmp6_hdr *pic6 = (struct icmp6_hdr *)rbuf;
-
-		nfds = select(maxfd + 1, &readfds, 0, 0, &tv);
-		if (nfds == 0)
-			break;	/* timed out */
-		if (nfds < 0) {
-			if (errno == EINTR)
-				continue;
-			tst_resm(TBROK | TERRNO, "%s: select failed", tname);
-		}
-		if (FD_ISSET(sall, &readfds)) {
-			cc = recv(sall, rbuf, sizeof(rbuf), 0);
-			if (cc < 0) {
-				tst_resm(TBROK | TERRNO,
-					 "%s: recv(sall, ..) failed", tname);
-				return -1;
-			}
-			/* if packet check succeeds... */
-			if (htonl(pic6->icmp6_data32[0]) == (uint32_t)getpid())
-				gotall = 1;
-		}
-		if (FD_ISSET(sf, &readfds)) {
-			cc = recv(sf, rbuf, sizeof(rbuf), 0);
-			if (cc < 0) {
-				tst_resm(TBROK | TERRNO,
-					 "%s: recv(sf, ..) failed", tname);
-				return -1;
-			}
-			/* if packet check succeeds... */
-			if (htonl(pic6->icmp6_data32[0]) == (uint32_t)getpid())
-				gotone = 1;
-		}
-		memcpy(&readfds, &readfds_saved, sizeof(readfds));
-	}
-	if (!gotall) {
-		tst_resm(TBROK, "%s: recv all timed out", tname);
-		return -1;
-	}
-	if (gotone)
-		return 1;
-	return 0;
-}
-
-/* functional tests */
-static void icmp6_ft(void)
-{
-	struct icmp6_filter i6f;
-	int sall, sf;
-	unsigned int i;
-
-	sall = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
-
-	ICMP6_FILTER_SETPASSALL(&i6f);
-	if (setsockopt(sall, IPPROTO_ICMPV6, ICMP6_FILTER, &i6f,
-		       sizeof(i6f)) < 0) {
-		tst_resm(TBROK | TERRNO,
-			 "setsockopt pass all ICMP6_FILTER failed");
-	}
-
-	sf = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
-
-	int rv;
-
-	for (i = 0; i < FTCOUNT; ++i) {
-
-		rv = -1;
-
-		switch (ftab[i].ft_test) {
-		case T_SETPASS:
-			ICMP6_FILTER_SETBLOCKALL(&i6f);
-			ICMP6_FILTER_SETPASS(ftab[i].ft_flttype, &i6f);
-			break;
-		case T_SETPASSALL:
-			ICMP6_FILTER_SETPASSALL(&i6f);
-			break;
-		case T_SETBLOCK:
-			ICMP6_FILTER_SETPASSALL(&i6f);
-			ICMP6_FILTER_SETBLOCK(ftab[i].ft_flttype, &i6f);
-			break;
-		case T_SETBLOCKALL:
-			ICMP6_FILTER_SETBLOCKALL(&i6f);
-			break;
-		case T_WILLBLOCK:
-			ICMP6_FILTER_SETPASSALL(&i6f);
-			ICMP6_FILTER_SETBLOCK(ftab[i].ft_flttype, &i6f);
-			rv = ICMP6_FILTER_WILLBLOCK(ftab[i].ft_sndtype, &i6f);
-			break;
-		case T_WILLPASS:
-			ICMP6_FILTER_SETBLOCKALL(&i6f);
-			ICMP6_FILTER_SETPASS(ftab[i].ft_flttype, &i6f);
-			rv = ICMP6_FILTER_WILLPASS(ftab[i].ft_sndtype, &i6f);
-			break;
-		default:
-			tst_resm(TBROK, "%s: unknown test type %d",
-				 ftab[i].ft_tname, ftab[i].ft_test);
-			continue;
-		}
-		if (ftab[i].ft_test != T_WILLBLOCK &&
-		    ftab[i].ft_test != T_WILLPASS) {
-			if (setsockopt(sf, IPPROTO_ICMPV6, ICMP6_FILTER, &i6f,
-				       sizeof(i6f)) < 0) {
-				tst_resm(TFAIL | TERRNO,
-					 "setsockopt ICMP6_FILTER");
-				continue;
-			}
-			if (ic6_send1(ftab[i].ft_tname, ftab[i].ft_sndtype))
-				continue;
-			rv = ic6_recv1(ftab[i].ft_tname, sall, sf);
-		} else {
-			rv = -1;
-		}
-
-		if (rv < 0)
-			continue;
-		if (rv != ftab[i].ft_expected)
-			tst_resm(TFAIL, "%s: rv %d != expected %d",
-				 ftab[i].ft_tname, rv, ftab[i].ft_expected);
-		else
-			tst_resm(TPASS, "%s", ftab[i].ft_tname);
-	}
-}
diff --git a/testcases/network/lib6/asapi_06.c b/testcases/network/lib6/asapi_06.c
deleted file mode 100644
index c6e2c8e..0000000
--- a/testcases/network/lib6/asapi_06.c
+++ /dev/null
@@ -1,385 +0,0 @@
-/*
- * Copyright (c) 2015 Fujitsu Ltd.
- * Copyright (c) International Business Machines  Corp., 2001
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation, either version 3 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- *
- * Author: David L Stevens
- */
-
-#include "config.h"
-
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <netdb.h>
-#include <libgen.h>
-#include <pthread.h>
-#include <semaphore.h>
-
-#include <sys/time.h>
-#include <netinet/in.h>
-#include <netinet/ip6.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <net/if.h>
-#include <sys/ioctl.h>
-#ifdef HAVE_IFADDRS_H
-#include <ifaddrs.h>
-#endif
-#include <arpa/inet.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "asapi_06";
-
-int TST_TOTAL = 1;
-
-#define READ_TIMEOUT	5	/* secs */
-
-static void do_tests(void);
-static void setup(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc)
-		do_tests();
-
-	tst_exit();
-}
-
-#define NH_TEST	0x9f
-
-#ifndef IPV6_RECVPKTINFO
-#define IPV6_RECVPKTINFO	-1
-#endif
-#ifndef IPV6_RECVHOPLIMIT
-#define IPV6_RECVHOPLIMIT	-1
-#endif
-#ifndef IPV6_RECVRTHDR
-#define IPV6_RECVRTHDR		-1
-#endif
-#ifndef IPV6_RECVHOPOPTS
-#define IPV6_RECVHOPOPTS	-1
-#endif
-#ifndef IPV6_RECVDSTOPTS
-#define IPV6_RECVDSTOPTS	-1
-#endif
-#ifndef IPV6_RECVTCLASS
-#define IPV6_RECVTCLASS		-1
-#endif
-#ifndef IPV6_TCLASS
-#define IPV6_TCLASS		-1
-#endif
-#ifndef IPV6_2292PKTINFO
-#define	IPV6_2292PKTINFO	-1
-#endif
-#ifndef IPV6_2292HOPLIMIT
-#define	IPV6_2292HOPLIMIT	-1
-#endif
-#ifndef IPV6_2292RTHDR
-#define	IPV6_2292RTHDR		-1
-#endif
-#ifndef IPV6_2292HOPOPTS
-#define	IPV6_2292HOPOPTS	-1
-#endif
-#ifndef IPV6_2292DSTOPTS
-#define	IPV6_2292DSTOPTS	-1
-#endif
-
-union soval {
-	struct in6_pktinfo sou_pktinfo;
-	int sou_hoplimit;
-	struct sockaddr_in6 sou_nexthop;
-	struct ip6_rthdr sou_rthdr;
-	struct ip6_hbh sou_hopopts;
-	struct ip6_dest sou_dstopts;
-	struct ip6_dest sou_rthdrdstopts;
-	int sou_tclass;
-	int sou_bool;
-};
-
-/* in6_addr initializer for loopback interface */
-#define IN6_LOOP	{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 }
-#define IN6_ANY		{0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
-
-/* so_clrval and so_setval members are initilized in the body */
-static struct soent {
-	char *so_tname;
-	int so_opt;
-	int so_dorecv;		/* do receive test? */
-	int so_cmtype;
-	int so_clear;		/* get fresh socket? */
-	union soval so_clrval;
-	union soval so_setval;
-	socklen_t so_valsize;
-} sotab[] = {
-	/* RFC 3542, Section 4 */
-	{"IPV6_RECVPKTINFO", IPV6_RECVPKTINFO, 1, IPV6_PKTINFO, 1,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-	{"IPV6_RECVHOPLIMIT", IPV6_RECVHOPLIMIT, 1, IPV6_HOPLIMIT, 1,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-	{"IPV6_RECVRTHDR", IPV6_RECVRTHDR, 0, IPV6_RTHDR, 1,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-	{"IPV6_RECVHOPOPTS", IPV6_RECVHOPOPTS, 0, IPV6_HOPOPTS, 1,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-	{"IPV6_RECVDSTOPTS", IPV6_RECVDSTOPTS, 0, IPV6_DSTOPTS, 1,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-	{"IPV6_RECVTCLASS", IPV6_RECVTCLASS, 1, IPV6_TCLASS, 1,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-	/* make sure TCLASS stays when setting another opt */
-	{"IPV6_RECVTCLASS (2)", IPV6_RECVHOPLIMIT, 1, IPV6_TCLASS, 0,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-	/* OLD values */
-	{"IPV6_2292PKTINFO", IPV6_2292PKTINFO, 1, IPV6_2292PKTINFO, 1,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-	{"IPV6_2292HOPLIMIT", IPV6_2292HOPLIMIT, 1, IPV6_2292HOPLIMIT, 1,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-	{"IPV6_2292RTHDR", IPV6_2292RTHDR, 0, IPV6_2292RTHDR, 1,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-	{"IPV6_2292HOPOPTS", IPV6_2292HOPOPTS, 0, IPV6_2292HOPOPTS, 1,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-	{"IPV6_2292DSTOPTS", IPV6_2292DSTOPTS, 0, IPV6_2292DSTOPTS, 1,
-	 {{{{{0} } }, 0} }, {{{{{0} } }, 0} }, sizeof(int)},
-};
-
-#define SOCOUNT	ARRAY_SIZE(sotab)
-
-struct soprot {
-	int sop_pid;			/* sender PID */
-	int sop_seq;			/* sequence # */
-	int sop_dlen;			/* tp_dat length */
-	unsigned char sop_dat[0];	/* user data */
-};
-
-static unsigned char tpbuf[sizeof(struct soprot) + 2048];
-static unsigned char rpbuf[sizeof(struct soprot) + 2048];
-
-static unsigned char control[2048];
-
-static int seq;
-
-static struct cme {
-	int cm_len;
-	int cm_level;
-	int cm_type;
-	union {
-		uint32_t cmu_tclass;
-		uint32_t cmu_hops;
-	} cmu;
-} cmtab[] = {
-	{sizeof(uint32_t), SOL_IPV6, IPV6_TCLASS, {0x12} },
-	{sizeof(uint32_t), SOL_IPV6, IPV6_HOPLIMIT, {0x21} },
-};
-
-#define CMCOUNT	ARRAY_SIZE(cmtab)
-
-static ssize_t sendall(int st)
-{
-	struct sockaddr_in6 sin6;
-	struct msghdr msg;
-	struct iovec iov;
-	struct soprot *psop;
-	unsigned char *pd;
-	unsigned int i;
-	int ctotal;
-
-	psop = (struct soprot *)tpbuf;
-	psop->sop_pid = htonl(getpid());
-	psop->sop_seq = ++seq;
-	psop->sop_dlen = 0;
-
-	memset(&sin6, 0, sizeof(sin6));
-	sin6.sin6_family = AF_INET6;
-	sin6.sin6_addr = in6addr_loopback;
-
-	memset(&msg, 0, sizeof(msg));
-	msg.msg_name = &sin6;
-	msg.msg_namelen = sizeof(sin6);
-	iov.iov_base = tpbuf;
-	iov.iov_len = sizeof(struct soprot) + ntohl(psop->sop_dlen);
-	msg.msg_iov = &iov;
-	msg.msg_iovlen = 1;
-
-	pd = control;
-	ctotal = 0;
-	for (i = 0; i < CMCOUNT; ++i) {
-		struct cmsghdr *pcmsg = (struct cmsghdr *)pd;
-
-		pcmsg->cmsg_len = CMSG_LEN(cmtab[i].cm_len);
-		pcmsg->cmsg_level = cmtab[i].cm_level;
-		pcmsg->cmsg_type = cmtab[i].cm_type;
-		memcpy(CMSG_DATA(pcmsg), &cmtab[i].cmu, cmtab[i].cm_len);
-		pd += CMSG_SPACE(cmtab[i].cm_len);
-		ctotal += CMSG_SPACE(cmtab[i].cm_len);
-	}
-	msg.msg_control = ctotal ? control : 0;
-	msg.msg_controllen = ctotal;
-
-	return sendmsg(st, &msg, 0);
-}
-
-static void so_test(struct soent *psoe)
-{
-	struct sockaddr_in6 sin6;
-	union soval sobuf;
-	socklen_t valsize;
-	static int sr = -1;
-	int st;
-
-	if (psoe->so_opt == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "%s not present at compile time",
-			 psoe->so_tname);
-	}
-	if (psoe->so_clear || sr < 0) {
-		if (sr < 0)
-			close(sr);
-		sr = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, NH_TEST);
-	}
-	memset(&sin6, 0, sizeof(sin6));
-	sin6.sin6_family = AF_INET6;
-	sin6.sin6_addr = in6addr_loopback;
-
-	SAFE_BIND(NULL, sr, (struct sockaddr *)&sin6, sizeof(sin6));
-
-	if (setsockopt(sr, SOL_IPV6, psoe->so_opt, &psoe->so_clrval,
-		       psoe->so_valsize) < 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "%s: setsockopt",
-			 psoe->so_tname);
-	}
-
-	TEST(setsockopt(sr, SOL_IPV6, psoe->so_opt, &psoe->so_setval,
-			psoe->so_valsize));
-	if (TEST_RETURN != 0) {
-		tst_resm(TFAIL | TERRNO, "%s set-get: setsockopt",
-			 psoe->so_tname);
-		return;
-	}
-
-	valsize = psoe->so_valsize;
-	TEST(getsockopt(sr, SOL_IPV6, psoe->so_opt, &sobuf, &valsize));
-	if (TEST_RETURN != 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "%s set-get: getsockopt",
-			 psoe->so_tname);
-	} else if (memcmp(&psoe->so_setval, &sobuf, psoe->so_valsize)) {
-		tst_resm(TFAIL, "%s set-get optval != setval", psoe->so_tname);
-	} else {
-		tst_resm(TPASS, "%s set-get", psoe->so_tname);
-	}
-
-	st = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, NH_TEST);
-
-	if (sendall(st) < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "%s transmit sendto",
-			 psoe->so_tname);
-
-	close(st);
-
-	/* receiver processing */
-	{
-		fd_set rfds, rfds_saved;
-		int nfds, cc;
-		int gotone;
-		struct timeval tv;
-		struct msghdr msg;
-		unsigned char cmsg[2048];
-		struct cmsghdr *pcmsg;
-		struct iovec iov;
-
-		FD_ZERO(&rfds_saved);
-		FD_SET(sr, &rfds_saved);
-
-		tv.tv_sec = 0;
-		tv.tv_usec = 250000;
-
-		while (1) {
-			memcpy(&rfds, &rfds_saved, sizeof(rfds));
-			nfds = select(sr + 1, &rfds, 0, 0, &tv);
-			if (nfds < 0) {
-				if (errno == EINTR)
-					continue;
-				tst_brkm(TBROK | TERRNO, NULL, "%s select",
-					 psoe->so_tname);
-			}
-			if (nfds == 0) {
-				tst_brkm(TBROK, NULL, "%s recvmsg timed out",
-					 psoe->so_tname);
-				return;
-			}
-			/* else, nfds == 1 */
-			if (!FD_ISSET(sr, &rfds))
-				continue;
-
-			memset(&msg, 0, sizeof(msg));
-			iov.iov_base = rpbuf;
-			iov.iov_len = sizeof(rpbuf);
-			msg.msg_iov = &iov;
-			msg.msg_iovlen = 1;
-			msg.msg_control = cmsg;
-			msg.msg_controllen = sizeof(cmsg);
-
-			cc = recvmsg(sr, &msg, 0);
-			if (cc < 0) {
-				tst_brkm(TBROK | TERRNO, NULL, "%s recvmsg",
-					 psoe->so_tname);
-			}
-			/* check pid & seq here */
-			break;
-		}
-		gotone = 0;
-		for (pcmsg = CMSG_FIRSTHDR(&msg); pcmsg != NULL;
-		     pcmsg = CMSG_NXTHDR(&msg, pcmsg)) {
-			if (!psoe->so_dorecv)
-				break;
-			gotone = pcmsg->cmsg_level == SOL_IPV6 &&
-			    pcmsg->cmsg_type == psoe->so_cmtype;
-			if (gotone) {
-				break;
-			} else if (psoe->so_clear) {
-				tst_resm(TFAIL, "%s receive: extraneous data "
-					 "in control: level %d type %d len %zu",
-					 psoe->so_tname, pcmsg->cmsg_level,
-					 pcmsg->cmsg_type, pcmsg->cmsg_len);
-				return;
-			}
-		}
-		/* check contents here */
-		if (psoe->so_dorecv)
-			tst_resm(gotone ? TPASS : TFAIL, "%s receive",
-				 psoe->so_tname);
-	}
-}
-
-static void do_tests(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < SOCOUNT; ++i) {
-		sotab[i].so_clrval.sou_bool = 0;
-		sotab[i].so_setval.sou_bool = 1;
-		so_test(&sotab[i]);
-	}
-}
-
-static void setup(void)
-{
-	TEST_PAUSE;
-}
-- 
1.9.3

