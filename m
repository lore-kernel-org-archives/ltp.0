Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02164C3600C
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 10:34:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E2503C9E6F
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 11:33:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFCD93C050F
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 11:33:41 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F3010600B55
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 11:33:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5681D21171;
 Thu, 27 Mar 2025 10:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743071618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzXZEzQqlyX60bHYP97u2m6Wys7WjwJvPLsDXjoIeLw=;
 b=kBOqa3g1KbnT233aBRKnuOeBZZFQNx5iS6Xw419fK/P9aT0u55U50zyE/LS1+9+Ujoqa4I
 WGXH5QRqW/XonOSYgrCyJXoASXHsXbCzsMDpYEXTNmX1Ml6DK20u4jauIgYcfIYaAmqdgB
 yXoKIPH5j+tbM8gU+LQ3Wl/HRIfJkSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743071618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzXZEzQqlyX60bHYP97u2m6Wys7WjwJvPLsDXjoIeLw=;
 b=EUhBMugbRLi/FOEY5RsxNlwHfdWEQEY/b5ztpQ6M29pKJjYmwTIqGncFcmh9wCdXqlQ1+x
 L47OZNQ+NZw7UrAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kBOqa3g1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EUhBMugb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743071618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzXZEzQqlyX60bHYP97u2m6Wys7WjwJvPLsDXjoIeLw=;
 b=kBOqa3g1KbnT233aBRKnuOeBZZFQNx5iS6Xw419fK/P9aT0u55U50zyE/LS1+9+Ujoqa4I
 WGXH5QRqW/XonOSYgrCyJXoASXHsXbCzsMDpYEXTNmX1Ml6DK20u4jauIgYcfIYaAmqdgB
 yXoKIPH5j+tbM8gU+LQ3Wl/HRIfJkSY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743071618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vzXZEzQqlyX60bHYP97u2m6Wys7WjwJvPLsDXjoIeLw=;
 b=EUhBMugbRLi/FOEY5RsxNlwHfdWEQEY/b5ztpQ6M29pKJjYmwTIqGncFcmh9wCdXqlQ1+x
 L47OZNQ+NZw7UrAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36D92139D4;
 Thu, 27 Mar 2025 10:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oH9lDIIp5WcLFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Mar 2025 10:33:38 +0000
Date: Thu, 27 Mar 2025 11:33:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: lufei <lufei@uniontech.com>
Message-ID: <20250327103336.GA70364@pevik>
References: <20250314044257.1673303-1-lufei@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250314044257.1673303-1-lufei@uniontech.com>
X-Rspamd-Queue-Id: 5681D21171
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] unshare03: using soft limit of NOFILE
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Al Viro <viro@zeniv.linux.org.uk>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi lufei, Al,

@Al, you're the author of the original test unshare_test.c [1] in kselftest.
This is a patch to LTP test unshare03.c, which is based on your test.

> I think it's safer to set NOFILE increasing from soft limit than from
> hard limit.

> Hard limit may lead to dup2 ENOMEM error which bring the result to
> TBROK on little memory machine. (e.g. 2GB memory in my situation, hard
> limit in /proc/sys/fs/nr_open come out to be 1073741816)

IMHO lowering number to ~ half (in my case) by using rlimit.rlim_max instead of
/proc/sys/fs/nr_open should not affect the functionality of the test, right?
Or am I missing something obvious?

@lufei I guess kselftest tools/testing/selftests/core/unshare_test.c would fail
for you as well, right?

Kind regards,
Petr

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=611fbeb44a777e5ab54ab3127ec85f72147911d8

> Signed-off-by: lufei <lufei@uniontech.com>
> ---
>  testcases/kernel/syscalls/unshare/unshare03.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

> diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
> index 7c5e71c4e..bb568264c 100644
> --- a/testcases/kernel/syscalls/unshare/unshare03.c
> +++ b/testcases/kernel/syscalls/unshare/unshare03.c
> @@ -24,7 +24,7 @@

>  static void run(void)
>  {
> -	int nr_open;
> +	int rlim_max;
>  	int nr_limit;
>  	struct rlimit rlimit;
>  	struct tst_clone_args args = {
> @@ -32,14 +32,12 @@ static void run(void)
>  		.exit_signal = SIGCHLD,
>  	};

> -	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
> -	tst_res(TDEBUG, "Maximum number of file descriptors: %d", nr_open);
> +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
> +	rlim_max = rlimit.rlim_max;

> -	nr_limit = nr_open + NR_OPEN_LIMIT;
> +	nr_limit = rlim_max + NR_OPEN_LIMIT;
>  	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_limit);

> -	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
> -
>  	rlimit.rlim_cur = nr_limit;
>  	rlimit.rlim_max = nr_limit;

> @@ -47,10 +45,10 @@ static void run(void)
>  	tst_res(TDEBUG, "Set new maximum number of file descriptors to : %d",
>  		nr_limit);

> -	SAFE_DUP2(2, nr_open + NR_OPEN_DUP);
> +	SAFE_DUP2(2, rlim_max + NR_OPEN_DUP);

>  	if (!SAFE_CLONE(&args)) {
> -		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
> +		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", rlim_max);
>  		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
>  		exit(0);
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
