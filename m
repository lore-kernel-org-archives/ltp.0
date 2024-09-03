Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB865CD343E
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 15:16:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B97E3C564D
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 17:16:57 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D1803C12A6
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 17:16:42 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C00611A01930
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 17:16:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B27B21B82;
 Tue,  3 Sep 2024 15:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725376600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9vZL1kcdl22pEcdAfCQEygqeoosgaygPBcEtEGkpM4=;
 b=mk0+75W5QXMH03jM3QKHDPYnHYxuSeNy2Eky6cdZ/nnL2Wg+rxZdvlr5X+iXlgyif9Qrtp
 mIERUtbtUuHXIuWJNCHODrLOsU2AjLaue+Bx2uuDxsUXzFaG9+z/+hO9XdyW0gKOEYs/7o
 JSBHjOeX5bOcQZSsQG8fgpiprIXYzWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725376600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9vZL1kcdl22pEcdAfCQEygqeoosgaygPBcEtEGkpM4=;
 b=pKt23yX1AyycfH6dA27Yp/p9bU+C35WpdJQbiMzy/A00oMivReNgHkC8Bi75B299zUF4y/
 IbAvZIvX1BgrwJDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725376600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9vZL1kcdl22pEcdAfCQEygqeoosgaygPBcEtEGkpM4=;
 b=mk0+75W5QXMH03jM3QKHDPYnHYxuSeNy2Eky6cdZ/nnL2Wg+rxZdvlr5X+iXlgyif9Qrtp
 mIERUtbtUuHXIuWJNCHODrLOsU2AjLaue+Bx2uuDxsUXzFaG9+z/+hO9XdyW0gKOEYs/7o
 JSBHjOeX5bOcQZSsQG8fgpiprIXYzWs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725376600;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9vZL1kcdl22pEcdAfCQEygqeoosgaygPBcEtEGkpM4=;
 b=pKt23yX1AyycfH6dA27Yp/p9bU+C35WpdJQbiMzy/A00oMivReNgHkC8Bi75B299zUF4y/
 IbAvZIvX1BgrwJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B12C13A80;
 Tue,  3 Sep 2024 15:16:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ST6nAVgo12b8agAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 03 Sep 2024 15:16:40 +0000
Date: Tue, 3 Sep 2024 17:15:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZtcoDmsWrMu8Qaze@yuki.lan>
References: <20240903140326.773060-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240903140326.773060-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] swapoff01: Define max_runtime 45s
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
> Test run mostly below 1 sec per filesystem, only NTFS is very slow
> ~ 10-15 sec depending on architecture.

If part of the slowdown is caused by the fact that we format the
filesystems the real question is if all the tests that format and mount
a device should have a max_runtime defined. It may make sense to
increment the max_runtime in the test library to compensate for the
mkfs, but it looks that it's not the mkfs that is slow.

I did some measurements for the swapoff01 case and the whole testrun
runs for about 10 seconds for me. If I change the test to do
tst_brk(TCONF, ...) as the first thing in the test setup its 1s. So
writing out the 1MB of swapfile and running mkswap and swapon() on that
takes about 90% of the runtime.

So yes it looks like the actual test needs some runtime defined,
although I'm not sure how long it should be. We probably need a
reference machine to callibrate this on. I would avoid any emulated CPU
and choose a real hardware. I guess one of the RPis e.g. Pi Zero would
be a good choice since they are widely available and slow by any modern
standards.

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * 60 => 45
> 
>  testcases/kernel/syscalls/swapoff/swapoff01.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
> index 314630267d..ef75c92de0 100644
> --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> @@ -53,5 +53,6 @@ static struct tst_test test = {
>  	.all_filesystems = 1,
>  	.needs_root = 1,
>  	.test_all = verify_swapoff,
> +	.max_runtime = 45,
>  	.setup = setup
>  };
> -- 
> 2.45.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
