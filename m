Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1Ycqwy-0005Nx-Mg
	for ltp-list@lists.sourceforge.net; Tue, 31 Mar 2015 07:51:04 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ycqww-000311-3K
	for ltp-list@lists.sourceforge.net; Tue, 31 Mar 2015 07:51:04 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t2V7ns3Q000394
	for <ltp-list@lists.sourceforge.net>; Tue, 31 Mar 2015 15:49:54 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Tue, 31 Mar 2015 15:46:12 +0800
Message-ID: <1427787975-10668-3-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/6] lib6/asapi_05.c: cleanup
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
* Modify the format of etab[] and ftab[].
* Some cleanup.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/network/lib6/asapi_05.c | 327 +++++++++++++++++---------------------
 1 file changed, 144 insertions(+), 183 deletions(-)

diff --git a/testcases/network/lib6/asapi_05.c b/testcases/network/lib6/asapi_05.c
index 9acc6a2..373e84b 100644
--- a/testcases/network/lib6/asapi_05.c
+++ b/testcases/network/lib6/asapi_05.c
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
- * Test Name: asapi_05
- *
- * Test Description:
- *  These tests are for the "Advanced Sockets API" (RFC 3542)
- *  Verify that in6 and sockaddr fields are present.
- *
- * Usage:  <for command-line>
- *  asapi_05
- *
- * HISTORY
- *	04/2005 written by David L Stevens
- *
- * RESTRICTIONS:
- *  None.
- *
+ *   Description:
+ *     These tests are for the "Advanced Sockets API" (RFC 3542).
+ *     Verify that in6 and sockaddr fields are present.
  */
 
 #include <stdio.h>
@@ -49,19 +37,120 @@
 #include "test.h"
 #include "runcc.h"
 
-char *TCID = "asapi_05";	/* Test program identifier.    */
+enum ttype { EXISTS, ALIAS, VALUE, DEFINED };
+
+struct etent {
+	char *et_tname;		/* test name */
+	int et_type;		/* test type */
+	char *et_incl;		/* include file list */
+	char *et_struct;	/* structure name */
+	char *et_field;		/* field name */
+	char *et_offset;	/* field offset */
+	union {
+		char *fu_value;	/* field size or value */
+		char *fu_dname;	/* #define name */
+	} ftun;
+#define et_value	ftun.fu_value
+#define et_dname	ftun.fu_dname
+} etab[] = {
+	/* existence checks, RFC 3542 section 3 */
+	{ "icmp6_filter icmp6_filt", EXISTS, ICMP6_H,
+		"icmp6_filter", "icmp6_filt", "0", {"32"} },
+	{ "icmp6_filter icmp6_filt[0]", EXISTS, ICMP6_H,
+		"icmp6_filter", "icmp6_filt[0]", "0", {"4"} },
+	{ "ICMP6_FILTER_WILLPASS", DEFINED, ICMP6_H,
+		"ICMP6_FILTER_WILLPASS", NULL, NULL, {0} },
+	{ "ICMP6_FILTER_WILLBLOCK", DEFINED, ICMP6_H,
+		"ICMP6_FILTER_WILLBLOCK", NULL, NULL, {0} },
+	{ "ICMP6_FILTER_SETPASS", DEFINED, ICMP6_H,
+		"ICMP6_FILTER_SETPASS", NULL, NULL, {0} },
+	{ "ICMP6_FILTER_SETBLOCK", DEFINED, ICMP6_H,
+		"ICMP6_FILTER_SETBLOCK", NULL, NULL, {0} },
+	{ "ICMP6_FILTER_SETPASSALL", DEFINED, ICMP6_H,
+		"ICMP6_FILTER_SETPASSALL", NULL, NULL, {0} },
+	{ "ICMP6_FILTER_SETBLOCKALL", DEFINED, ICMP6_H,
+		"ICMP6_FILTER_SETBLOCKALL", NULL, NULL, {0} },
+	{ "ICMP6_FILTER", DEFINED, ICMP6_H, "ICMP6_FILTER",
+		NULL, NULL, {0} },
+	/* existence checks, RFC 3542 section 4 */
+	/* socket options */
+	{ "IPV6_RECVPKTINFO", VALUE, IN_H, "IPV6_RECVPKTINFO",
+		NULL, NULL, {"IPV6_RECVPKTINFO"} },
+	{ "IPV6_RECVHOPLIMIT", VALUE, IN_H, "IPV6_RECVHOPLIMIT",
+		NULL, NULL, {"IPV6_RECVHOPLIMIT"} },
+	{ "IPV6_RECVRTHDR", VALUE, IN_H, "IPV6_RECVRTHDR",
+		NULL, NULL, {"IPV6_RECVRTHDR"} },
+	{ "IPV6_RECVHOPOPTS", VALUE, IN_H, "IPV6_RECVHOPOPTS",
+		NULL, NULL, {"IPV6_RECVHOPOPTS"} },
+	{ "IPV6_RECVDSTOPTS", VALUE, IN_H, "IPV6_RECVDSTOPTS",
+		NULL, NULL, {"IPV6_RECVDSTOPTS"} },
+	{ "IPV6_RECVTCLASS", VALUE, IN_H, "IPV6_RECVTCLASS",
+		NULL, NULL, {"IPV6_RECVTCLASS"} },
+	/* cmsg types */
+	{ "IPV6_PKTINFO", DEFINED, IN_H, "IPV6_PKTINFO",
+		NULL, NULL, {0} },
+	{ "IPV6_HOPLIMIT", DEFINED, IN_H, "IPV6_HOPLIMIT",
+		NULL, NULL, {0} },
+	{ "IPV6_NEXTHOP", DEFINED, IN_H, "IPV6_NEXTHOP",
+		NULL, NULL, {0} },
+	{ "IPV6_RTHDR", DEFINED, IN_H, "IPV6_RTHDR",
+		NULL, NULL, {0} },
+	{ "IPV6_HOPOPTS", DEFINED, IN_H, "IPV6_HOPOPTS",
+		NULL, NULL, {0} },
+	{ "IPV6_DSTOPTS", DEFINED, IN_H, "IPV6_DSTOPTS",
+		NULL, NULL, {0} },
+	{ "IPV6_RTHDRDSTOPTS", DEFINED, IN_H, "IPV6_RTHDRDSTOPTS",
+		NULL, NULL, {0} },
+	{ "IPV6_TCLASS", DEFINED, IN_H, "IPV6_TCLASS",
+		NULL, NULL, {0} },
+};
+
+#define ETCOUNT	(sizeof(etab)/sizeof(etab[0]))
+
+/*
+ * This is for old, broken glibc-header icmp6_filter structure definitions.
+ * If icmp6.h has struct icmp6_filter with field named "data" instead
+ * of the standard "icmp_filt", uncomment this line.
+ */
+/*#define icmp_filt	data */
+
+enum tt { T_WILLPASS, T_WILLBLOCK, T_SETPASS, T_SETBLOCK, T_SETPASSALL,
+	T_SETBLOCKALL
+};
+struct ftent {
+	char *ft_tname;		/* test name, for logging */
+	unsigned char ft_sndtype;	/* send type field */
+	unsigned char ft_flttype;	/* filter type field */
+	enum tt ft_test;	/* what macro to test */
+	int ft_expected;	/* packet should pass? */
+} ftab[] = {
+	{ "ICMP6_FILTER_SETPASS s 20 f 20", 20, 20, T_SETPASS, 1 },
+	{ "ICMP6_FILTER_SETPASS s 20 f 21", 20, 21, T_SETPASS, 0 },
+	{ "ICMP6_FILTER_SETBLOCK s 20 f 20", 20, 20, T_SETBLOCK, 0 },
+	{ "ICMP6_FILTER_SETBLOCK s 20 f 21", 20, 21, T_SETBLOCK, 1 },
+	{ "ICMP6_FILTER_PASSALL s 20", 20, 0, T_SETPASSALL, 1 },
+	{ "ICMP6_FILTER_PASSALL s 20", 21, 0, T_SETPASSALL, 1 },
+	{ "ICMP6_FILTER_BLOCKALL s 20", 20, 0, T_SETBLOCKALL, 0 },
+	{ "ICMP6_FILTER_BLOCKALL s 20", 21, 0, T_SETBLOCKALL, 0 },
+	{ "ICMP6_FILTER_WILLBLOCK s 20 f 21", 20, 21, T_WILLBLOCK, 0 },
+	{ "ICMP6_FILTER_WILLBLOCK s 20 f 20", 20, 20, T_WILLBLOCK, 1 },
+	{ "ICMP6_FILTER_WILLPASS s 20 f 21", 20, 21, T_WILLPASS, 0 },
+	{ "ICMP6_FILTER_WILLPASS s 22 f 22", 22, 22, T_WILLPASS, 1 },
+};
+
+#define FTCOUNT	(sizeof(ftab)/sizeof(ftab[0]))
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
+static void icmp6_et(void);
+static void icmp6_ft(void);
 
-void icmp6_et(void);
-void icmp6_ft(void);
+char *TCID = "asapi_05";
+int TST_TOTAL = ETCOUNT + FTCOUNT;
 
 int main(int argc, char *argv[])
 {
 	int lc;
 
-	/* Parse standard options given to run the test. */
 	tst_parse_opts(argc, argv, NULL, NULL);
 
 	setup();
@@ -71,168 +160,47 @@ int main(int argc, char *argv[])
 		icmp6_ft();
 	}
 
-	cleanup();
-
 	tst_exit();
 }
 
-enum ttype { EXISTS, ALIAS, VALUE, DEFINED };
-
-struct etent {
-	char *et_tname;		/* test name */
-	int et_type;		/* test type */
-	char *et_incl;		/* include file list */
-	char *et_struct;	/* structure name */
-	char *et_field;		/* field name */
-	char *et_offset;	/* field offset */
-	union {
-		char *fu_value;	/* field size or value */
-		char *fu_dname;	/* #define name */
-	} ftun;
-#define et_value	ftun.fu_value
-#define et_dname	ftun.fu_dname
-} etab[] = {
-/* existence checks, RFC 3542 section 3 */
-	{
-		"icmp6_filter icmp6_filt", EXISTS, ICMP6_H, "icmp6_filter",
-		    "icmp6_filt", "0", {
-	"32"}}, {
-		"icmp6_filter icmp6_filt[0]", EXISTS, ICMP6_H, "icmp6_filter",
-		    "icmp6_filt[0]", "0", {
-	"4"}}, {
-		"ICMP6_FILTER_WILLPASS", DEFINED, ICMP6_H,
-		    "ICMP6_FILTER_WILLPASS", NULL, NULL, {
-	0}}, {
-		"ICMP6_FILTER_WILLBLOCK", DEFINED, ICMP6_H,
-		    "ICMP6_FILTER_WILLBLOCK", NULL, NULL, {
-	0}}, {
-		"ICMP6_FILTER_SETPASS", DEFINED, ICMP6_H,
-		    "ICMP6_FILTER_SETPASS", NULL, NULL, {
-	0}}, {
-		"ICMP6_FILTER_SETBLOCK", DEFINED, ICMP6_H,
-		    "ICMP6_FILTER_SETBLOCK", NULL, NULL, {
-	0}}, {
-		"ICMP6_FILTER_SETPASSALL", DEFINED, ICMP6_H,
-		    "ICMP6_FILTER_SETPASSALL", NULL, NULL, {
-	0}}, {
-		"ICMP6_FILTER_SETBLOCKALL", DEFINED, ICMP6_H,
-		    "ICMP6_FILTER_SETBLOCKALL", NULL, NULL, {
-	0}}, {
-		"ICMP6_FILTER", DEFINED, ICMP6_H, "ICMP6_FILTER", NULL, NULL, {
-	0}},
-/* existence checks, RFC 3542 section 4 */
-/* socket options */
-	{
-		"IPV6_RECVPKTINFO", VALUE, IN_H, "IPV6_RECVPKTINFO", NULL, NULL, {
-	"IPV6_RECVPKTINFO"}}, {
-		"IPV6_RECVHOPLIMIT", VALUE, IN_H, "IPV6_RECVHOPLIMIT", NULL,
-		    NULL, {
-	"IPV6_RECVHOPLIMIT"}}, {
-		"IPV6_RECVRTHDR", VALUE, IN_H, "IPV6_RECVRTHDR", NULL, NULL, {
-	"IPV6_RECVRTHDR"}}, {
-		"IPV6_RECVHOPOPTS", VALUE, IN_H, "IPV6_RECVHOPOPTS", NULL, NULL, {
-	"IPV6_RECVHOPOPTS"}}, {
-		"IPV6_RECVDSTOPTS", VALUE, IN_H, "IPV6_RECVDSTOPTS", NULL, NULL, {
-	"IPV6_RECVDSTOPTS"}}, {
-		"IPV6_RECVTCLASS", VALUE, IN_H, "IPV6_RECVTCLASS", NULL, NULL, {
-	"IPV6_RECVTCLASS"}},
-/* cmsg types */
-	{
-		"IPV6_PKTINFO", DEFINED, IN_H, "IPV6_PKTINFO", NULL, NULL, {
-	0}}, {
-		"IPV6_HOPLIMIT", DEFINED, IN_H, "IPV6_HOPLIMIT", NULL, NULL, {
-	0}}, {
-		"IPV6_NEXTHOP", DEFINED, IN_H, "IPV6_NEXTHOP", NULL, NULL, {
-	0}}, {
-		"IPV6_RTHDR", DEFINED, IN_H, "IPV6_RTHDR", NULL, NULL, {
-	0}}, {
-		"IPV6_HOPOPTS", DEFINED, IN_H, "IPV6_HOPOPTS", NULL, NULL, {
-	0}}, {
-		"IPV6_DSTOPTS", DEFINED, IN_H, "IPV6_DSTOPTS", NULL, NULL, {
-	0}}, {
-		"IPV6_RTHDRDSTOPTS", DEFINED, IN_H, "IPV6_RTHDRDSTOPTS", NULL,
-		    NULL, {
-	0}}, {
-		"IPV6_TCLASS", DEFINED, IN_H, "IPV6_TCLASS", NULL, NULL, {
-0}},};
-
-#define ETCOUNT	(sizeof(etab)/sizeof(etab[0]))
+void setup(void)
+{
+	TEST_PAUSE;
+	tst_require_root(NULL);
+}
 
 /*  existence tests */
 void icmp6_et(void)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ETCOUNT; ++i) {
 		switch (etab[i].et_type) {
 		case EXISTS:
 			structcheck(etab[i].et_tname, etab[i].et_incl,
-				    etab[i].et_struct, etab[i].et_field,
-				    etab[i].et_offset, etab[i].et_value);
+				etab[i].et_struct, etab[i].et_field,
+				etab[i].et_offset, etab[i].et_value);
 			break;
 		case ALIAS:
 			aliascheck(etab[i].et_tname, etab[i].et_incl,
-				   etab[i].et_struct, etab[i].et_field,
-				   etab[i].et_dname);
+				etab[i].et_struct, etab[i].et_field,
+				etab[i].et_dname);
 			break;
 		case VALUE:
 			valuecheck(etab[i].et_tname, etab[i].et_incl,
-				   etab[i].et_struct, etab[i].et_dname);
+				etab[i].et_struct, etab[i].et_dname);
 			break;
 		case DEFINED:
 			funccheck(etab[i].et_tname, etab[i].et_incl,
-				  etab[i].et_struct);
+				etab[i].et_struct);
 			break;
 		default:
-			tst_resm(TBROK, "invalid type %d", etab[i].et_type);
-			break;
+			tst_brkm(TBROK, NULL, "invalid type %d",
+				etab[i].et_type);
 		}
 	}
 }
 
-void setup(void)
-{
-	TEST_PAUSE;		/* if -P option specified */
-	tst_require_root(NULL);
-}
-
-void cleanup(void)
-{
-}
-
-/*
- * This is for old, broken glibc-header icmp6_filter structure definitions.
- * If icmp6.h has struct icmp6_filter with field named "data" instead
- * of the standard "icmp_filt", uncomment this line.
- */
-/*#define icmp_filt	data */
-
-enum tt { T_WILLPASS, T_WILLBLOCK, T_SETPASS, T_SETBLOCK, T_SETPASSALL,
-	T_SETBLOCKALL
-};
-struct ftent {
-	char *ft_tname;		/* test name, for logging */
-	unsigned char ft_sndtype;	/* send type field */
-	unsigned char ft_flttype;	/* filter type field */
-	enum tt ft_test;	/* what macro to test */
-	int ft_expected;	/* packet should pass? */
-} ftab[] = {
-	{
-	"ICMP6_FILTER_SETPASS s 20 f 20", 20, 20, T_SETPASS, 1}, {
-	"ICMP6_FILTER_SETPASS s 20 f 21", 20, 21, T_SETPASS, 0}, {
-	"ICMP6_FILTER_SETBLOCK s 20 f 20", 20, 20, T_SETBLOCK, 0}, {
-	"ICMP6_FILTER_SETBLOCK s 20 f 21", 20, 21, T_SETBLOCK, 1}, {
-	"ICMP6_FILTER_PASSALL s 20", 20, 0, T_SETPASSALL, 1}, {
-	"ICMP6_FILTER_PASSALL s 20", 21, 0, T_SETPASSALL, 1}, {
-	"ICMP6_FILTER_BLOCKALL s 20", 20, 0, T_SETBLOCKALL, 0}, {
-	"ICMP6_FILTER_BLOCKALL s 20", 21, 0, T_SETBLOCKALL, 0}, {
-	"ICMP6_FILTER_WILLBLOCK s 20 f 21", 20, 21, T_WILLBLOCK, 0}, {
-	"ICMP6_FILTER_WILLBLOCK s 20 f 20", 20, 20, T_WILLBLOCK, 1}, {
-	"ICMP6_FILTER_WILLPASS s 20 f 21", 20, 21, T_WILLPASS, 0}, {
-"ICMP6_FILTER_WILLPASS s 22 f 22", 22, 22, T_WILLPASS, 1},};
-
-#define FTCOUNT	(sizeof(ftab)/sizeof(ftab[0]))
-
 int ic6_send1(char *tname, unsigned char type)
 {
 	struct sockaddr_in6 sin6;
@@ -241,8 +209,7 @@ int ic6_send1(char *tname, unsigned char type)
 
 	s = socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
 	if (s == -1) {
-		tst_resm(TBROK, "%s: socket failed", tname);
-		return 1;
+		tst_brkm(TBROK | TERRNO, NULL, "%s: socket failed", tname);
 	}
 	memset(&ic6, 0, sizeof(ic6));
 	ic6.icmp6_type = type;
@@ -253,8 +220,7 @@ int ic6_send1(char *tname, unsigned char type)
 	sin6.sin6_addr = in6addr_loopback;
 	if (sendto(s, &ic6, sizeof(ic6), 0, (struct sockaddr *)&sin6,
 		   sizeof(sin6)) == -1) {
-		tst_resm(TBROK | TERRNO, "%s: sendto failed", tname);
-		return 1;
+		tst_brkm(TBROK | TERRNO, NULL, "%s: sendto failed", tname);
 	}
 	return 0;
 }
@@ -292,35 +258,35 @@ int ic6_recv1(char *tname, int sall, int sf)
 		if (nfds < 0) {
 			if (errno == EINTR)
 				continue;
-			tst_resm(TBROK | TERRNO, "%s: select failed", tname);
+			tst_brkm(TBROK | TERRNO, NULL,
+				"%s: select failed", tname);
 		}
 		if (FD_ISSET(sall, &readfds)) {
 			cc = recv(sall, rbuf, sizeof(rbuf), 0);
 			if (cc < 0) {
-				tst_resm(TBROK | TERRNO,
+				tst_brkm(TBROK | TERRNO, NULL,
 					 "%s: recv(sall, ..) failed", tname);
-				return -1;
 			}
 			/* if packet check succeeds... */
-			if (htonl(pic6->icmp6_data32[0]) == getpid())
+			if (htonl(pic6->icmp6_data32[0]) ==
+				(uint32_t)getpid())
 				gotall = 1;
 		}
 		if (FD_ISSET(sf, &readfds)) {
 			cc = recv(sf, rbuf, sizeof(rbuf), 0);
 			if (cc < 0) {
-				tst_resm(TBROK | TERRNO,
+				tst_brkm(TBROK | TERRNO, NULL,
 					 "%s: recv(sf, ..) failed", tname);
-				return -1;
 			}
 			/* if packet check succeeds... */
-			if (htonl(pic6->icmp6_data32[0]) == getpid())
+			if (htonl(pic6->icmp6_data32[0]) ==
+				(uint32_t)getpid())
 				gotone = 1;
 		}
 		memcpy(&readfds, &readfds_saved, sizeof(readfds));
 	}
 	if (!gotall) {
-		tst_resm(TBROK, "%s: recv all timed out", tname);
-		return -1;
+		tst_brkm(TBROK, NULL, "%s: recv all timed out", tname);
 	}
 	if (gotone)
 		return 1;
@@ -332,26 +298,24 @@ void icmp6_ft(void)
 {
 	struct icmp6_filter i6f;
 	int sall, sf;
-	int i;
+	unsigned int i;
 
 	sall = socket(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
 	if (sall < 0) {
-		tst_resm(TBROK | TERRNO,
+		tst_brkm(TBROK | TERRNO, NULL,
 			 "icmp6_ft socket: can't create sall socket");
-		return;
 	}
 	ICMP6_FILTER_SETPASSALL(&i6f);
 	if (setsockopt(sall, IPPROTO_ICMPV6, ICMP6_FILTER, &i6f,
 		       sizeof(i6f)) < 0) {
-		tst_resm(TBROK | TERRNO,
+		tst_brkm(TBROK | TERRNO, NULL,
 			 "setsockopt pass all ICMP6_FILTER failed");
 	}
 
 	sf = socket(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
 	if (sf < 0) {
-		tst_resm(TBROK | TERRNO,
+		tst_brkm(TBROK | TERRNO, NULL,
 			 "icmp6_ft socket: can't create test socket");
-		return;
 	}
 
 	int rv;
@@ -386,9 +350,8 @@ void icmp6_ft(void)
 			rv = ICMP6_FILTER_WILLPASS(ftab[i].ft_sndtype, &i6f);
 			break;
 		default:
-			tst_resm(TBROK, "%s: unknown test type %d",
+			tst_brkm(TBROK, NULL, "%s: unknown test type %d",
 				 ftab[i].ft_tname, ftab[i].ft_test);
-			continue;
 		}
 		if (ftab[i].ft_test != T_WILLBLOCK &&
 		    ftab[i].ft_test != T_WILLPASS) {
@@ -396,7 +359,7 @@ void icmp6_ft(void)
 				       sizeof(i6f)) < 0) {
 				tst_resm(TFAIL | TERRNO,
 					 "setsockopt ICMP6_FILTER");
-				continue;
+				return;
 			}
 			if (ic6_send1(ftab[i].ft_tname, ftab[i].ft_sndtype))
 				continue;
@@ -413,5 +376,3 @@ void icmp6_ft(void)
 			tst_resm(TPASS, "%s", ftab[i].ft_tname);
 	}
 }
-
-int TST_TOTAL = ETCOUNT;
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
