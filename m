Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28ACBC433FE
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 15:24:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D6D03C7ACE
	for <ltp@archiver.kernel.org>; Mon, 21 Mar 2022 16:24:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 674EB3C061B
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 16:24:32 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8A38F6006EF
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 16:24:31 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B365F210EE
 for <ltp@lists.linux.it>; Mon, 21 Mar 2022 15:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647876270;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pXQJTKCwtI3/LgiUs3YAA1nCYgbslMoQJAPyT/aecig=;
 b=rKiQEbM9TvGPb1eAjXZ/KRlBB8OJ0EDFzh+dvwEgMaB2xjFZUhZ5v7tR0dnsSVRD/SaXy/
 OcEFHqLp8HXywParbNqbW8gk9Jcf3Zb3C46Lnax5fJFzYuPzzQ6gXbffGgKWd4l4a2vuPh
 JoWG4D2HjqU6Z8JBYphdzW+O681ZC+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647876270;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pXQJTKCwtI3/LgiUs3YAA1nCYgbslMoQJAPyT/aecig=;
 b=rw5nWwYRKo1vugkb1RGfsVpuRJLKs7NtlhE/fPiXzqQcHyEx64v2dZapd+8YK2ZqFEGxLV
 jpEbSX9tHZnkIKBw==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8491DA3B9D;
 Mon, 21 Mar 2022 15:24:30 +0000 (UTC)
References: <20220321133849.14924-1-chrubis@suse.cz>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 21 Mar 2022 15:17:55 +0000
In-reply-to: <20220321133849.14924-1-chrubis@suse.cz>
Message-ID: <87ils7corb.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] waitid10: Fix when coredumps are piped
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello

Cyril Hrubis <chrubis@suse.cz> writes:

> When coredumps are piped into a stdin of a program (the core_pattern
> starts with '|') the RLIMIT_CORE limits are not enforced.
>
> This fixes the test expectation in the corner case that rlim_cur and
> rlim_max for RLIMIT_CORE are both set to 0 but the core pattern is set
> to dump core into a pipe where we previously assumed the core wouldn't
> be dumped.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/syscalls/waitid/waitid10.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
> index 869ef18bd..e75edd07e 100644
> --- a/testcases/kernel/syscalls/waitid/waitid10.c
> +++ b/testcases/kernel/syscalls/waitid/waitid10.c
> @@ -45,14 +45,17 @@ static void run(void)
>  static void setup(void)
>  {
>  	struct rlimit rlim;
> +	char c;
>  
>  	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
> +	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%c", &c);
>  
>  	if (rlim.rlim_cur)
>  		return;
>  
>  	if (!rlim.rlim_max) {
> -		core_dumps = 0;
> +		if (c != '|')
> +			core_dumps = 0;
>  		return;
>  	}
>  
> -- 
> 2.34.1

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

BTW I thought that division by zero actually just resulted in zero or
INT_MAX on some platforms? (e.g. ARM)

It's undefined behaviour, so I fail to see how this test has ever worked
on some architectures. Perhaps we should dereference a null/invalid
pointer instead?


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
