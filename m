Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3293CC433EF
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 11:06:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46C523C6EBE
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 12:06:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B84AB3C2590
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 12:06:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 455C21401123
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 12:06:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E5841F37C;
 Thu,  6 Jan 2022 11:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641467163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vc9miIeigEVYXcHZvxA6U0cB2sHPgUVWjXoE195ogEk=;
 b=WKtrhqr3iimI7cxVqDa+/heeAmRt62jtfQ/fHJvGefzUGBWnItSaAOiEn762HVOXm+WedV
 LGQ/KRHK1Qji7zDCpm/iTX4jDVUnip5jzwEwdgJ2ieXPt9/9EMqKsT7KD3B4p0OpLHVylL
 LXC/dim/xDm5xYxweYuixHbWE3V0mXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641467163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vc9miIeigEVYXcHZvxA6U0cB2sHPgUVWjXoE195ogEk=;
 b=jHRwJJnYqXpLGttybrFwnizle5jhQfWjFaSHlofc4su/kc2wAaVLez0hF5+tggADwRILYL
 mH2lhY3qJXkKj/AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E513913C3E;
 Thu,  6 Jan 2022 11:06:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7P52NhrN1mHOEgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 06 Jan 2022 11:06:02 +0000
Date: Thu, 6 Jan 2022 12:07:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YdbNdknOelj9H3ji@yuki>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641461121-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] lib: Introduce LTP_KCONFIG_DISABLE
 environment variables
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
> diff --git a/doc/user-guide.txt b/doc/user-guide.txt
> index 494652618..8d4435a28 100644
> --- a/doc/user-guide.txt
> +++ b/doc/user-guide.txt
> @@ -18,6 +18,9 @@ For running LTP network tests see `testcases/network/README.md`.
>  | 'LTP_SINGLE_FS_TYPE'  | Testing only - specifies filesystem instead all
>                            supported (for tests with '.all_filesystems').
>  | 'LTP_DEV_FS_TYPE'     | Filesystem used for testing (default: 'ext2').
> +| 'LTP_KCONFIG_DISABLE' | Switch for kernel config check functionality.
> +                          'y' or '1': disable kconfig check,
> +                          'n' or '0': enable kconfig check.

Maybe it would be better named LTP_KCONFIG_SKIP or even
KCONFIG_SKIP_CHECK we do have KCONFIG_PATH so it would make sense to
keep the kernel config related variables prefixed with just KCONFIG_

I think that the point made by Tim Bird was that the KCONFIG_PATH should
be standartized variable among testsuites, so it makes sense to have
KCONFIG_SKIP_CHECK as a standartized variable as well.

[CC: Tim should we start tracking common env variables like this somewhere?]

>  | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
>                            slow machines to avoid unexpected timeout).
>                            Variable is also used in shell tests, but ceiled to int.
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index dc7decff9..c37afd8c8 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -478,6 +478,27 @@ static void dump_vars(const struct tst_expr *expr)
>  	}
>  }
>  
> +static int tst_kconfig_disabled(void)
> +{
> +	static int check;
> +
> +	if (check)
> +		return check - 1;
> +
> +	char *env = getenv("LTP_KCONFIG_DISABLE");
> +
> +	if (env) {
> +		if (!strcmp(env, "n") || !strcmp(env, "0"))
> +			check = 1;
> +		if (!strcmp(env, "y") || !strcmp(env, "1"))
> +			check = 2;
> +		return check - 1;
> +	}
> +
> +	check = 1;
> +	return 0;
> +}

As pointed out by Peter, can we please keep it simple? I.e. just branch
on variable defined/undefined?

>  int tst_kconfig_check(const char *const kconfigs[])
>  {
>  	size_t expr_cnt = array_len(kconfigs);
> @@ -485,6 +506,11 @@ int tst_kconfig_check(const char *const kconfigs[])
>  	unsigned int i, var_cnt;
>  	int ret = 0;
>  
> +	if (tst_kconfig_disabled()) {
> +		tst_res(TINFO, "Kernel config check functionality has been disabled.");

I would try to make more clear what has happened here, something as:

"Skipping kernel config check as requested"

Or something along these lines.

> +		return 0;
> +	}
> +
>  	for (i = 0; i < expr_cnt; i++) {
>  		exprs[i] = tst_bool_expr_parse(kconfigs[i]);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
