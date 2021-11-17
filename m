Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4286C433F5
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 10:38:58 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31030617E4
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 10:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31030617E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 960013C8861
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 11:38:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E7B43C072D
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 11:38:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ECAF4100119F
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 11:38:45 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 33AE921709;
 Wed, 17 Nov 2021 10:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637145525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZo3zbRHqudfyQBsTWMMO5+9Un7trjPnMx/6xTn/cc8=;
 b=qHsNoL6/py6c2n0Fg2zz17Dv6N5ogvRfiMb6odPzrPCMx6E28DlKJZ6EqpmZFldWsncr9C
 opoNVcuBIK9YLsTYSIrRHeCwVJSpQW6VT6YYnYb63w3UnhgeFNnBAsdWfO3hTv6HycEzix
 IhmOJR1G2ImRuhq8qJFx4gd0eF5/6VQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637145525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FZo3zbRHqudfyQBsTWMMO5+9Un7trjPnMx/6xTn/cc8=;
 b=6gzMwX6EKBwQlIKFla7IFRBbbLlKMeF+I+YZqFH4pvikkaU+/L7kQqk9Kb1UW9HcH5CM4Y
 /doJxmp34YXJkoBg==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F3DECA3B83;
 Wed, 17 Nov 2021 10:38:44 +0000 (UTC)
References: <20211117070708.2174932-1-liwang@redhat.com>
 <20211117070708.2174932-3-liwang@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Wed, 17 Nov 2021 10:33:57 +0000
In-reply-to: <20211117070708.2174932-3-liwang@redhat.com>
Message-ID: <87v90r9idn.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/3] max_map_count: replace ifdefs by tst_arch
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

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Signed-off-by: Li Wang <liwang@redhat.com>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/mem/tunable/max_map_count.c | 46 ++++++++++----------
>  1 file changed, 24 insertions(+), 22 deletions(-)
>
> diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
> index 4f0ad0037..a4c3dbf8e 100644
> --- a/testcases/kernel/mem/tunable/max_map_count.c
> +++ b/testcases/kernel/mem/tunable/max_map_count.c
> @@ -55,7 +55,6 @@
>  
>  static long old_max_map_count = -1;
>  static long old_overcommit = -1;
> -static struct utsname un;
>  
>  static void setup(void)
>  {
> @@ -66,9 +65,6 @@ static void setup(void)
>  	old_max_map_count = get_sys_tune("max_map_count");
>  	old_overcommit = get_sys_tune("overcommit_memory");
>  	set_sys_tune("overcommit_memory", 0, 1);
> -
> -	if (uname(&un) != 0)
> -		tst_brk(TBROK | TERRNO, "uname error");
>  }
>  
>  static void cleanup(void)
> @@ -91,24 +87,30 @@ static bool filter_map(const char *line)
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
> +		break;
> +	case TST_IA64:
> +		/* On ia64, the vdso is not a proper mapping */
> +		if (!strcmp(buf, "[vdso]"))
> +			return true;
> +		break;
> +	case TST_ARM:
> +		/* Skip it when run it in aarch64 */

This should not be possible. If TST_ARM is set then how can we be on
aarch64? We also have TST_AARCH64.

> +		if (tst_kernel_bits() == 64)
> +			return false;
> +
> +		/* Older arm kernels didn't label their vdso maps */
> +		if (!strncmp(line, "ffff0000-ffff1000", 17))
> +			return true;
> +		break;
> +	default:
> +		break;
> +	};
>  
>  	return false;
>  }
> -- 
> 2.31.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
