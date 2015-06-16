Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Z4qVE-0007yB-Vj
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 13:02:08 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z4qV7-0003pS-CF
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 13:02:08 +0000
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 16 Jun 2015 20:24:38 +0800
Message-ID: <1434457479-20493-6-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1434457479-20493-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <5572ED1E.1020203@oracle.com>
	<1434457479-20493-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 6/7] lib6/getaddrinfo_01.c: Cleanup
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
* Remove cleanup() function.
* Remove useless comments.
* In every test function, using TINFO instead of TPASS
  marks the success of each inner test.
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/lib6/getaddrinfo_01.c | 503 ++++++++++++++++++--------------
 1 file changed, 281 insertions(+), 222 deletions(-)

diff --git a/testcases/network/lib6/getaddrinfo_01.c b/testcases/network/lib6/getaddrinfo_01.c
index ec29b5d..a812e77 100644
--- a/testcases/network/lib6/getaddrinfo_01.c
+++ b/testcases/network/lib6/getaddrinfo_01.c
@@ -1,43 +1,21 @@
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
- * Test Name: getaddrinfo_01
- *
- * Test Description:
- *  Tests for getaddrinfo library function
- *
- * Usage:  <for command-line>
- *  getaddrinfo_01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2004 written by David L Stevens
- *
- * RESTRICTIONS:
- *  None.
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
+ * Author: David L Stevens
  */
 
 #include <unistd.h>
@@ -53,40 +31,38 @@
 #define AI_V4MAPPED    0x0008	/* IPv4 mapped addresses are acceptable.  */
 #endif
 
-char *TCID = "getaddrinfo_01";	/* Test program identifier.    */
-int testno;
+static void setup(void);
+static void gaiv4(void);
+static void gaiv6(void);
 
-void setup(void), cleanup(void);
-
-int TST_TOTAL = 1;
-
-/* a host that isn't where LTP is running */
-#define REMOTEHOSTNAME	"www.ibm.com"
-
-void gaiv4(void), gaiv6(void);
-void dumpres(struct addrinfo *);
+char *TCID = "getaddrinfo_01";
+int TST_TOTAL = 2;
 
 int main(int argc, char *argv[])
 {
 	int lc;
 
-	/* Parse standard options given to run the test. */
 	tst_parse_opts(argc, argv, NULL, NULL);
 
 	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
+		tst_count = 0;
+
 		gaiv4();
 		gaiv6();
 	}
-	cleanup();
 
-	return (0);
+	tst_exit();
 }
 
-/* getaddrinfo tests (v4) */
+static void setup(void)
+{
+	TEST_PAUSE;
+}
 
-void gaiv4(void)
+/* getaddrinfo tests (v4) */
+static void gaiv4(void)
 {
 	struct addrinfo *aires, hints, *pai;
 	char hostname[MAXHOSTNAMELEN + 1];
@@ -132,13 +108,18 @@ void gaiv4(void)
 				 psin ? psin->sin_family : 0,
 				 psin ? psin->sin_port : 0,
 				 psin ? htons(psin->sin_port) : 0);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv4 basic lookup");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv4 basic "
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv4 basic lookup");
+			freeaddrinfo(aires);
+		}
+	} else {
+		tst_resm(TFAIL, "getaddrinfo IPv4 basic "
 			 "lookup (\"%s\") returns %ld (\"%s\")", hostname,
 			 TEST_RETURN, gai_strerror(TEST_RETURN));
+		return;
+	}
 
 	/* test 2, IPv4 canonical name */
 	memset(&hints, 0, sizeof(hints));
@@ -152,20 +133,26 @@ void gaiv4(void)
 		if (!pai) {
 			tst_resm(TFAIL, "getaddrinfo IPv4 canonical name: no "
 				 "entries with canonical name set");
+			freeaddrinfo(aires);
+			return;
 		} else if (strcasecmp(hostname, pai->ai_canonname)) {
 			tst_resm(TFAIL, "getaddrinfo IPv4 canonical name "
 				 "(\"%s\") doesn't match hostname (\"%s\")",
 				 pai->ai_canonname, hostname);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv4 canonical name");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv4 "
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv4 canonical name");
+			freeaddrinfo(aires);
+		}
+	} else {
+		tst_resm(TFAIL, "getaddrinfo IPv4 "
 			 "canonical name (\"%s\") returns %ld (\"%s\")",
 			 shortname, TEST_RETURN, gai_strerror(TEST_RETURN));
+		return;
+	}
 
 	/* test 3, IPv4 host+service name */
-
 	memset(&hints, 0, sizeof(hints));
 	/*
 	 * These are hard-coded for echo/7 to avoid using getservbyname(),
@@ -200,13 +187,18 @@ void gaiv4(void)
 				 psin ? psin->sin_family : 0,
 				 psin ? psin->sin_port : 0,
 				 psin ? htons(psin->sin_port) : 0);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv4 host+service");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv4 host+"
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv4 host+service");
+			freeaddrinfo(aires);
+		}
+	} else {
+		tst_resm(TFAIL, "getaddrinfo IPv4 host+"
 			 "service returns %ld (\"%s\")", TEST_RETURN,
 			 gai_strerror(TEST_RETURN));
+		return;
+	}
 
 	/* test 4, IPv4 hostname+service, AI_PASSIVE */
 	memset(&hints, 0, sizeof(hints));
@@ -244,18 +236,22 @@ void gaiv4(void)
 				 psin ? psin->sin_family : 0,
 				 psin ? psin->sin_port : 0,
 				 psin ? htons(psin->sin_port) : 0);
-		} else
-			tst_resm(TPASS,
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO,
 				 "getaddrinfo IPv4 host+service PASSIVE");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv4 host+"
+			freeaddrinfo(aires);
+		}
+	} else {
+		tst_resm(TFAIL, "getaddrinfo IPv4 host+"
 			 "service, PASSIVE (\"%s\", \"%s\") returns %ld (\"%s\")",
 			 hostname, service, TEST_RETURN,
 			 gai_strerror(TEST_RETURN));
+		return;
+	}
 
 	/* test 5, IPv4 host+service w/ AI_NUMERICHOST */
-
 	memset(&hints, 0, sizeof(hints));
 	strcpy(service, "echo");
 	servnum = 7;
@@ -266,8 +262,11 @@ void gaiv4(void)
 		tst_resm(TFAIL, "getaddrinfo IPv4 AI_NUMERICHOST w/ hostname: "
 			 "returns %ld expected %d (EAI_NONAME)",
 			 TEST_RETURN, EAI_NONAME);
+		if (!TEST_RETURN)
+			freeaddrinfo(aires);
+		return;
 	} else
-		tst_resm(TPASS, "getaddrinfo IPv4 AI_NUMERICHOST w/ hostname");
+		tst_resm(TINFO, "getaddrinfo IPv4 AI_NUMERICHOST w/ hostname");
 	if (!TEST_RETURN)
 		freeaddrinfo(aires);
 
@@ -306,17 +305,28 @@ void gaiv4(void)
 				 psin ? psin->sin_family : 0,
 				 psin ? psin->sin_port : 0,
 				 psin ? htons(psin->sin_port) : 0);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv4 0+service, PASSIVE");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
-			 "getaddrinfo IPv4 0+service, PASSIVE (\"\", \"%s\") "
-			 "returns %ld (\"%s\")", service, TEST_RETURN,
-			 gai_strerror(TEST_RETURN));
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv4 0+service, PASSIVE");
+			freeaddrinfo(aires);
+		}
+	} else {
+		if (TEST_RETURN == EAI_BADFLAGS) {
+			tst_resm(TINFO, "getaddrinfo IPv4 0+service,"
+				" PASSIVE (\"\", \"%s\") returns %ld (\"%s\")",
+				service, TEST_RETURN,
+				gai_strerror(TEST_RETURN));
+		} else {
+			tst_resm(TFAIL, "getaddrinfo IPv4 0+service,i"
+				" PASSIVE (\"\", \"%s\") returns %ld (\"%s\")",
+				service, TEST_RETURN,
+				gai_strerror(TEST_RETURN));
+			return;
+		}
+	}
 
 	/* test 7, IPv4 0+service */
-
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_family = AF_INET;
 	hints.ai_socktype = SOCK_STREAM;
@@ -350,19 +360,30 @@ void gaiv4(void)
 				 psin ? psin->sin_family : 0,
 				 psin ? psin->sin_port : 0,
 				 psin ? htons(psin->sin_port) : 0);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv4 0+service");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
-			 "getaddrinfo IPv4 0+service (\"\", \"%s\") returns %ld "
-			 "(\"%s\")", service, TEST_RETURN,
-			 gai_strerror(TEST_RETURN));
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv4 0+service");
+			freeaddrinfo(aires);
+		}
+	} else {
+		if (TEST_RETURN == EAI_BADFLAGS) {
+			tst_resm(TINFO, "getaddrinfo IPv4 "
+				"0+service (\"\", \"%s\") returns %ld (\"%s\")",
+				service, TEST_RETURN,
+				gai_strerror(TEST_RETURN));
+		} else {
+			tst_resm(TFAIL, "getaddrinfo IPv4 "
+				"0+service (\"\", \"%s\") returns %ld (\"%s\")",
+				service, TEST_RETURN,
+				gai_strerror(TEST_RETURN));
+			return;
+		}
+	}
 
 	/* test 8, IPv4 host+service, AI_NUMERICSERV */
-
 #ifndef AI_NUMERICSERV
-	tst_resm(TFAIL, "getaddrinfo IPv4 host+service, AI_NUMERICSERV: flag "
+	tst_resm(TCONF, "getaddrinfo IPv4 host+service, AI_NUMERICSERV: flag "
 		 "not implemented");
 #else
 	memset(&hints, 0, sizeof(hints));
@@ -376,15 +397,18 @@ void gaiv4(void)
 			 "getaddrinfo IPv4 host+service, AI_NUMERICSERV: "
 			 "returns %ld (\"%s\") expected %d (EAI_NONAME)",
 			 TEST_RETURN, gai_strerror(TEST_RETURN), EAI_NONAME);
-	} else
-		tst_resm(TPASS,
+		if (!TEST_RETURN)
+			freeaddrinfo(aires);
+		return;
+	} else {
+		tst_resm(TINFO,
 			 "getaddrinfo IPv4 host+service, AI_NUMERICSERV");
+	}
 	if (!TEST_RETURN)
 		freeaddrinfo(aires);
 #endif /* AI_NUMERICSERV */
 
 	/* test 9, IPv4 SOCK_STREAM/IPPROTO_UDP hints */
-
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_family = AF_INET;
 	hints.ai_socktype = SOCK_STREAM;
@@ -396,12 +420,13 @@ void gaiv4(void)
 		tst_resm(TFAIL, "getaddrinfo IPv4 SOCK_STREAM/IPPROTO_UDP "
 			 "hints");
 		freeaddrinfo(aires);
-	} else
-		tst_resm(TPASS, "getaddrinfo IPv4 SOCK_STREAM/IPPROTO_UDP "
+		return;
+	} else {
+		tst_resm(TINFO, "getaddrinfo IPv4 SOCK_STREAM/IPPROTO_UDP "
 			 "hints");
+	}
 
 	/* test 10, IPv4 socktype 0, 513 */
-
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_family = AF_INET;
 	hints.ai_socktype = 0;
@@ -439,20 +464,31 @@ void gaiv4(void)
 				 psin ? psin->sin_family : 0,
 				 psin ? psin->sin_port : 0,
 				 psin ? htons(psin->sin_port) : 0);
-		} else if (got_tcp && got_udp)
-			tst_resm(TPASS, "getaddrinfo IPv4 socktype 0,513");
-		else
+			freeaddrinfo(aires);
+			return;
+		} else if (got_tcp && got_udp) {
+			tst_resm(TINFO, "getaddrinfo IPv4 socktype 0,513");
+			freeaddrinfo(aires);
+		} else {
 			tst_resm(TFAIL, "getaddrinfo IPv4 socktype 0,513 TCP %d"
 				 " UDP %d", got_tcp, got_udp);
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
-			 "getaddrinfo IPv4 socktype 0,513 (\"\", \"%s\") returns"
-			 " %ld (\"%s\")", service, TEST_RETURN,
-			 gai_strerror(TEST_RETURN));
+			freeaddrinfo(aires);
+			return;
+		}
+	} else {
+		if (TEST_RETURN == EAI_BADFLAGS) {
+			tst_resm(TINFO, "getaddrinfo IPv4 socktype 0,513"
+				" (\"\", \"%s\") returns %ld (\"%s\")", service,
+				TEST_RETURN, gai_strerror(TEST_RETURN));
+		} else {
+			tst_resm(TFAIL, "getaddrinfo IPv4 socktype 0,513"
+				" (\"\", \"%s\") returns %ld (\"%s\")", service,
+				TEST_RETURN, gai_strerror(TEST_RETURN));
+			return;
+		}
+	}
 
 	/* test 11, IPv4 AI_V4MAPPED */
-
 	/* AI_V4MAPPED should be ignored because family != AF_INET6 */
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_family = AF_INET;
@@ -482,18 +518,25 @@ void gaiv4(void)
 				 psin ? psin->sin_family : 0,
 				 psin ? psin->sin_port : 0,
 				 psin ? htons(psin->sin_port) : 0);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv4 AI_V4MAPPED");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv4 "
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv4 AI_V4MAPPED");
+			freeaddrinfo(aires);
+		}
+	} else {
+		tst_resm(TFAIL, "getaddrinfo IPv4 "
 			 "AI_V4MAPPED (\"%s\") returns %ld (\"%s\")", hostname,
 			 TEST_RETURN, gai_strerror(TEST_RETURN));
+		return;
+	}
+
+
+	tst_resm(TPASS, "getaddrinfo tests (v4) succeed");
 }
 
 /* getaddrinfo tests (v6) */
-
-void gaiv6(void)
+static void gaiv6(void)
 {
 	struct addrinfo *aires, hints, *pai;
 	char hostname[MAXHOSTNAMELEN + 1];
@@ -539,13 +582,18 @@ void gaiv6(void)
 				 psin6 ? psin6->sin6_family : 0,
 				 psin6 ? psin6->sin6_port : 0,
 				 psin6 ? htons(psin6->sin6_port) : 0);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv6 basic lookup");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv6 basic "
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv6 basic lookup");
+			freeaddrinfo(aires);
+		}
+	} else {
+		tst_resm(TFAIL, "getaddrinfo IPv6 basic "
 			 "lookup (\"%s\") returns %ld (\"%s\")", hostname,
 			 TEST_RETURN, gai_strerror(TEST_RETURN));
+		return;
+	}
 
 	/* test 13, IPv6 canonical name */
 	memset(&hints, 0, sizeof(hints));
@@ -559,20 +607,26 @@ void gaiv6(void)
 		if (!pai) {
 			tst_resm(TFAIL, "getaddrinfo IPv6 canonical name: no "
 				 "entries with canonical name set");
+			freeaddrinfo(aires);
+			return;
 		} else if (strcasecmp(hostname, pai->ai_canonname)) {
 			tst_resm(TFAIL, "getaddrinfo IPv6 canonical name "
 				 "(\"%s\") doesn't match hostname (\"%s\")",
 				 pai->ai_canonname, hostname);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv6 canonical name");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv6 "
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv6 canonical name");
+			freeaddrinfo(aires);
+		}
+	} else {
+		tst_resm(TFAIL, "getaddrinfo IPv6 "
 			 "canonical name (\"%s\") returns %ld (\"%s\")",
 			 shortname, TEST_RETURN, gai_strerror(TEST_RETURN));
+		return;
+	}
 
 	/* test 14, IPv6 host+service name */
-
 	memset(&hints, 0, sizeof(hints));
 	/*
 	 * These are hard-coded for echo/7 to avoid using getservbyname(),
@@ -607,13 +661,18 @@ void gaiv6(void)
 				 psin6 ? psin6->sin6_family : 0,
 				 psin6 ? psin6->sin6_port : 0,
 				 psin6 ? htons(psin6->sin6_port) : 0);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv6 host+service");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv6 host+"
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv6 host+service");
+			freeaddrinfo(aires);
+		}
+	} else {
+		tst_resm(TFAIL, "getaddrinfo IPv6 host+"
 			 "service returns %ld (\"%s\")", TEST_RETURN,
 			 gai_strerror(TEST_RETURN));
+		return;
+	}
 
 	/* test 15, IPv6 hostname+service, AI_PASSIVE */
 	memset(&hints, 0, sizeof(hints));
@@ -652,18 +711,22 @@ void gaiv6(void)
 				 psin6 ? psin6->sin6_family : 0,
 				 psin6 ? psin6->sin6_port : 0,
 				 psin6 ? htons(psin6->sin6_port) : 0);
-		} else
-			tst_resm(TPASS,
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO,
 				 "getaddrinfo IPv6 host+service PASSIVE");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv6 host+"
+			freeaddrinfo(aires);
+		}
+	} else {
+		tst_resm(TFAIL, "getaddrinfo IPv6 host+"
 			 "service, PASSIVE (\"%s\", \"%s\") returns %ld (\"%s\")",
 			 hostname, service, TEST_RETURN,
 			 gai_strerror(TEST_RETURN));
+		return;
+	}
 
 	/* test 16, IPv6 host+service w/ AI_NUMERICHOST */
-
 	memset(&hints, 0, sizeof(hints));
 	strcpy(service, "echo");
 	servnum = 7;
@@ -674,8 +737,11 @@ void gaiv6(void)
 		tst_resm(TFAIL, "getaddrinfo IPv6 AI_NUMERICHOST w/ hostname: "
 			 "returns %ld expected %d (EAI_NONAME)",
 			 TEST_RETURN, EAI_NONAME);
+		if (!TEST_RETURN)
+			freeaddrinfo(aires);
+		return;
 	} else
-		tst_resm(TPASS, "getaddrinfo IPv6 AI_NUMERICHOST w/ hostname");
+		tst_resm(TINFO, "getaddrinfo IPv6 AI_NUMERICHOST w/ hostname");
 	if (!TEST_RETURN)
 		freeaddrinfo(aires);
 
@@ -715,17 +781,26 @@ void gaiv6(void)
 				 psin6 ? psin6->sin6_family : 0,
 				 psin6 ? psin6->sin6_port : 0,
 				 psin6 ? htons(psin6->sin6_port) : 0);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv6 0+service, PASSIVE");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
-			 "getaddrinfo IPv6 0+service, PASSIVE (\"\", \"%s\") "
-			 "returns %ld (\"%s\")", service, TEST_RETURN,
-			 gai_strerror(TEST_RETURN));
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv6 0+service, PASSIVE");
+			freeaddrinfo(aires);
+		}
+	} else {
+		if (TEST_RETURN == EAI_BADFLAGS) {
+			tst_resm(TINFO, "getaddrinfo IPv6 0+service, PASSIVE"
+				" (\"\", \"%s\") returns %ld (\"%s\")", service,
+				TEST_RETURN, gai_strerror(TEST_RETURN));
+		} else {
+			tst_resm(TFAIL, "getaddrinfo IPv6 0+service, PASSIVE"
+				" (\"\", \"%s\") returns %ld (\"%s\")", service,
+				TEST_RETURN, gai_strerror(TEST_RETURN));
+			return;
+		}
+	}
 
 	/* test 18, IPv6 0+service */
-
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_family = AF_INET6;
 	hints.ai_socktype = SOCK_STREAM;
@@ -760,19 +835,28 @@ void gaiv6(void)
 				 psin6 ? psin6->sin6_family : 0,
 				 psin6 ? psin6->sin6_port : 0,
 				 psin6 ? htons(psin6->sin6_port) : 0);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv6 0+service");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
-			 "getaddrinfo IPv6 0+service (\"\", \"%s\") returns %ld "
-			 "(\"%s\")", service, TEST_RETURN,
-			 gai_strerror(TEST_RETURN));
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv6 0+service");
+			freeaddrinfo(aires);
+		}
+	} else {
+		if (TEST_RETURN == EAI_BADFLAGS) {
+			tst_resm(TINFO, "getaddrinfo IPv6 0+service"
+				" (\"\", \"%s\") returns %ld (\"%s\")", service,
+				TEST_RETURN, gai_strerror(TEST_RETURN));
+		} else {
+			tst_resm(TFAIL, "getaddrinfo IPv6 0+service"
+				" (\"\", \"%s\") returns %ld (\"%s\")", service,
+				TEST_RETURN, gai_strerror(TEST_RETURN));
+			return;
+		}
+	}
 
 	/* test 19, IPv6 host+service, AI_NUMERICSERV */
-
 #ifndef AI_NUMERICSERV
-	tst_resm(TFAIL, "getaddrinfo IPv6 host+service, AI_NUMERICSERV: flag "
+	tst_resm(TCONF, "getaddrinfo IPv6 host+service, AI_NUMERICSERV: flag "
 		 "not implemented");
 #else
 	memset(&hints, 0, sizeof(hints));
@@ -786,15 +870,17 @@ void gaiv6(void)
 			 "getaddrinfo IPv6 host+service, AI_NUMERICSERV: "
 			 "returns %ld (\"%s\") expected %d (EAI_NONAME)",
 			 TEST_RETURN, gai_strerror(TEST_RETURN), EAI_NONAME);
+		if (!TEST_RETURN)
+			freeaddrinfo(aires);
+		return;
 	} else
-		tst_resm(TPASS,
+		tst_resm(TINFO,
 			 "getaddrinfo IPv6 host+service, AI_NUMERICSERV");
 	if (!TEST_RETURN)
 		freeaddrinfo(aires);
 #endif /* AI_NUMERICSERV */
 
 	/* test 20, IPv6 SOCK_STREAM/IPPROTO_UDP hints */
-
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_family = AF_INET6;
 	hints.ai_socktype = SOCK_STREAM;
@@ -806,12 +892,13 @@ void gaiv6(void)
 		tst_resm(TFAIL, "getaddrinfo IPv6 SOCK_STREAM/IPPROTO_UDP "
 			 "hints");
 		freeaddrinfo(aires);
-	} else
-		tst_resm(TPASS, "getaddrinfo IPv6 SOCK_STREAM/IPPROTO_UDP "
+		return;
+	} else {
+		tst_resm(TINFO, "getaddrinfo IPv6 SOCK_STREAM/IPPROTO_UDP "
 			 "hints");
+	}
 
 	/* test 21, IPv6 socktype 0, 513 */
-
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_family = AF_INET6;
 	hints.ai_socktype = 0;
@@ -850,20 +937,31 @@ void gaiv6(void)
 				 psin6 ? psin6->sin6_family : 0,
 				 psin6 ? psin6->sin6_port : 0,
 				 psin6 ? htons(psin6->sin6_port) : 0);
-		} else if (got_tcp && got_udp)
-			tst_resm(TPASS, "getaddrinfo IPv6 socktype 0,513");
-		else
+			freeaddrinfo(aires);
+			return;
+		} else if (got_tcp && got_udp) {
+			tst_resm(TINFO, "getaddrinfo IPv6 socktype 0,513");
+			freeaddrinfo(aires);
+		} else {
 			tst_resm(TFAIL, "getaddrinfo IPv6 socktype 0,513 TCP %d"
 				 " UDP %d", got_tcp, got_udp);
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN == EAI_BADFLAGS ? TPASS : TFAIL,
-			 "getaddrinfo IPv6 socktype 0,513 (\"\", \"%s\") returns"
-			 " %ld (\"%s\")", service, TEST_RETURN,
-			 gai_strerror(TEST_RETURN));
+			freeaddrinfo(aires);
+			return;
+		}
+	} else {
+		if (TEST_RETURN == EAI_BADFLAGS) {
+			tst_resm(TINFO, "getaddrinfo IPv6 socktype 0,513"
+				" (\"\", \"%s\") returns %ld (\"%s\")", service,
+				TEST_RETURN, gai_strerror(TEST_RETURN));
+		} else {
+			tst_resm(TFAIL, "getaddrinfo IPv6 socktype 0,513"
+				" (\"\", \"%s\") returns %ld (\"%s\")", service,
+				TEST_RETURN, gai_strerror(TEST_RETURN));
+			return;
+		}
+	}
 
 	/* test 22, IPv6 AI_V4MAPPED */
-
 	memset(&hints, 0, sizeof(hints));
 	hints.ai_family = AF_INET6;
 	hints.ai_flags = AI_V4MAPPED;
@@ -892,57 +990,18 @@ void gaiv6(void)
 				 psin6 ? psin6->sin6_family : 0,
 				 psin6 ? psin6->sin6_port : 0,
 				 psin6 ? htons(psin6->sin6_port) : 0);
-		} else
-			tst_resm(TPASS, "getaddrinfo IPv6 AI_V4MAPPED");
-		freeaddrinfo(aires);
-	} else
-		tst_resm(TEST_RETURN ? TFAIL : TPASS, "getaddrinfo IPv6 "
+			freeaddrinfo(aires);
+			return;
+		} else {
+			tst_resm(TINFO, "getaddrinfo IPv6 AI_V4MAPPED");
+			freeaddrinfo(aires);
+		}
+	} else {
+		tst_resm(TFAIL, "getaddrinfo IPv6 "
 			 "AI_V4MAPPED (\"%s\") returns %ld (\"%s\")", hostname,
 			 TEST_RETURN, gai_strerror(TEST_RETURN));
-}
-
-/* this prints an addrinfo list; useful for debugging */
-void dumpres(struct addrinfo *pai)
-{
-	int count = 1;
-	for (; pai; pai = pai->ai_next, count++) {
-		printf("result %d [0x%p]\n", count, pai);
-		printf("\tai_flags %x\n", pai->ai_flags);
-		printf("\tai_family %d\n", pai->ai_family);
-		printf("\tai_socktype %d\n", pai->ai_socktype);
-		printf("\tai_protocol %d\n", pai->ai_protocol);
-		printf("\tai_addrlen %d\n", pai->ai_addrlen);
-		printf("\tai_canonname \"%s\"\n", pai->ai_canonname);
-		printf("\tai_addr.sa_family %x\n", pai->ai_addr->sa_family);
-		if (pai->ai_addr->sa_family == AF_INET) {
-			char buf[1024];
-			struct sockaddr_in *psin =
-			    (struct sockaddr_in *)pai->ai_addr;
-
-			if (!inet_ntop(AF_INET, &psin->sin_addr, buf,
-				       sizeof(buf)))
-				buf[0] = '\0';
-			printf("\tai_addr.sin_addr \"%s\"\n", buf);
-		} else if (pai->ai_addr->sa_family == AF_INET6) {
-			char buf[1024];
-
-			struct sockaddr_in6 *psin6 =
-			    (struct sockaddr_in6 *)pai->ai_addr;
-			if (!inet_ntop(AF_INET6, &psin6->sin6_addr, buf,
-				       sizeof(buf)))
-				buf[0] = '\0';
-			printf("\tai_addr.sin6_addr \"%s\"\n", buf);
-
-		}
-		printf("\tai_next %p\n", pai->ai_next);
+		return;
 	}
-}
 
-void setup(void)
-{
-	TEST_PAUSE;		/* if -P option specified */
-}
-
-void cleanup(void)
-{
+	tst_resm(TPASS, "getaddrinfo tests (v6) succeed");
 }
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
