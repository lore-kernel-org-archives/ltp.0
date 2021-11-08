Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A99C433FE
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 12:43:55 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FAD61288
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 12:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37FAD61288
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7966D3C77D1
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 13:43:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C1F53C101C
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 13:43:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BE00C600791
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 13:43:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 248E0212CA;
 Mon,  8 Nov 2021 12:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636375423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4iwfhEGhQCdHVgc10U9RSYbdCo/MO0IZr9MjmETKBYE=;
 b=DErSosCP9syzQM6IDoUGpfArgWamPbeDRjqIY4UrBpRyw0Iy6mnoOFfXF4XxjDQ85yd0QO
 yCKtQUhW6f8DUiXLKtMtmVvJWqksktRN/FVBO1BumcBuEi62oThhLFpUzr+iGBNvYjBcdn
 eR1ObEG4ZWUghJBgzuT7DX9oKa78800=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636375423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4iwfhEGhQCdHVgc10U9RSYbdCo/MO0IZr9MjmETKBYE=;
 b=uB9wVrtWAUVIaIrNDi9ddg8Dycyl/KoZ8Q2JQDyqzgsuNBgsls6WwFBK2F/6j2QW6ho9My
 va5KBlfIB5GtKlCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0520B13BA0;
 Mon,  8 Nov 2021 12:43:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +xpJOn4biWGqawAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 08 Nov 2021 12:43:42 +0000
Date: Mon, 8 Nov 2021 13:44:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YYkbujntxMkANsG6@yuki>
References: <20211108021450.1460819-1-liwang@redhat.com>
 <20211108021450.1460819-3-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211108021450.1460819-3-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] max_map_count: replace ifdefs by tst_arch
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

On Mon, Nov 08, 2021 at 10:14:50AM +0800, Li Wang wrote:
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/mem/tunable/max_map_count.c | 41 +++++++++++---------
>  1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
> index 4f0ad0037..9da67520c 100644
> --- a/testcases/kernel/mem/tunable/max_map_count.c
> +++ b/testcases/kernel/mem/tunable/max_map_count.c
> @@ -91,24 +91,29 @@ static bool filter_map(const char *line)
>  	if (ret != 1)
>  		return false;
>  
> -#if defined(__x86_64__) || defined(__x86__)
> -	/* On x86, there's an old compat vsyscall page */
> -	if (!strcmp(buf, "[vsyscall]"))
> -		return true;
> -#elif defined(__ia64__)
> -	/* On ia64, the vdso is not a proper mapping */
> -	if (!strcmp(buf, "[vdso]"))
> -		return true;
> -#elif defined(__arm__)
> -	/* Skip it when run it in aarch64 */
> -	if ((!strcmp(un.machine, "aarch64"))
> -	|| (!strcmp(un.machine, "aarch64_be")))
> -		return false;
> -
> -	/* Older arm kernels didn't label their vdso maps */
> -	if (!strncmp(line, "ffff0000-ffff1000", 17))
> -		return true;
> -#endif
> +	switch (tst_arch.type) {
> +	case TST_X86:
> +	case TST_X86_64:
> +		/* On x86, there's an old compat vsyscall page */
> +		if (!strcmp(buf, "[vsyscall]"))
> +			return true;
> +	break;
> +	case TST_IA64:
> +		/* On ia64, the vdso is not a proper mapping */
> +		if (!strcmp(buf, "[vdso]"))
> +			return true;
> +	break;
> +	case TST_ARM:
> +		/* Skip it when run it in aarch64 */
> +		if ((!strcmp(un.machine, "aarch64"))
> +				|| (!strcmp(un.machine, "aarch64_be")))
> +			return false;

		I wonder if this would be better as:

		if (tst_kernel_bits() == 64)
			return false;

Other than this the code looks actually better this way.

> +		/* Older arm kernels didn't label their vdso maps */
> +		if (!strncmp(line, "ffff0000-ffff1000", 17))
> +			return true;
> +	break;
> +	};
>  
>  	return false;
>  }
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
