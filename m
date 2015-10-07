From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Wed, 7 Oct 2015 18:47:46 +0800
Subject: [LTP] [PATCH v7 4/7] lib6/asapi_05.c: Cleanup
In-Reply-To: <1444214869-3597-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1444214869-3597-1-git-send-email-zenglg.jy@cn.fujitsu.com>
Message-ID: <1444214869-3597-4-git-send-email-zenglg.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Add 'static' before some functions and global variables.
* Remove cleanup().
* Remove useless comments.
* Use SAFE_XXX().
* Modify the format of etab[] and ftab[].
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/lib6/asapi_05.c | 159 ++++++++++++++------------------------
 1 file changed, 60 insertions(+), 99 deletions(-)

diff --git a/testcases/network/lib6/asapi_05.c b/testcases/network/lib6/asapi_05.c
index e251eee..f8c30f1 100644
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
@@ -47,86 +30,74 @@
 #include <netinet/icmp6.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
-char *TCID = "asapi_05";	/* Test program identifier.    */
+char *TCID = "asapi_05";
 
-void setup(void);
-void cleanup(void);
+static void setup(void);
 
-void icmp6_ft(void);
+static void icmp6_ft(void);
 
 int main(int argc, char *argv[])
 {
 	int lc;
 
-	/* Parse standard options given to run the test. */
 	tst_parse_opts(argc, argv, NULL, NULL);
 
 	setup();
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+	for (lc = 0; TEST_LOOPING(lc); ++lc)
 		icmp6_ft();
-	}
-
-	cleanup();
 
 	tst_exit();
 }
 
-void setup(void)
+static void setup(void)
 {
-	TEST_PAUSE;		/* if -P option specified */
+	TEST_PAUSE;
 	tst_require_root();
 }
 
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
@@ -142,7 +113,7 @@ int ic6_send1(char *tname, unsigned char type)
 	return 0;
 }
 
-int ic6_recv1(char *tname, int sall, int sf)
+static int ic6_recv1(char *tname, int sall, int sf)
 {
 	fd_set readfds, readfds_saved;
 	struct timeval tv;
@@ -185,7 +156,7 @@ int ic6_recv1(char *tname, int sall, int sf)
 				return -1;
 			}
 			/* if packet check succeeds... */
-			if (htonl(pic6->icmp6_data32[0]) == getpid())
+			if (htonl(pic6->icmp6_data32[0]) == (uint32_t)getpid())
 				gotall = 1;
 		}
 		if (FD_ISSET(sf, &readfds)) {
@@ -196,7 +167,7 @@ int ic6_recv1(char *tname, int sall, int sf)
 				return -1;
 			}
 			/* if packet check succeeds... */
-			if (htonl(pic6->icmp6_data32[0]) == getpid())
+			if (htonl(pic6->icmp6_data32[0]) == (uint32_t)getpid())
 				gotone = 1;
 		}
 		memcpy(&readfds, &readfds_saved, sizeof(readfds));
@@ -211,18 +182,14 @@ int ic6_recv1(char *tname, int sall, int sf)
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
@@ -230,12 +197,7 @@ void icmp6_ft(void)
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
 
@@ -284,8 +246,9 @@ void icmp6_ft(void)
 			if (ic6_send1(ftab[i].ft_tname, ftab[i].ft_sndtype))
 				continue;
 			rv = ic6_recv1(ftab[i].ft_tname, sall, sf);
-		} else
+		} else {
 			rv = -1;
+		}
 
 		if (rv < 0)
 			continue;
@@ -296,5 +259,3 @@ void icmp6_ft(void)
 			tst_resm(TPASS, "%s", ftab[i].ft_tname);
 	}
 }
-
-int TST_TOTAL = FTCOUNT;
-- 
1.9.3

