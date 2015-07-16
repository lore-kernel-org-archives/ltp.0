Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1ZFbka-0005NT-RH
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 05:30:28 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZFbkW-0000of-JH
	for ltp-list@lists.sourceforge.net; Thu, 16 Jul 2015 05:30:28 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 16 Jul 2015 13:30:43 +0800
Message-ID: <1437024647-2066-7-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <55A680FC.2010807@oracle.com>
	<1437024647-2066-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v5 07/11] lib6/asapi_05.c: Cleanup
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
* Modify the format of etab[] and ftab[].
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/lib6/asapi_05.c | 274 ++++++++++++++++----------------------
 1 file changed, 113 insertions(+), 161 deletions(-)

diff --git a/testcases/network/lib6/asapi_05.c b/testcases/network/lib6/asapi_05.c
index 9acc6a2..25a5dbf 100644
--- a/testcases/network/lib6/asapi_05.c
+++ b/testcases/network/lib6/asapi_05.c
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
+ * Author: David L Stevens
  */
 
 #include <stdio.h>
@@ -47,21 +30,21 @@
 #include <netinet/icmp6.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "runcc.h"
 
-char *TCID = "asapi_05";	/* Test program identifier.    */
+char *TCID = "asapi_05";
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
+static void cleanup(void);
 
-void icmp6_et(void);
-void icmp6_ft(void);
+static void icmp6_et(void);
+static void icmp6_ft(void);
 
 int main(int argc, char *argv[])
 {
 	int lc;
 
-	/* Parse standard options given to run the test. */
 	tst_parse_opts(argc, argv, NULL, NULL);
 
 	setup();
@@ -72,13 +55,12 @@ int main(int argc, char *argv[])
 	}
 
 	cleanup();
-
 	tst_exit();
 }
 
 enum ttype { EXISTS, ALIAS, VALUE, DEFINED };
 
-struct etent {
+static struct etent {
 	char *et_tname;		/* test name */
 	int et_type;		/* test type */
 	char *et_incl;		/* include file list */
@@ -92,76 +74,58 @@ struct etent {
 #define et_value	ftun.fu_value
 #define et_dname	ftun.fu_dname
 } etab[] = {
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
+	/* existence checks, RFC 3542 section 3 */
+	{"icmp6_filter icmp6_filt", EXISTS, ICMP6_H, "icmp6_filter",
+	 "icmp6_filt", "0", {"32"} },
+	{"icmp6_filter icmp6_filt[0]", EXISTS, ICMP6_H, "icmp6_filter",
+	 "icmp6_filt[0]", "0", {"4"} },
+	{"ICMP6_FILTER_WILLPASS", DEFINED, ICMP6_H, "ICMP6_FILTER_WILLPASS",
+	 NULL, NULL, {0} },
+	{"ICMP6_FILTER_WILLBLOCK", DEFINED, ICMP6_H, "ICMP6_FILTER_WILLBLOCK",
+	 NULL, NULL, {0} },
+	{"ICMP6_FILTER_SETPASS", DEFINED, ICMP6_H, "ICMP6_FILTER_SETPASS", NULL,
+	 NULL, {0} },
+	{"ICMP6_FILTER_SETBLOCK", DEFINED, ICMP6_H, "ICMP6_FILTER_SETBLOCK",
+	 NULL, NULL, {0} },
+	{"ICMP6_FILTER_SETPASSALL", DEFINED, ICMP6_H, "ICMP6_FILTER_SETPASSALL",
+	 NULL, NULL, {0} },
+	{"ICMP6_FILTER_SETBLOCKALL", DEFINED, ICMP6_H,
+	 "ICMP6_FILTER_SETBLOCKALL", NULL, NULL, {0} },
+	{"ICMP6_FILTER", DEFINED, ICMP6_H, "ICMP6_FILTER", NULL, NULL, {0} },
+	/* existence checks, RFC 3542 section 4 */
+	/* socket options */
+	{"IPV6_RECVPKTINFO", VALUE, IN_H, "IPV6_RECVPKTINFO", NULL, NULL,
+	 {"IPV6_RECVPKTINFO"} },
+	{"IPV6_RECVHOPLIMIT", VALUE, IN_H, "IPV6_RECVHOPLIMIT", NULL, NULL,
+	 {"IPV6_RECVHOPLIMIT"} },
+	{"IPV6_RECVRTHDR", VALUE, IN_H, "IPV6_RECVRTHDR", NULL, NULL,
+	 {"IPV6_RECVRTHDR"} },
+	{"IPV6_RECVHOPOPTS", VALUE, IN_H, "IPV6_RECVHOPOPTS", NULL, NULL,
+	 {"IPV6_RECVHOPOPTS"} },
+	{"IPV6_RECVDSTOPTS", VALUE, IN_H, "IPV6_RECVDSTOPTS", NULL, NULL,
+	 {"IPV6_RECVDSTOPTS"} },
+	{"IPV6_RECVTCLASS", VALUE, IN_H, "IPV6_RECVTCLASS", NULL, NULL,
+	 {"IPV6_RECVTCLASS"} },
+	/* cmsg types */
+	{"IPV6_PKTINFO", DEFINED, IN_H, "IPV6_PKTINFO", NULL, NULL, {0} },
+	{"IPV6_HOPLIMIT", DEFINED, IN_H, "IPV6_HOPLIMIT", NULL, NULL, {0} },
+	{"IPV6_NEXTHOP", DEFINED, IN_H, "IPV6_NEXTHOP", NULL, NULL, {0} },
+	{"IPV6_RTHDR", DEFINED, IN_H, "IPV6_RTHDR", NULL, NULL, {0} },
+	{"IPV6_HOPOPTS", DEFINED, IN_H, "IPV6_HOPOPTS", NULL, NULL, {0} },
+	{"IPV6_DSTOPTS", DEFINED, IN_H, "IPV6_DSTOPTS", NULL, NULL, {0} },
+	{"IPV6_RTHDRDSTOPTS", DEFINED, IN_H, "IPV6_RTHDRDSTOPTS", NULL, NULL,
+	 {0} },
+	{"IPV6_TCLASS", DEFINED, IN_H, "IPV6_TCLASS", NULL, NULL, {0} },
+};
+
+#define ETCOUNT	ARRAY_SIZE(etab)
+
+int TST_TOTAL = ETCOUNT;
 
 /*  existence tests */
-void icmp6_et(void)
+static void icmp6_et(void)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ETCOUNT; ++i) {
 		switch (etab[i].et_type) {
@@ -190,60 +154,59 @@ void icmp6_et(void)
 	}
 }
 
-void setup(void)
+static void setup(void)
 {
-	TEST_PAUSE;		/* if -P option specified */
+	TEST_PAUSE;
 	tst_require_root(NULL);
+
+	tst_tmpdir();
 }
 
-void cleanup(void)
+static void cleanup(void)
 {
+	tst_rmdir();
 }
 
-/*
- * This is for old, broken glibc-header icmp6_filter structure definitions.
- * If icmp6.h has struct icmp6_filter with field named "data" instead
- * of the standard "icmp_filt", uncomment this line.
- */
-/*#define icmp_filt	data */
-
-enum tt { T_WILLPASS, T_WILLBLOCK, T_SETPASS, T_SETBLOCK, T_SETPASSALL,
+enum tt {
+	T_WILLPASS,
+	T_WILLBLOCK,
+	T_SETPASS,
+	T_SETBLOCK,
+	T_SETPASSALL,
 	T_SETBLOCKALL
 };
-struct ftent {
-	char *ft_tname;		/* test name, for logging */
+
+static struct ftent {
+	char *ft_tname;			/* test name, for logging */
 	unsigned char ft_sndtype;	/* send type field */
 	unsigned char ft_flttype;	/* filter type field */
-	enum tt ft_test;	/* what macro to test */
-	int ft_expected;	/* packet should pass? */
+	enum tt ft_test;		/* what macro to test */
+	int ft_expected;		/* packet should pass? */
 } ftab[] = {
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
-int ic6_send1(char *tname, unsigned char type)
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
 {
 	struct sockaddr_in6 sin6;
 	struct icmp6_hdr ic6;
 	int s;
 
-	s = socket(AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
-	if (s == -1) {
-		tst_resm(TBROK, "%s: socket failed", tname);
-		return 1;
-	}
+	s = SAFE_SOCKET(NULL, AF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
+
 	memset(&ic6, 0, sizeof(ic6));
 	ic6.icmp6_type = type;
 	ic6.icmp6_data32[0] = htonl(getpid());
@@ -259,7 +222,7 @@ int ic6_send1(char *tname, unsigned char type)
 	return 0;
 }
 
-int ic6_recv1(char *tname, int sall, int sf)
+static int ic6_recv1(char *tname, int sall, int sf)
 {
 	fd_set readfds, readfds_saved;
 	struct timeval tv;
@@ -302,7 +265,7 @@ int ic6_recv1(char *tname, int sall, int sf)
 				return -1;
 			}
 			/* if packet check succeeds... */
-			if (htonl(pic6->icmp6_data32[0]) == getpid())
+			if (htonl(pic6->icmp6_data32[0]) == (uint32_t)getpid())
 				gotall = 1;
 		}
 		if (FD_ISSET(sf, &readfds)) {
@@ -313,7 +276,7 @@ int ic6_recv1(char *tname, int sall, int sf)
 				return -1;
 			}
 			/* if packet check succeeds... */
-			if (htonl(pic6->icmp6_data32[0]) == getpid())
+			if (htonl(pic6->icmp6_data32[0]) == (uint32_t)getpid())
 				gotone = 1;
 		}
 		memcpy(&readfds, &readfds_saved, sizeof(readfds));
@@ -328,18 +291,14 @@ int ic6_recv1(char *tname, int sall, int sf)
 }
 
 /* functional tests */
-void icmp6_ft(void)
+static void icmp6_ft(void)
 {
 	struct icmp6_filter i6f;
 	int sall, sf;
-	int i;
+	unsigned int i;
+
+	sall = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
 
-	sall = socket(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
-	if (sall < 0) {
-		tst_resm(TBROK | TERRNO,
-			 "icmp6_ft socket: can't create sall socket");
-		return;
-	}
 	ICMP6_FILTER_SETPASSALL(&i6f);
 	if (setsockopt(sall, IPPROTO_ICMPV6, ICMP6_FILTER, &i6f,
 		       sizeof(i6f)) < 0) {
@@ -347,12 +306,7 @@ void icmp6_ft(void)
 			 "setsockopt pass all ICMP6_FILTER failed");
 	}
 
-	sf = socket(PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
-	if (sf < 0) {
-		tst_resm(TBROK | TERRNO,
-			 "icmp6_ft socket: can't create test socket");
-		return;
-	}
+	sf = SAFE_SOCKET(NULL, PF_INET6, SOCK_RAW, IPPROTO_ICMPV6);
 
 	int rv;
 
@@ -413,5 +367,3 @@ void icmp6_ft(void)
 			tst_resm(TPASS, "%s", ftab[i].ft_tname);
 	}
 }
-
-int TST_TOTAL = ETCOUNT;
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
