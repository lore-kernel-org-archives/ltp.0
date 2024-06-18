Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0C3C27C4F
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 10:16:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43F023D0D54
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 12:16:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD71C3CB74E
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 12:16:09 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 36C7E600CDD
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 12:16:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3CE09219C2;
 Tue, 18 Jun 2024 10:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718705766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SBjpdWh/fLmuGTpcAojG/c/wVSA6yNwbNoGLSIftkZU=;
 b=KuJnldiMsUborqUtxPh6Kt+JOhtDpcgksFg03XpeZDZ0ydiWcuJ3g/5nI61B/50OKUeFzU
 19g/5cwGPZy2VdLfovsHFRQTpJGzrisPZ9Txw3pBO3B1P3p/lt83SHattbryEgZHfPhONv
 0RNLFibXoV7Q6fR/Y9jyhB8tjse0cNA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718705766;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SBjpdWh/fLmuGTpcAojG/c/wVSA6yNwbNoGLSIftkZU=;
 b=ZqgIa2sl7F/ZePxMI68mO1eJ3eKDTD8eCFJQLzuiB6j9ZQTbZbJrpb6JfRTMrpIFQW+CiL
 SyZ6Mnc7p18uQ6Dg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718705765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SBjpdWh/fLmuGTpcAojG/c/wVSA6yNwbNoGLSIftkZU=;
 b=TblvvuzyF6LA8s1CQ0Cbm55oyILYJnH+uT7881vV6lfEKJEOdKhSmJp2cSMOj1tXAzYGlu
 dAv0gTvoCqFGmKBHf1sfFvoPy+TJNfVV6hspNFUM+XNOPNjd3pk4IHf3KXe2I3BvEUlYQY
 kX0QC8woNkLpPA00NxmMJdsDqVaXwA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718705765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SBjpdWh/fLmuGTpcAojG/c/wVSA6yNwbNoGLSIftkZU=;
 b=MqkO6j+EUG1Zs09QOgwbuVnCEE368+DtTWEkEdH2vVUbz/7NO8JnOUDqeQZN9KX1PhnTfd
 v67nL1Z4fNxshBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C79613AA0;
 Tue, 18 Jun 2024 10:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jSf5CWVecWZpKAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 18 Jun 2024 10:16:05 +0000
Date: Tue, 18 Jun 2024 12:15:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <ZnFeWJJldj_ggKnq@yuki>
References: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1718700544-17304-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, toshiba.co.jp:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Add kernel version check to
 memfd_secret
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
> memfd_secret is a syscall added since 5.14. On earlier kernels, tests such
> as accept03, readahead01 and splice07 that use memfd_secret fail.
> This adds a kernel version check to the tst_fd library when running tests using
> memfd_secret.
> 
> Test log on linux-5.10.162/arm32 with version 20240524:
> ```
> $ ./testcases/kernel/syscalls/accept/accept03
> tst_test.c:1733: TINFO: LTP version: 20240524
> tst_test.c:1617: TINFO: Timeout per run is 0h 00m 30s
> accept03.c:58: TPASS: accept() on file : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on O_PATH file : EBADF (9)
> accept03.c:58: TPASS: accept() on directory : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on /dev/zero : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on /proc/self/maps : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on pipe read end : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on pipe write end : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on epoll : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on eventfd : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on signalfd : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on timerfd : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on pidfd : ENOTSOCK (88)
> tst_fd.c:151: TCONF: Skipping fanotify: ENOSYS (38)
> accept03.c:58: TPASS: accept() on inotify : ENOTSOCK (88)
> tst_fd.c:170: TCONF: Skipping userfaultfd: ENOSYS (38)
> accept03.c:58: TPASS: accept() on perf event : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on io uring : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on bpf map : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on fsopen : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on fspick : ENOTSOCK (88)
> accept03.c:58: TPASS: accept() on open_tree : EBADF (9)
> accept03.c:58: TPASS: accept() on memfd : ENOTSOCK (88)
> tst_test.c:1677: TBROK: Test killed by SIGILL!

This looks like a bug either in kernel or libc.

> Summary:
> passed   20
> failed   0
> broken   1
> skipped  2
> warnings 0
> ```
> 
> Closed: #1145
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  lib/tst_fd.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/lib/tst_fd.c b/lib/tst_fd.c
> index 6538a098c..53f583fa0 100644
> --- a/lib/tst_fd.c
> +++ b/lib/tst_fd.c
> @@ -255,8 +255,16 @@ static void open_memfd(struct tst_fd *fd)
>  
>  static void open_memfd_secret(struct tst_fd *fd)
>  {
> +	if ((tst_kvercmp(5, 14, 0)) < 0) {
> +		tst_res(TINFO, "accept() on %s: Linux kernel version is before than v5.14", tst_fd_desc(fd));
> +		errno = ENOSYS;
> +		goto skip;
> +	}
> +
>  	fd->fd = syscall(__NR_memfd_secret, 0);
> +
>  	if (fd->fd < 0) {
> +skip:
>  		tst_res(TCONF | TERRNO,
>  			"Skipping %s", tst_fd_desc(fd));
>  	}

And this looks like you are working around the bug.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
