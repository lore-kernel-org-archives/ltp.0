Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E40CCD98DA
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 18:07:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 691E03E5DAF
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 20:07:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F6A03E6A54
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:54 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E4AD460008A
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 20:06:53 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-137335bc3caso4285614c88.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781546812; x=1782151612; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHgBwmyT0BzScgCN8e1k0H8/y9yl3Y2SPuQMKhDFKuU=;
 b=TMqrKvvbkT+RIDvzblC4bGq2Brets5JaBMjf2RvKIu6cK/LUyTLn8oI3ri+7YYyAN7
 9sc0ErG5eZ1ICVw0xgaWfpQFQY1r8N1o+gl8uYPBmNzrYeRyiZN0cXr3RS6x8dC7AGjr
 TG5iXG3AF3UaVO8VdY7KAUz78ohJ3icTrToMIeKyS/eIrYuw0fmJiJkvjRQA4UAd0unm
 QR4Gg6d5O1K/l/Pnd4gONQRNGhwr/EhRoZyp4oiAKu+FNgWLLe6on6RMCA8GEAZfBm1V
 7AaacWqerXjPz1UsFqKbU5wVWd171biRwTu13UYCch74qiibLbUSpBzUPndwm/62SPAn
 FolQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546812; x=1782151612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XHgBwmyT0BzScgCN8e1k0H8/y9yl3Y2SPuQMKhDFKuU=;
 b=b5qlSyPL+oJynshcnbyp45PeO0oXfCogAYp8xB9wYNXCmB3bdd+fmXehaZonTs1/JB
 ESw0PGEaCNkLvWssl+dl8FGOJ395VCCNkqKOPQq+l9DrfznCDg3mmMduxURtuD0py5kU
 ZxMXDMxBLPrxkY1tgXlQBDpETf1GXGLTCcKg2IL8sXMppDmwJr6iJc9Hgo6+PTlpHWDQ
 9x1J+5uMsICy5AP8Q1ti5yLssk6K9Gokt+RG/wA0buywpi1VeqxvJKtq1UrFbwv3GfEA
 V4QzBOwnJJfz6C0S5NsOSCTWzMX/XVtADD3O6dGYsweHkvudfWGKXInjtrdPkDzIS58r
 0v/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9y2rhj6zQ3PzsAKJHPmSbe6bj8hL4ox3aV4k4unnTDe/K5ay7TPkb481cAHPvOJgQCFxo=@lists.linux.it
X-Gm-Message-State: AOJu0YwMTOcW44+t/uxFe1HDlXrOjcePaYxEp5jo/L9RXlBoypib5b76
 zAB4QqatGJQrLRNe8Iq0wOWR92oVhoQljWws8vkapjavs7Q9zOPw4NB1
X-Gm-Gg: Acq92OFPX6kpGvjhm3/4VwRSdr8vFBtMLdxwACmCysZFp0yh5hCq8K7Pb5pJHREiKsD
 FyNYuTCLGPIcOyV3dKOX8PjOaYyxhyqdIvL2KN6uAbCsvUdcL5OiqweS1Ad3aCFdVL5Ze3x3h6G
 MmU0BGM+x3w+ZLTznoa4QQelNZ7liNRnGz09w+HfSJSDLoeidlELGfWRjSq0rjpFFtv0pTlzNHI
 qXLgZPLJrVXBDK2dl3LPkPqzTxUC8nMxJeJclrCZ/QLJyRlmYDKPAxUEMeoq5muQu+aBCX+jgf+
 80tmjn1ygaBFZ9gEA/s1zPlpX1tC9qKuljYU5ctZjADE1bvqHZLMD8EhfDbqrjqjD/hbsuSRTuR
 9V09AsMo1pIO6PCitZrcLBOx/6sKq3IAGLGqslY6gK5yZzUta+V0X1au7dxVTfpe/nWa8toRIst
 hGdzOHfWZU0UoxAqQKZ1e2J3xLN/Y=
X-Received: by 2002:a05:7300:6408:b0:2f3:986d:2d01 with SMTP id
 5a478bee46e88-30ba5f1528amr174792eec.19.1781546812060; 
 Mon, 15 Jun 2026 11:06:52 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081ea4f7a0sm14352840eec.24.2026.06.15.11.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 11:06:51 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Tue, 16 Jun 2026 02:06:26 +0800
Message-ID: <20260615180629.7148-3-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615180629.7148-1-anonymemeow@gmail.com>
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] fanotify21: Stop relying on exited child for
 pidfd error
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
Cc: amir73il@gmail.com, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

fanotify21 used to verify the pidfd error case by generating an event
from a child process and reading the event after the child had exited.
This is no longer a stable way to trigger a pidfd error, because newer
kernels can report pidfds for exited event processes.

Read the event from a child process in a descendant PID namespace
instead. The reader cannot get the pidfd in the parent PID namespace
from fanotify, so pidfd creation will fail and the test can verify
FAN_NOPIDFD, or -ESRCH with FAN_REPORT_FD_ERROR.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify21.c     | 55 ++++++++-----------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 4d2115469..bd1a43513 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -42,7 +42,6 @@ struct pidfd_fdinfo_t {
 
 static struct test_case_t {
 	char *name;
-	int fork;
 	int want_pidfd_err;
 	int remount_ro;
 } test_cases[] = {
@@ -50,18 +49,15 @@ static struct test_case_t {
 		"return a valid pidfd for event created by self",
 		0,
 		0,
-		0,
 	},
 	{
-		"return invalid pidfd for event created by terminated child",
-		1,
+		"return invalid pidfd for reader in descendant PID namespace",
 		1,
 		0,
 	},
 	{
 		"fail to open rw fd for event created on read-only mount",
 		0,
-		0,
 		1,
 	},
 };
@@ -72,6 +68,11 @@ static struct pidfd_fdinfo_t *self_pidfd_fdinfo;
 
 static int fd_error_unsupported;
 
+static struct tst_clone_args clone_args = {
+	.flags = CLONE_NEWPID,
+	.exit_signal = SIGCHLD,
+};
+
 static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
 {
 	char *fdinfo_path;
@@ -100,24 +101,6 @@ static void generate_event(void)
 	SAFE_CLOSE(fd);
 }
 
-static void do_fork(void)
-{
-	int status;
-	pid_t child;
-
-	child = SAFE_FORK();
-	if (child == 0) {
-		SAFE_CLOSE(fanotify_fd);
-		generate_event();
-		exit(EXIT_SUCCESS);
-	}
-
-	SAFE_WAITPID(child, &status, 0);
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
-		tst_brk(TBROK,
-			"child process terminated incorrectly");
-}
-
 static void do_setup(void)
 {
 	int pidfd;
@@ -165,6 +148,8 @@ static void do_test(unsigned int num)
 	int nopidfd_err = tc->want_pidfd_err ?
 			  (tst_variant ? -ESRCH : FAN_NOPIDFD) : 0;
 	int fd_err = (tc->remount_ro && tst_variant) ? -EROFS : 0;
+	pid_t reader_pid;
+	int reader_exit_status;
 
 	tst_res(TINFO, "Test #%d.%d: %s %s", num, tst_variant, tc->name,
 			tst_variant ? "(FAN_REPORT_FD_ERROR)" : "");
@@ -178,15 +163,20 @@ static void do_test(unsigned int num)
 	SAFE_MOUNT("none", MOUNT_PATH, "none", MS_BIND | MS_REMOUNT |
 		   (tc->remount_ro ? MS_RDONLY : 0), NULL);
 
+	generate_event();
+
 	/*
-	 * Generate the event in either self or a child process. Event
-	 * generation in a child process is done so that the FAN_NOPIDFD case
-	 * can be verified.
+	 * Read the event in either self or a child process in a descendant
+	 * PID namespace. A reader in a descendant PID namespace cannot obtain
+	 * the pidfd of the event process in the parent PID namespace so that
+	 * the FAN_NOPIDFD case can be verified.
 	 */
-	if (tc->fork)
-		do_fork();
-	else
-		generate_event();
+	if (tc->want_pidfd_err && (reader_pid = SAFE_CLONE(&clone_args))) {
+		SAFE_WAITPID(reader_pid, &reader_exit_status, 0);
+		if (!WIFEXITED(reader_exit_status) || WEXITSTATUS(reader_exit_status))
+			tst_brk(TBROK, "reader process exited incorrectly");
+		return;
+	}
 
 	/*
 	 * Read all of the queued events into the provided event
@@ -274,7 +264,7 @@ static void do_test(unsigned int num)
 			goto next_event;
 		} else if (tc->want_pidfd_err && info->pidfd == nopidfd_err) {
 			tst_res(TPASS,
-				"pid: %u terminated before pidfd was created, "
+				"pid: %u is invisible in reader PID namespace, "
 				"pidfd set to the value of: %d, as expected",
 				(unsigned int)event->pid,
 				nopidfd_err);
@@ -343,6 +333,9 @@ next_event:
 		if (event_pidfd_fdinfo)
 			free(event_pidfd_fdinfo);
 	}
+
+	if (tc->want_pidfd_err)
+		exit(0);
 }
 
 static void do_cleanup(void)
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
