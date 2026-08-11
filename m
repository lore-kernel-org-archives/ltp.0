Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5797C5B56A
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 15:53:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 534303D0E8E
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 17:53:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F74F3D0835
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 17:52:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A3AB76001E0
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 17:52:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 243B981DBB;
 Tue, 11 Aug 2026 15:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786463541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRgJyn0UGv0TS2IWbd+Om3iiSHRn/8iPdNjWXL2UXc4=;
 b=lYJk7TWhagDPQ0DH8NTE4V9TW+xlnL9cW0q7hk7vg4Py6uAME+weeCb89XWpyOhUIyDLUI
 p+sFecymxutAcfpk3RoOyl3RTO/2Xasa2pIPoeMOn4tuWxXZiLSHSKg+zmNqW7nLpIgHoP
 dkGEW4E8SA2zMGa1hfG9BO187/fCh+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786463541;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRgJyn0UGv0TS2IWbd+Om3iiSHRn/8iPdNjWXL2UXc4=;
 b=B5CMr24SbcLKHOGn+/0IOeUb0fMW/bzKpGw2cnGIKQPjnvqhNxCz0AFld2bKNODlBtdSFH
 JVrZtjzFmUuBXmCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786463537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRgJyn0UGv0TS2IWbd+Om3iiSHRn/8iPdNjWXL2UXc4=;
 b=rvcue2KMNNWqfc/YwrgJOtpw/0FA2y8fcSxWR6NCsxKhSGCczmduEzhIkGCFrb2mKa7BMD
 t4MYtucjezpM8mMzplG1ONCVN8wPI4r7Jvphl0eHjSsGj/Fq/uQZBKiGHp1fL/zLFnfGNq
 vvZe98xn0ZF0HyLN7lE3bHqpDqbzT9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786463537;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pRgJyn0UGv0TS2IWbd+Om3iiSHRn/8iPdNjWXL2UXc4=;
 b=R8hRh+pROsYMfQ7R1YhkwBsvHT+ydQgb5Vpc4Jlv5D7D7kKjetsHzrHQ1QvmXZ5TAY4I9o
 EXNgoHmQQKrQZvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9AD8779BF;
 Tue, 11 Aug 2026 15:52:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wNFEKS1Fe2rldAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Aug 2026 15:52:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 11 Aug 2026 17:52:01 +0200
Message-ID: <20260811155202.1744316-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260811155202.1744316-1-pvorel@suse.cz>
References: <20260811155202.1744316-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] tree: Use TST_EXP_PASS_OR_FAIL() and
 TST_EXP_FD_OR_FAIL()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Shorten code with test macros.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/access/access01.c   |   9 +-
 .../kernel/syscalls/arch_prctl/arch_prctl01.c |   9 +-
 testcases/kernel/syscalls/bind/bind01.c       |   9 +-
 .../kernel/syscalls/epoll_ctl/epoll_ctl06.c   |  12 +-
 .../syscalls/finit_module/finit_module01.c    |   7 +-
 .../syscalls/init_module/init_module01.c      |   7 +-
 .../kernel/syscalls/landlock/landlock08.c     |  18 +--
 .../kernel/syscalls/landlock/landlock09.c     |  10 +-
 .../kernel/syscalls/landlock/landlock10.c     |   8 +-
 .../syscalls/landlock/landlock_tester.h       | 129 ++++++------------
 10 files changed, 66 insertions(+), 152 deletions(-)

diff --git a/testcases/kernel/syscalls/access/access01.c b/testcases/kernel/syscalls/access/access01.c
index 66907d1279..e8d81b392f 100644
--- a/testcases/kernel/syscalls/access/access01.c
+++ b/testcases/kernel/syscalls/access/access01.c
@@ -236,13 +236,8 @@ static struct tcase {
 
 static void access_test(struct tcase *tc, const char *user)
 {
-	if (tc->exp_errno) {
-		TST_EXP_FAIL(access(tc->fname, tc->mode), tc->exp_errno,
-		             "access(%s, %s) as %s", tc->fname, tc->name, user);
-	} else {
-		TST_EXP_PASS(access(tc->fname, tc->mode),
-		             "access(%s, %s) as %s", tc->fname, tc->name, user);
-	}
+	TST_EXP_PASS_OR_FAIL(access(tc->fname, tc->mode), tc->exp_errno,
+				 "access(%s, %s) as %s", tc->fname, tc->name, user);
 }
 
 static void verify_access(unsigned int n)
diff --git a/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
index 8ce905c6ce..851a5cf50a 100644
--- a/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
+++ b/testcases/kernel/syscalls/arch_prctl/arch_prctl01.c
@@ -50,10 +50,9 @@ static void setup(void)
 
 static void run(unsigned int index)
 {
-	if (tag)
-		TST_EXP_PASS(arch_prctl_set(ARCH_SET_CPUID, index));
-	else
-		TST_EXP_FAIL(arch_prctl_set(ARCH_SET_CPUID, index), ENODEV);
+	int err = tag ? 0 : ENODEV;
+
+	TST_EXP_PASS_OR_FAIL(arch_prctl_set(ARCH_SET_CPUID, index), err);
 
 	// if cpu has cpuid_fault flag, ARCH_GET_CPUID returns what has been
 	// set: index, otherwise, returns default status: 1
@@ -61,7 +60,7 @@ static void run(unsigned int index)
 
 	TEST(arch_prctl_get(ARCH_GET_CPUID));
 	if (TST_RET == exp)
-		tst_res(TPASS, "get cpuid succeed.");
+		tst_res(TPASS, "get cpuid succeed");
 	else
 		tst_res(TFAIL, "get wrong cpuid status");
 }
diff --git a/testcases/kernel/syscalls/bind/bind01.c b/testcases/kernel/syscalls/bind/bind01.c
index 1bf55e898d..7f27bf3b7c 100644
--- a/testcases/kernel/syscalls/bind/bind01.c
+++ b/testcases/kernel/syscalls/bind/bind01.c
@@ -69,12 +69,9 @@ static void verify_bind(unsigned int nr)
 {
 	struct test_case *tcase = &tcases[nr];
 
-	if (tcase->experrno) {
-		TST_EXP_FAIL(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen),
-				tcase->experrno, "%s", tcase->desc);
-	} else {
-		TST_EXP_PASS(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen),
-				"%s", tcase->desc);
+	TST_EXP_PASS_OR_FAIL(bind(*tcase->socket_fd, tcase->sockaddr, tcase->salen),
+			tcase->experrno, "%s", tcase->desc);
+	if (TST_PASS) {
 		SAFE_CLOSE(inet_socket);
 		inet_socket = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
 	}
diff --git a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
index a06d996e02..69321582f1 100644
--- a/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
+++ b/testcases/kernel/syscalls/epoll_ctl/epoll_ctl06.c
@@ -52,15 +52,9 @@ static void run(void)
 		ev.data.fd = fd.fd;
 		err = exp_errno(fd.type);
 
-		if (err) {
-			TST_EXP_FAIL(epoll_ctl(efd, EPOLL_CTL_ADD,
-				     fd.fd, &ev), err,
-				     "epoll_ctl() on %s", tst_fd_desc(&fd));
-		} else {
-			TST_EXP_PASS(epoll_ctl(efd, EPOLL_CTL_ADD,
-				     fd.fd, &ev),
-				     "epoll_ctl() on %s", tst_fd_desc(&fd));
-		}
+		TST_EXP_PASS_OR_FAIL(epoll_ctl(efd, EPOLL_CTL_ADD,
+				 fd.fd, &ev), err,
+				 "epoll_ctl() on %s", tst_fd_desc(&fd));
 
 		SAFE_CLOSE(efd);
 	}
diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
index 397d5a1ae4..ec14a42588 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module01.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -34,12 +34,9 @@ static void setup(void)
 
 static void run(void)
 {
-	if (sig_enforce == 1) {
-		TST_EXP_FAIL(finit_module(fd, "status=valid", 0), EKEYREJECTED);
-		return;
-	}
+	int err = sig_enforce == 1 ? EKEYREJECTED : 0;
 
-	TST_EXP_PASS(finit_module(fd, "status=valid", 0));
+	TST_EXP_PASS_OR_FAIL(finit_module(fd, "status=valid", 0), err);
 	if (!TST_PASS)
 		return;
 
diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
index a0d4792c95..171e360f89 100644
--- a/testcases/kernel/syscalls/init_module/init_module01.c
+++ b/testcases/kernel/syscalls/init_module/init_module01.c
@@ -39,12 +39,9 @@ static void setup(void)
 
 static void run(void)
 {
-	if (sig_enforce == 1) {
-		TST_EXP_FAIL(init_module(buf, sb.st_size, "status=valid"), EKEYREJECTED);
-		return;
-	}
+	int err = sig_enforce == 1 ? EKEYREJECTED : 0;
 
-	TST_EXP_PASS(init_module(buf, sb.st_size, "status=valid"));
+	TST_EXP_PASS_OR_FAIL(init_module(buf, sb.st_size, "status=valid"), err);
 	if (!TST_PASS)
 		return;
 
diff --git a/testcases/kernel/syscalls/landlock/landlock08.c b/testcases/kernel/syscalls/landlock/landlock08.c
index 770061ba0b..052b016be6 100644
--- a/testcases/kernel/syscalls/landlock/landlock08.c
+++ b/testcases/kernel/syscalls/landlock/landlock08.c
@@ -102,13 +102,8 @@ static void test_bind(const struct tcase *tc, const in_port_t port, const int ex
 	create_socket(&socket, tc->family, port, tc->type);
 	getsocket_addr(&socket, tc->family, &addr);
 
-	if (exp_err) {
-		TST_EXP_FAIL(bind(socket.fd, addr, socket.address_size),
-			     exp_err, "bind() access on port %u", port);
-	} else {
-		TST_EXP_PASS(bind(socket.fd, addr, socket.address_size),
-			     "bind() access on port %u", port);
-	}
+	TST_EXP_PASS_OR_FAIL(bind(socket.fd, addr, socket.address_size),
+		exp_err, "bind() access on port %u", port);
 
 	SAFE_CLOSE(socket.fd);
 }
@@ -121,13 +116,8 @@ static void test_connect(const struct tcase *tc, const in_port_t port, const int
 	create_socket(&socket, tc->family, port, tc->type);
 	getsocket_addr(&socket, tc->family, &addr);
 
-	if (exp_err) {
-		TST_EXP_FAIL(connect(socket.fd, addr, socket.address_size),
-			     exp_err, "connect() on port %u", port);
-	} else {
-		TST_EXP_PASS(connect(socket.fd, addr, socket.address_size),
-			     "connect() on port %u", port);
-	}
+	TST_EXP_PASS_OR_FAIL(connect(socket.fd, addr, socket.address_size),
+		exp_err, "connect() on port %u", port);
 
 	SAFE_CLOSE(socket.fd);
 }
diff --git a/testcases/kernel/syscalls/landlock/landlock09.c b/testcases/kernel/syscalls/landlock/landlock09.c
index 09a762bb1b..c2d73a7085 100644
--- a/testcases/kernel/syscalls/landlock/landlock09.c
+++ b/testcases/kernel/syscalls/landlock/landlock09.c
@@ -35,6 +35,8 @@ static void scoped_sandbox(const char *from)
 
 static void run_client(void)
 {
+	int err = tst_variant == DOMAIN_CLIENT ? EPERM : 0;
+
 	if (tst_variant == DOMAIN_CLIENT)
 		scoped_sandbox("client");
 
@@ -47,14 +49,8 @@ static void run_client(void)
 	TST_CHECKPOINT_WAIT(0);
 
 	tst_res(TINFO, "Connecting to UNIX socket");
-
 	sendsock = SAFE_SOCKET(AF_UNIX, SOCK_STREAM, 0);
-
-	if (tst_variant != DOMAIN_CLIENT)
-		TST_EXP_PASS(connect(sendsock, (struct sockaddr *)&addr, SOCKET_LENGTH));
-	else
-		TST_EXP_FAIL(connect(sendsock, (struct sockaddr *)&addr, SOCKET_LENGTH), EPERM);
-
+	TST_EXP_PASS_OR_FAIL(connect(sendsock, (struct sockaddr *)&addr, SOCKET_LENGTH), err);
 	SAFE_CLOSE(sendsock);
 
 	TST_CHECKPOINT_WAKE(0);
diff --git a/testcases/kernel/syscalls/landlock/landlock10.c b/testcases/kernel/syscalls/landlock/landlock10.c
index a29e3bca82..96ee40bc79 100644
--- a/testcases/kernel/syscalls/landlock/landlock10.c
+++ b/testcases/kernel/syscalls/landlock/landlock10.c
@@ -30,6 +30,8 @@ static void scoped_sandbox(const char *from)
 
 static void run(void)
 {
+	int err = tst_variant == DOMAIN_KILLER ? EPERM : 0;
+
 	/* isolate test inside a process so we won't stack too many
 	 * layers (-E2BIG) when there are multiple test's iterations
 	 */
@@ -62,11 +64,7 @@ static void run(void)
 
 		TST_CHECKPOINT_WAKE(0);
 
-		if (tst_variant == DOMAIN_KILLER)
-			TST_EXP_FAIL(kill(paused_pid, SIGKILL), EPERM);
-		else
-			TST_EXP_PASS(kill(paused_pid, SIGKILL));
-
+		TST_EXP_PASS_OR_FAIL(kill(paused_pid, SIGKILL), err);
 		exit(0);
 	}
 
diff --git a/testcases/kernel/syscalls/landlock/landlock_tester.h b/testcases/kernel/syscalls/landlock/landlock_tester.h
index 4e77e8a61f..3e2abd2e78 100644
--- a/testcases/kernel/syscalls/landlock/landlock_tester.h
+++ b/testcases/kernel/syscalls/landlock/landlock_tester.h
@@ -145,7 +145,7 @@ static void tester_cleanup_files(void)
 	_remove_file(FILE_REGULAR);
 }
 
-static void _test_exec(const int result)
+static void _test_exec(const int exp_err)
 {
 	int status;
 	pid_t pid;
@@ -155,16 +155,7 @@ static void _test_exec(const int result)
 
 	pid = SAFE_FORK();
 	if (!pid) {
-		int rval;
-
-		if (result == TPASS) {
-			rval = execve(FILE_EXEC, args, NULL);
-			if (rval == -1)
-				tst_res(TFAIL | TERRNO, "Failed to execute test binary");
-		} else {
-			TST_EXP_FAIL(execve(FILE_EXEC, args, NULL), EACCES);
-		}
-
+		TST_EXP_PASS_OR_FAIL(execve(FILE_EXEC, args, NULL), exp_err);
 		_exit(1);
 	}
 
@@ -172,31 +163,23 @@ static void _test_exec(const int result)
 	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 		return;
 
-	tst_res(result, "Test binary has been executed");
+	tst_res(exp_err ? TFAIL : TPASS, "Test binary has been executed");
 }
 
-static void _test_write(const int result)
+static void _test_write(const int exp_err)
 {
 	tst_res(TINFO, "Test writing file");
 
-	if (result == TPASS)
-		TST_EXP_FD(open(FILE_WRITE, O_WRONLY, PERM_MODE));
-	else
-		TST_EXP_FAIL(open(FILE_WRITE, O_WRONLY, PERM_MODE), EACCES);
-
+	TST_EXP_FD_OR_FAIL(open(FILE_WRITE, O_WRONLY, PERM_MODE), exp_err);
 	if (TST_RET != -1)
 		SAFE_CLOSE(TST_RET);
 }
 
-static void _test_read(const int result)
+static void _test_read(const int exp_err)
 {
 	tst_res(TINFO, "Test reading file");
 
-	if (result == TPASS)
-		TST_EXP_FD(open(FILE_READ, O_RDONLY, PERM_MODE));
-	else
-		TST_EXP_FAIL(open(FILE_READ, O_RDONLY, PERM_MODE), EACCES);
-
+	TST_EXP_FD_OR_FAIL(open(FILE_READ, O_RDONLY, PERM_MODE), exp_err);
 	if (TST_RET != -1)
 		SAFE_CLOSE(TST_RET);
 }
@@ -239,122 +222,90 @@ static void _test_readdir(const int result)
 	TST_EXP_EQ_LI(files_counted, ARRAY_SIZE(readdir_files));
 }
 
-static void _test_rmdir(const int result)
+static void _test_rmdir(const int exp_err)
 {
 	tst_res(TINFO, "Test removing directory");
-
-	if (result == TPASS)
-		TST_EXP_PASS(rmdir(DIR_RMDIR));
-	else
-		TST_EXP_FAIL(rmdir(DIR_RMDIR), EACCES);
+	TST_EXP_PASS_OR_FAIL(rmdir(DIR_RMDIR), exp_err);
 }
 
-static void _test_rmfile(const int result)
+static void _test_rmfile(const int exp_err)
 {
 	tst_res(TINFO, "Test removing file");
-
-	if (result == TPASS) {
-		TST_EXP_PASS(unlink(FILE_UNLINK));
-		TST_EXP_PASS(remove(FILE_REMOVE));
-	} else {
-		TST_EXP_FAIL(unlink(FILE_UNLINK), EACCES);
-		TST_EXP_FAIL(remove(FILE_REMOVE), EACCES);
-	}
+	TST_EXP_PASS_OR_FAIL(unlink(FILE_UNLINK), exp_err);
+	TST_EXP_PASS_OR_FAIL(remove(FILE_REMOVE), exp_err);
 }
 
-static void _test_make(const char *path, const int type, const int dev, const int result)
+static void _test_make(const char *path, const int type, const int dev, const int exp_err)
 {
 	tst_res(TINFO, "Test normal or special files creation");
-
-	if (result == TPASS)
-		TST_EXP_PASS(mknod(path, type | 0400, dev));
-	else
-		TST_EXP_FAIL(mknod(path, type | 0400, dev), EACCES);
+	TST_EXP_PASS_OR_FAIL(mknod(path, type | 0400, dev), exp_err);
 }
 
-static void _test_symbolic(const int result)
+static void _test_symbolic(const int exp_err)
 {
 	tst_res(TINFO, "Test symbolic links");
-
-	if (result == TPASS)
-		TST_EXP_PASS(symlink(FILE_SYM0, FILE_SYM1));
-	else
-		TST_EXP_FAIL(symlink(FILE_SYM0, FILE_SYM1), EACCES);
+	TST_EXP_PASS_OR_FAIL(symlink(FILE_SYM0, FILE_SYM1), exp_err);
 }
 
-static void _test_truncate(const int result)
+static void _test_truncate(const int exp_err)
 {
 	int fd;
 
 	tst_res(TINFO, "Test truncating file");
 
-	if (result == TPASS) {
-		TST_EXP_PASS(truncate(FILE_TRUNCATE, 10));
-
-		fd = SAFE_OPEN(FILE_TRUNCATE, O_WRONLY, PERM_MODE);
-		if (fd != -1) {
-			TST_EXP_PASS(ftruncate(fd, 10));
-			SAFE_CLOSE(fd);
-		}
-
-		fd = TST_EXP_FD(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE));
-		if (fd != -1)
-			SAFE_CLOSE(fd);
-	} else {
-		TST_EXP_FAIL(truncate(FILE_TRUNCATE, 10), EACCES);
-
-		fd = open(FILE_TRUNCATE, O_WRONLY, PERM_MODE);
-		if (fd != -1) {
-			TST_EXP_FAIL(ftruncate(fd, 10), EACCES);
-			SAFE_CLOSE(fd);
-		}
-
-		TST_EXP_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), EACCES);
-
-		if (TST_RET != -1)
-			SAFE_CLOSE(TST_RET);
+	TST_EXP_PASS_OR_FAIL(truncate(FILE_TRUNCATE, 10), exp_err);
+	TST_EXP_FD_OR_FAIL(fd = open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
+	if (fd != -1) {
+		TST_EXP_PASS_OR_FAIL(ftruncate(fd, 10), exp_err);
+		SAFE_CLOSE(fd);
 	}
+
+	TST_EXP_FD_OR_FAIL(fd = open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
+	if (fd != -1)
+		SAFE_CLOSE(TST_RET);
 }
 
 static void tester_run_fs_rules(const int rules, const int result)
 {
+	int exp_err = result == TPASS ? 0 : EACCES;
+
 	if (rules & LANDLOCK_ACCESS_FS_EXECUTE)
-		_test_exec(result);
+		_test_exec(exp_err);
 
 	if (rules & LANDLOCK_ACCESS_FS_WRITE_FILE)
-		_test_write(result);
+		_test_write(exp_err);
 
 	if (rules & LANDLOCK_ACCESS_FS_READ_FILE)
-		_test_read(result);
+		_test_read(exp_err);
 
 	if (rules & LANDLOCK_ACCESS_FS_READ_DIR)
 		_test_readdir(result);
 
 	if (rules & LANDLOCK_ACCESS_FS_REMOVE_DIR)
-		_test_rmdir(result);
+		_test_rmdir(exp_err);
 
 	if (rules & LANDLOCK_ACCESS_FS_REMOVE_FILE)
-		_test_rmfile(result);
+		_test_rmfile(exp_err);
 
 	if (rules & LANDLOCK_ACCESS_FS_MAKE_REG)
-		_test_make(FILE_REGULAR, S_IFREG, 0, result);
+		_test_make(FILE_REGULAR, S_IFREG, 0, exp_err);
 
 	if (strcmp(tst_device->fs_type, "vfat") &&
 	    strcmp(tst_device->fs_type, "exfat")) {
 		if (rules & LANDLOCK_ACCESS_FS_MAKE_CHAR)
-			_test_make(DEV_CHAR0, S_IFCHR, dev_chr, result);
+			_test_make(DEV_CHAR0, S_IFCHR, dev_chr, exp_err);
 
 		if (rules & LANDLOCK_ACCESS_FS_MAKE_BLOCK)
-			_test_make(DEV_BLK0, S_IFBLK, dev_blk, result);
+			_test_make(DEV_BLK0, S_IFBLK, dev_blk, exp_err);
 
 		if (rules & LANDLOCK_ACCESS_FS_MAKE_SOCK)
-			_test_make(FILE_SOCKET, S_IFSOCK, 0, result);
+			_test_make(FILE_SOCKET, S_IFSOCK, 0, exp_err);
 
 		if (rules & LANDLOCK_ACCESS_FS_MAKE_FIFO)
-			_test_make(FILE_FIFO, S_IFIFO, 0, result);
+			_test_make(FILE_FIFO, S_IFIFO, 0, exp_err);
 
 		if (rules & LANDLOCK_ACCESS_FS_MAKE_SYM)
-			_test_symbolic(result);
+			_test_symbolic(exp_err);
 	}
 
 	if (rules & LANDLOCK_ACCESS_FS_TRUNCATE) {
@@ -366,7 +317,7 @@ static void tester_run_fs_rules(const int rules, const int result)
 			return;
 		}
 
-		_test_truncate(result);
+		_test_truncate(exp_err);
 	}
 }
 
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
