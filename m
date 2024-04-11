Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363BBC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:35:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C18653C0333
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:35:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 238523CF828
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2A44910103BA
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 669B75CD21;
 Thu, 11 Apr 2024 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HU0Etkf3TJ92Fz6PewehDnRkpWwF05RNNyKpRpX/nIk=;
 b=wmOS8LlWrO341B+Mx6lvkoq3WxqS2h5wq3vT9lLjfXKb4j8YIvJtSkmMaH/IMn61PBClzW
 HisyKKkgEutK+uRnmlfTBMZoZjnpksGIh/tPW8U6xj8znorLtZdogUoM3D3zhumsTfyYg4
 1bYKj/g9UXy0OQy0nzvEnOrl2YRpHng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HU0Etkf3TJ92Fz6PewehDnRkpWwF05RNNyKpRpX/nIk=;
 b=vmAAoPKzEJA2dopucvuf/x5ogcfympGkkqzmS4bUJtTf5uup5hKzYf4w5ayti94Ffpe20G
 UCOXEpd9Fffa+VDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wmOS8LlW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vmAAoPKz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HU0Etkf3TJ92Fz6PewehDnRkpWwF05RNNyKpRpX/nIk=;
 b=wmOS8LlWrO341B+Mx6lvkoq3WxqS2h5wq3vT9lLjfXKb4j8YIvJtSkmMaH/IMn61PBClzW
 HisyKKkgEutK+uRnmlfTBMZoZjnpksGIh/tPW8U6xj8znorLtZdogUoM3D3zhumsTfyYg4
 1bYKj/g9UXy0OQy0nzvEnOrl2YRpHng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HU0Etkf3TJ92Fz6PewehDnRkpWwF05RNNyKpRpX/nIk=;
 b=vmAAoPKzEJA2dopucvuf/x5ogcfympGkkqzmS4bUJtTf5uup5hKzYf4w5ayti94Ffpe20G
 UCOXEpd9Fffa+VDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34E501386E;
 Thu, 11 Apr 2024 14:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6Bj/CQb0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:30 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:29:59 +0200
Message-ID: <20240411143025.352507-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 669B75CD21
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 05/31] tree: Remove FORK_OR_VFORK and tst_vfork()
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

It was defined only to support UCLINUX.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/old/Maintainer-Patch-Review-Checklist.asciidoc   |  2 +-
 include/old/test.h                                   | 12 ------------
 lib/tst_res.c                                        |  8 --------
 testcases/kernel/syscalls/connect/connect01.c        |  2 +-
 testcases/kernel/syscalls/epoll/epoll-ltp.c          |  4 ++--
 testcases/kernel/syscalls/exit/exit01.c              |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl07.c            |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl11.c            |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl14.c            |  6 +++---
 testcases/kernel/syscalls/fcntl/fcntl16.c            |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl17.c            |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl18.c            |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl19.c            |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl20.c            |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl21.c            |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl22.c            |  2 +-
 .../kernel/syscalls/ipc/msgstress/msgstress01.c      |  4 ++--
 .../kernel/syscalls/ipc/msgstress/msgstress02.c      |  6 +++---
 .../kernel/syscalls/ipc/msgstress/msgstress03.c      |  4 ++--
 .../kernel/syscalls/ipc/msgstress/msgstress04.c      |  6 +++---
 testcases/kernel/syscalls/ipc/semctl/semctl06.c      |  4 ++--
 testcases/kernel/syscalls/kill/kill02.c              |  8 ++++----
 testcases/kernel/syscalls/kill/kill07.c              |  2 +-
 testcases/kernel/syscalls/kill/kill08.c              |  4 ++--
 testcases/kernel/syscalls/kill/kill09.c              |  2 +-
 testcases/kernel/syscalls/kill/kill12.c              |  2 +-
 testcases/kernel/syscalls/modify_ldt/modify_ldt02.c  |  2 +-
 testcases/kernel/syscalls/mprotect/mprotect02.c      |  4 ++--
 testcases/kernel/syscalls/mprotect/mprotect03.c      |  2 +-
 testcases/kernel/syscalls/pause/pause02.c            |  2 +-
 testcases/kernel/syscalls/pause/pause03.c            |  2 +-
 testcases/kernel/syscalls/pipe/pipe04.c              |  4 ++--
 testcases/kernel/syscalls/pipe/pipe09.c              |  4 ++--
 testcases/kernel/syscalls/recv/recv01.c              |  2 +-
 testcases/kernel/syscalls/recvfrom/recvfrom01.c      |  2 +-
 testcases/kernel/syscalls/rename/rename14.c          |  4 ++--
 testcases/kernel/syscalls/send/send01.c              |  2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg01.c        |  2 +-
 testcases/kernel/syscalls/sendto/sendto01.c          |  2 +-
 testcases/kernel/syscalls/setfsuid/setfsuid04.c      |  4 ++--
 testcases/kernel/syscalls/setpgid/setpgid01.c        |  2 +-
 testcases/kernel/syscalls/setpgrp/setpgrp01.c        |  2 +-
 testcases/kernel/syscalls/setrlimit/setrlimit01.c    |  6 +++---
 testcases/kernel/syscalls/setsid/setsid01.c          |  6 +++---
 testcases/kernel/syscalls/sigrelse/sigrelse01.c      |  2 +-
 45 files changed, 66 insertions(+), 86 deletions(-)

diff --git a/doc/old/Maintainer-Patch-Review-Checklist.asciidoc b/doc/old/Maintainer-Patch-Review-Checklist.asciidoc
index 1cd36b3c9..9cd8606f9 100644
--- a/doc/old/Maintainer-Patch-Review-Checklist.asciidoc
+++ b/doc/old/Maintainer-Patch-Review-Checklist.asciidoc
@@ -129,7 +129,7 @@ New test should
   (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2238-test-tags[Test tags])
 * When rewriting old tests, https://en.wikipedia.org/wiki/%CE%9CClinux[uClinux]
   support should be removed (project has been discontinued).
-  E.g. remove `#ifdef UCLINUX`, replace `FORK_OR_VFORK()` with simple `fork()` or `SAFE_FORK()`.
+  E.g. remove `#ifdef UCLINUX`, replace `tst_fork()` with simple `fork()` or `SAFE_FORK()`.
 
 ### Shell tests
 * Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell[shell API]
diff --git a/include/old/test.h b/include/old/test.h
index 8ccd5f5e8..7394a365e 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -65,18 +65,6 @@
 					/* strings to control tst_res output */
 					/* If not set, TOUT_VERBOSE_S is assumed */
 
-/*
- * fork() can't be used on uClinux systems, so use FORK_OR_VFORK instead,
- * which will run vfork() on uClinux.
- */
-#ifdef UCLINUX
-# define FORK_OR_VFORK			tst_vfork
-/* tst_old_flush() + vfork() */
-pid_t tst_vfork(void);
-#else
-# define FORK_OR_VFORK			tst_fork
-#endif
-
 /*
  * Macro to use for making functions called only once in
  * multi-threaded tests such as init or cleanup function.
diff --git a/lib/tst_res.c b/lib/tst_res.c
index e87918ed1..7c66d2f6c 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -471,14 +471,6 @@ void tst_record_childstatus(void (*cleanup)(void), pid_t child)
 	}
 }
 
-pid_t tst_vfork(void)
-{
-	NO_NEWLIB_ASSERT("Unknown", 0);
-
-	tst_old_flush();
-	return vfork();
-}
-
 /*
  * Make tst_brk reentrant so that one can call the SAFE_* macros from within
  * user-defined cleanup functions.
diff --git a/testcases/kernel/syscalls/connect/connect01.c b/testcases/kernel/syscalls/connect/connect01.c
index 1c1630fa7..d901427ff 100644
--- a/testcases/kernel/syscalls/connect/connect01.c
+++ b/testcases/kernel/syscalls/connect/connect01.c
@@ -261,7 +261,7 @@ pid_t start_server(struct sockaddr_in *sin0)
 	}
 	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
-	switch ((pid = FORK_OR_VFORK())) {
+	switch ((pid = tst_fork())) {
 	case 0:		/* child */
 #ifdef UCLINUX
 		self_exec(argv0, "d", sfd);
diff --git a/testcases/kernel/syscalls/epoll/epoll-ltp.c b/testcases/kernel/syscalls/epoll/epoll-ltp.c
index 8b04f5326..dac132e2f 100644
--- a/testcases/kernel/syscalls/epoll/epoll-ltp.c
+++ b/testcases/kernel/syscalls/epoll/epoll-ltp.c
@@ -143,7 +143,7 @@ do {					\
 	int kid_status;			\
 					\
 	tst_old_flush();			\
-	kid_pid = FORK_OR_VFORK();	\
+	kid_pid = tst_fork();	\
 	if (kid_pid == 0) {
 
 #define PROTECT_REGION_EXIT(errval) return (errval);
@@ -177,7 +177,7 @@ do {					\
 	int kid_status;								\
 										\
 	tst_old_flush();								\
-	kid_pid = FORK_OR_VFORK();						\
+	kid_pid = tst_fork();						\
 	if (kid_pid == 0) { /* Run the function */				\
 		return fn(epoll_fd);						\
 	} else {								\
diff --git a/testcases/kernel/syscalls/exit/exit01.c b/testcases/kernel/syscalls/exit/exit01.c
index 1c15f43b0..ca62dba49 100644
--- a/testcases/kernel/syscalls/exit/exit01.c
+++ b/testcases/kernel/syscalls/exit/exit01.c
@@ -52,7 +52,7 @@ int main(int ac, char **av)
 		sig = 0;
 		exno = 1;
 
-		pid = FORK_OR_VFORK();
+		pid = tst_fork();
 
 		switch (pid) {
 		case 0:
diff --git a/testcases/kernel/syscalls/fcntl/fcntl07.c b/testcases/kernel/syscalls/fcntl/fcntl07.c
index 9108b79c1..10d1186fc 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl07.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl07.c
@@ -101,7 +101,7 @@ static void verify_cloexec(struct tcase *tc)
 
 	sprintf(pidname, "%d", fd);
 
-	switch (pid = FORK_OR_VFORK()) {
+	switch (pid = tst_fork()) {
 	case -1:
 		tst_resm(TBROK | TERRNO, "fork() failed");
 		return;
diff --git a/testcases/kernel/syscalls/fcntl/fcntl11.c b/testcases/kernel/syscalls/fcntl/fcntl11.c
index d042c6b9b..2ad3aee5e 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl11.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl11.c
@@ -257,7 +257,7 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		if ((child_pid = FORK_OR_VFORK()) == 0) {	/* parent */
+		if ((child_pid = tst_fork()) == 0) {	/* parent */
 #ifdef UCLINUX
 			if (self_exec(av[0], "ddddd", parent_pipe[0],
 				      parent_pipe[1], child_pipe[0],
diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index ca68d0f98..09f5f0954 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -738,7 +738,7 @@ void dochild(void)
 		 * need some way to have fcntl() atomically unblock a
 		 * signal and wait for the lock.)
 		 */
-		pid = FORK_OR_VFORK();
+		pid = tst_fork();
 		switch (pid) {
 		case -1:
 			tst_resm(TFAIL, "Fork failed");
@@ -828,7 +828,7 @@ void run_test(int file_flag, int file_mode, int seek, int start, int end)
 		/* flush the stdout to avoid garbled output */
 		fflush(stdout);
 
-		if ((child = FORK_OR_VFORK()) == 0) {
+		if ((child = tst_fork()) == 0) {
 #ifdef UCLINUX
 			if (self_exec(argv0, "nddddddddd", 2, thiscase->c_type,
 				      thiscase->c_whence, thiscase->c_start,
@@ -1079,7 +1079,7 @@ int main(int ac, char **av)
 		if (sighold(SIGUSR1) < 0)
 			tst_brkm(TBROK, cleanup, "sighold failed");
 
-		if ((child = FORK_OR_VFORK()) == 0) {
+		if ((child = tst_fork()) == 0) {
 #ifdef UCLINUX
 			if (self_exec(argv0, "nddddddddd", 2, thiscase->c_type,
 				      thiscase->c_whence, thiscase->c_start,
diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
index a77a81298..2d895edd2 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl16.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
@@ -497,7 +497,7 @@ int run_test(int file_flag, int file_mode, int start, int end)
 		/* spawn child processes */
 		for (i = 0; i < 2; i++) {
 			if (thislock->l_type != IGNORED) {
-				if ((child = FORK_OR_VFORK()) == 0) {
+				if ((child = tst_fork()) == 0) {
 #ifdef UCLINUX
 					if (self_exec(argv0, "ddddd", i, parent,
 						      test, thislock, fd) < 0) {
diff --git a/testcases/kernel/syscalls/fcntl/fcntl17.c b/testcases/kernel/syscalls/fcntl/fcntl17.c
index e055f1a12..35769579f 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl17.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl17.c
@@ -467,7 +467,7 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		tst_resm(TINFO, "Enter preparation phase");
-		if ((child_pid1 = FORK_OR_VFORK()) == 0) {	/* first child */
+		if ((child_pid1 = tst_fork()) == 0) {	/* first child */
 #ifdef UCLINUX
 			if (self_exec(av[0], "nddddddddd", 1, file_fd,
 				      parent_pipe[0], parent_pipe[1],
diff --git a/testcases/kernel/syscalls/fcntl/fcntl18.c b/testcases/kernel/syscalls/fcntl/fcntl18.c
index 1105dd393..6bf39b981 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl18.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl18.c
@@ -123,7 +123,7 @@ int main(int ac, char **av)
 /* //block3: */
 	tst_resm(TINFO, "Enter block 3");
 	fail = 0;
-	if ((pid = FORK_OR_VFORK()) == 0) {	/* child */
+	if ((pid = tst_fork()) == 0) {	/* child */
 		fail = 0;
 		pass = getpwnam("nobody");
 		retval = setreuid(-1, pass->pw_uid);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl19.c b/testcases/kernel/syscalls/fcntl/fcntl19.c
index f929aff99..368629d25 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl19.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl19.c
@@ -296,7 +296,7 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		if ((child_pid = FORK_OR_VFORK()) == 0) {	/* child */
+		if ((child_pid = tst_fork()) == 0) {	/* child */
 #ifdef UCLINUX
 			if (self_exec
 			    (av[0], "ddddd", parent_pipe[0], parent_pipe[1],
diff --git a/testcases/kernel/syscalls/fcntl/fcntl20.c b/testcases/kernel/syscalls/fcntl/fcntl20.c
index 4aa773451..0865140de 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl20.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl20.c
@@ -295,7 +295,7 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		if ((child_pid = FORK_OR_VFORK()) == 0) {	/* child */
+		if ((child_pid = tst_fork()) == 0) {	/* child */
 #ifdef UCLINUX
 			if (self_exec
 			    (av[0], "ddddd", parent_pipe[0], parent_pipe[1],
diff --git a/testcases/kernel/syscalls/fcntl/fcntl21.c b/testcases/kernel/syscalls/fcntl/fcntl21.c
index 824b8c059..d191a6bbd 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl21.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl21.c
@@ -303,7 +303,7 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		if ((child_pid = FORK_OR_VFORK()) == 0) {
+		if ((child_pid = tst_fork()) == 0) {
 #ifdef UCLINUX
 			if (self_exec
 			    (av[0], "ddddd", parent_pipe[0], parent_pipe[1],
diff --git a/testcases/kernel/syscalls/fcntl/fcntl22.c b/testcases/kernel/syscalls/fcntl/fcntl22.c
index 2e94a1257..507934389 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl22.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl22.c
@@ -60,7 +60,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		child_pid = FORK_OR_VFORK();
+		child_pid = tst_fork();
 		switch (child_pid) {
 		case 0:
 			TEST(fcntl(file, F_SETLK, &fl));
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 84e338437..572e43409 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -154,7 +154,7 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < nprocs; i++) {
 		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		if ((pid = tst_fork()) < 0) {
 			tst_brkm(TFAIL,
 				 NULL,
 				 "\tFork failed (may be OK if under stress)");
@@ -216,7 +216,7 @@ static int dotest(key_t key, int child_process)
 	sigrelse(SIGTERM);
 
 	fflush(stdout);
-	if ((pid = FORK_OR_VFORK()) < 0) {
+	if ((pid = tst_fork()) < 0) {
 		printf("\tFork failed (may be OK if under stress)\n");
 		TEST(msgctl(tid, IPC_RMID, 0));
 		if (TEST_RETURN < 0) {
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
index a0f894b05..ad3b0e309 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress02.c
@@ -164,7 +164,7 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < nprocs; i++) {
 		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		if ((pid = tst_fork()) < 0) {
 			tst_brkm(TFAIL,
 				 NULL,
 				 "\tFork failed (may be OK if under stress)");
@@ -249,7 +249,7 @@ static int dotest(key_t key, int child_process)
 
 	for (i = 0; i < nkids; i++) {
 		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		if ((pid = tst_fork()) < 0) {
 			printf("Fork failure in the first child of child group %d\n",
 				child_process);
 			cleanup_msgqueue(i, tid);
@@ -263,7 +263,7 @@ static int dotest(key_t key, int child_process)
 		}
 		rkidarray[i] = pid;
 		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		if ((pid = tst_fork()) < 0) {
 			printf("Fork failure in the second child of child group %d\n",
 				child_process);
 			/*
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
index aa37d9058..3ddd47be8 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress03.c
@@ -160,7 +160,7 @@ int main(int argc, char **argv)
 
 	for (i = 0; i < nprocs; i++) {
 		fflush(stdout);
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		if ((pid = tst_fork()) < 0) {
 			tst_brkm(TFAIL,
 				 NULL,
 				 "\tFork failed (may be OK if under stress)");
@@ -221,7 +221,7 @@ static int dotest(key_t key, int child_process)
 	sigrelse(SIGTERM);
 
 	fflush(stdout);
-	if ((pid = FORK_OR_VFORK()) < 0) {
+	if ((pid = tst_fork()) < 0) {
 		printf("Fork failed (may be OK if under stress)\n");
 		TEST(msgctl(tid, IPC_RMID, 0));
 		if (TEST_RETURN < 0) {
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
index b9ebf9035..bcbcf770a 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress04.c
@@ -200,7 +200,7 @@ static void dotest_iteration(int off)
 	for (i = 0; i < nprocs; i++) {
 		key = keyarray[off + i];
 
-		if ((pid = FORK_OR_VFORK()) < 0)
+		if ((pid = tst_fork()) < 0)
 			tst_brkm(TFAIL, cleanup,
 				 "Fork failed (may be OK if under stress)");
 
@@ -275,7 +275,7 @@ static int dotest(key_t key, int child_process)
 	exit_status = PASS;
 
 	for (i = 0; i < nkids; i++) {
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		if ((pid = tst_fork()) < 0) {
 			printf("Fork failure in the first child of child group %d\n",
 				child_process);
 			cleanup_msgqueue(i, tid);
@@ -288,7 +288,7 @@ static int dotest(key_t key, int child_process)
 					child_process, nreps));
 		}
 		rkidarray[i] = pid;
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		if ((pid = tst_fork()) < 0) {
 			printf("Fork failure in the second child of child group %d\n",
 				child_process);
 			/*
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl06.c b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
index b3af41fb3..b00ee89d2 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl06.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
@@ -112,7 +112,7 @@ int main(int argc, char **argv)
 	}
 
 	for (i = 0; i < NPROCS; i++) {
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		if ((pid = tst_fork()) < 0) {
 			tst_resm(TFAIL,
 				 "\tFork failed (may be OK if under stress)");
 
@@ -188,7 +188,7 @@ static void dotest(key_t key)
 	}
 
 	for (i = 0; i < NKIDS; i++) {
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		if ((pid = tst_fork()) < 0) {
 			tst_resm(TFAIL, "\tfork failed");
 		}
 		if (pid == 0)
diff --git a/testcases/kernel/syscalls/kill/kill02.c b/testcases/kernel/syscalls/kill/kill02.c
index 7ae2427c8..21aacffa1 100644
--- a/testcases/kernel/syscalls/kill/kill02.c
+++ b/testcases/kernel/syscalls/kill/kill02.c
@@ -231,8 +231,8 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		if ((pid1 = FORK_OR_VFORK()) > 0) {
-			if ((pid2 = FORK_OR_VFORK()) > 0) {
+		if ((pid1 = tst_fork()) > 0) {
+			if ((pid2 = tst_fork()) > 0) {
 				(void)parent_rout();
 			} else if (pid2 == 0) {
 #ifdef UCLINUX
@@ -452,11 +452,11 @@ void child1_rout(void)
 	/*
 	 *  Create children A & B.
 	 */
-	if ((pidA = FORK_OR_VFORK()) > 0) {
+	if ((pidA = tst_fork()) > 0) {
 		/*
 		 *  This is the parent(child1), fork again to create child B.
 		 */
-		if ((pidB = FORK_OR_VFORK()) == 0) {
+		if ((pidB = tst_fork()) == 0) {
 			/* This is child B. */
 #ifdef UCLINUX
 			if (self_exec(argv0, "nd", 2, pipeB_fd[1]) < 0) {
diff --git a/testcases/kernel/syscalls/kill/kill07.c b/testcases/kernel/syscalls/kill/kill07.c
index c566a0a09..21dd7ff4f 100644
--- a/testcases/kernel/syscalls/kill/kill07.c
+++ b/testcases/kernel/syscalls/kill/kill07.c
@@ -124,7 +124,7 @@ int main(int ac, char **av)
 		/* setup the signal handler */
 		ret = sigaction(TEST_SIG, &my_act, &old_act);
 
-		pid = FORK_OR_VFORK();
+		pid = tst_fork();
 		if (pid < 0) {
 			tst_brkm(TBROK, cleanup, "Fork of child failed");
 		} else if (pid == 0) {
diff --git a/testcases/kernel/syscalls/kill/kill08.c b/testcases/kernel/syscalls/kill/kill08.c
index b0826c2e5..d75a4db46 100644
--- a/testcases/kernel/syscalls/kill/kill08.c
+++ b/testcases/kernel/syscalls/kill/kill08.c
@@ -95,13 +95,13 @@ int main(int ac, char **av)
 		/* Fork a process and set the process group so that */
 		/* it is different from this one.  Fork 5 more children. */
 
-		pid1 = FORK_OR_VFORK();
+		pid1 = tst_fork();
 		if (pid1 < 0) {
 			tst_brkm(TBROK, cleanup, "Fork of first child failed");
 		} else if (pid1 == 0) {
 			setpgrp();
 			for (i = 0; i < 5; i++) {
-				pid2 = FORK_OR_VFORK();
+				pid2 = tst_fork();
 				if (pid2 < 0) {
 					tst_brkm(TBROK, cleanup, "Fork failed");
 				} else if (pid2 == 0) {
diff --git a/testcases/kernel/syscalls/kill/kill09.c b/testcases/kernel/syscalls/kill/kill09.c
index c5878923c..ad93c5d81 100644
--- a/testcases/kernel/syscalls/kill/kill09.c
+++ b/testcases/kernel/syscalls/kill/kill09.c
@@ -145,7 +145,7 @@ int main(int ac, char **av)
 
 		tst_count = 0;
 
-		if ((fork_pid = FORK_OR_VFORK()) == -1)
+		if ((fork_pid = tst_fork()) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "fork failed");
 
 		if (fork_pid == 0) {
diff --git a/testcases/kernel/syscalls/kill/kill12.c b/testcases/kernel/syscalls/kill/kill12.c
index 8ab641d39..f864bdcb6 100644
--- a/testcases/kernel/syscalls/kill/kill12.c
+++ b/testcases/kernel/syscalls/kill/kill12.c
@@ -95,7 +95,7 @@ int main(int argc, char **argv)
 		fflush(temp);
 		chflag = 0;
 
-		pid = FORK_OR_VFORK();
+		pid = tst_fork();
 		if (pid < 0) {
 			forkfail();
 		}
diff --git a/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c b/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
index f911aa5fd..5113b3fb4 100644
--- a/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
+++ b/testcases/kernel/syscalls/modify_ldt/modify_ldt02.c
@@ -119,7 +119,7 @@ int main(int ac, char **av)
 		}
 
 		tst_old_flush();
-		if ((pid = FORK_OR_VFORK()) == 0) {
+		if ((pid = tst_fork()) == 0) {
 			signal(SIGSEGV, SIG_DFL);
 			val = read_segment(0);
 			exit(1);
diff --git a/testcases/kernel/syscalls/mprotect/mprotect02.c b/testcases/kernel/syscalls/mprotect/mprotect02.c
index af282bba7..de894868f 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect02.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect02.c
@@ -89,7 +89,7 @@ int main(int ac, char **av)
 		addr = SAFE_MMAP(cleanup, 0, sizeof(buf), PROT_READ,
 				 MAP_SHARED, fd, 0);
 
-		if ((pid = FORK_OR_VFORK()) == -1)
+		if ((pid = tst_fork()) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "fork #1 failed");
 
 		if (pid == 0) {
@@ -118,7 +118,7 @@ int main(int ac, char **av)
 		TEST(mprotect(addr, sizeof(buf), PROT_WRITE));
 
 		if (TEST_RETURN != -1) {
-			if ((pid = FORK_OR_VFORK()) == -1)
+			if ((pid = tst_fork()) == -1)
 				tst_brkm(TBROK | TERRNO, cleanup,
 					 "fork #2 failed");
 
diff --git a/testcases/kernel/syscalls/mprotect/mprotect03.c b/testcases/kernel/syscalls/mprotect/mprotect03.c
index ed0c1a7de..8ef64f212 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect03.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect03.c
@@ -95,7 +95,7 @@ int main(int ac, char **av)
 		TEST(mprotect(addr, strlen(buf), PROT_READ));
 
 		if (TEST_RETURN != -1) {
-			if ((pid = FORK_OR_VFORK()) == -1) {
+			if ((pid = tst_fork()) == -1) {
 				tst_brkm(TBROK, cleanup, "fork failed");
 			}
 
diff --git a/testcases/kernel/syscalls/pause/pause02.c b/testcases/kernel/syscalls/pause/pause02.c
index 32b41bd7d..335bb3b35 100644
--- a/testcases/kernel/syscalls/pause/pause02.c
+++ b/testcases/kernel/syscalls/pause/pause02.c
@@ -54,7 +54,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		cpid = FORK_OR_VFORK();
+		cpid = tst_fork();
 		switch (cpid) {
 		case -1:
 			tst_brkm(TBROK, cleanup, "fork() failed");
diff --git a/testcases/kernel/syscalls/pause/pause03.c b/testcases/kernel/syscalls/pause/pause03.c
index b1503fc5c..4c30d9614 100644
--- a/testcases/kernel/syscalls/pause/pause03.c
+++ b/testcases/kernel/syscalls/pause/pause03.c
@@ -53,7 +53,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		if ((cpid = FORK_OR_VFORK()) == -1)
+		if ((cpid = tst_fork()) == -1)
 			tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
 
 		if (cpid == 0) {
diff --git a/testcases/kernel/syscalls/pipe/pipe04.c b/testcases/kernel/syscalls/pipe/pipe04.c
index a3c56e337..047fdb523 100644
--- a/testcases/kernel/syscalls/pipe/pipe04.c
+++ b/testcases/kernel/syscalls/pipe/pipe04.c
@@ -98,7 +98,7 @@ int main(int ac, char **av)
 
 		SAFE_PIPE(cleanup, fildes);
 
-		if ((c1pid = FORK_OR_VFORK()) == -1)
+		if ((c1pid = tst_fork()) == -1)
 			tst_brkm(TBROK, cleanup, "fork() failed - "
 				 "errno %d", errno);
 		if (c1pid == 0)
@@ -110,7 +110,7 @@ int main(int ac, char **av)
 #else
 			c1func();
 #endif
-		if ((c2pid = FORK_OR_VFORK()) == -1)
+		if ((c2pid = tst_fork()) == -1)
 			tst_brkm(TBROK, cleanup, "fork() failed - "
 				 "errno %d", errno);
 		if (c2pid == 0)
diff --git a/testcases/kernel/syscalls/pipe/pipe09.c b/testcases/kernel/syscalls/pipe/pipe09.c
index a4b2f8231..86282de49 100644
--- a/testcases/kernel/syscalls/pipe/pipe09.c
+++ b/testcases/kernel/syscalls/pipe/pipe09.c
@@ -98,7 +98,7 @@ int main(int ac, char **av)
 			continue;
 		}
 
-		if ((fork_1 = FORK_OR_VFORK()) == -1) {
+		if ((fork_1 = tst_fork()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork() #1 failed");
 		}
 
@@ -125,7 +125,7 @@ int main(int ac, char **av)
 			tst_brkm(TBROK, cleanup, "child exited abnormally");
 		}
 
-		if ((fork_2 = FORK_OR_VFORK()) == -1) {
+		if ((fork_2 = tst_fork()) == -1) {
 			tst_brkm(TBROK, cleanup, "fork() #2 failed");
 		}
 
diff --git a/testcases/kernel/syscalls/recv/recv01.c b/testcases/kernel/syscalls/recv/recv01.c
index 2f09864a5..64658ae32 100644
--- a/testcases/kernel/syscalls/recv/recv01.c
+++ b/testcases/kernel/syscalls/recv/recv01.c
@@ -240,7 +240,7 @@ pid_t start_server(struct sockaddr_in *sin0)
 	}
 	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
-	switch ((pid = FORK_OR_VFORK())) {
+	switch ((pid = tst_fork())) {
 	case 0:		/* child */
 #ifdef UCLINUX
 		if (self_exec(argv0, "d", sfd) < 0)
diff --git a/testcases/kernel/syscalls/recvfrom/recvfrom01.c b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
index 853d1cb9f..a05256003 100644
--- a/testcases/kernel/syscalls/recvfrom/recvfrom01.c
+++ b/testcases/kernel/syscalls/recvfrom/recvfrom01.c
@@ -269,7 +269,7 @@ pid_t start_server(struct sockaddr_in *sin0)
 	}
 	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
-	switch ((pid = FORK_OR_VFORK())) {
+	switch ((pid = tst_fork())) {
 	case 0:		/* child */
 #ifdef UCLINUX
 		if (self_exec(argv0, "d", sfd) < 0) {
diff --git a/testcases/kernel/syscalls/rename/rename14.c b/testcases/kernel/syscalls/rename/rename14.c
index 726b35ce2..c0e96cef0 100644
--- a/testcases/kernel/syscalls/rename/rename14.c
+++ b/testcases/kernel/syscalls/rename/rename14.c
@@ -89,14 +89,14 @@ int main(int argc, char *argv[])
 	parent_pid = getpid();
 	tst_tmpdir();
 
-	pid = FORK_OR_VFORK();
+	pid = tst_fork();
 	if (pid < 0)
 		tst_brkm(TBROK, NULL, "fork() returned %d", pid);
 	if (pid == 0)
 		dochild1();
 
 	kidpid[0] = pid;
-	pid = FORK_OR_VFORK();
+	pid = tst_fork();
 	if (pid < 0) {
 		(void)kill(kidpid[0], SIGTERM);
 		(void)unlink("./rename14");
diff --git a/testcases/kernel/syscalls/send/send01.c b/testcases/kernel/syscalls/send/send01.c
index 2e0ae2177..1f97daf5f 100644
--- a/testcases/kernel/syscalls/send/send01.c
+++ b/testcases/kernel/syscalls/send/send01.c
@@ -185,7 +185,7 @@ static pid_t start_server(struct sockaddr_in *sin0)
 	}
 	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
-	switch ((pid = FORK_OR_VFORK())) {
+	switch ((pid = tst_fork())) {
 	case 0:
 #ifdef UCLINUX
 		if (self_exec(argv0, "d", sfd) < 0)
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg01.c b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
index cf6e74289..62477e56b 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg01.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg01.c
@@ -457,7 +457,7 @@ static pid_t start_server(struct sockaddr_in *sin0, struct sockaddr_un *sun0)
 		return -1;
 	}
 
-	switch ((pid = FORK_OR_VFORK())) {
+	switch ((pid = tst_fork())) {
 	case 0:
 #ifdef UCLINUX
 		if (self_exec(argv0, "dd", sfd, ufd) < 0)
diff --git a/testcases/kernel/syscalls/sendto/sendto01.c b/testcases/kernel/syscalls/sendto/sendto01.c
index 6fe0274ee..654e6057e 100644
--- a/testcases/kernel/syscalls/sendto/sendto01.c
+++ b/testcases/kernel/syscalls/sendto/sendto01.c
@@ -255,7 +255,7 @@ static pid_t start_server(struct sockaddr_in *sin0)
 	}
 	SAFE_GETSOCKNAME(cleanup, sfd, (struct sockaddr *)sin0, &slen);
 
-	switch ((pid = FORK_OR_VFORK())) {
+	switch ((pid = tst_fork())) {
 	case 0:
 #ifdef UCLINUX
 		if (self_exec(argv0, "d", sfd) < 0)
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
index 8585d6207..e1525a731 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
@@ -62,7 +62,7 @@ int main(int ac, char **av)
 
 	setup();
 
-	pid = FORK_OR_VFORK();
+	pid = tst_fork();
 	if (pid < 0)
 		tst_brkm(TBROK, cleanup, "Fork failed");
 
@@ -106,7 +106,7 @@ static void do_master_child(void)
 	/* Test 2: Check a son process cannot open the file
 	 *         with RDWR permissions.
 	 */
-	pid = FORK_OR_VFORK();
+	pid = tst_fork();
 	if (pid < 0) {
 		perror("Fork failed");
 		exit(TFAIL);
diff --git a/testcases/kernel/syscalls/setpgid/setpgid01.c b/testcases/kernel/syscalls/setpgid/setpgid01.c
index 89c9a3779..60034e016 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid01.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid01.c
@@ -108,7 +108,7 @@ static void setpgid_test2(void)
 	int ret;
 	pid_t pgid, pid;
 
-	pid = FORK_OR_VFORK();
+	pid = tst_fork();
 	if (pid == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "fork()");
 
diff --git a/testcases/kernel/syscalls/setpgrp/setpgrp01.c b/testcases/kernel/syscalls/setpgrp/setpgrp01.c
index 3fdb8cb4c..543106f14 100644
--- a/testcases/kernel/syscalls/setpgrp/setpgrp01.c
+++ b/testcases/kernel/syscalls/setpgrp/setpgrp01.c
@@ -92,7 +92,7 @@ void setup(void)
 	 * Make sure current process is NOT a session or pgrp leader
 	 */
 	if (getpgrp() == getpid()) {
-		if ((pid = FORK_OR_VFORK()) == -1) {
+		if ((pid = tst_fork()) == -1) {
 			tst_brkm(TBROK, cleanup,
 				 "fork() in setup() failed - errno %d", errno);
 		}
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit01.c b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
index 7b133ef9e..188d310b2 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit01.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit01.c
@@ -134,7 +134,7 @@ static void test2(void)
 	 * output will be saved to the logfile (instead of stdout)
 	 * when the testcase (parent) is run from the driver.
 	 */
-	pid = FORK_OR_VFORK();
+	pid = tst_fork();
 	if (pid == -1)
 		tst_brkm(TBROK, cleanup, "fork() failed");
 
@@ -218,7 +218,7 @@ static void test3(void)
 	}
 
 	for (i = 0; i < 20; i++) {
-		pid = FORK_OR_VFORK();
+		pid = tst_fork();
 		if (pid == -1) {
 			if (errno != EAGAIN) {
 				tst_resm(TWARN, "Expected EAGAIN got %d",
@@ -251,7 +251,7 @@ static void test4(void)
 		return;
 	}
 
-	pid = FORK_OR_VFORK();
+	pid = tst_fork();
 	if (pid == -1)
 		tst_brkm(TBROK, cleanup, "fork() failed");
 
diff --git a/testcases/kernel/syscalls/setsid/setsid01.c b/testcases/kernel/syscalls/setsid/setsid01.c
index 08a7e2595..5df2c1ff4 100644
--- a/testcases/kernel/syscalls/setsid/setsid01.c
+++ b/testcases/kernel/syscalls/setsid/setsid01.c
@@ -90,10 +90,10 @@ int main(int ac, char **av)
 		 * and then it attached itself to another process
 		 * group and tries to setsid
 		 */
-		pid = FORK_OR_VFORK();
+		pid = tst_fork();
 
 		if (pid == 0) {
-			if ((pid = FORK_OR_VFORK()) == -1) {
+			if ((pid = tst_fork()) == -1) {
 				tst_resm(TFAIL, "Fork failed");
 
 			}
@@ -161,7 +161,7 @@ void do_child_1(void)
 		exno = 1;
 	}
 
-	if ((pid = FORK_OR_VFORK()) == -1) {
+	if ((pid = tst_fork()) == -1) {
 		tst_brkm(TFAIL, NULL, "Fork failed");
 	}
 	if (pid == 0) {
diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index 38086caa7..a9d509cba 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -208,7 +208,7 @@ int main(int argc, char **argv)
 		/*
 		 * fork off a child process
 		 */
-		if ((pid = FORK_OR_VFORK()) < 0) {
+		if ((pid = tst_fork()) < 0) {
 			tst_brkm(TBROK | TERRNO, cleanup, "fork() failed");
 
 		} else if (pid > 0) {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
