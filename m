Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F61EDB7F6
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 10:52:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD0E23E0E67
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 12:52:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE3C13E0E67
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 12:51:54 +0200 (CEST)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CE144600829
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 12:51:53 +0200 (CEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 636LmgGg2298432; Tue, 7 Apr 2026 10:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=BkjmfrgW34hBbU3JteDt20KHxvFW/F7550GTBxnjc
 vk=; b=k34AJ+hO3efxIrbCGPVanz5F1I9EFINYxdHOxsLAwRFstLEYKVRHRHRKZ
 gOyix3VxqVLZqVjYudjyS0lW9X022LxWbvntQNQqjov9LkCwHsCBn1Yz70pnJFQp
 yXsUfXik+EP7skQzoxfMZ4uswnd/I/07qzGtxxpU3G9NuqWev8cTl547tA7vERel
 3hmBc5oofgPKdc2rJC65mfg9YIZ4FecXcPk9CUe+yNWGNydAYs4amYir9+DA+Hqv
 DRm5Oxd9WWOm3gofFxFe52CiSHBTPhVlnSFBc2+q+Il9A3DJvG8yJzAJ+qwr2v/I
 4WLJ8R+w12/mS+iEvTlkn4pH1ZK3w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ft920-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Apr 2026 10:51:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6378v6xu007917;
 Tue, 7 Apr 2026 10:51:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmg2acr4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Apr 2026 10:51:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 637ApkLM27525526
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Apr 2026 10:51:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF0802004B;
 Tue,  7 Apr 2026 10:51:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D91BD20040;
 Tue,  7 Apr 2026 10:51:45 +0000 (GMT)
Received: from ltcden9-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Apr 2026 10:51:45 +0000 (GMT)
From: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
To: ltp@lists.linux.it
Date: Wed,  8 Apr 2026 09:45:35 +0530
Message-ID: <20260408041535.128509-1-samir@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d4e1c7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=rmORDmhwHauEg5OCeHoA:9
X-Proofpoint-ORIG-GUID: cBdX541a7XXII6JUgFeLoj5jzCRRdV3v
X-Proofpoint-GUID: cBdX541a7XXII6JUgFeLoj5jzCRRdV3v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEwMSBTYWx0ZWRfX/J4/LiaOTcXX
 kP81CoEFEA5rG/sP1ecfI3vROzBRmTTmQcn9CVM0yyvMKxUBYiHXXJ2tLdfjgV8jdr516VJAPvF
 /1UknoG0GpS7FikKg6kAZH7ieJPpGW+UJKXNHb8PWFy/mFv6eURSo3jTQzltsaeB76Ao+SHgM4G
 3rN5g6xAmW7T/rmV1HGsnidp+KX1m1bI3TuTSpgmwq32LWmEXqWo4Y7y1+kbib3a/XZePZm/m28
 46SW78s6P1qqgTeBR4+rsskDKZFPgBjRwcJPcwE2PchZ9X3489SYZMnju16sa5IRBd42SVBstwJ
 cBRWUyl6Jm5VFjDFUWnM1ETbgniBitUbTn7EKUizqXMgvgnBaNbnKheSIEuob0g7HOrAI1XR3F8
 8eVpDoYcEB70rL0vslKumW+8zNQLFLAIKsr3Rd4WJyNmmY0hn1QRELwcnxTcL253ofd4IvYGn+b
 wps5gRMhj+mOpAU1Xqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070101
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sched/clisrv: Fix "make check" warnings and errors
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: =?UTF-8?q?=E2=80=9CSamir?= <samir@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Fixed multiple checkpatch issues in the clisrv test suite to improve
code style compliance with Linux kernel coding standards.

Changes made:
* Added SPDX-License-Identifier headers to all files
* Removed FSF mailing address from license text
* Fixed SPDX comment style (// for .c files, /* */ for .h files)
* Removed 'extern' keyword from function prototypes in header
* Fixed pointer declaration style (char* -> char *)
* Wrapped multi-statement macro in do-while loop
* Added parentheses around macro values
* Fixed block comment formatting (added * on subsequent lines)
* Separated assignments from if conditions
* Removed unnecessary parentheses from return statements
* Added blank lines after variable declarations
* Replaced platform-specific yield() with sched_yield()
* Added function parameter identifier (void *arg_)
* Changed NULL comparison to implicit check for fgets()
* Restructured if-else logic to avoid "else after break"
* Used __func__ in printf() calls where applicable
* Added (void) cast to suppress unused parameter warnings

Files modified:
- testcases/kernel/sched/clisrv/inet.h
- testcases/kernel/sched/clisrv/pthcli.c
- testcases/kernel/sched/clisrv/pthserv.c
- testcases/kernel/sched/clisrv/readline.c
- testcases/kernel/sched/clisrv/writen.c

Note: Function names are intentionally kept in perror() calls
(e.g., "str_cli:", "str_echo:") for better error context, as perror()
doesn't support format strings and cannot use __func__. This results
in minor checkpatch warnings but provides valuable debugging information.

Signed-off-by: Samir <samir@linux.ibm.com>
---
 testcases/kernel/sched/clisrv/inet.h     | 36 ++++-------
 testcases/kernel/sched/clisrv/pthcli.c   | 75 +++++++---------------
 testcases/kernel/sched/clisrv/pthserv.c  | 79 +++++++-----------------
 testcases/kernel/sched/clisrv/readline.c | 47 ++++++--------
 testcases/kernel/sched/clisrv/writen.c   | 27 ++------
 5 files changed, 78 insertions(+), 186 deletions(-)

diff --git a/testcases/kernel/sched/clisrv/inet.h b/testcases/kernel/sched/clisrv/inet.h
index 7cc5f186c..da052b2d9 100644
--- a/testcases/kernel/sched/clisrv/inet.h
+++ b/testcases/kernel/sched/clisrv/inet.h
@@ -1,23 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2001
  */
 
-/* inet.h */
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -30,23 +15,24 @@
 /* address for server */
 char *pname;
 
-extern int writen(int fd, char *ptr, int nbytes);
-extern int readline(int fd, char *ptr, int maxlen);
-extern void noprintf(char* string, ...);
-
+int writen(int fd, char *ptr, int nbytes);
+int readline(int fd, char *ptr, int maxlen);
+void noprintf(char *string, ...);
 
 /* debug */
 #ifdef DEBUG
 
-#define prtln()	fflush(NULL); \
-		printf("Reached %s: %d\n", __FILE__, __LINE__);
+#define prtln() do { \
+		fflush(NULL); \
+		printf("Reached %s: %d\n", __FILE__, __LINE__); \
+	} while (0)
 #define dprt	printf
-#define dprt2(args)    printf args
+#define dprt2(args)    (printf args)
 
 #else
 
 #define prtln()
 #define dprt	noprintf
-#define dprt2(args) noprintf args
+#define dprt2(args) (noprintf args)
 
 #endif
diff --git a/testcases/kernel/sched/clisrv/pthcli.c b/testcases/kernel/sched/clisrv/pthcli.c
index 7833b86d1..5f15239bc 100644
--- a/testcases/kernel/sched/clisrv/pthcli.c
+++ b/testcases/kernel/sched/clisrv/pthcli.c
@@ -1,46 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 1993, 2001
  */
 
-/******************************************************************************
- *
- *   pthcli.c
- *
- *
- *   (C) COPYRIGHT International Business Machines Corp. 1993
- *   All Rights Reserved
- *   Licensed Materials - Property of IBM
- *   US Government Users Restricted Rights - Use, duplication or
- *   disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
- *
- *****************************************************************************/
-
-/******************************************************************************/
-/* File:        pthcli.c                                                      */
-/*                                                                            */
-/* Description: Read contents of data file. Write each line to socket, then   */
-/*              ead line back from socket and write to standard output.       */
-/*                                                                            */
-/*                                                                            */
-/* Usage:       pthcli [port number]                                          */
-/*                                                                            */
-/******************************************************************************/
-
 /* client using TCP */
 
 #include <stdio.h>
@@ -56,19 +18,22 @@ void noprintf(char *string, ...)
 	(void) string;
 }
 
-/* Read contents of FILE *fp. Write each line to socket, then
-   read line back from socket and write to standard output.
-   Return to caller when done */
+/*
+ * Read contents of FILE *fp. Write each line to socket, then
+ * read line back from socket and write to standard output.
+ * Return to caller when done
+ */
 
 void str_cli(FILE *fp, int sockfd)
 {
 	int n;
 	char sendline[MAXLINE], recvline[MAXLINE + 1];
+
 	prtln();
-	while (fgets(sendline, MAXLINE, fp) != NULL) {
+	while (fgets(sendline, MAXLINE, fp)) {
 		n = strlen(sendline);
 
-		dprt("%s: str_cli(): sendline = %s", __FILE__, sendline);
+		dprt("%s: %s(): sendline = %s", __FILE__, __func__, sendline);
 
 		if (writen(sockfd, sendline, n) != n)
 			perror("str_cli: writen error on socket");
@@ -80,7 +45,7 @@ void str_cli(FILE *fp, int sockfd)
 		n = readline(sockfd, recvline, MAXLINE);
 		prtln();
 		/*
-		   printf("strcli: recvline = %s", recvline);
+		 * printf("strcli: recvline = %s", recvline);
 		 */
 		if (n < 0)
 			perror("str_cli: readline error on socket");
@@ -112,32 +77,34 @@ int main(int argc, char *argv[])
 	serv_addr.sin_addr.s_addr = inet_addr(argv[1]);
 	serv_addr.sin_port = htons(SERV_TCP_PORT);
 	prtln();
-	dprt("%s: main(): Binding local address for client to use\n"
+	dprt("%s: %s(): Binding local address for client to use\n"
 	     "serv_addr.sin_family = %d\n serv_addr.sin_addr.s_addr = %#x\n"
-	     "serv_addr.sin_port = %d\n", __FILE__, serv_addr.sin_family,
+	     "serv_addr.sin_port = %d\n", __FILE__, __func__, serv_addr.sin_family,
 	     serv_addr.sin_addr.s_addr, serv_addr.sin_port);
 
 	/* Open Internet stream socket */
-	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
+	sockfd = socket(AF_INET, SOCK_STREAM, 0);
+	if (sockfd < 0) {
 		printf("client: socket open failure, no = %d\n", errno);
-		return (errno);
+		return errno;
 		exit(1);
 	}
 	prtln();
-	dprt("%s: main(): Open Internet stream socket, socfd = %d\n", __FILE__,
+	dprt("%s: %s(): Open Internet stream socket, socfd = %d\n", __FILE__, __func__,
 	     sockfd);
 	/* Connect to the server */
 	if (connect(sockfd, (struct sockaddr *)&serv_addr, sizeof(serv_addr)) <
 	    0) {
 		prtln();
 		printf("client: connect failure, no = %d\n", errno);
-		return (errno);
+		return errno;
 		exit(1);
 	}
 #ifdef _LINUX
-	if ((input = fopen(argv[2], "r")) == NULL) {
+	input = fopen(argv[2], "r");
+	if (!input) {
 		perror("fopen");
-		return (errno);
+		return errno;
 	}
 	str_cli(input, sockfd);	/* call the routines that do the work */
 	prtln();
diff --git a/testcases/kernel/sched/clisrv/pthserv.c b/testcases/kernel/sched/clisrv/pthserv.c
index e3da52130..e5f3154bb 100644
--- a/testcases/kernel/sched/clisrv/pthserv.c
+++ b/testcases/kernel/sched/clisrv/pthserv.c
@@ -1,38 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2001
  */
-/*
-*   File: pthserv.c	Version: 1.3		Last update: 5/19/94 08:55:35
-*/
-/******************************************************************************/
-/* File:        pthserv.c                                                     */
-/*                                                                            */
-/* Description: Read a stream socket one line at a time and write each line   */
-/*              back to the sender.                                           */
-/*                                                                            */
-/* History:     Contact - 06/21/2001 - Manoj Iyeri, IBM Austin                */
-/*                                                                            */
-/* Usage:       pthcli [port number]                                          */
-/*                                                                            */
-/******************************************************************************/
-
-/*
-    TCP server
-*/
 
 #include <pthread.h>
 #include <string.h>
@@ -44,14 +13,17 @@
 #define MAXLINE 1024
 void noprintf(char *string, ...)
 {
+	(void)string;
 }
 
 pthread_t th;
 pthread_mutex_t current_mutex;
 int sockfd;
 
-/* Read a stream socket one line at a time and write each line back
-   to sender. Return when connection is terminated */
+/*
+ * Read a stream socket one line at a time and write each line back
+ * to sender. Return when connection is terminated
+ */
 
 int str_echo(int sockfd)
 {
@@ -61,19 +33,18 @@ int str_echo(int sockfd)
 	printf("sockfd = %d\n", sockfd);
 	for (;;) {
 		prtln();
-		dprt2(("%s: str_echo(): reading from sockfd %d\n", __FILE__,
+		dprt2(("reading from sockfd %d\n",
 		       sockfd));
 		n = readline(sockfd, line, MAXLINE);
-		printf("str_echo: n = %d\n", n);
+		printf("%s: n = %d\n", __func__, n);
 		if (n == 0) {
-			dprt2(("%s: str_echo(): connection terminated\n",
-			       __FILE__));
+			dprt2(("connection terminated\n"));
 			return 0;	/* connection terminated */
 		} else if (n < 0) {
 			perror("str_echo: readline error");
 			return (-1);
 		}
-		dprt2(("%s: str_echo(): writing to sockfd = %d\n", __FILE__,
+		dprt2(("writing to sockfd = %d\n",
 		       sockfd));
 		testint = writen(sockfd, line, n);
 		prtln();
@@ -87,22 +58,23 @@ int str_echo(int sockfd)
 
 int main(int argc, char *argv[])
 {
-	void *new_thread(void *);
+	void *new_thread(void *arg_);
 	pthread_attr_t newattr;
 	int newsockfd;
 	socklen_t clilen;
 	struct sockaddr_in cli_addr, serv_addr;
-	pname = argv[0];
 
-	(void) argc;
+	pname = argv[0];
+	(void)argc;
 	prtln();
 	/* Open inet stream socket */
-	if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) < 0) {
+	sockfd = socket(AF_INET, SOCK_STREAM, 0);
+	if (sockfd < 0) {
 		printf("server: socket failure:");
 		exit(1);
 	}
 	prtln();
-	dprt2(("%s: main(): Open inet stream socket sockfd = %d\n", __FILE__,
+	dprt2(("%s: %s(): Open inet stream socket sockfd = %d\n", __FILE__, __func__,
 	       sockfd));
 
 	/* Bind local address for client to use */
@@ -111,9 +83,9 @@ int main(int argc, char *argv[])
 	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
 	serv_addr.sin_port = htons(SERV_TCP_PORT);
 	prtln();
-	dprt2(("%s: main(): Binding local address for client to use\n"
+	dprt2(("%s: %s(): Binding local address for client to use\n"
 	       "serv_addr.sin_family = %d\n serv_addr.sin_addr.s_addr = %#x\n"
-	       "serv_addr.sin_port = %d\n", __FILE__, serv_addr.sin_family,
+	       "serv_addr.sin_port = %d\n", __FILE__, __func__, serv_addr.sin_family,
 	       serv_addr.sin_addr.s_addr, serv_addr.sin_port));
 
 	prtln();
@@ -153,11 +125,7 @@ int main(int argc, char *argv[])
 			if (pthread_create(&th, &newattr, new_thread,
 					   (void *)(uintptr_t) newsockfd))
 				printf("failure to create thread\n");
-#ifndef _LINUX
-			yield();
-#else
 			sched_yield();
-#endif
 		}
 		prtln();
 	}
@@ -166,18 +134,15 @@ int main(int argc, char *argv[])
 
 void *new_thread(void *arg_)
 {
-	int arg = (uintptr_t) arg_;
+	int arg = (uintptr_t)arg_;
+
 	if (pthread_mutex_lock(&current_mutex))
 		printf("mutex_lock failed");
 	if (str_echo(arg) < 0)	/* process the request */
-		printf("new_thread: str_echo returned error");
+		printf("str_echo returned error");
 	close(arg);		/* i.e. newsockfd */
 	if (pthread_mutex_unlock(&current_mutex))
 		printf("mutex_unlock failed");
-#ifndef _LINUX
-	yield();
-#else
 	sched_yield();
-#endif
 	pthread_exit(NULL);
 }
diff --git a/testcases/kernel/sched/clisrv/readline.c b/testcases/kernel/sched/clisrv/readline.c
index 0c3272999..7c1ab86a6 100644
--- a/testcases/kernel/sched/clisrv/readline.c
+++ b/testcases/kernel/sched/clisrv/readline.c
@@ -1,50 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2001
  */
 
-/*****************************************************************************
- *  readline.c
- ******************************************************************************/
-
 #include <unistd.h>
 
-/* Read line from a descriptor, byte at a time, return number of
-   characters up to the null */
+/*
+ * Read line from a descriptor, byte at a time, return number of
+ * characters up to the null
+ */
 
 int readline(int fd, char *ptr, int maxlen)
 {
 	int n, rc;
 	char c;
 	/*
-	   printf("readline: fd = %d\n", fd);
+	 * printf("readline: fd = %d\n", fd);
 	 */
 	for (n = 1; n < maxlen; n++) {
-		if ((rc = read(fd, &c, 1)) == 1) {
+		rc = read(fd, &c, 1);
+		if (rc == 1) {
 			*ptr++ = c;
 			if (c == '\n')
 				break;
-		} else if (rc == 0) {
+		}
+
+		if (rc == 0) {
 			if (n == 1)
 				return 0;	/* EOF no data read */
-			else
-				break;	/* EOF, some data read */
-		} else
-			return (-1);	/* error */
+			break;	/* EOF, some data read */
+		}
+
+		if (rc < 0)
+			return -1;	/* error */
 	}
 	*ptr = 0;
-	return (n);
+	return n;
 }
diff --git a/testcases/kernel/sched/clisrv/writen.c b/testcases/kernel/sched/clisrv/writen.c
index 7ab12cdbe..fd03e7332 100644
--- a/testcases/kernel/sched/clisrv/writen.c
+++ b/testcases/kernel/sched/clisrv/writen.c
@@ -1,29 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *   Copyright (c) International Business Machines  Corp., 2001
- *
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * Copyright (c) International Business Machines  Corp., 2001
  */
 
-/******************************************************************************
- *  writen.c
- ******************************************************************************/
-
 #include <unistd.h>
 
-/* Write "n" bytes to a descriptor
-   Use instead of write() when fd is a stream socket. */
+/*
+ * Write "n" bytes to a descriptor
+ * Use instead of write() when fd is a stream socket.
+ */
 
 int writen(int fd, char *ptr, int nbytes)
 {
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
