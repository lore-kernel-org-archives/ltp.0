Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E71C6FD1D
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 16:50:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 854903CD338
	for <ltp@archiver.kernel.org>; Tue, 21 Mar 2023 17:50:32 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F5223C56B7
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 17:50:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB649600831
 for <ltp@lists.linux.it>; Tue, 21 Mar 2023 17:50:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4960C20260;
 Tue, 21 Mar 2023 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679417418;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6TCrLcTlOiG+rQ1nUtdmLboRd5Bi/H4dFtqbslZwhY=;
 b=AEWZKSNaeVGBj4F2kw17de/kw4ZV3YP7yVtAxHtqEyGrKJsgKqMgyKLIB8zVQZojQaB1LW
 UK3txktOKwLEfcHopIkuCjq2Ds574EdFpcilKlb/+bO8TCoONXYCz+nG9Q4ajA8eX3yPLn
 Uy27IoFXv4bmfYdzl9n+aIwv6msH3uE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679417418;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u6TCrLcTlOiG+rQ1nUtdmLboRd5Bi/H4dFtqbslZwhY=;
 b=i7aqRocI6dLPnlYQEHTPbQJePrH+PdNFW+hUJa7ze/rp19iPJ0C0JZL257DQA3tfHAa5Ku
 uYgLE9Asgn78+kBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17CD013451;
 Tue, 21 Mar 2023 16:50:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bYMsBErgGWR6DQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Mar 2023 16:50:18 +0000
Date: Tue, 21 Mar 2023 17:50:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230321165016.GA306314@pevik>
References: <20230313134133.8396-1-wegao@suse.com>
 <20230314093725.3814-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230314093725.3814-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] madvise11.c:Check loadable module before rmmod
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

FYI although it turned out that CONFIG_HWPOISON_INJECT=y in one of our kernels
was a mistake (will be changed to CONFIG_HWPOISON_INJECT=m, which is the default
since kernel ~ 3.14 thus nobody noticed), the test still should work with
CONFIG_HWPOISON_INJECT=y.

BTW I'd personally put madvise11.c change to separate commit.

nit: the title should be:

madvise11: Check if module is loadable before rmmod

> Following fail msg will popup if we try to rmmod buildin module:
> rmmod: ERROR: Module hwpoison_inject is builtin

> So need add extra check.

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  include/tst_kernel.h                          | 10 ++++++
>  lib/tst_kernel.c                              | 36 +++++++++++--------
>  testcases/kernel/syscalls/madvise/madvise11.c |  2 +-
>  3 files changed, 33 insertions(+), 15 deletions(-)

> diff --git a/include/tst_kernel.h b/include/tst_kernel.h
> index 9e17bb71e..0c1262e2f 100644
> --- a/include/tst_kernel.h
> +++ b/include/tst_kernel.h
> @@ -10,6 +10,16 @@
>   */
>  int tst_kernel_bits(void);

> +/*
> + * Checks builtin module for the kernel driver.
Check if the kernel module is built-in .
> + *
> + * @param driver The name of the driver.
> + * @return Returns 0 if builtin driver
> + * -1 when driver is missing or config file not available.
> + * On Android *always* 0 (always expect the driver is available).
> + */
> +int tst_check_builtin_driver(const char *driver);
> +
>  /**
>   * Checks support for the kernel driver.
Checks support for the kernel module (both built-in and loadable).

I'm willing to do the changes before merge.

Kind regards,
Petr

>   *
> diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
> index ecf4b917e..be3ec92da 100644
> --- a/lib/tst_kernel.c
> +++ b/lib/tst_kernel.c
> @@ -90,7 +90,7 @@ int tst_kernel_bits(void)
>  	return kernel_bits;
>  }

> -static int tst_search_driver(const char *driver, const char *file)
> +static int tst_search_driver_(const char *driver, const char *file)
>  {
>  	struct stat st;
>  	char buf[PATH_MAX];
> @@ -144,28 +144,19 @@ static int tst_search_driver(const char *driver, const char *file)
>  	return ret;
>  }

> -static int tst_check_driver_(const char *driver)
> -{
> -	if (!tst_search_driver(driver, "modules.dep") ||
> -		!tst_search_driver(driver, "modules.builtin"))
> -		return 0;
> -
> -	return -1;
> -}
> -
> -int tst_check_driver(const char *driver)
> +static int tst_search_driver(const char *driver, const char *file)
>  {
>  #ifdef __ANDROID__
>  	/*
>  	 * Android may not have properly installed modules.* files. We could
> -	 * search modules in /system/lib/modules, but to to determine built-in
> +	 * search modules in /system/lib/modules, but to determine built-in
>  	 * drivers we need modules.builtin. Therefore assume all drivers are
>  	 * available.
>  	 */
>  	return 0;
>  #endif

> -	if (!tst_check_driver_(driver))
> +	if (!tst_search_driver_(driver, file))
>  		return 0;

>  	int ret = -1;
> @@ -183,9 +174,26 @@ int tst_check_driver(const char *driver)
>  		while ((ix = strchr(ix, find)))
>  			*ix++ = replace;

> -		ret = tst_check_driver_(driver2);
> +		ret = tst_search_driver_(driver2, file);
>  		free(driver2);
>  	}

>  	return ret;
>  }
> +
> +int tst_check_builtin_driver(const char *driver)
> +{
> +	if (!tst_search_driver(driver, "modules.builtin"))
> +		return 0;
> +
> +	return -1;
> +}
> +
> +int tst_check_driver(const char *driver)
> +{
> +	if (!tst_search_driver(driver, "modules.dep") ||
> +		!tst_search_driver(driver, "modules.builtin"))
> +		return 0;
> +
> +	return -1;
> +}
> diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
> index 7e291d571..4d99d5289 100644
> --- a/testcases/kernel/syscalls/madvise/madvise11.c
> +++ b/testcases/kernel/syscalls/madvise/madvise11.c
> @@ -300,7 +300,7 @@ static int open_unpoison_pfn(void)
>  	struct mntent *mnt;
>  	FILE *mntf;

> -	if (!find_in_file("/proc/modules", HW_MODULE))
> +	if (!find_in_file("/proc/modules", HW_MODULE) && tst_check_builtin_driver(HW_MODULE))
>  		hwpoison_probe = 1;

>  	/* probe hwpoison only if it isn't already there */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
