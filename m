Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21968C4332F
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 13:55:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 582A23CF3F9
	for <ltp@archiver.kernel.org>; Mon, 30 Oct 2023 14:55:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 868BD3CC965
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 14:55:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DF6231A009A1
 for <ltp@lists.linux.it>; Mon, 30 Oct 2023 14:55:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DC2FD21845;
 Mon, 30 Oct 2023 13:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698674135; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U/WeJXdN6l3lDdDFNfjXrqx/aWEtGBL3j2WZXdfwmTM=;
 b=tDxyqo0mkWGRb77hAzbdDylK7l09rwGSt0nyqypjEkIv8ew5sRdw7ual71BoaRS6fAxb8X
 L0s/0WpIr5lraxWwWLZ4wx/q3otj0st9yqvGh2S9XBiHaaYOAlHp3mocen/HUOyStA2AQ8
 /T9fCg17butz0U+yXwoJUl/v5vplorE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698674135;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U/WeJXdN6l3lDdDFNfjXrqx/aWEtGBL3j2WZXdfwmTM=;
 b=8b9euijnBxvQZOJGH/+J38l8fEXuNSXWzkuRu0i9TUfztDPM75tFBVZgwzBy2P+pjWp5d8
 vV1nl1ysrKt00cDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C72B8138F8;
 Mon, 30 Oct 2023 13:55:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DMsyL9e1P2WuLAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 30 Oct 2023 13:55:35 +0000
Date: Mon, 30 Oct 2023 14:56:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZT-19kgC8PqKMlb8@yuki>
References: <20230904111940.26824-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230904111940.26824-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor timer_getoverrun test using new LTP
 API
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
> +	switch (tst_variant) {
> +	case 0:
> +		SAFE_TIMER_CREATE(CLOCK_REALTIME, &ev, &timer);
> +		TST_EXP_POSITIVE(timer_getoverrun(timer));
> +
> +		/* glibc causes SIGSEGV where timer_getoverrun() fails with EINVAL */
> +#ifndef __GLIBC__
> +		TST_EXP_FAIL(timer_getoverrun((timer_t)-1), EINVAL);
> +#endif

I wonder if we should even keep it here, the most likely end result is
that we will have to add to this ifdef once other libc implementations
attempt to interpret the id before passing it to kernel. Maybe we should
just remove it and save our future time.

> +		break;
> +	case 1:
> +		tst_syscall(__NR_timer_create, CLOCK_REALTIME, &ev, &timer);
> +		TST_EXP_POSITIVE(tst_syscall(__NR_timer_getoverrun, timer));
> +		TST_EXP_FAIL(tst_syscall(__NR_timer_getoverrun, -1), EINVAL);

There are actually two different cases that can cause EINVAL in the
kernel, first obvious case is that we id > INT_MAX, the second case is
failed lookup. I suppose that the -1 gets casted to unsigned long long
in kernel and ends up > INT_MAX.

I guess to trigger the second case we can call timer_delete(timer); and
then test it as:
		TST_EXP_FAIL(tst_syscall(__NR_timer_getoverrun, timer), EINVAL);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
