Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D483CE7B0B
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 07:36:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A0593CE12A
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 09:36:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 307353C0123
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 09:36:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B17F71000610
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 09:36:29 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id DC62521871;
 Thu, 28 Sep 2023 07:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695886584;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSmMfiLwWivK+opZGx2HwGvUetfhnWM5MO3e+UJSjgY=;
 b=ezSGWi+vHepjtHA98EEkHR/PgpYXVgJfrnp27xttnHs077GAhgWUt87+PiF4VCXvWyGOjD
 mwz5TW73fhuED+24T4GDPOOppp/EJzOqGe+Y4Oqs4b3laEfi9VsE678lejvWCKrc9hmM9x
 Hme4fXCn3prAqaiPEuDpsVEbSPjc5M4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695886584;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSmMfiLwWivK+opZGx2HwGvUetfhnWM5MO3e+UJSjgY=;
 b=ZZw1vRBS9u/Ps60XdxqNy2LXx6QKbIvvQIE7pCgW1/e0CgCqkcv6U9RyGZ10cnrfn5dZJA
 gOrigv55VTy3HBDA==
Received: from g78 (rpalethorpe.tcp.ovpn1.nue.suse.de [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8EF5D2C142;
 Thu, 28 Sep 2023 07:36:24 +0000 (UTC)
References: <20230928010808.15862-1-wegao@suse.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Thu, 28 Sep 2023 08:06:09 +0100
Organization: Linux Private Site
In-reply-to: <20230928010808.15862-1-wegao@suse.com>
Message-ID: <87lecqeolk.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] getcwd01: Only check buffer NULL on glibc
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

Hello,

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---

Need to mention the github issue in the commit
https://github.com/linux-test-project/ltp/issues/1084

>  testcases/kernel/syscalls/getcwd/getcwd01.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
> index 65d827873..6769eb6f4 100644
> --- a/testcases/kernel/syscalls/getcwd/getcwd01.c
> +++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
> @@ -34,10 +34,13 @@ static struct t_case {
>  	int exp_err;
>  } tcases[] = {
>  	{(void *)-1, PATH_MAX, EFAULT},
> -	{NULL, (size_t)-1, ENOMEM},
>  	{buffer, 0, EINVAL},
>  	{buffer, 1, ERANGE},
> +/* musl and uclibc-ng will allocate memory before syscall if buf == NULL */
> +#ifdef __GLIBC__
> +	{NULL, (size_t)-1, ENOMEM},

I'd prefer a more general solution. There are a lot of failures like
this. I've seen a lot in the past in glibc where it changed its
behaviour.

Most of these failures follow the same pattern:
pass an invalid argument -> expect a particular kernel error code.

Two things go wrong:
1. libc does something with the invalid value
   a. performs some extended behaviour (like above)
   b. segfaults
2. kernel returns an unexpected error code because the value or context
   are invalid in multiple ways.

For 1. we can usually call the system call directly. This solution has
       been used before. It works for most syscalls except ones like clone.

For 2. Beyond reporting these errors I'm just going to ignore tests like this.

>  	{NULL, 1, ERANGE}
> +#endif
>  };
>  
>  static void verify_getcwd(unsigned int n)
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
