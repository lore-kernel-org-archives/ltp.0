Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8B0C004C0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 11:27:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 272763CD19D
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 13:26:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF8483C8487
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 13:26:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C5D0A140045C
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 13:26:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 355F61F8D7;
 Mon, 23 Oct 2023 11:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698060406;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Q6Yc+EH1/wAKwV+ZOgdZUErkNo3V8ddIoRE7dviK+w=;
 b=mLJyKlK8n2zB3AS1tZH88VPsbU14DcDLcI/xvyM5XT3yXafnTt7aO073SpqE6DP0ExTDcd
 jKbazOckWUh9Kjjn5CHYfU/R4qXio3eNxepBRKUEqjAuOqQYptSKcU4HNIvVJNFKRJAuBj
 eQngQfYraJIQSgPwDxZ/gHjF5+BMNTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698060406;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Q6Yc+EH1/wAKwV+ZOgdZUErkNo3V8ddIoRE7dviK+w=;
 b=kgn2I1EUwqT3N/4r6G0Sll6Q0vXkjNfPQDn8JDATsWqQxeNfEolPL9xHdqh2Uhc4t9Pcgo
 Qrv+KOK4LyxZYnCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 109EF132FD;
 Mon, 23 Oct 2023 11:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oeERAnZYNmV+BAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 23 Oct 2023 11:26:46 +0000
Date: Mon, 23 Oct 2023 13:26:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231023112644.GB23219@pevik>
References: <20231021122958.13458-1-wegao@suse.com>
 <20231021122958.13458-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231021122958.13458-3-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.18 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.88)[99.51%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] execl01.c: set stack to unlimited
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

Hi Wei,

It would be also here mention
https://github.com/linux-test-project/ltp/issues/530

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/execl/execl01.c | 4 ++++
>  1 file changed, 4 insertions(+)

> diff --git a/testcases/kernel/syscalls/execl/execl01.c b/testcases/kernel/syscalls/execl/execl01.c
> index 9268d4976..5cdd84656 100644
> --- a/testcases/kernel/syscalls/execl/execl01.c
> +++ b/testcases/kernel/syscalls/execl/execl01.c
> @@ -35,4 +35,8 @@ static struct tst_test test = {
>  	.forks_child = 1,
>  	.child_needs_reinit = 1,
>  	.test_all = verify_execl,

BTW #530 mentions execve(). Is it ok that we use it on execl()?

The difference is not big (all glibc wrappers use SYS_execve syscall
internally), so that it might be OK, but how about also add it to some test
which uses execve() + SAFE_FORK()/.fork_child (e.g. execve01.c).

Kind regards,
Petr

> +	.ulimit = (const struct tst_ulimit_val[]) {
> +		{RLIMIT_STACK, {RLIM_INFINITY, RLIM_INFINITY}},
> +		{}
> +	},
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
