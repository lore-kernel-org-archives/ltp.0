Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1YEaiv-0002yf-HC
	for ltp-list@lists.sourceforge.net; Fri, 23 Jan 2015 09:40:17 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YEait-0004vw-Jw
	for ltp-list@lists.sourceforge.net; Fri, 23 Jan 2015 09:40:17 +0000
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t0N9dThP006589
	for <ltp-list@lists.sourceforge.net>; Fri, 23 Jan 2015 17:39:29 +0800
From: Xing Gu <gux.fnst@cn.fujitsu.com>
Date: Fri, 23 Jan 2015 17:36:09 +0800
Message-ID: <1422005772-19099-4-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1422005772-19099-1-git-send-email-gux.fnst@cn.fujitsu.com>
References: <1422005772-19099-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 4/7] lib6/asapi_07.c: cleanup
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

* Remove useless comments.

* Modify the format of etab[].

* Modify adatet() as the test body.

Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
---
 testcases/network/lib6/asapi_07.c | 213 +++++++++++++++++---------------------
 1 file changed, 94 insertions(+), 119 deletions(-)

diff --git a/testcases/network/lib6/asapi_07.c b/testcases/network/lib6/asapi_07.c
index 4571320..213754b 100644
--- a/testcases/network/lib6/asapi_07.c
+++ b/testcases/network/lib6/asapi_07.c
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
- * Test Name: asapi_07
- *
- * Test Description:
- *  These tests are for the "Advanced Sockets API" (RFC 3542)
- *  Section 20, ancillary data macros and structure definitions
- *
- * Usage:  <for command-line>
- *  asapi_07
- *
- * HISTORY
- *	04/2005 written by David L Stevens
- *
- * RESTRICTIONS:
- *  None.
- *
+ *   Description:
+ *     These tests are for the "Advanced Sockets API" (RFC 3542)
+ *     Section 20, ancillary data macros and structure definitions
  */
 
 #include <stdio.h>
@@ -49,37 +37,9 @@
 #include "usctest.h"
 #include "runcc.h"
 
-char *TCID = "asapi_07";	/* Test program identifier.    */
-
-void setup(void);
-void cleanup(void);
-
-void adatet(void);
-void adatft(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-	const char *msg;
-
-	/* Parse standard options given to run the test. */
-	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		adatet();
-	}
-
-	cleanup();
-
-	tst_exit();
-}
-
 enum ttype { EXISTS, ALIAS, VALUE, DEFINED };
 
-struct etent {
+static struct etent {
 	char *et_tname;		/* test name */
 	int et_type;		/* test type */
 	char *et_incl;		/* include file list */
@@ -93,84 +53,72 @@ struct etent {
 #define et_value	ftun.fu_value
 #define et_dname	ftun.fu_dname
 } etab[] = {
-/* existence checks, RFC 3542 sections 5, 20 */
-	{
-		"msghdr msg_name", EXISTS, SOCKET_H, "msghdr", "msg_name", NULL, {
-	"sizeof(void *)"}}, {
-		"msghdr msg_namelen", EXISTS, SOCKET_H, "msghdr",
-		    "msg_namelen", NULL, {
-	"sizeof(socklen_t)"}}, {
-		"msghdr msg_iov", EXISTS, SOCKET_H, "msghdr", "msg_iov", NULL, {
-	"sizeof(struct iovec *)"}}, {
-		"msghdr msg_iovlen", EXISTS, SOCKET_H, "msghdr",
-		    "msg_iovlen", NULL, {
-	"sizeof(size_t)"}}, {
-		"msghdr msg_control", EXISTS, SOCKET_H, "msghdr",
-		    "msg_control", NULL, {
-	"sizeof(void *)"}}, {
-		"msghdr msg_controllen", EXISTS, SOCKET_H, "msghdr",
-		    "msg_controllen", NULL, {
-	"sizeof(size_t)"}}, {
-		"msghdr msg_flags", EXISTS, SOCKET_H, "msghdr",
-		    "msg_flags", NULL, {
-	"sizeof(int)"}}, {
-		"cmsghdr cmsg_len", EXISTS, SOCKET_H, "cmsghdr",
-		    "cmsg_len", NULL, {
-	"sizeof(size_t)"}}, {
-		"cmsghdr cmsg_level", EXISTS, SOCKET_H, "cmsghdr",
-		    "cmsg_level", NULL, {
-	"sizeof(int)"}}, {
-		"cmsghdr cmsg_type", EXISTS, SOCKET_H, "cmsghdr",
-		    "cmsg_type", NULL, {
-	"sizeof(int)"}}, {
-		"CMSG_DATA", DEFINED, SOCKET_H, "CMSG_DATA", NULL, NULL, {
-	0}}, {
-		"CMSG_NXTHDR", DEFINED, SOCKET_H, "CMSG_NXTHDR", NULL, NULL, {
-	0}}, {
-		"CMSG_FIRSTHDR", DEFINED, SOCKET_H, "CMSG_FIRSTHDR", NULL, NULL, {
-	0}}, {
-		"CMSG_SPACE", DEFINED, SOCKET_H, "CMSG_SPACE", NULL, NULL, {
-	0}}, {
-		"CMSG_LEN", DEFINED, SOCKET_H, "CMSG_LEN", NULL, NULL, {
-0}},};
-
-#define ETCOUNT	(sizeof(etab)/sizeof(etab[0]))
+	/* existence checks, RFC 3542 sections 5, 20 */
+	{ "msghdr msg_name", EXISTS, SOCKET_H, "msghdr",
+		"msg_name", NULL, {"sizeof(void *)"} },
+	{ "msghdr msg_namelen", EXISTS, SOCKET_H, "msghdr",
+		"msg_namelen", NULL, {"sizeof(socklen_t)"} },
+	{ "msghdr msg_iov", EXISTS, SOCKET_H, "msghdr",
+		"msg_iov", NULL, {"sizeof(struct iovec *)"} },
+	{ "msghdr msg_iovlen", EXISTS, SOCKET_H, "msghdr",
+		"msg_iovlen", NULL, {"sizeof(size_t)"} },
+	{ "msghdr msg_control", EXISTS, SOCKET_H, "msghdr",
+		"msg_control", NULL, {"sizeof(void *)"} },
+	{ "msghdr msg_controllen", EXISTS, SOCKET_H, "msghdr",
+		"msg_controllen", NULL, {"sizeof(size_t)"} },
+	{ "msghdr msg_flags", EXISTS, SOCKET_H, "msghdr",
+		"msg_flags", NULL, {"sizeof(int)"} },
+	{ "cmsghdr cmsg_len", EXISTS, SOCKET_H, "cmsghdr",
+		"cmsg_len", NULL, {"sizeof(size_t)"} },
+	{ "cmsghdr cmsg_level", EXISTS, SOCKET_H, "cmsghdr",
+		"cmsg_level", NULL, {"sizeof(int)"} },
+	{ "cmsghdr cmsg_type", EXISTS, SOCKET_H, "cmsghdr",
+		"cmsg_type", NULL, {"sizeof(int)"} },
+	{ "CMSG_DATA", DEFINED, SOCKET_H, "CMSG_DATA",
+		NULL, NULL, {0} },
+	{ "CMSG_NXTHDR", DEFINED, SOCKET_H, "CMSG_NXTHDR",
+		NULL, NULL, {0} },
+	{ "CMSG_FIRSTHDR", DEFINED, SOCKET_H, "CMSG_FIRSTHDR",
+		NULL, NULL, {0} },
+	{ "CMSG_SPACE", DEFINED, SOCKET_H, "CMSG_SPACE",
+		NULL, NULL, {0} },
+	{ "CMSG_LEN", DEFINED, SOCKET_H, "CMSG_LEN",
+		NULL, NULL, {0} },
+};
+
+static void setup(void);
+static void cleanup(void);
+static void adatet(const struct etent *etptr);
+
+char *TCID = "asapi_07";
+int TST_TOTAL = ARRAY_SIZE(etab);
 
-/*  existence tests */
-void adatet(void)
+int main(int argc, char *argv[])
 {
-	int i;
-
-	for (i = 0; i < ETCOUNT; ++i) {
-		switch (etab[i].et_type) {
-		case EXISTS:
-			structcheck(etab[i].et_tname, etab[i].et_incl,
-				    etab[i].et_struct, etab[i].et_field,
-				    etab[i].et_offset, etab[i].et_value);
-			break;
-		case ALIAS:
-			aliascheck(etab[i].et_tname, etab[i].et_incl,
-				   etab[i].et_struct, etab[i].et_field,
-				   etab[i].et_dname);
-			break;
-		case VALUE:
-			valuecheck(etab[i].et_tname, etab[i].et_incl,
-				   etab[i].et_struct, etab[i].et_dname);
-			break;
-		case DEFINED:
-			funccheck(etab[i].et_tname, etab[i].et_incl,
-				  etab[i].et_struct);
-			break;
-		default:
-			tst_resm(TBROK, "invalid type %d", etab[i].et_type);
-			break;
-		}
+	int i, lc;
+	const char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+		tst_count = 0;
+
+		for (i = 0; i < TST_TOTAL; i++)
+			adatet(&etab[i]);
 	}
+
+	cleanup();
+
+	tst_exit();
 }
 
 void setup(void)
 {
-	TEST_PAUSE;		/* if -P option specified */
+	TEST_PAUSE;
 }
 
 void cleanup(void)
@@ -178,4 +126,31 @@ void cleanup(void)
 	TEST_CLEANUP;
 }
 
-int TST_TOTAL = ETCOUNT;
+/*  existence tests */
+void adatet(const struct etent *etptr)
+{
+	switch (etptr->et_type) {
+	case EXISTS:
+		structcheck(etptr->et_tname, etptr->et_incl,
+			etptr->et_struct, etptr->et_field,
+			etptr->et_offset, etptr->et_value);
+		break;
+	case ALIAS:
+		aliascheck(etptr->et_tname, etptr->et_incl,
+			etptr->et_struct, etptr->et_field,
+			etptr->et_dname);
+		break;
+	case VALUE:
+		valuecheck(etptr->et_tname, etptr->et_incl,
+			etptr->et_struct, etptr->et_dname);
+		break;
+	case DEFINED:
+		funccheck(etptr->et_tname, etptr->et_incl,
+			etptr->et_struct);
+		break;
+	default:
+		tst_resm(TBROK, "invalid type %d",
+			etptr->et_type);
+		break;
+	}
+}
-- 
1.9.3


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
