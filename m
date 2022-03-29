Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21538C433F5
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 14:25:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48D4F3C9EF9
	for <ltp@archiver.kernel.org>; Tue, 29 Mar 2022 16:25:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C02343C72A7
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 16:25:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 165771400BE0
 for <ltp@lists.linux.it>; Tue, 29 Mar 2022 16:25:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C943A1FD32;
 Tue, 29 Mar 2022 14:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648563908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yTZRC7s9LTQgTAGkiv2ZT9HeFvbvLWjWNq4HMy3yPIo=;
 b=hO1xPwNovgCmFd/vLcpEP2ZAPAUvaNX4Wyx1fLlZVGXsePejN1x0Nv/vXNsJgnDmmR5KWV
 YoXkrND4CeDgNSMTcvAD5m5hvp12RL3VQ6HsLc90XXxlQOTHivZSKLlMKbuHXGp43of6I4
 fOdirb2MM6fUfJG2AlH/mn2/MxNThwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648563908;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yTZRC7s9LTQgTAGkiv2ZT9HeFvbvLWjWNq4HMy3yPIo=;
 b=SVCk5RtT8u4hnD1lGDkuvLrB7+dmUFEfwYWsE2+gySc7mky2XWjwTwz0FEJFUMfaG5wjm1
 oOqywmRuCdD/z2Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A041E13A7E;
 Tue, 29 Mar 2022 14:25:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oOtmJMQWQ2LKVwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 29 Mar 2022 14:25:08 +0000
Date: Tue, 29 Mar 2022 16:27:28 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YkMXUJmKnhh1RCRs@yuki>
References: <20220325093626.11114-1-andrea.cervesato@suse.de>
 <20220325093626.11114-8-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220325093626.11114-8-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 7/9] Rewrite userns07.c using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with minor fixes, thanks.

- Rewrote the description to match what the test does better
- Got rid of the useless TEST() macro usage
- Fixed the tst_strstatus() usage
- Made use of the SAFE_FILE_PRINTF()

Full diff:

diff --git a/testcases/kernel/containers/userns/userns07.c b/testcases/kernel/containers/userns/userns07.c
index 454abedae..4659de636 100644
--- a/testcases/kernel/containers/userns/userns07.c
+++ b/testcases/kernel/containers/userns/userns07.c
@@ -7,8 +7,7 @@
 /*\
  * [Description]
  *
- * Verify that the kernel imposes a limit of at least 32 nested levels on
- * user namespaces.
+ * Verify that the kernel allows at least 32 nested levels of user namespaces.
  */
 
 #define _GNU_SOURCE
@@ -40,14 +39,12 @@ static int child_fn1(void *arg)
 		return 0;
 	}
 
-	TEST(ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, (void *)(level + 1)));
-	if (TST_RET < 0) {
+	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, (void *)(level + 1));
+	if (cpid1 < 0) {
 		tst_res(TFAIL | TERRNO, "level %ld, unexpected error", level);
 		return 1;
 	}
 
-	cpid1 = (int)TST_RET;
-
 	parentuid = geteuid();
 	parentgid = getegid();
 
@@ -58,10 +55,8 @@ static int child_fn1(void *arg)
 
 	SAFE_WAITPID(cpid1, &status, 0);
 
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
-		tst_brk(TBROK | TERRNO, "child exited abnormally %s", tst_strstatus(status));
-	else if (WIFSIGNALED(status))
-		tst_brk(TBROK | TERRNO, "child was killed with signal = %d", WTERMSIG(status));
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+		tst_brk(TBROK, "child %s", tst_strstatus(status));
 
 	return 0;
 }
@@ -71,7 +66,6 @@ static void run(void)
 	pid_t cpid1;
 	int parentuid;
 	int parentgid;
-	int fd;
 	char path[BUFSIZ];
 
 	cpid1 = ltp_clone_quick(CLONE_NEWUSER | SIGCHLD, (void *)child_fn1, (void *)0);
@@ -83,10 +77,7 @@ static void run(void)
 
 	if (access("/proc/self/setgroups", F_OK) == 0) {
 		sprintf(path, "/proc/%d/setgroups", cpid1);
-
-		fd = SAFE_OPEN(path, O_WRONLY, 0644);
-		SAFE_WRITE(1, fd, "deny", 4);
-		SAFE_CLOSE(fd);
+		SAFE_FILE_PRINTF(path, "deny");
 	}
 
 	updatemap(cpid1, UID_MAP, 0, parentuid);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
