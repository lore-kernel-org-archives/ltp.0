Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72B8CD5BBF
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 09:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779699805; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=dK1z5RYU8mVl2ZdsFJ1hagPmZwV0YF/0k3R3TRKWHQM=;
 b=gsq+nXZyom1zu7IwkBmiX3fTmF72Ee2dI6VCCC5rI1QlUS4jYdPWJiYgTX3lkq10xVcUY
 QJYc5hRbJnalfdMVSQBxfrMzAqG1Yw4/HN64KWtjUhhos1tQtzTG6euyPgbvaHuuk/mgKBe
 62gnvxdkTU/rJxfcCt0zdRcHXDmn6q4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9966B3E52A8
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 11:03:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A60923E528A
 for <ltp@lists.linux.it>; Mon, 25 May 2026 11:02:42 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D3DDB2002C3
 for <ltp@lists.linux.it>; Mon, 25 May 2026 11:02:41 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso5944892f8f.0
 for <ltp@lists.linux.it>; Mon, 25 May 2026 02:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779699761; x=1780304561; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ioH33Z9D+tfHCcIC/PiXMnJ5/UrCOHJ222FA1k3zXPQ=;
 b=MVWU8aNtVwv3pz62HnAZBUCCLEGdfmOf6M59Sl6DDT3sQWlCpGVdpA6OdOvThpGbCV
 n+GV66Vi7wO/b/W79lKhtKQMzEbNOx5/zn4swVRxrVafn+uXLd/f+q4qbG7mVf/vQFKo
 1yJcE8r+UxuXht+UC6Ol2I0Ki3o6KMRTvAUUrY8iHqitsder9lmidpU+TqNcSdZtFITv
 cUMPsUJMyVZ3d+2XQo1tp0tCqMAwfv/xhI2Xqylf+1Sgq3/XjhCo6FDhARxiMgLkTP2w
 nrQWrxpFIR7RjmzhZx5Hn5FEmoWqci/p5fuogOjf4G1UtZ0rGe+1Ww64RJ+AqUOuLkUs
 CaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779699761; x=1780304561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ioH33Z9D+tfHCcIC/PiXMnJ5/UrCOHJ222FA1k3zXPQ=;
 b=qd2huuunLw8epEGq3/O/CWOizkpRUPGNdqaYOzvO5yAIq5MIwQn1tELA4TpF/IT6np
 qTC9laFlu10xxsfBmbZA9EJdkVFYlC8+/rV1BuVkrExrkLt/d321Y8vF2IPWmpNwRoNK
 bGCagk/QhUduOLUhYABOtGkaZiWKeTowtC9MD9NPm4+uAwxxOAsBRjL+V55LB6CYiAYg
 X+4LgDKiCx4RDrGKy38CePUQ08wbO6a++D08B4ss909BM9Tp/b9jJIGCnfPih8nEtB2d
 fuvRh7pfN6zNCyMsOvPxBkaJVSIhYPIu29I+xysMzytG8mI0mZ163VF4XIYA65N4Ye5E
 DzwA==
X-Gm-Message-State: AOJu0Yy2R2haINlkBc1iAxaX9ue8ew160XiGRMXziO3+aQ36Som+74UH
 MrbtDMXso+953n3A2f+45H7xzlS9A+Fq+575F2kscw1fqyBRBZkQzZ6IkTFmILShFYhSm4eiJ7/
 dkkM=
X-Gm-Gg: Acq92OGl6Io1JML7ac5mhnafxr+y16tDhqTjdilkhyNZMPuJj2eMR6tobn9mPMMeSkG
 Zu64oRj7CzSHT3XMoGiPKVNqOSzj/JH878vOJ7JH75MHtFF8spc/Lm/jWsG5YdhIut2j6JiOfo2
 Q6a/ipANM+ebt5klDKhFzBXO1T7kQ89gNS+8NZ7xPPfiFd1PUL1FrFle0mQwnbJJmYbwZPkDdNE
 aq8oXCwzcNfXcHdoa7h51JxNA1+vZ2bXL+Z5kLPIepoLPB8VBS9JvEPCkhHxAUrLZqCmXC4pBt/
 ftPW/ZqdekmxyTmuXRX4R9rpl7wgNm3Q/yk+p147AYu7p2yAGwkl4p4R6sWwsEekafATyyv29Rl
 MLJ0dXV2sZROJxEXrmhdB1pGs1bXxm4n4zPdDxTacuNdkMtVygQE5YICzBwlASZfSxs+27FcFwB
 hg+S8QPGwSZ0M=
X-Received: by 2002:a05:600c:4e45:b0:490:538a:9c0b with SMTP id
 5b1f17b1804b1-490538a9eb2mr146523975e9.2.1779699760934; 
 Mon, 25 May 2026 02:02:40 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490454a0b82sm249243285e9.9.2026.05.25.02.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 02:02:40 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 25 May 2026 09:02:20 +0000
Message-ID: <20260525090228.11895-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260525090228.11895-1-wegao@suse.com>
References: <20240514045110.85640-1-xuyang2018.jy@fujitsu.com>
 <20260525090228.11895-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] connect01: Convert to new API
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Convert the connect01 test case from the legacy LTP API to the new
tst_test API.

Refactor the test according to reviewer feedback:
- Simplified the server child process to a single accept/exit loop.
- Moved the server lifecycle to the global setup/cleanup.
- The server now accepts a single connection for the EISCONN test case
  and exits immediately, which avoids blocking the test runner.
- Centralized test case initialization into the global setup.
- Used tst_get_bad_addr() for the EFAULT test case to ensure
  architectural compatibility.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/connect/connect01.c | 360 +++++-------------
 1 file changed, 95 insertions(+), 265 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 6cb8adab3..923c4be81 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -1,308 +1,138 @@
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
- *
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
- *
+/*\
+ * Verify that connect() returns the proper errno for various failure cases.
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
+#include <sys/wait.h>
 #include <netinet/in.h>
+#include "tst_test.h"
+#include "lapi/syscalls.h"
 
-#include "test.h"
-#include "tso_safe_macros.h"
-
-char *TCID = "connect01";
-int testno;
-
-int s, s2;			/* socket descriptor */
-struct sockaddr_in sin1, sin2, sin3, sin4;
-static int sfd;			/* shared between start_server and do_child */
+static int fd_invalid = -1;
+static int fd_socket;
+static int fd_null;
+static int fd_connected;
+static int fd_server;
 
-void setup(void), setup0(void), setup1(void), setup2(void),
-cleanup(void), cleanup0(void), cleanup1(void), do_child(void);
+static struct sockaddr_in sock1;
+static struct sockaddr_in sock2;
+static struct sockaddr_in sock3;
+static void *bad_addr;
 
-static pid_t start_server(struct sockaddr_in *);
+static pid_t pid;
 
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
+static struct test_case_t {
+	int *fd;
+	void *addr;
+	socklen_t salen;
+	int exp_errno;
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
+	{&fd_invalid, &sock1, sizeof(sock1), EBADF,
+		"sockfd is not a valid open file descriptor"},
+	{&fd_socket, NULL, sizeof(sock1), EFAULT,
+		"socket structure address is outside the user's address space"},
+	{&fd_socket, &sock1, 3, EINVAL,
+		"addrlen is not valid"},
+	{&fd_null, &sock1, sizeof(sock1), ENOTSOCK,
+		"file descriptor sockfd does not refer to a socket"},
+	{&fd_connected, &sock1, sizeof(sock1), EISCONN,
+		"socket is already connected"},
+	{&fd_socket, &sock2, sizeof(sock2), ECONNREFUSED,
+		"connect on a socket found no one listening on remote address"},
+	{&fd_socket, &sock3, sizeof(sock3), EAFNOSUPPORT,
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
+static void start_server(struct sockaddr_in *sock)
 {
-	int lc;
+	socklen_t slen = sizeof(*sock);
 
-	tst_parse_opts(argc, argv, NULL, NULL);
+	sock->sin_family = AF_INET;
+	sock->sin_port = 0;
+	sock->sin_addr.s_addr = INADDR_ANY;
 
-	setup();
+	fd_server = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(fd_server, (struct sockaddr *)sock, slen);
+	SAFE_LISTEN(fd_server, 10);
+	SAFE_GETSOCKNAME(fd_server, (struct sockaddr *)sock, &slen);
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			tdat[testno].setup();
+	pid = SAFE_FORK();
 
-			TEST(connect
-			     (s, tdat[testno].sockaddr, tdat[testno].salen));
+	if (!pid) {
+		int nfd = SAFE_ACCEPT(fd_server, NULL, NULL);
 
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
-			}
-			tdat[testno].cleanup();
-		}
+		SAFE_CLOSE(nfd);
+		exit(0);
 	}
-	cleanup();
-
-	tst_exit();
+	close(fd_server);
 }
 
-pid_t pid;
-
-void setup(void)
+static void setup(void)
 {
-	TEST_PAUSE;		/* if -p option specified */
-
-	pid = start_server(&sin1);
-
-	sin2.sin_family = AF_INET;
-	/* this port must be unused! */
-	sin2.sin_port = TST_GET_UNUSED_PORT(NULL, AF_INET, SOCK_STREAM);
-	sin2.sin_addr.s_addr = INADDR_ANY;
-
-	sin3.sin_family = AF_INET;
-	sin3.sin_port = 0;
-	/* assumes no route to this network! */
-	sin3.sin_addr.s_addr = htonl(0x0AFFFEFD);
-
-	sin4.sin_family = 47;	/* bogus address family */
-	sin4.sin_port = 0;
-	sin4.sin_addr.s_addr = htonl(0x0AFFFEFD);
-
-}
+	bad_addr = tst_get_bad_addr(NULL);
+	start_server(&sock1);
 
-void cleanup(void)
-{
-	(void)kill(pid, SIGKILL);
+	fd_socket = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
+	fd_null = SAFE_OPEN("/dev/null", O_WRONLY);
 
-}
+	fd_connected = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
+	SAFE_CONNECT(fd_connected, (const struct sockaddr *)&sock1, sizeof(sock1));
 
-void setup0(void)
-{
-	if (tdat[testno].experrno == EBADF)
-		s = 400;	/* anything not an open file */
-	else if ((s = open("/dev/null", O_WRONLY)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open(/dev/null) failed");
+	/* Wait for server to accept and exit */
+	SAFE_WAITPID(pid, NULL, 0);
+	pid = 0;
 
-}
+	sock2.sin_family = AF_INET;
+	sock2.sin_port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);
+	sock2.sin_addr.s_addr = INADDR_ANY;
 
-void cleanup0(void)
-{
-	close(s);
-	s = -1;
+	sock3.sin_family = 47;
+	sock3.sin_port = 0;
+	sock3.sin_addr.s_addr = htonl(0x0AFFFEFD);
 }
 
-void setup1(void)
+static void cleanup(void)
 {
-	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
-		        tdat[testno].proto);
-}
-
-void cleanup1(void)
-{
-	(void)close(s);
-	s = -1;
-}
-
-void setup2(void)
-{
-	setup1();		/* get a socket in s */
-	SAFE_CONNECT(cleanup, s, (const struct sockaddr *)&sin1, sizeof(sin1));
-}
-
-pid_t start_server(struct sockaddr_in *sin0)
-{
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
+	if (fd_socket > 0)
+		SAFE_CLOSE(fd_socket);
+	if (fd_null > 0)
+		SAFE_CLOSE(fd_null);
+	if (fd_connected > 0)
+		SAFE_CLOSE(fd_connected);
+
+	if (pid > 0) {
+		SAFE_KILL(pid, SIGKILL);
+		SAFE_WAITPID(pid, NULL, 0);
 	}
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
 }
 
-void do_child(void)
+static void verify_connect(unsigned int i)
 {
-	struct sockaddr_in fsin;
-	fd_set afds, rfds;
-	int nfds, cc, fd;
-	char c;
-
-	FD_ZERO(&afds);
-	FD_SET(sfd, &afds);
-
-	nfds = sfd + 1;
+	struct test_case_t *tc = &tcases[i];
+	void *addr = tc->addr ? tc->addr : bad_addr;
 
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
+	TST_EXP_FAIL(sys_connect(*tc->fd, addr, tc->salen),
+		tc->exp_errno, "%s", tc->desc);
 }
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_connect,
+	.forks_child = 1,
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
