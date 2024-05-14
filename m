Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88560C25B74
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 06:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1716533262; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=P00ztePqzpGII0tKPNh0UUnVnmMR7z+3/kKryM3al94=;
 b=fxgSmhLslLXQCgO7vYsK7Bli2EeNobatjE8JBzIma+6HNgh1EO2epWwoERsfg8h7BYo69
 TSaRkynuBaZRUdXOO5h907j7/axes1pqdS0ZnGMCrRnQ/9uwDNkfNkkdroEeCytoWLCC+by
 i8hgBOTVMarUaB8ilEgal9wQxaf314U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C3033CF100
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 08:47:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A206B3C86CF
 for <ltp@lists.linux.it>; Fri, 24 May 2024 08:47:19 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=68.232.139.130;
 helo=esa5.hc1455-7.c3s2.iphmx.com; envelope-from=xuyang2018.jy@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com
 [68.232.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3EA99201DAB
 for <ltp@lists.linux.it>; Fri, 24 May 2024 08:47:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1716533238; x=1748069238;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JiHfJurIgcz4x49Ji/yqsMkl66yYckTA1N8qgoRPQaY=;
 b=GHBexii80tbpX+jWqROwKiEyZtwXakwr2B9UiICnYT5i++5yzW+Qzimf
 EqBfBlVGl8QSqbf1+KhnnHihlOcr5izeFQ2nQXq8Mp/LIA1U+XL3ti7c4
 ZyKzrrWOfjnQu5WOwP+5B1OSm2Xc+GHI23a4lAPM0JpPuAmfrxRSZp9eZ
 T1OxcsMjrxc8iyGSKbujeZFifYmpchdIn4eOiItVuVkNLKlXzIoURoyu/
 I6y7I8eQzedTUMtPA7fQBd0cccNpJZ7b3ObEVgUcJMgbiVv6ZU/1lJXUb
 qiEKztFAIVA2Q+7b02GUs9Hb4I8bMp9hUHgyCswM59lvUjbVtzuDTEUpl Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="158988773"
X-IronPort-AV: E=Sophos;i="6.08,184,1712588400"; d="scan'208";a="158988773"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2024 15:47:15 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 65818E6002
 for <ltp@lists.linux.it>; Fri, 24 May 2024 15:47:13 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 7EF76D60CD
 for <ltp@lists.linux.it>; Fri, 24 May 2024 15:47:12 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 0B8846B8D4
 for <ltp@lists.linux.it>; Fri, 24 May 2024 15:47:12 +0900 (JST)
Received: from rhel93GA.g08.fujitsu.local (unknown [10.167.221.71])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3ECA11A000A;
 Fri, 24 May 2024 14:47:11 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 14 May 2024 00:51:09 -0400
Message-Id: <20240514045110.85640-1-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28406.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28406.005
X-TMASE-Result: 10--20.696700-10.000000
X-TMASE-MatchedRID: xwm2tuCJ8xqRp9tz3DZBj07nLUqYrlslFIuBIWrdOeOU8ftiyKjZrXlb
 NLJMhGktx8cx3E6pg15WTBAeKqaX9Spe4ofkluPsiH95tLFH8edZ+CK+BxQ9k224tW2R9/7QDui
 v1PSTVn4QT82YoBmnzDFTm2Y2SkL+qFxsFrCmzTTTfU1/F+PbMxeN9Hd3TB5GxuXV3UE49jhURt
 baWlO5VNnEmek5bkuZj2oaPHTkaOMGYZSobNY0ww55FEYgJX09guwtqyXlE6E8cwBuO6HB3z9Jn
 3A147yPRXINoJ11RflPuclkyugPVGDoMOliBKDzowvZ4t/MYW687rU89eLPKYIEht5QlwfXY+It
 XZ/PvriV61Wi9gHVyNTOKyA8bVcHdh9gYos97K0qIkSpQVZGCAV54COoxb6XFp+v4pKMtMI3tvm
 LHoGDvolOTESqnG+hmVv4zOFeLFZnY5kT+XJDb0rOO5m0+0gEWQ3R4k5PTnDWfdTIhX4P8+Y86q
 N+YNgg1MprXmH9eUHVDlcUGlyCBwYNrhTpT76csuwzRUFoV+Aejl8XURi8fEwRR6Ao0TvDn4Lfq
 ES/avdFDD/cchgtzOCksQY3XVtcBAF1SBaD5qSeAiCmPx4NwBnUJ0Ek6yhjxEHRux+uk8irEHfa
 j14Zyf+K1r6Y/VHIA/3R8k/14e0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] connect01: Convert to new API
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
From: Yang Xu via ltp <ltp@lists.linux.it>
Reply-To: Yang Xu <xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/connect/connect01.c | 401 +++++++-----------
 1 file changed, 146 insertions(+), 255 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 660c4f7a9..52a6f154b 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -1,308 +1,199 @@
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
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) Linux Test Project, 2006-2024
  */
 
-/*
- * Test Name: connect01
+/*\
+ * [Description]
  *
- * Test Description:
- *  Verify that connect() returns the proper errno for various failure cases
- *
- * Usage:  <for command-line>
- *  connect01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
- *     where,  -c n : Run n copies concurrently.
- *             -e   : Turn on errno logging.
- *	       -i n : Execute test n times.
- *	       -I x : Execute test for x seconds.
- *	       -P x : Pause for x seconds between iterations.
- *	       -t   : Turn on syscall timing.
- *
- * HISTORY
- *	07/2001 Ported by Wayne Boyer
- *
- * RESTRICTIONS:
- *  None.
+ * Verify that connect() returns the proper errno for various failure case
  *
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <fcntl.h>
-
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/signal.h>
-#include <sys/un.h>
-
-#include <netinet/in.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "connect01";
-int testno;
-
-int s, s2;			/* socket descriptor */
-struct sockaddr_in sin1, sin2, sin3, sin4;
-static int sfd;			/* shared between start_server and do_child */
-
-void setup(void), setup0(void), setup1(void), setup2(void),
-cleanup(void), cleanup0(void), cleanup1(void), do_child(void);
-
-static pid_t start_server(struct sockaddr_in *);
+#include <sys/wait.h>
+#include <pwd.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
-struct test_case_t {		/* test case structure */
-	int domain;		/* PF_INET, PF_UNIX, ... */
-	int type;		/* SOCK_STREAM, SOCK_DGRAM ... */
-	int proto;		/* protocol number (usually 0 = default) */
-	struct sockaddr *sockaddr;	/* socket address buffer */
-	int salen;		/* connect's 3rd argument */
-	int retval;		/* syscall return value */
-	int experrno;		/* expected errno */
-	void (*setup) (void);
-	void (*cleanup) (void);
+static int fd_share;
+static int fd_server;
+
+static struct sockaddr_in sock1;
+static struct sockaddr_in sock2;
+static struct sockaddr_in sock3;
+
+static pid_t pid;
+
+static void setup1(unsigned int);
+static void setup2(unsigned int);
+static void setup3(unsigned int);
+static void cleanup1(void);
+
+static struct test_case_t {
+	int domain;
+	int type;
+	int proto;
+	struct sockaddr *sockaddr;
+	int salen;
+	int exp_errno;
+	void (*setup)(unsigned int i);
+	void (*cleanup)(void);
 	char *desc;
-} tdat[] = {
-	{
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
-		    sizeof(struct sockaddr_in), -1, EBADF, setup0,
-		    cleanup0, "bad file descriptor"},
-	{
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)-1,
-		    sizeof(struct sockaddr_in), -1, EFAULT, setup1,
-		    cleanup1, "invalid socket buffer"},
-	{
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
-		    3, -1, EINVAL, setup1, cleanup1, "invalid salen"}, {
-	0, 0, 0, (struct sockaddr *)&sin1,
-		    sizeof(sin1), -1, ENOTSOCK, setup0, cleanup0,
-		    "invalid socket"}
-	, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
-		    sizeof(sin1), -1, EISCONN, setup2, cleanup1,
-		    "already connected"}
-	, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin2,
-		    sizeof(sin2), -1, ECONNREFUSED, setup1, cleanup1,
-		    "connection refused"}
-	, {
-	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin4,
-		    sizeof(sin4), -1, EAFNOSUPPORT, setup1, cleanup1,
-		    "invalid address family"}
-,};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
-
-/**
- * bionic's connect() implementation calls netdClientInitConnect() before
- * sending the request to the kernel.  We need to bypass this, or the test will
- * segfault during the addr = (struct sockaddr *)-1 testcase. We had cases where
- * tests started to segfault on glibc upgrade or in special conditions where
- * libc had to convert structure layouts between 32bit/64bit userspace/kernel =>
- * safer to call the raw syscall regardless of the libc implementation.
- */
-#include "lapi/syscalls.h"
+} tcases[] = {
+	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sock1,
+		sizeof(struct sockaddr_in), EBADF, setup1, cleanup1,
+		"sockfd is not a valid open file descriptor"},
+	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)-1,
+		sizeof(struct sockaddr_in), EFAULT, setup2, cleanup1,
+		"socket structure address is outside the user's address space"},
+	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sock1,
+		3, EINVAL, setup2, cleanup1,
+		"addrlen is not valid"},
+	{0, 0, 0, (struct sockaddr *)&sock1,
+		sizeof(sock1), ENOTSOCK, setup1, cleanup1,
+		"file descriptor sockfd does not refer to a socket"},
+	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sock1,
+		sizeof(sock1), EISCONN, setup3, cleanup1,
+		"socket is already connected"},
+	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sock2,
+		sizeof(sock2), ECONNREFUSED, setup2, cleanup1,
+		"connect on a socket found no one listening on remote address"},
+	{PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sock3,
+		sizeof(sock3), EAFNOSUPPORT, setup2, cleanup1,
+		"address doesn't have the correct address family in sa_family"},
+};
 
 static int sys_connect(int sockfd, const struct sockaddr *addr,
-		socklen_t addrlen)
+	socklen_t addrlen)
 {
 	return tst_syscall(__NR_connect, sockfd, addr, addrlen);
 }
 
-#define connect(sockfd, addr, addrlen) sys_connect(sockfd, addr, addrlen)
-
-int main(int argc, char *argv[])
+static void do_child(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
+	struct sockaddr_in sock;
+	fd_set fd_set_all;
+	fd_set fd_set_read;
+	int nfds;
+	ssize_t bytes;
+	int fd;
+	char data;
+
+	FD_ZERO(&fd_set_all);
+	FD_SET(fd_server, &fd_set_all);
+	nfds = fd_server + 1;
 
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			tdat[testno].setup();
+	while (1) {
+		socklen_t len;
 
-			TEST(connect
-			     (s, tdat[testno].sockaddr, tdat[testno].salen));
+		memcpy(&fd_set_read, &fd_set_all, sizeof(fd_set_read));
+		if (select(nfds, &fd_set_read, NULL, NULL, NULL) < 0)
+			if (errno != EINTR)
+				exit(1);
+		if (FD_ISSET(fd_server, &fd_set_read)) {
+			int newfd;
 
-			if (TEST_RETURN != tdat[testno].retval ||
-			    (TEST_RETURN < 0 &&
-			     TEST_ERRNO != tdat[testno].experrno)) {
-				tst_resm(TFAIL, "%s ; returned"
-					 " %ld (expected %d), errno %d (expected"
-					 " %d)", tdat[testno].desc,
-					 TEST_RETURN, tdat[testno].retval,
-					 TEST_ERRNO, tdat[testno].experrno);
-			} else {
-				tst_resm(TPASS, "%s successful",
-					 tdat[testno].desc);
+			len = sizeof(sock);
+			newfd = SAFE_ACCEPT(fd_server, (struct sockaddr *)&sock,
+				&len);
+			if (newfd >= 0) {
+				FD_SET(newfd, &fd_set_all);
+				nfds = MAX(nfds, newfd + 1);
 			}
-			tdat[testno].cleanup();
 		}
+		for (fd = 0; fd < nfds; fd++)
+			if (fd != fd_server && FD_ISSET(fd, &fd_set_read)) {
+				bytes = read(fd, &data, 1);
+				if (bytes == 0) {
+					close(fd);
+					FD_CLR(fd, &fd_set_all);
+				}
+			}
 	}
-	cleanup();
-
-	tst_exit();
 }
 
-pid_t pid;
-
-void setup(void)
+static void start_server(struct sockaddr_in *sock)
 {
-	TEST_PAUSE;		/* if -p option specified */
-
-	pid = start_server(&sin1);
+	socklen_t slen = sizeof(*sock);
 
-	sin2.sin_family = AF_INET;
-	/* this port must be unused! */
-	sin2.sin_port = TST_GET_UNUSED_PORT(NULL, AF_INET, SOCK_STREAM);
-	sin2.sin_addr.s_addr = INADDR_ANY;
+	sock->sin_family = AF_INET;
+	sock->sin_port = 0;
+	sock->sin_addr.s_addr = INADDR_ANY;
 
-	sin3.sin_family = AF_INET;
-	sin3.sin_port = 0;
-	/* assumes no route to this network! */
-	sin3.sin_addr.s_addr = htonl(0x0AFFFEFD);
-
-	sin4.sin_family = 47;	/* bogus address family */
-	sin4.sin_port = 0;
-	sin4.sin_addr.s_addr = htonl(0x0AFFFEFD);
+	fd_server = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(fd_server, (struct sockaddr *)sock, slen);
+	SAFE_LISTEN(fd_server, 10);
+	SAFE_GETSOCKNAME(fd_server, (struct sockaddr *)sock, &slen);
 
+	pid = SAFE_FORK();
+	if (!pid) {
+		do_child();
+		exit(0);
+	}
+	close(fd_server);
 }
 
-void cleanup(void)
+static void setup(void)
 {
-	(void)kill(pid, SIGKILL);
+	sock2.sin_family = AF_INET;
+	sock2.sin_port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);
+	sock2.sin_addr.s_addr = INADDR_ANY;
 
+	sock3.sin_family = 47;
+	sock3.sin_port = 0;
+	sock3.sin_addr.s_addr = htonl(0x0AFFFEFD);
 }
 
-void setup0(void)
+static void setup1(unsigned int i)
 {
-	if (tdat[testno].experrno == EBADF)
-		s = 400;	/* anything not an open file */
-	else if ((s = open("/dev/null", O_WRONLY)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open(/dev/null) failed");
+	struct test_case_t *tc = &tcases[i];
 
+	if (tc->exp_errno == EBADF)
+		fd_share = -1;
+	else
+		fd_share = SAFE_OPEN("/dev/null", O_WRONLY);
 }
 
-void cleanup0(void)
+static void setup2(unsigned int i)
 {
-	close(s);
-	s = -1;
-}
+	struct test_case_t *tc = &tcases[i];
 
-void setup1(void)
-{
-	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
-		        tdat[testno].proto);
+	fd_share = SAFE_SOCKET(tc->domain, tc->type, tc->proto);
 }
 
-void cleanup1(void)
+static void setup3(unsigned int i)
 {
-	(void)close(s);
-	s = -1;
+	setup2(i);
+	SAFE_CONNECT(fd_server, (const struct sockaddr *)&sock1, sizeof(sock1));
 }
 
-void setup2(void)
+static void cleanup1(void)
 {
-	setup1();		/* get a socket in s */
-	SAFE_CONNECT(cleanup, s, (const struct sockaddr *)&sin1, sizeof(sin1));
+	if (fd_share > 0)
+		SAFE_CLOSE(fd_share);
 }
 
-pid_t start_server(struct sockaddr_in *sin0)
+static void verify_connect(unsigned int i)
 {
-	pid_t pid;
-	socklen_t slen = sizeof(*sin0);
-
-	sin0->sin_family = AF_INET;
-	sin0->sin_port = 0; /* pick random free port */
-	sin0->sin_addr.s_addr = INADDR_ANY;
-
-	sfd = socket(PF_INET, SOCK_STREAM, 0);
-	if (sfd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
-		return -1;
-	}
-	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
-		return -1;
-	}
-	if (listen(sfd, 10) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
-		return -1;
-	}
-	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
-
-	switch ((pid = tst_fork())) {
-	case 0:		/* child */
-		do_child();
-		break;
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "server fork failed");
-		/* fall through */
-	default:		/* parent */
-		(void)close(sfd);
-		return pid;
-	}
-
-	return -1;
+	struct test_case_t *tc = &tcases[i];
+
+	start_server(&sock1);
+	if (tc->setup)
+		tc->setup(i);
+	TST_EXP_FAIL(sys_connect(fd_share, tc->sockaddr, tc->salen),
+		tc->exp_errno, "%s", tc->desc);
+	SAFE_KILL(pid, SIGKILL);
+	SAFE_WAITPID(pid, NULL, 0);
+	if (tc->cleanup)
+		tc->cleanup();
 }
 
-void do_child(void)
-{
-	struct sockaddr_in fsin;
-	fd_set afds, rfds;
-	int nfds, cc, fd;
-	char c;
-
-	FD_ZERO(&afds);
-	FD_SET(sfd, &afds);
-
-	nfds = sfd + 1;
-
-	/* accept connections until killed */
-	while (1) {
-		socklen_t fromlen;
-
-		memcpy(&rfds, &afds, sizeof(rfds));
-
-		if (select(nfds, &rfds, NULL, NULL,
-			   NULL) < 0)
-			if (errno != EINTR)
-				exit(1);
-		if (FD_ISSET(sfd, &rfds)) {
-			int newfd;
-
-			fromlen = sizeof(fsin);
-			newfd = accept(sfd, (struct sockaddr *)&fsin, &fromlen);
-			if (newfd >= 0) {
-				FD_SET(newfd, &afds);
-				nfds = MAX(nfds, newfd + 1);
-			}
-		}
-		for (fd = 0; fd < nfds; ++fd)
-			if (fd != sfd && FD_ISSET(fd, &rfds)) {
-				if ((cc = read(fd, &c, 1)) == 0) {
-					(void)close(fd);
-					FD_CLR(fd, &afds);
-				}
-			}
-	}
-}
+static struct tst_test test = {
+	.setup = setup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_connect,
+	.forks_child = 1,
+};
-- 
2.39.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
