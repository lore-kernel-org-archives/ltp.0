Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C84C433F5
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:18:51 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C85D613D0
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:18:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C85D613D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55BFD3C7084
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 10:18:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7864D3C1B31
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 10:18:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AB6301001198
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 10:18:38 +0200 (CEST)
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id 02F3522529;
 Wed, 29 Sep 2021 08:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632903518;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cC85woQW2pt3RNzTVHsAJ3b6d3DP2WE6MMTK9Fninl4=;
 b=HDvv7jOU02sY1x22jjd7rrvJY73KtoeY7LcS+YvxGt0FZwjUhZQfj9YFw1AScsWHdqANNT
 pjcRzSKUwSjeIpqzEkNBcvzxdMrxgwAMwGXaK1PYa9zVXuFlpvJYJDpdBmEjoTmQUhL3fb
 hEM5O0YP/hg3Fabk+b/Y5o24BRoG0D8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632903518;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cC85woQW2pt3RNzTVHsAJ3b6d3DP2WE6MMTK9Fninl4=;
 b=rYN9qTuVuyEPFQRHI9UR9nW6RbLjWvoDcOhxz8mUk4xuRNf8Aa4C7nGJb4MlZ/DSUX9s5k
 dELxyD+F/g8CHhCQ==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay1.suse.de (Postfix) with ESMTPS id C807525D66;
 Wed, 29 Sep 2021 08:18:37 +0000 (UTC)
References: <20210928021850.2015065-1-ralph.siemsen@linaro.org>
User-agent: mu4e 1.6.5; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 29 Sep 2021 09:14:56 +0100
In-reply-to: <20210928021850.2015065-1-ralph.siemsen@linaro.org>
Message-ID: <87ee97g5gi.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: fix MemAvailable parsing
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

Hello Ralph,

Ralph Siemsen <ralph.siemsen@linaro.org> writes:

> The amount of available memory was not being returned correctly, which
> resulted in tests being executed when they should have been skipped.
>
> Fixes: 8759f4 ("lib: adjust the tmpfs size according to .dev_min_size and MemAvailable")
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>  lib/tst_memutils.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index 69077861f..90911da56 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -65,9 +65,9 @@ void tst_pollute_memory(size_t maxsize, int fillchar)
>  
>  long long tst_available_mem(void)
>  {
> -	long long mem_available;
> +	long long mem_available = 0;
>  
> -	if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %ld",
> +	if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %lld",
>  		&mem_available)) {
>  		mem_available = SAFE_READ_MEMINFO("MemFree:")
>  			+ SAFE_READ_MEMINFO("Cached:");
> -- 
> 2.25.1

Just curious, did you find this on 32-bit ARM?

Anyway looks correct.

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
