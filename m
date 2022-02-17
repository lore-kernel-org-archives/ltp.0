Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956ACC433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 19:20:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3637F3CA0A2
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 20:20:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B7543C9600
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 20:20:19 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BCF081401702
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 20:20:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA6941F37D;
 Thu, 17 Feb 2022 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645125617;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syaSu/3OltL0AB1C6Abgf/2dl1syWIN2GEz2NJPJ9B0=;
 b=Paa/fFgHtctttti/+eKDw3v0FdSrfBnIuh67h65A+blbEcS8hZrZ6hIIpowVJWa3zV8bvJ
 8ANW0rwhiSoJ7e6fNVo/v4+vs4lYsIuSvRc3XwGhzHoOy1bhhWqZnE3k1h4j+f12QqDjME
 MEi/TWgKXqcrAlNG8KfXtL59MY+J9U4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645125617;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syaSu/3OltL0AB1C6Abgf/2dl1syWIN2GEz2NJPJ9B0=;
 b=Pu/BI9+uHQlwx5rui/3/YXxG4NiPT4iS7V3fkW8iWmcg7ELRvpxnVcD5/kQLe2ELNTzG6N
 BFRONMMHuDwozjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 99DAB13C2E;
 Thu, 17 Feb 2022 19:20:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KafTIfGfDmKxSQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Feb 2022 19:20:17 +0000
Date: Thu, 17 Feb 2022 20:20:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Yg6f6p/rdFTfzkoR@pevik>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1645005868-2373-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] Add pidfd_getfd01 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

...
> +++ b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd01.c
...
> +	remotefd = TST_RET;
> +	flag = fcntl(remotefd, F_GETFD);
> +	if (flag == -1)
> +		tst_brk(TFAIL | TERRNO, "fcntl(F_GETFD) failed");
Just:
flag = SAFE_FCNTL(remotefd, F_GETFD);

> +	if (!(flag & FD_CLOEXEC))
> +		tst_res(TFAIL, "pidfd_getfd() didn't set close-on-exec flag");
> +
> +	TEST(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));
> +	if (TST_RET != 0)
> +		tst_res(TFAIL, "pidfd_getfd() didn't get the same open file description");
Maybe just:
       TST_EXP_PASS_SILENT(kcmp(getpid(), pid, KCMP_FILE, remotefd, targetfd));

       if (!TST_PASS)
               return;
Although your version is more descriptive.

> +
> +	TST_CHECKPOINT_WAKE(0);
> +	SAFE_CLOSE(remotefd);
> +
> +	tst_res(TPASS, "pidfd_getfd(%d, %d, 0) passed", pidfd, targetfd);
> +	SAFE_CLOSE(pidfd);
Shouldn't be pidfd closed in cleanup? In case fcntl() fails it's kept open.
> +	SAFE_CLOSE(fds[0]);
The same is for fds, which is already static.

These are very minor and you can change it before merge.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
