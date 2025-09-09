Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9836BCA0FED
	for <ltp@archiver.kernel.org>; Tue,  9 Sep 2025 08:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757407537; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=HO4AVxihY/gll2AcksunMHSoqSYpN1dFcyFsEmtcaFI=;
 b=T4OqLp/JM7y53tBEqMNOLqPz4xsszsEZdCKGnF1hf0HG304eM/RWIigTmhUFCCyCPIuZr
 hegWgJ2WfrJGGOzfez4uVDgzNotJlHIGQWczHMYX4MYfB3AmaiU80NquFPDpSeFggjLThbQ
 JWE4n1n72EfL7atwE5h7n+FPkGRuhzQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 687103CC3B6
	for <ltp@archiver.kernel.org>; Tue,  9 Sep 2025 10:45:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 050A13C59AA
 for <ltp@lists.linux.it>; Tue,  9 Sep 2025 10:45:16 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0DFFC1A004EE
 for <ltp@lists.linux.it>; Tue,  9 Sep 2025 10:45:15 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b047f28a83dso888888966b.2
 for <ltp@lists.linux.it>; Tue, 09 Sep 2025 01:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757407515; x=1758012315; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZHZHFJQQ16YSwGhm7wjQzYphdeGQVJ1kB/2xySyBLI=;
 b=AmB9QdSFDCzphbNbMhvrUwFL7b225/iVO717SOxrzww8Dj2FZYB+ObnWFEPan0Lrpx
 utrIVj3HplA3EQjCwbbtYtulL7VkErdiUWhqvFQ4wZRf56o/3zLdD5SfUvZfhmmrXpB/
 8sOalTgYKLmxVuEHEN5a8pYzjC2C5ROCoe21HBbqLwaRm3PqR6oxxuKRhAhkINUOrzJE
 FMi3NYnDb55bBt3g+j70HArYGLHUijS7SBJ3IoNLBWtKUBQPSZo8g9d62uTBe6gBnEyf
 1bK6Y3CkOiW2ilr0sOLT3frZvLtHq8Kr3gp8KRtQZQbGVe4RNdjnMalJA9SZsuRCaP7D
 5Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757407515; x=1758012315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ZHZHFJQQ16YSwGhm7wjQzYphdeGQVJ1kB/2xySyBLI=;
 b=dhmCK2xCwjghtiwtSf/7qoRBOirXbQ8FBLpK9vKt4XjG3Z4L3nFxZXJVPGaPll07Gr
 TpCFMyQqSKKinaOAk6sQOvBsyRQTmUW2ZLulm8GpKmT2PhfL+B5pR/QTwrX8wuRA861y
 5CH8abarulKKmtHBEeX70SY7912ScIfgyiH9uzP95ZSbpWOVWJaY6qg8jDh1p3PSk9s2
 qZ3T0qDc+vUriLaPT68o4S3w4D6i5E6P2z9wY5WqpT0edo7mcTxCHQ4UDDHncnxe4NrD
 TG8/XcngOZDydCagSszQBc3uW5fGGRPj/x17p06StHDTmsK+pw0bM2Qc5oR2DS+EnORm
 M7AA==
X-Gm-Message-State: AOJu0YyIunWUbITdiXc2U6khWES3baecKe4Hjv/zu13rNWOF2kJ+lGLU
 seNqrS9lXlaANNob8F6ObXlyKZBPtPrsVTaX/+zf79PXLks9FHx65irGSMke4QI7TSQSocRAtSZ
 bC3HPSA==
X-Gm-Gg: ASbGncs9+VXwVmHiolDLsLIR8tFbrRqFlR6K/aRUQEcfk3QH32xWvYQCTf40TyvGT+e
 V7M6jdzVJr3CMG6ZoWYKvPs3gSmgBSdROI/w+ZDuAZOKK2TZC/wPrIBPUaVlvBtLIZEKcUxWrEl
 vp0DmI/y/7jLiQWLZZfKbrXm4ZkbTlEVAgxA6xHIlUpQWcCSuIaiSwvXRLqoSnxERRSptDxOsqR
 ObgoatmiKN0SdNLdypVB15ELSZPkJI34QFT9eCBFhIXyqCuUpAC9LKdKwUk1irzbgHbXl1+FnnD
 wrPeO5zaVrmgzpC8M1+kX2T8kcWlFOt0hxpaDIGMGEwOLXf1gjDEf/GuyxsUgllLiC4UCs1XEuG
 OByvIn8wnk7TnV8xCcOZvqINx/smx0zY94g90r8VN3kU=
X-Google-Smtp-Source: AGHT+IHOUE14b63acJpFY3lIwrO3WnyXHHIMiD1jsfYeqG+DQn9YBu2oQjVR+rBgSqgSkjMuYMOjWg==
X-Received: by 2002:a17:907:2d0c:b0:b04:a780:4673 with SMTP id
 a640c23a62f3a-b04b1663c1cmr1114614166b.31.1757407514875; 
 Tue, 09 Sep 2025 01:45:14 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-aff032125e2sm2677001966b.77.2025.09.09.01.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 01:45:14 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  9 Sep 2025 08:44:17 +0000
Message-ID: <20250909084512.10962-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] connect01: Add positive check with different type
 of server
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

This patch refactors the existing test suite to use the new API. Previously,
the tests only covered negative scenarios with invalid parameters. This update
also introduces new positive tests to verify successful connections with
various server types.

Fixes: #1167
Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/connect/connect01.c | 277 ++++++++----------
 1 file changed, 118 insertions(+), 159 deletions(-)

diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 660c4f7a9..6a3416772 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -1,71 +1,30 @@
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
+ * Copyright (c) 2025 Wei Gao <wegao@suse.com>
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
+ * LTP test case verify that connect() returns the expected errno
+ * for various failure cases and the also validates successful connections
+ * to various server types.
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <errno.h>
-#include <fcntl.h>
-
-#include <sys/types.h>
-#include <sys/socket.h>
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
+#include "tst_test.h"
 
-int s, s2;			/* socket descriptor */
-struct sockaddr_in sin1, sin2, sin3, sin4;
+static int s;			/* socket descriptor */
+static struct sockaddr_in sin1, sin2, sin3, sin4;
 static int sfd;			/* shared between start_server and do_child */
+static pid_t pid;
 
-void setup(void), setup0(void), setup1(void), setup2(void),
-cleanup(void), cleanup0(void), cleanup1(void), do_child(void);
-
-static pid_t start_server(struct sockaddr_in *);
+static void setup(void);
+static void setup0(unsigned int testno);
+static void setup1(unsigned int testno);
+static void setup2(unsigned int testno);
+static void cleanup0(void);
+static void cleanup1(void);
+static void do_child(void);
+static pid_t start_server(int domain, int type, struct sockaddr_in *);
 
 struct test_case_t {		/* test case structure */
 	int domain;		/* PF_INET, PF_UNIX, ... */
@@ -75,8 +34,8 @@ struct test_case_t {		/* test case structure */
 	int salen;		/* connect's 3rd argument */
 	int retval;		/* syscall return value */
 	int experrno;		/* expected errno */
-	void (*setup) (void);
-	void (*cleanup) (void);
+	void (*setup)(unsigned int testno);
+	void (*cleanup)(void);
 	char *desc;
 } tdat[] = {
 	{
@@ -89,25 +48,32 @@ struct test_case_t {		/* test case structure */
 		    cleanup1, "invalid socket buffer"},
 	{
 	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
-		    3, -1, EINVAL, setup1, cleanup1, "invalid salen"}, {
-	0, 0, 0, (struct sockaddr *)&sin1,
+		    3, -1, EINVAL, setup1, cleanup1, "invalid salen"},
+	{
+	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
 		    sizeof(sin1), -1, ENOTSOCK, setup0, cleanup0,
-		    "invalid socket"}
-	, {
+		    "invalid socket"},
+	{
 	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
 		    sizeof(sin1), -1, EISCONN, setup2, cleanup1,
-		    "already connected"}
-	, {
+		    "already connected"},
+	{
 	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin2,
 		    sizeof(sin2), -1, ECONNREFUSED, setup1, cleanup1,
-		    "connection refused"}
-	, {
+		    "connection refused"},
+	{
 	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin4,
 		    sizeof(sin4), -1, EAFNOSUPPORT, setup1, cleanup1,
-		    "invalid address family"}
-,};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
+		    "invalid address family"},
+	{
+	PF_INET, SOCK_STREAM, 0, (struct sockaddr *)&sin1,
+		sizeof(sin1), 0, 0, setup1, cleanup1,
+		"valid stream connection"},
+	{
+	PF_INET, SOCK_DGRAM, 0, (struct sockaddr *)&sin1,
+		sizeof(sin1), 0, 0, setup1, cleanup1,
+		"valid datagram connection"},
+};
 
 /**
  * bionic's connect() implementation calls netdClientInitConnect() before
@@ -127,53 +93,38 @@ static int sys_connect(int sockfd, const struct sockaddr *addr,
 
 #define connect(sockfd, addr, addrlen) sys_connect(sockfd, addr, addrlen)
 
-int main(int argc, char *argv[])
+static void verify_accept(unsigned int testno)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
+	pid = start_server(tdat[testno].domain, tdat[testno].type, &sin1);
 
 	setup();
 
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			tdat[testno].setup();
-
-			TEST(connect
-			     (s, tdat[testno].sockaddr, tdat[testno].salen));
-
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
+	tdat[testno].setup(testno);
+
+	TEST(connect(s, tdat[testno].sockaddr, tdat[testno].salen));
+
+	if (TST_RET != tdat[testno].retval ||
+			(TST_RET < 0 &&
+			 TST_ERR != tdat[testno].experrno)) {
+		tst_res(TFAIL, "%s ; returned"
+				" %ld (expected %d), errno %d (expected"
+				" %d)", tdat[testno].desc,
+				TST_RET, tdat[testno].retval,
+				TST_ERR, tdat[testno].experrno);
+	} else {
+		tst_res(TPASS, "%s successful", tdat[testno].desc);
 	}
-	cleanup();
 
-	tst_exit();
+	tdat[testno].cleanup();
 }
 
-pid_t pid;
 
-void setup(void)
+static void setup(void)
 {
-	TEST_PAUSE;		/* if -p option specified */
-
-	pid = start_server(&sin1);
 
 	sin2.sin_family = AF_INET;
 	/* this port must be unused! */
-	sin2.sin_port = TST_GET_UNUSED_PORT(NULL, AF_INET, SOCK_STREAM);
+	sin2.sin_port = TST_GET_UNUSED_PORT(AF_INET, SOCK_STREAM);
 	sin2.sin_addr.s_addr = INADDR_ANY;
 
 	sin3.sin_family = AF_INET;
@@ -187,46 +138,40 @@ void setup(void)
 
 }
 
-void cleanup(void)
-{
-	(void)kill(pid, SIGKILL);
-
-}
-
-void setup0(void)
+static void setup0(unsigned int testno)
 {
 	if (tdat[testno].experrno == EBADF)
 		s = 400;	/* anything not an open file */
-	else if ((s = open("/dev/null", O_WRONLY)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open(/dev/null) failed");
+	else
+		s = SAFE_OPEN("/dev/null", O_WRONLY);
 
 }
 
-void cleanup0(void)
+static void cleanup0(void)
 {
 	close(s);
 	s = -1;
 }
 
-void setup1(void)
+static void setup1(unsigned int testno)
 {
-	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
-		        tdat[testno].proto);
+	s = SAFE_SOCKET(tdat[testno].domain, tdat[testno].type,
+		tdat[testno].proto);
 }
 
-void cleanup1(void)
+static void cleanup1(void)
 {
 	(void)close(s);
 	s = -1;
 }
 
-void setup2(void)
+static void setup2(unsigned int testno)
 {
-	setup1();		/* get a socket in s */
-	SAFE_CONNECT(cleanup, s, (const struct sockaddr *)&sin1, sizeof(sin1));
+	setup1(testno);		/* get a socket in s */
+	SAFE_CONNECT(s, (const struct sockaddr *)&sin1, sizeof(sin1));
 }
 
-pid_t start_server(struct sockaddr_in *sin0)
+static pid_t start_server(int domain, int type, struct sockaddr_in *sin0)
 {
 	pid_t pid;
 	socklen_t slen = sizeof(*sin0);
@@ -235,27 +180,31 @@ pid_t start_server(struct sockaddr_in *sin0)
 	sin0->sin_port = 0; /* pick random free port */
 	sin0->sin_addr.s_addr = INADDR_ANY;
 
-	sfd = socket(PF_INET, SOCK_STREAM, 0);
+	sfd = socket(domain, type, 0);
 	if (sfd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
+		tst_brk(TBROK | TERRNO, "server socket failed");
 		return -1;
 	}
 	if (bind(sfd, (struct sockaddr *)sin0, sizeof(*sin0)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
+		tst_brk(TBROK | TERRNO, "server bind failed");
 		return -1;
 	}
-	if (listen(sfd, 10) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
-		return -1;
+
+	if (type != SOCK_DGRAM) {
+		if (listen(sfd, 10) < 0) {
+			tst_brk(TBROK | TERRNO, "server listen failed");
+			return -1;
+		}
 	}
-	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
-	switch ((pid = tst_fork())) {
+	SAFE_GETSOCKNAME(sfd, (struct sockaddr *)sin0, &slen);
+
+	switch ((pid = SAFE_FORK())) {
 	case 0:		/* child */
 		do_child();
 		break;
 	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "server fork failed");
+		tst_brk(TBROK | TERRNO, "server fork failed");
 		/* fall through */
 	default:		/* parent */
 		(void)close(sfd);
@@ -265,7 +214,7 @@ pid_t start_server(struct sockaddr_in *sin0)
 	return -1;
 }
 
-void do_child(void)
+static void do_child(void)
 {
 	struct sockaddr_in fsin;
 	fd_set afds, rfds;
@@ -277,32 +226,42 @@ void do_child(void)
 
 	nfds = sfd + 1;
 
-	/* accept connections until killed */
-	while (1) {
-		socklen_t fromlen;
+	struct timeval timeout;
 
-		memcpy(&rfds, &afds, sizeof(rfds));
+	timeout.tv_sec = 0;
+	timeout.tv_usec = 100;
 
-		if (select(nfds, &rfds, NULL, NULL,
-			   NULL) < 0)
-			if (errno != EINTR)
-				exit(1);
-		if (FD_ISSET(sfd, &rfds)) {
-			int newfd;
+	socklen_t fromlen;
 
-			fromlen = sizeof(fsin);
-			newfd = accept(sfd, (struct sockaddr *)&fsin, &fromlen);
-			if (newfd >= 0) {
-				FD_SET(newfd, &afds);
-				nfds = MAX(nfds, newfd + 1);
-			}
+	memcpy(&rfds, &afds, sizeof(rfds));
+
+	if (select(nfds, &rfds, NULL, NULL, &timeout) < 0)
+		exit(0);
+
+	if (FD_ISSET(sfd, &rfds)) {
+		int newfd;
+
+		fromlen = sizeof(fsin);
+		newfd = accept(sfd, (struct sockaddr *)&fsin, &fromlen);
+		if (newfd >= 0) {
+			FD_SET(newfd, &afds);
+			nfds = MAX(nfds, newfd + 1);
 		}
-		for (fd = 0; fd < nfds; ++fd)
-			if (fd != sfd && FD_ISSET(fd, &rfds)) {
-				if ((cc = read(fd, &c, 1)) == 0) {
-					(void)close(fd);
-					FD_CLR(fd, &afds);
-				}
-			}
 	}
+	for (fd = 0; fd < nfds; ++fd)
+		if (fd != sfd && FD_ISSET(fd, &rfds)) {
+			cc = read(fd, &c, 1);
+			if (cc == 0) {
+				(void)close(fd);
+				FD_CLR(fd, &afds);
+			}
+		}
+
+	exit(0);
 }
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(tdat),
+	.test = verify_accept,
+	.forks_child = 1,
+};
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
