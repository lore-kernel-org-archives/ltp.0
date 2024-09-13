Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BECFA3741
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 10:52:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A8123C27A3
	for <ltp@archiver.kernel.org>; Fri, 13 Sep 2024 12:52:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41A353C12A6
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 12:52:22 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ACB641001169
 for <ltp@lists.linux.it>; Fri, 13 Sep 2024 12:52:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3986218EE;
 Fri, 13 Sep 2024 10:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726224740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hU4Q04/88k2ZTUgmU9iBRk2VUU9p43DWrB30SeZWri8=;
 b=dKb4TLOpAYHY6ZNw0DmhzoR+ji6l1ltQZd5JKk/JQYQseCzX3yYE3DdIb6lv2MYIJabVBl
 o0qaWs7zj9B2V//YqOx1x6WJB12+3S0X3qOz3b95Uu3xujjeTE8XDu1qe9ofMa7xlzw7/c
 91puWDVVONCBqTzLxyeS1KTjg5+E6Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726224740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hU4Q04/88k2ZTUgmU9iBRk2VUU9p43DWrB30SeZWri8=;
 b=abdUTOEIZGb/k9Pf9bkuFt+gghfzGb9HeDXOeKFh1Q+UanwP/+0WPUl8WA1Cy76/M79VOc
 5HhWAMshIJtDx2CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726224740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hU4Q04/88k2ZTUgmU9iBRk2VUU9p43DWrB30SeZWri8=;
 b=dKb4TLOpAYHY6ZNw0DmhzoR+ji6l1ltQZd5JKk/JQYQseCzX3yYE3DdIb6lv2MYIJabVBl
 o0qaWs7zj9B2V//YqOx1x6WJB12+3S0X3qOz3b95Uu3xujjeTE8XDu1qe9ofMa7xlzw7/c
 91puWDVVONCBqTzLxyeS1KTjg5+E6Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726224740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hU4Q04/88k2ZTUgmU9iBRk2VUU9p43DWrB30SeZWri8=;
 b=abdUTOEIZGb/k9Pf9bkuFt+gghfzGb9HeDXOeKFh1Q+UanwP/+0WPUl8WA1Cy76/M79VOc
 5HhWAMshIJtDx2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90AFC13999;
 Fri, 13 Sep 2024 10:52:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l5T6ImQZ5GabbQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 13 Sep 2024 10:52:20 +0000
Date: Fri, 13 Sep 2024 12:51:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <ZuQZH3FB8Fo_B_oS@yuki.lan>
References: <8a4a1452-0d8b-473e-be89-c0d4fb286abd@suse.com>
 <20240530082522.2505-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240530082522.2505-1-maxj.fnst@fujitsu.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] signalfd: Add negative tests
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
Pushed with changes described below, thanks.

- there is no need for three masks we just need one valid mask
  + moved the mask structure into a guarded buffer

- it's pointless to attempt to close the fd_einval2 and fd_ebadf
  as these variables are never assigned a valid fd

diff --git a/testcases/kernel/syscalls/signalfd/signalfd02.c b/testcases/kernel/syscalls/signalfd/signalfd02.c
index 527e1aff9..fdd15781c 100644
--- a/testcases/kernel/syscalls/signalfd/signalfd02.c
+++ b/testcases/kernel/syscalls/signalfd/signalfd02.c
@@ -7,7 +7,7 @@
 /*\
  * [Description]
  *
- * Verify that signalfd(2) fails with
+ * Verify that signalfd(2) fails with:
  *
  * - EBADF when fd is invalid
  * - EINVAL when fd is not a valid signalfd file descriptor
@@ -23,53 +23,40 @@ static int fd_ebadf = -2;
 static int fd_einval1;
 static int fd_einval2 = -1;
 
-static sigset_t mask1;
-static sigset_t mask2;
-static sigset_t mask3;
+static sigset_t *mask;
 
 static struct test_case_t {
        int *fd;
-       sigset_t *mask;
        int flags;
        int expected_errno;
        char *desc;
 } tcases[] = {
-       {&fd_ebadf, &mask1, 0, EBADF, "fd is invalid"},
-       {&fd_einval1, &mask2, 0, EINVAL,
+       {&fd_ebadf, 0, EBADF, "fd is invalid"},
+       {&fd_einval1, 0, EINVAL,
                "fd is not a valid signalfd file descriptor"},
-       {&fd_einval2, &mask3, -1, EINVAL, "flags are invalid"},
+       {&fd_einval2, -1, EINVAL, "flags are invalid"},
 };
 
 static void setup(void)
 {
-       SAFE_SIGEMPTYSET(&mask1);
-       SAFE_SIGADDSET(&mask1, SIGUSR1);
-       SAFE_SIGPROCMASK(SIG_BLOCK, &mask1, NULL);
-       SAFE_SIGEMPTYSET(&mask2);
-       SAFE_SIGADDSET(&mask2, SIGUSR2);
-       SAFE_SIGPROCMASK(SIG_BLOCK, &mask2, NULL);
-       SAFE_SIGEMPTYSET(&mask2);
-       SAFE_SIGADDSET(&mask3, SIGUSR2);
-       SAFE_SIGPROCMASK(SIG_BLOCK, &mask3, NULL);
+       SAFE_SIGEMPTYSET(mask);
+       SAFE_SIGADDSET(mask, SIGUSR1);
+       SAFE_SIGPROCMASK(SIG_BLOCK, mask, NULL);
 
        fd_einval1 = SAFE_OPEN(SIGNAL_FILE, O_CREAT, 0777);
 }
 
 static void cleanup(void)
 {
-       if (fd_ebadf > 0)
-               SAFE_CLOSE(fd_ebadf);
        if (fd_einval1 > 0)
                SAFE_CLOSE(fd_einval1);
-       if (fd_einval2 > 0)
-               SAFE_CLOSE(fd_einval2);
 }
 
 static void verify_signalfd(unsigned int i)
 {
        struct test_case_t *tc = &tcases[i];
 
-       TST_EXP_FAIL2(signalfd(*(tc->fd), tc->mask, tc->flags),
+       TST_EXP_FAIL2(signalfd(*(tc->fd), mask, tc->flags),
                tc->expected_errno, "%s", tc->desc);
 }
 
@@ -79,4 +66,8 @@ static struct tst_test test = {
        .setup = setup,
        .cleanup = cleanup,
        .needs_tmpdir = 1,
+       .bufs = (struct tst_buffers []) {
+               {&mask, .size = sizeof(sigset_t)},
+               {}
+       }
 };


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
