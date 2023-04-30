Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE3FC77B73
	for <ltp@archiver.kernel.org>; Sun, 30 Apr 2023 06:04:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D0713CB988
	for <ltp@archiver.kernel.org>; Sun, 30 Apr 2023 08:04:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E9E23CB1C6
 for <ltp@lists.linux.it>; Sun, 30 Apr 2023 08:04:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 543951A002D5
 for <ltp@lists.linux.it>; Sun, 30 Apr 2023 08:04:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6928E1FDA1;
 Sun, 30 Apr 2023 06:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1682834665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FFXsyJ6uEX2HuqLQ8sHANWav6sswmP9tfyKoybI44OQ=;
 b=OKqV1tXnOHjRvCpBRvEDX0xkL84x4CbCsyv5038adkzI/N7LfFMgny7YdFlVJ4ecg0YYO5
 0+vL8/Yl5GuRNqDOXOjHPKuxGhLB83nLp7KKbkdLW3NsSkIHGW36jzcLKJebx6cnQg+9kY
 KoonV0i8LXVPtk5R63NmpsGXpZKdO1w=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 075C013319;
 Sun, 30 Apr 2023 06:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PFbmMucETmQZRAAAMHmgww
 (envelope-from <wegao@suse.com>); Sun, 30 Apr 2023 06:04:23 +0000
To: ltp@lists.linux.it
Date: Sun, 30 Apr 2023 02:04:19 -0400
Message-Id: <20230430060419.12045-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230424103056.6017-1-wegao@suse.com>
References: <20230424103056.6017-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] recvmsg01: Refactor using new LTP API
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

---
 testcases/kernel/syscalls/recvmsg/recvmsg01.c | 717 +++++++++---------
 1 file changed, 345 insertions(+), 372 deletions(-)

diff --git a/testcases/kernel/syscalls/recvmsg/recvmsg01.c b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
index 3ce7ab027..e77a12400 100644
--- a/testcases/kernel/syscalls/recvmsg/recvmsg01.c
+++ b/testcases/kernel/syscalls/recvmsg/recvmsg01.c
@@ -1,364 +1,363 @@
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
+ * Copyright (c) 2001 Wayne Boyer International Business Machines
+ * Copyright (c) Linux Test Project, 2002-2022
+ * Copyright (c) 2023 Wei Gao <wegao@suse.com>
  */
 
-/*
- * Test Name: recvmsg01
- *
- * Test Description:
- *  Verify that recvmsg() returns the proper errno for various failure cases
- *
- * Usage:  <for command-line>
- *  recvmsg01 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
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
+/*\
+ * [Description]
  *
+ * Verify that recvmsg() returns the proper errno for various failure cases.
  */
 
 #include <stdio.h>
-#include <unistd.h>
-#include <string.h>
-#include <errno.h>
-#include <fcntl.h>
-
+#include <stdlib.h>
 #include <sys/wait.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <sys/signal.h>
-#include <sys/uio.h>
-#include <sys/un.h>
-#include <sys/file.h>
-
-#include <netinet/in.h>
-
-#include "test.h"
-#include "safe_macros.h"
-
-char *TCID = "recvmsg01";
-int testno;
-
-char buf[1024], cbuf[1024];
-int s;				/* socket descriptor */
-int passed_fd = -1;		/* rights-passing test descriptor */
-struct sockaddr_in sin1, from;
-struct sockaddr_un sun1;
-struct msghdr msgdat;
-struct cmsghdr *control = 0;
-int controllen = 0;
-struct iovec iov[1];
+#include "tst_test.h"
+
+#define MSG "from recvmsg01 server"
+#define BUF_SIZE 1024
+#define CONTROL_LEN (128 * 1024)
+
+static char recv_buf[BUF_SIZE], cbuf[BUF_SIZE];
+static int sock;
+static struct sockaddr_in sin1, from;
+static struct sockaddr_un sun1;
+static struct msghdr msgdat;
+static struct cmsghdr *control;
+static int controllen;
+static struct iovec iov[1];
 static int sfd;			/* shared between do_child and start_server */
 static int ufd;			/* shared between do_child and start_server */
-
-void setup(void);
-void setup0(void);
-void setup1(void);
-void setup2(void);
-void setup3(void);
-void setup4(void);
-void cleanup(void);
-void cleanup0(void);
-void cleanup1(void);
-void cleanup2(void);
-void do_child(void);
-
-void sender(int);
-pid_t start_server(struct sockaddr_in *, struct sockaddr_un *);
-
-struct test_case_t {		/* test case structure */
-	int domain;		/* PF_INET, PF_UNIX, ... */
-	int type;		/* SOCK_STREAM, SOCK_DGRAM ... */
-	int proto;		/* protocol number (usually 0 = default) */
+static pid_t pid;
+static char tmpsunpath[BUF_SIZE];
+
+static void setup_all(void);
+static void setup_invalid_sock(int);
+static void setup_valid_sock(int);
+static void setup_valid_msg_control(int);
+static void setup_large_msg_control(int);
+static void cleanup_all(void);
+static void cleanup_invalid_sock(int);
+static void cleanup_close_sock(int);
+static void cleanup_reset_all(int);
+static void do_child(void);
+static pid_t start_server(struct sockaddr_in *, struct sockaddr_un *);
+
+static struct tcase {
+	int domain;
+	int type;
+	int protocol;
 	struct iovec *iov;
 	int iovcnt;
-	void *buf;		/* recv data buffer */
-	int buflen;		/* recv buffer length */
+	void *recv_buf;
+	int buflen;
 	struct msghdr *msg;
-	unsigned flags;
-	struct sockaddr *from;	/* from address */
-	int fromlen;		/* from address value/result buffer length */
-	int retval;		/* syscall return value */
-	int experrno;		/* expected errno */
-	void (*setup) (void);
-	void (*cleanup) (void);
+	unsigned int flags;
+	struct sockaddr *from;
+	int fromlen;
+	int ret;
+	int exp_errno;
+	void (*setup)(int n);
+	void (*cleanup)(int n);
 	char *desc;
-} tdat[] = {
-/* 1 */
-	{
-	PF_INET, SOCK_STREAM, 0, iov, 1, buf, sizeof(buf), &msgdat, 0,
-		    (struct sockaddr *)&from, sizeof(from),
-		    -1, EBADF, setup0, cleanup0, "bad file descriptor"}
-	,
-/* 2 */
+} tcases[] = {
 	{
-	0, 0, 0, iov, 1, (void *)buf, sizeof(buf), &msgdat, 0,
-		    (struct sockaddr *)&from, sizeof(from),
-		    -1, ENOTSOCK, setup0, cleanup0, "invalid socket"}
-	,
-/* 3 */
+		.domain = PF_INET,
+		.type = SOCK_STREAM,
+		.iov = iov,
+		.iovcnt = 1,
+		.recv_buf = recv_buf,
+		.buflen = sizeof(recv_buf),
+		.msg = &msgdat,
+		.from = (struct sockaddr *)&from,
+		.fromlen = sizeof(from),
+		.ret = -1,
+		.exp_errno = EBADF,
+		.setup = setup_invalid_sock,
+		.cleanup = cleanup_invalid_sock,
+		.desc = "bad file descriptor",
+	},
 	{
-	PF_INET, SOCK_STREAM, 0, iov, 1, (void *)buf, sizeof(buf),
-		    &msgdat, 0, (struct sockaddr *)-1, sizeof(from), 0,
-		    ENOTSOCK, setup1, cleanup1, "invalid socket buffer"}
-	,
-/* 4 */
+		.domain = PF_INET,
+		.type = SOCK_STREAM,
+		.iov = iov,
+		.iovcnt = 1,
+		.recv_buf = (void *)recv_buf,
+		.buflen = sizeof(recv_buf),
+		.msg = &msgdat,
+		.from = (struct sockaddr *)&from,
+		.fromlen = sizeof(from),
+		.ret = -1,
+		.exp_errno = ENOTSOCK,
+		.setup = setup_invalid_sock,
+		.cleanup = cleanup_invalid_sock,
+		.desc = "invalid socket",
+	},
 	{
-	PF_INET, SOCK_STREAM, 0, iov, 1, (void *)buf, sizeof(buf),
-		    &msgdat, -1, (struct sockaddr *)&from, -1, -1,
-		    EINVAL, setup1, cleanup1, "invalid socket length"},
-/* 5 */
+		.domain = PF_INET,
+		.type = SOCK_STREAM,
+		.iov = iov,
+		.iovcnt = 1,
+		.recv_buf = (void *)recv_buf,
+		.buflen = sizeof(recv_buf),
+		.msg = &msgdat,
+		.flags = -1,
+		.from = (struct sockaddr *)&from,
+		.fromlen = -1,
+		.ret = -1,
+		.exp_errno = EINVAL,
+		.setup = setup_valid_sock,
+		.cleanup = cleanup_close_sock,
+		.desc = "invalid socket length",
+	},
 	{
-	PF_INET, SOCK_STREAM, 0, iov, 1, (void *)-1, sizeof(buf),
-		    &msgdat, 0, (struct sockaddr *)&from, sizeof(from),
-		    -1, EFAULT, setup1, cleanup1, "invalid recv buffer"}
-	,
-/* 6 */
+		.domain = PF_INET,
+		.type = SOCK_STREAM,
+		.iov = iov,
+		.iovcnt = 1,
+		.recv_buf = (void *)-1,
+		.buflen = sizeof(recv_buf),
+		.msg = &msgdat,
+		.from = (struct sockaddr *)&from,
+		.fromlen = sizeof(from),
+		.ret = -1,
+		.exp_errno = EFAULT,
+		.setup = setup_valid_sock,
+		.cleanup = cleanup_close_sock,
+		.desc = "invalid recv buffer",
+	},
 	{
-	PF_INET, SOCK_STREAM, 0, 0, 1, (void *)buf, sizeof(buf),
-		    &msgdat, 0, (struct sockaddr *)&from, sizeof(from),
-		    -1, EFAULT, setup1, cleanup1, "invalid iovec buffer"}
-	,
-/* 7 */
+		.domain = PF_INET,
+		.type = SOCK_STREAM,
+		.iovcnt = 1,
+		.recv_buf = recv_buf,
+		.buflen = sizeof(recv_buf),
+		.msg = &msgdat,
+		.from = (struct sockaddr *)&from,
+		.fromlen = sizeof(from),
+		.ret = -1,
+		.exp_errno = EFAULT,
+		.setup = setup_valid_sock,
+		.cleanup = cleanup_close_sock,
+		.desc = "invalid iovec buffer",
+	},
 	{
-	PF_INET, SOCK_STREAM, 0, iov, -1, (void *)buf, sizeof(buf),
-		    &msgdat, 0, (struct sockaddr *)&from, sizeof(from),
-		    -1, EMSGSIZE, setup1, cleanup1, "invalid iovec count"}
-	,
-/* 8 */
+		.domain = PF_INET,
+		.type = SOCK_STREAM,
+		.iov = iov,
+		.iovcnt = -1,
+		.recv_buf = recv_buf,
+		.buflen = sizeof(recv_buf),
+		.msg = &msgdat,
+		.from = (struct sockaddr *)&from,
+		.fromlen = sizeof(from),
+		.ret = -1,
+		.exp_errno = EMSGSIZE,
+		.setup = setup_valid_sock,
+		.cleanup = cleanup_close_sock,
+		.desc = "invalid iovec count",
+	},
 	{
-	PF_UNIX, SOCK_STREAM, 0, iov, 1, (void *)buf, sizeof(buf),
-		    &msgdat, 0, (struct sockaddr *)&from, sizeof(from),
-		    0, 0, setup2, cleanup2, "rights reception"}
-	,
-/* 9 */
+		.domain = PF_INET,
+		.type = SOCK_STREAM,
+		.iov = iov,
+		.iovcnt = 1,
+		.recv_buf = recv_buf,
+		.buflen = sizeof(recv_buf),
+		.msg = &msgdat,
+		.from = (struct sockaddr *)&from,
+		.fromlen = sizeof(from),
+		.setup = setup_valid_msg_control,
+		.cleanup = cleanup_reset_all,
+		.desc = "rights reception",
+	},
 	{
-	PF_INET, SOCK_STREAM, 0, iov, 1, (void *)buf, sizeof(buf),
-		    &msgdat, MSG_OOB, (struct sockaddr *)&from,
-		    sizeof(from), -1, EINVAL, setup1, cleanup1,
-		    "invalid MSG_OOB flag set"}
-	,
-/* 10 */
+		.domain = PF_INET,
+		.type = SOCK_STREAM,
+		.iov = iov,
+		.iovcnt = 1,
+		.recv_buf = recv_buf,
+		.buflen = sizeof(recv_buf),
+		.msg = &msgdat,
+		.flags = MSG_OOB,
+		.from = (struct sockaddr *)&from,
+		.fromlen = sizeof(from),
+		.ret = -1,
+		.exp_errno = EINVAL,
+		.setup = setup_valid_sock,
+		.cleanup = cleanup_close_sock,
+		.desc = "invalid MSG_OOB flag set",
+	},
 	{
-	PF_INET, SOCK_STREAM, 0, iov, 1, (void *)buf, sizeof(buf),
-		    &msgdat, MSG_ERRQUEUE, (struct sockaddr *)&from,
-		    sizeof(from), -1, EAGAIN, setup1, cleanup1,
-		    "invalid MSG_ERRQUEUE flag set"}
-	,
-/* 11 */
+		.domain = PF_INET,
+		.type = SOCK_STREAM,
+		.iov = iov,
+		.iovcnt = 1,
+		.recv_buf = recv_buf,
+		.buflen = sizeof(recv_buf),
+		.msg = &msgdat,
+		.flags = MSG_ERRQUEUE,
+		.from = (struct sockaddr *)&from,
+		.fromlen = sizeof(from),
+		.ret = -1,
+		.exp_errno = EAGAIN,
+		.setup = setup_valid_sock,
+		.cleanup = cleanup_close_sock,
+		.desc = "invalid MSG_ERRQUEUE flag set",
+	},
 	{
-	PF_UNIX, SOCK_STREAM, 0, iov, 1, (void *)buf, sizeof(buf),
-		    &msgdat, 0, (struct sockaddr *)&from, sizeof(from),
-		    0, EINVAL, setup3, cleanup2, "invalid cmsg length"}
-	,
-/* 12 */
-	{
-	PF_UNIX, SOCK_STREAM, 0, iov, 1, (void *)buf, sizeof(buf),
-		    &msgdat, 0, (struct sockaddr *)&from, sizeof(from),
-		    0, 0, setup4, cleanup2, "large cmesg length"}
-,};
-
-int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
+		.domain = PF_INET,
+		.type = SOCK_STREAM,
+		.iov = iov,
+		.iovcnt = 1,
+		.recv_buf = recv_buf,
+		.buflen = sizeof(recv_buf),
+		.msg = &msgdat,
+		.from = (struct sockaddr *)&from,
+		.fromlen = sizeof(from),
+		.setup = setup_large_msg_control,
+		.cleanup = cleanup_reset_all,
+		.desc = "large cmesg length",
+	},
+
+};
+
+static void run(unsigned int n)
+{
+	setup_all();
 
-#ifdef UCLINUX
-static char *argv0;
-#endif
+	struct tcase *tc = &tcases[n];
 
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-#ifdef UCLINUX
-	argv0 = argv[0];
-	maybe_run_child(&do_child, "dd", &sfd, &ufd);
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-			if ((tst_kvercmp(3, 17, 0) < 0)
-			    && (tdat[testno].flags & MSG_ERRQUEUE)
-			    && (tdat[testno].type & SOCK_STREAM)) {
-				tst_resm(TCONF, "skip MSG_ERRQUEUE test, "
-						"it's supported from 3.17");
-				continue;
-			}
+	if ((tst_kvercmp(3, 17, 0) < 0)
+			&& (tc->flags & MSG_ERRQUEUE)
+			&& (tc->type & SOCK_STREAM)) {
+		tst_res(TCONF, "MSG_ERRQUEUE requires kernel >= 3.17");
+	}
 
-			tdat[testno].setup();
-
-			/* setup common to all tests */
-			iov[0].iov_base = tdat[testno].buf;
-			iov[0].iov_len = tdat[testno].buflen;
-			msgdat.msg_name = tdat[testno].from;
-			msgdat.msg_namelen = tdat[testno].fromlen;
-			msgdat.msg_iov = tdat[testno].iov;
-			msgdat.msg_iovlen = tdat[testno].iovcnt;
-			msgdat.msg_control = control;
-			msgdat.msg_controllen = controllen;
-			msgdat.msg_flags = 0;
-
-			TEST(recvmsg(s, tdat[testno].msg, tdat[testno].flags));
-			if (TEST_RETURN >= 0)
-				TEST_RETURN = 0;	/* all nonzero equal here */
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
+	tc->setup(n);
+
+	iov[0].iov_base = tc->recv_buf;
+	iov[0].iov_len = tc->buflen;
+	msgdat.msg_name = tc->from;
+	msgdat.msg_namelen = tc->fromlen;
+	msgdat.msg_iov = tc->iov;
+	msgdat.msg_iovlen = tc->iovcnt;
+	msgdat.msg_control = control;
+	msgdat.msg_controllen = controllen;
+	msgdat.msg_flags = 0;
+
+	TEST(recvmsg(sock, tc->msg, tc->flags));
+	if (TST_RET >= 0)
+		TST_RET = 0;
+
+	if (TST_RET != tc->ret) {
+		tst_res(TFAIL | TTERRNO, "%s: expected %d, returned %ld",
+			tc->desc, tc->ret, TST_RET);
+	} else if (TST_ERR != tc->exp_errno) {
+		tst_res(TFAIL | TTERRNO,
+			"%s: expected %s",
+			tc->desc, tst_strerrno(tc->exp_errno));
+	} else {
+		tst_res(TPASS, "%s passed", tc->desc);
 	}
-	cleanup();
 
-	tst_exit();
+	tc->cleanup(n);
+	cleanup_all();
 }
 
-pid_t pid;
-char tmpsunpath[1024];
 
-void setup(void)
+static void setup_all(void)
 {
 	int tfd;
-	TEST_PAUSE;
 
-	tst_tmpdir();
+	sun1.sun_family = AF_UNIX;
+
 	(void)strcpy(tmpsunpath, "udsockXXXXXX");
 	tfd = mkstemp(tmpsunpath);
-	close(tfd);
-	unlink(tmpsunpath);
-	sun1.sun_family = AF_UNIX;
+	SAFE_CLOSE(tfd);
+	SAFE_UNLINK(tmpsunpath);
 	(void)strcpy(sun1.sun_path, tmpsunpath);
-
-	signal(SIGPIPE, SIG_IGN);
-
+	SAFE_SIGNAL(SIGPIPE, SIG_IGN);
 	pid = start_server(&sin1, &sun1);
 }
 
-void cleanup(void)
+static void cleanup_all(void)
 {
 	if (pid > 0) {
 		(void)kill(pid, SIGKILL);	/* kill server */
 		wait(NULL);
 	}
 	if (tmpsunpath[0] != '\0')
-		(void)unlink(tmpsunpath);
-	tst_rmdir();
-
+		(void)SAFE_UNLINK(tmpsunpath);
 }
 
-void setup0(void)
+static void setup_invalid_sock(int n)
 {
-	if (tdat[testno].experrno == EBADF)
-		s = 400;	/* anything not an open file */
-	else if ((s = open("/dev/null", O_WRONLY)) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open(/dev/null) failed");
+	if (tcases[n].exp_errno == EBADF)
+		sock = 400;	/* anything not an open file */
+	else
+		sock = SAFE_OPEN("/dev/null", O_WRONLY);
 }
 
-void cleanup0(void)
+static void cleanup_invalid_sock(int n)
 {
-	s = -1;
+	if (tcases[n].exp_errno == EBADF)
+		sock = -1;
+	else
+		SAFE_CLOSE(sock);
 }
 
-void setup1(void)
+static void setup_valid_sock(int n)
 {
 	fd_set rdfds;
 	struct timeval timeout;
-	int n;
 
-	s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
-			tdat[testno].proto);
-	if (tdat[testno].type == SOCK_STREAM) {
-		if (tdat[testno].domain == PF_INET) {
-			SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sin1,
+	sock = SAFE_SOCKET(tcases[n].domain, tcases[n].type,
+			tcases[n].protocol);
+	if (tcases[n].type == SOCK_STREAM) {
+		if (tcases[n].domain == PF_INET) {
+			SAFE_CONNECT(sock, (struct sockaddr *)&sin1,
 				     sizeof(sin1));
 			/* Wait for something to be readable, else we won't detect EFAULT on recv */
 			FD_ZERO(&rdfds);
-			FD_SET(s, &rdfds);
+			FD_SET(sock, &rdfds);
 			timeout.tv_sec = 2;
 			timeout.tv_usec = 0;
-			n = select(s + 1, &rdfds, 0, 0, &timeout);
-			if (n != 1 || !FD_ISSET(s, &rdfds))
-				tst_brkm(TBROK, cleanup,
-					 "client setup1 failed - no message ready in 2 sec");
-		} else if (tdat[testno].domain == PF_UNIX) {
-			SAFE_CONNECT(cleanup, s, (struct sockaddr *)&sun1,
+			n = select(sock + 1, &rdfds, 0, 0, &timeout);
+			if (n != 1 || !FD_ISSET(sock, &rdfds))
+				tst_brk(TBROK, "no message ready in 2 sec");
+		} else if (tcases[n].domain == PF_UNIX) {
+			SAFE_CONNECT(sock, (struct sockaddr *)&sun1,
 				     sizeof(sun1));
 		}
 	}
 }
 
-void setup2(void)
+static void setup_valid_msg_control(int n)
 {
-	setup1();
-	if (write(s, "R", 1) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "test setup failed: write:");
+	setup_valid_sock(n);
+	SAFE_SEND(1, sock, "R", 1, 0);
 	control = (struct cmsghdr *)cbuf;
 	controllen = control->cmsg_len = sizeof(cbuf);
 }
 
-void setup3(void)
+static void setup_large_msg_control(int n)
 {
-	setup2();
-	controllen = sizeof(struct cmsghdr) - 1;
+	setup_valid_msg_control(n);
+	controllen = CONTROL_LEN;
 }
 
-void setup4(void)
+static void cleanup_close_sock(int n)
 {
-	setup2();
-	controllen = 128 * 1024;
+	SAFE_CLOSE(sock);
 }
 
-void cleanup1(void)
+static void cleanup_reset_all(int n)
 {
-	(void)close(s);
-	close(ufd);
-	close(sfd);
-	s = -1;
-}
+	SAFE_CLOSE(sock);
 
-void cleanup2(void)
-{
-	close(ufd);
-	close(sfd);
-	(void)close(s);
-	s = -1;
-
-	if (passed_fd >= 0)
-		(void)close(passed_fd);
-	passed_fd = -1;
 	control = 0;
 	controllen = 0;
 }
@@ -373,63 +372,70 @@ pid_t start_server(struct sockaddr_in *ssin, struct sockaddr_un *ssun)
 	ssin->sin_addr.s_addr = INADDR_ANY;
 
 	/* set up inet socket */
-	sfd = socket(PF_INET, SOCK_STREAM, 0);
-	if (sfd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server socket failed");
-		return -1;
-	}
-	if (bind(sfd, (struct sockaddr *)ssin, sizeof(*ssin)) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server bind failed");
-		return -1;
-	}
-	if (listen(sfd, 10) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server listen failed");
-		return -1;
-	}
-	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)ssin, &slen);
+	sfd = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
+	SAFE_BIND(sfd, (struct sockaddr *)ssin, sizeof(*ssin));
+	SAFE_LISTEN(sfd, 10);
+	SAFE_GETSOCKNAME(sfd, (struct sockaddr *)ssin, &slen);
 
 	/* set up UNIX-domain socket */
-	ufd = socket(PF_UNIX, SOCK_STREAM, 0);
-	if (ufd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server UD socket failed");
-		return -1;
-	}
-	if (bind(ufd, (struct sockaddr *)ssun, sizeof(*ssun))) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server UD bind failed");
-		return -1;
-	}
-	if (listen(ufd, 10) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "server UD listen failed");
-		return -1;
-	}
+	ufd = SAFE_SOCKET(PF_UNIX, SOCK_STREAM, 0);
+	SAFE_BIND(ufd, (struct sockaddr *)ssun, sizeof(*ssun));
+	SAFE_LISTEN(ufd, 10);
 
-	switch ((pid = FORK_OR_VFORK())) {
-	case 0:		/* child */
-#ifdef UCLINUX
-		if (self_exec(argv0, "dd", sfd, ufd) < 0)
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "server self_exec failed");
-#else
+	pid = SAFE_FORK();
+	if (!pid) {
 		do_child();
-#endif
-		break;
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "server fork failed");
-		/* fall through */
-	default:		/* parent */
-		(void)close(sfd);
-		(void)close(ufd);
-		return pid;
+		exit(1);
 	}
-	exit(1);
+
+	SAFE_CLOSE(sfd);
+	SAFE_CLOSE(ufd);
+
+	return pid;
 }
 
-void do_child(void)
+/* special for rights-passing test */
+static void sender(int fd)
+{
+	struct msghdr mh = {};
+	struct cmsghdr *control;
+	char tmpfn[BUF_SIZE] = "";
+	char snd_cbuf[BUF_SIZE] = "";
+	int tfd;
+
+	(void)strcpy(tmpfn, "smtXXXXXX");
+	tfd = mkstemp(tmpfn);
+	if (tfd < 0)
+		return;
+
+	/* set up cmsghdr */
+	control = (struct cmsghdr *)snd_cbuf;
+	control->cmsg_len = sizeof(struct cmsghdr) + 4;
+	control->cmsg_level = SOL_SOCKET;
+	control->cmsg_type = SCM_RIGHTS;
+	*(int *)CMSG_DATA(control) = tfd;
+
+	/* set up msghdr */
+	iov[0].iov_base = MSG;
+	iov[0].iov_len = sizeof(MSG);
+	mh.msg_iov = iov;
+	mh.msg_iovlen = 1;
+	mh.msg_flags = 0;
+	mh.msg_control = control;
+	mh.msg_controllen = control->cmsg_len;
+
+	/* do it */
+	SAFE_SENDMSG(sizeof(MSG), fd, &mh, 0);
+	SAFE_CLOSE(tfd);
+	(void)SAFE_UNLINK(tmpfn);
+}
+
+static void do_child(void)
 {
 	struct sockaddr_in fsin;
 	struct sockaddr_un fsun;
 	fd_set afds, rfds;
-	int nfds, cc, fd;
+	int nfds, fd;
 
 	FD_ZERO(&afds);
 	FD_SET(sfd, &afds);
@@ -455,19 +461,19 @@ void do_child(void)
 			int newfd;
 
 			fromlen = sizeof(fsin);
-			newfd = accept(sfd, (struct sockaddr *)&fsin, &fromlen);
+			newfd = SAFE_ACCEPT(sfd, (struct sockaddr *)&fsin, &fromlen);
 			if (newfd >= 0) {
 				FD_SET(newfd, &afds);
 				nfds = MAX(nfds, newfd + 1);
 				/* send something back */
-				(void)write(newfd, "hoser\n", 6);
+				SAFE_SEND(1, newfd, "hi", 2, 0);
 			}
 		}
 		if (FD_ISSET(ufd, &rfds)) {
 			int newfd;
 
 			fromlen = sizeof(fsun);
-			newfd = accept(ufd, (struct sockaddr *)&fsun, &fromlen);
+			newfd = SAFE_ACCEPT(ufd, (struct sockaddr *)&fsun, &fromlen);
 			if (newfd >= 0) {
 				FD_SET(newfd, &afds);
 				nfds = MAX(nfds, newfd + 1);
@@ -475,55 +481,22 @@ void do_child(void)
 		}
 		for (fd = 0; fd < nfds; ++fd)
 			if (fd != sfd && fd != ufd && FD_ISSET(fd, &rfds)) {
-				char rbuf[1024];
+				char rbuf[BUF_SIZE];
 
-				cc = read(fd, rbuf, sizeof(rbuf));
-				if (cc && rbuf[0] == 'R')
+				TEST(read(fd, rbuf, sizeof(rbuf)));
+				if (TST_RET > 0 && rbuf[0] == 'R')
 					sender(fd);
-				if (cc == 0 || (cc < 0 && errno != EINTR)) {
-					(void)close(fd);
+				if (TST_RET == 0 || (TST_RET < 0 && TST_ERR != EINTR)) {
+					close(fd);
 					FD_CLR(fd, &afds);
 				}
 			}
 	}
 }
 
-#define TM	"from recvmsg01 server"
-
-/* special for rights-passing test */
-void sender(int fd)
-{
-	struct msghdr mh;
-	struct cmsghdr *control;
-	char tmpfn[1024], snd_cbuf[1024];
-	int tfd;
-
-	(void)strcpy(tmpfn, "smtXXXXXX");
-	tfd = mkstemp(tmpfn);
-	if (tfd < 0)
-		return;
-
-	memset(&mh, 0x00, sizeof(mh));
-
-	/* set up cmsghdr */
-	control = (struct cmsghdr *)snd_cbuf;
-	memset(control, 0x00, sizeof(struct cmsghdr));
-	control->cmsg_len = sizeof(struct cmsghdr) + 4;
-	control->cmsg_level = SOL_SOCKET;
-	control->cmsg_type = SCM_RIGHTS;
-	*(int *)CMSG_DATA(control) = tfd;
-
-	/* set up msghdr */
-	iov[0].iov_base = TM;
-	iov[0].iov_len = sizeof(TM);
-	mh.msg_iov = iov;
-	mh.msg_iovlen = 1;
-	mh.msg_flags = 0;
-	mh.msg_control = control;
-	mh.msg_controllen = control->cmsg_len;
-
-	/* do it */
-	(void)sendmsg(fd, &mh, 0);
-	(void)close(tfd);
-	(void)unlink(tmpfn);
-}
+static struct tst_test test = {
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
+	.needs_tmpdir = 1,
+};
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
