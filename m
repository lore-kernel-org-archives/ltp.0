Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AA6C4828D
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 10:44:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 666773CE171
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 11:44:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B93EA3C12A7
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 11:44:43 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DA03D201738
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 11:44:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E0C5F1FB71;
 Tue,  6 Feb 2024 10:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707216282;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rLHIfZNpha/Lknx7FMfxM8eijbzigBG9IIj9QbzCdEs=;
 b=nUgLpjCGy4iTw10GGh55P7JNY9XDE8X+z9Gvg9PhTDBrV8wqit+zg0GHsX5xB2IdMq8FWn
 FXhYMCOZzdh8TXuwT31HSY7UfV0hWGnD2EfVXtdY+qVOIKoRKPRpAM5rKMDEX9p6ZBeMVQ
 2ibIKyN78MN1NWVrlOAbrjmno5giXwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707216282;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rLHIfZNpha/Lknx7FMfxM8eijbzigBG9IIj9QbzCdEs=;
 b=0kD7dA562fXnP93BE/AqQVjVztdO3aG87Y1MtyvGOkzqmIcC702pXwTMpOz9xmxVQE8/kC
 c9+3xluXuLFRh6CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707216281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rLHIfZNpha/Lknx7FMfxM8eijbzigBG9IIj9QbzCdEs=;
 b=RgpswE0wPNxVUhd9aTczqnO+oWKVhP45LZLon1fTAVAVScsuOG5yPmQat5tW7SqkD20d97
 XsLdr6yKN+MheihQ7scJSCtX20sAVot8G54VKok+J21IDXxW9RGqDFLaTJb3xqwOHOBW5J
 gTErOo6fXPsfsR2lX2UQzyS3Tq/CXIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707216281;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rLHIfZNpha/Lknx7FMfxM8eijbzigBG9IIj9QbzCdEs=;
 b=KuzjIgn0MdllyTpc6JJ6jL4g6vGiQ0Keo+V5kvpMxLHAqWkNtK21AoQQJq5GXW7vYRhIU/
 FDErNwi5WZ7znHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2D04139D8;
 Tue,  6 Feb 2024 10:44:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3OiwLZkNwmUeBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 Feb 2024 10:44:41 +0000
Date: Tue, 6 Feb 2024 11:44:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240206104440.GA270992@pevik>
References: <20240130162813.20278-1-mdoucha@suse.cz>
 <20240205173452.GB218023@pevik>
 <868916ef-de27-4512-a395-f7be5aa4c97d@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <868916ef-de27-4512-a395-f7be5aa4c97d@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] waitpid01: Test all standard deadly signals
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

Hi Martin,

> On 05. 02. 24 18:34, Petr Vorel wrote:
> > Hi Martin,

> > first this change (merged as ed5ccf6c1 ("waitpid01: Test all standard deadly
> > signals") is failing on 6.6 on Debian:

> > ed5ccf6c1 ("waitpid01: Test all standard deadly signals")

> > waitpid01.c:88: TINFO: Testing child: raise(sig)
> > waitpid01.c:109: TPASS: waitpid() returned correct pid 236064
> > waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> > waitpid01.c:126: TPASS: WTERMSIG() == SIGIOT/SIGABRT
> > waitpid01.c:143: TPASS: Child dumped core as expected
> > waitpid01.c:109: TPASS: waitpid() returned correct pid 236071
> > waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> > waitpid01.c:126: TPASS: WTERMSIG() == SIGALRM
> > waitpid01.c:109: TPASS: waitpid() returned correct pid 236072
> > waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> > waitpid01.c:126: TPASS: WTERMSIG() == SIGBUS
> > waitpid01.c:143: TPASS: Child dumped core as expected
> > waitpid01.c:109: TPASS: waitpid() returned correct pid 236082
> > waitpid01.c:113: TFAIL: WIFSIGNALED() not set in status (exited with 0)
> > ...
> > waitpid01.c:88: TINFO: Testing child: kill(getpid(), sig)
> > waitpid01.c:109: TPASS: waitpid() returned correct pid 236165
> > waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> > waitpid01.c:126: TPASS: WTERMSIG() == SIGIOT/SIGABRT
> > waitpid01.c:143: TPASS: Child dumped core as expected
> > waitpid01.c:109: TPASS: waitpid() returned correct pid 236176
> > waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> > waitpid01.c:126: TPASS: WTERMSIG() == SIGALRM
> > waitpid01.c:109: TPASS: waitpid() returned correct pid 236177
> > waitpid01.c:118: TPASS: WIFSIGNALED() set in status
> > waitpid01.c:126: TPASS: WTERMSIG() == SIGBUS
> > waitpid01.c:143: TPASS: Child dumped core as expected
> > waitpid01.c:109: TPASS: waitpid() returned correct pid 236187
> > waitpid01.c:113: TFAIL: WIFSIGNALED() not set in status (exited with 0)
> > ...

> > But it works on 6.8.0-rc1-2.gf4ba5db-default Tumbleweed, which I tested it
> > before.

> I've tested the patch on kernel v6.6.1 on Tumbleweed and all testcases pass.
> The failure shows that SIGFPE doesn't trigger coredump for some reason,
> that's either a system bug or some parent process left over a SIGFPE
> handler. Could you try the Debian test again with this patch?

> diff --git a/testcases/kernel/syscalls/waitpid/waitpid01.c
> b/testcases/kernel/syscalls/waitpid/waitpid01.c
> index 367f7875c..a42b7e8ac 100644
> --- a/testcases/kernel/syscalls/waitpid/waitpid01.c
> +++ b/testcases/kernel/syscalls/waitpid/waitpid01.c
> @@ -94,6 +94,9 @@ static void run(unsigned int n)
>         int status;
>         const struct testcase *tc = testcase_list + n;

> +       if (tc->sig != SIGKILL)
> +               SAFE_SIGNAL(tc->sig, SIG_DFL);
> +

Ah, reset the signal, thanks!

It works on the current master, but because different patch would broke your
waiting waitpid01 patch, so that I'll review and merge it first.

Will you send this as a patch or should I merge this as your Suggested-by: ?

Kind regards,
Petr

>         pid = SAFE_FORK();
>         if (!pid)
>                 variant_list[tst_variant].func(tc->sig);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
