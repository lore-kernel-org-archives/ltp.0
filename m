Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 370B4CD98E1
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 21:05:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84DF43E5E1D
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 23:05:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 275A43E6A54
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:09 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7998F10005D4
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:09 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so5290122eec.0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 14:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781643908; x=1782248708; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQuZ+i5QaSjM5Csa0JmG6f0n+xE0KFSW6DvRlnH+7OE=;
 b=JQhyhtPNNmAMBsJXcV+kM2KAa3Np/X76oaZqZPT/OfAQXcZsnGMu5ozJ2LFGOG0vR9
 mB7QiM4mbSQByC7OMFhUEq8giwqfslEHyYlqRo4+9UXAsCqnVv30qxbD2rQuOqV0q0SL
 NIwKV7F+1nBWM9O1SfY7vzHbPRuZE/bR/jIEPNioQijKtLZXOuafkBdBgGxFrH7xlby/
 qJy+Lsba5/mezZCEIpTYmWAQ8C6VITfELKNCbxZFF7ZRfVHKfcovQ3t42cHmMYc2DZa0
 gIpjE+XJjdcIyPdNrUb9hCvRvQkIca3XjiyLDsJp/4G7FFOIDXA3zJEDtUvB3pgRkwbT
 sWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781643908; x=1782248708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iQuZ+i5QaSjM5Csa0JmG6f0n+xE0KFSW6DvRlnH+7OE=;
 b=WuOWfwXD4S9RxWzgaOelHGR6eyRLasjFFCsDScaXNkzU1Z9nDFnym4fPxi/sieqfza
 dRjVMPXcWV+lqBt2eDui4PbMv2QyyPsgCLXHtMRw6sXzKxswU07v/Y/xlBr4vELFwsms
 mWBnHf6AHSXr2ZKDhAdNNhSCXa2JQNfb9VCj6vBPBp1rfnma1PHY2XAsybTi+JYoSLZN
 dPTkc0JZajIVC4EhFfzfqw3nS/7gunXbdpzSVpEZTPYDvNc1Rmn2Frv1sDL5iCeD8CWY
 /i9mrdgPlEharfTkSzRjfAIOnGxgc3u+5vW6mJ9+w3Va8VBS5UNgt6FLENrXZFNZ/yYN
 dnBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8MTVeV0a6c7HELClkXAz9tirLSn0rBv6xw7NmpiatNT19+vOcuJTAGvcyNJ3jSu6TdFC8=@lists.linux.it
X-Gm-Message-State: AOJu0YxJIWtMnNJ/TkXOmQ7oanBDGXkNxZXKIXtBCPq6V8BHleSYi58q
 DoJrD/AdHFXN8HP+0/JbuvQODdTojlTxobX09o+C2HmFOfAg6QqI98aM
X-Gm-Gg: Acq92OF5lr19O9qlOzH/w/7T18yzqi/s2CMDbur6l/OXislGBh4xVvpWe5rLbOGKlNf
 NotU5twcAu9OFMJSB6KjU51+d0gbAQOo6XVXZBKkrER8KC+L/YWKc62X4GjEY8INS46HCy1ka0q
 SEHdHCBH6K60DpyF9NNu1Rwxa3g1nm3W26iLxuP2eJyzmZ59J73da0L58AA2XRcHR6tr3AApzv3
 WxnuMVWig6ReIi+yjGf0mZI2Z0/sdu0Yjfcdtn3Bs+17ZguHMVEH7yTxvhjLn9yI0/MpoVKJugJ
 zeyU894JnhsJXQiGU8qa7c8URQKoore7maWrV13opZ3pYcjyqdq6Vfme3WF+jsUuZA2IZIwuPWw
 VFkmDTcPk0I3tpkfsu9DsfPqvblljk2cXbB6MlhqH8fTDXihjWnNEFERgo1iQvG+JORuQ2dZHM8
 PD4wCtaeck/xdC7S5E
X-Received: by 2002:a05:7301:7c0e:b0:304:9b48:53d8 with SMTP id
 5a478bee46e88-30bc9df7446mr556154eec.10.1781643907658; 
 Tue, 16 Jun 2026 14:05:07 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0828sm22231766eec.10.2026.06.16.14.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:05:07 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Wed, 17 Jun 2026 05:04:45 +0800
Message-ID: <20260616210448.12175-3-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616210448.12175-1-anonymemeow@gmail.com>
References: <20260616210448.12175-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/5] fanotify21: Stop relying on exited child for
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
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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
