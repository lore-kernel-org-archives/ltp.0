Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CFCCD98CE
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 05:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781587534; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=dHofVmDuj2UOZIIf9b+pPWd1fMTyIwSAH/JIGOKusdM=;
 b=QcJTcT8daqva/+tZ+Wgq94JJU6QlqhZnjPu+BXtrB1uTyS9EBNkAKQI172pzuITTrQwHi
 dI1g1/Hi38xZTC6CiwnCUHVtlQaFkZsd2TYPg5Vp09e2Qsb+8Km0DmYwuaO5+CglNHZn8BD
 tuwL5OD4B4b3bZz32RTcsk4+e0kohQs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86D183E1FC1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 07:25:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A14C3E4E34
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 07:24:58 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E36511A00806
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 07:24:57 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490be29c1c5so44754955e9.2
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 22:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781587497; x=1782192297; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmv1wEzht6h8TLCpogLs+X8FJ/Wb4BsfVpJ7Vx47buM=;
 b=Mhx0fDRA+EmqtITD9501RprkmhombY+rglF3kq7uVFjFDISor50joUYLzdQs8M4+xU
 HXrkCuJeGeu+nLA/z8YBOezSZl4FvkTK9InxcFAQiPegzyik5UW1L5pKIw0LKQY2ieDs
 Ja/s8Kpbb8YES6AjZ5dIQGFQ6UD2JT2EALyokZgxpvskeWmWwXW9kVOlgGFNQUM9m1/4
 p6tFxF/OgKFDy/pMGnUO0sfrv/ZU0DqugQbyJAl0PwjDqVNasTgHN89VjEHMhKjdfHxQ
 OYDZIIqgQANagyFevbT7pY9WuEQVCYqPx9Y6QNfTx41XUm/Egm1fZF23Nxh6dgtvO1LG
 qM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781587497; x=1782192297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kmv1wEzht6h8TLCpogLs+X8FJ/Wb4BsfVpJ7Vx47buM=;
 b=Hggru8bwk3VtYEKZZhO2oLXZ5hzCvXxjDbR7x62CZLXwC33P/1Bp6D5nNv095zCUL1
 YEzktEdQBuYu6hih2TOR9Gvuq9QDKLhJwOUvq283ipNc2yt3n384ZP5ToqbY3rx4JiPD
 GuA3VDHmoFAhg8Y+X6D2sOGCUzYd72v6eKPSQi/8CBfxMm3kHYlZ+YnqJcm9qSfoRh8s
 TOx7KmxrBHwsUuzFCL+FQI/JDr/RGGS9nSXUbLAfnzlUL0IrX8MP/u4Vj5wmPBOlblnM
 EeFMZM9cbrC1+m3Teg3Fp8WqHlFsWytBXrskOv6ja5J1GGg9iaZfpAXGyZeyIHxG4T3u
 Hl7w==
X-Gm-Message-State: AOJu0YwTd2HeU8K3OY8mBXxNtzGfradbZ76nrU+0LaNRIN4SUE1trsNi
 QKpo68DpXgcW8Ke9lQVwJJ5lQMFd6jW+aqsVh3Y7jJFVE6x3BK9A9jfSxrRWHyS+HVbiUcnhD9M
 qagU=
X-Gm-Gg: Acq92OE5V5YhT52eqOpZ3WmrOseX0iAXJxp+Zww7qhExG0YfmR1hEEU1S88UUIdXNpJ
 qrCtm0HFb64wQpz+zDUgfWkldt16tFmPjgPuGGDD/eWAlNIo7ApzEtniWGh+BCSjFa64+oX0DBu
 G1Sija4wqRQPJ4jI+Bive1cI9JU9tMhQCRE1bGisdm8G807VUVM8jiO1EFZ0M3ePd4Pa04Bg3Zw
 qAUivsMJrgnLyRW3gzr2rZoyrqfzjlYEPldZQujO+kYsv9Ko9qjFc8HGI47WZcM5+IkxIYFEXeS
 e5+45OHif4X7c2cHuMbOHi0mCR0oTB2AaU/LuV1EOdx93T04vip3/lTINV9aqqG8iI6tBVSxaQ2
 SLL/AYuGmLkIM8j6uYo1WC3Lo+NZYOPIe9EYAdDR7htYn6EdtmfEG6HBi6UFvhqQDkmkd8wHfZH
 TPIx+GqBVaFmw=
X-Received: by 2002:a05:600c:1d0f:b0:492:2100:aba2 with SMTP id
 5b1f17b1804b1-4922ff72bafmr29180895e9.4.1781587497071; 
 Mon, 15 Jun 2026 22:24:57 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49230a4f8d7sm30863515e9.5.2026.06.15.22.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 22:24:56 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue, 16 Jun 2026 05:24:19 +0000
Message-ID: <20260616052452.8353-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616052452.8353-1-wegao@suse.com>
References: <20260616014747.8220-2-wegao@suse.com>
 <20260616052452.8353-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 1/2] connect01: Convert to new API
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

Convert the connect01 test case from the legacy LTP API to the new tst_test API.

Simplify the server child process to a single accept/exit loop and move the server
lifecycle to the global setup and cleanup. The server now accepts a single connection
for the EISCONN test case and exits immediately, which avoids blocking the test runner.
Centralize test case initialization into the global setup and use tst_get_bad_addr()
for the EFAULT test case to ensure architectural compatibility.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/connect/connect01.c | 362 +++++-------------
 1 file changed, 97 insertions(+), 265 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 6cb8adab3..fd288559e 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -1,308 +1,140 @@
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
+ * Copyright (c) Linux Test Project, 2006-2026
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
+ * Verify that :manpage:`connect(2)` returns the proper errno for various failure cases.
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
+static int fd_socket = -1;
+static int fd_null = -1;
+static int fd_connected = -1;
+static int fd_server = -1;
 
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
+		       socklen_t addrlen)
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
+	SAFE_CLOSE(fd_server);
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
+	if (fd_socket != -1)
+		SAFE_CLOSE(fd_socket);
+	if (fd_null != -1)
+		SAFE_CLOSE(fd_null);
+	if (fd_connected != -1)
+		SAFE_CLOSE(fd_connected);
+	if (fd_server != -1)
+		SAFE_CLOSE(fd_server);
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
+		     tc->exp_errno, "%s", tc->desc);
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
