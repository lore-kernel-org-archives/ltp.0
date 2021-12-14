Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC20CC433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 16:01:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37B0F3C8DD7
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 17:01:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B4C43C8B34
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 17:01:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 26861140138F
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 17:01:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 315301F383;
 Tue, 14 Dec 2021 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639497701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bN60ts/6mToDoGTSk1vKSUnUN3K5eklWXbgU1H00UBs=;
 b=PGGc97I6Q9as7CLenWnFr19JlRJWSvyPBHvaf+gAgUs4a/uo06RILA7eZBTENuilWQGihW
 DSGPZzvRbGRXDS4pKWYU2YlXHUkm9zTdu2wFEDBBkyDysXSsk6/LRuUt9LVyfeS1+jxnkK
 Y5owzDYZN+ArnSxD2cCAoMQsS0NQ4Jc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639497701;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bN60ts/6mToDoGTSk1vKSUnUN3K5eklWXbgU1H00UBs=;
 b=v7s4OCU/qCT7u27jIVsm4GVbJiI8kPe9Qb+hJKvY4iPCkRePwdkoQ1xynFCo4mqBmBAVzQ
 zFmShzi3H4FSY1DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E34C13EA2;
 Tue, 14 Dec 2021 16:01:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id U2ryBuW/uGFDdAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Dec 2021 16:01:41 +0000
Date: Tue, 14 Dec 2021 17:03:05 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YbjAOffrWpsMvinQ@yuki>
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211214144309.6704-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: Add support for debugging
 .all_filesystems
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
> +| 'LTP_SINGLE_FS_TYPE'  | Testing only specified filesystem instead all
                                         ^   ^
					 |   "specifies"
					 there should be comma or dash here

> +                          supported (for tests with '.all_filesystems').
>  | 'LTP_DEV_FS_TYPE'     | Filesystem used for testing (default: 'ext2').
>  | 'LTP_TIMEOUT_MUL'     | Multiply timeout, must be number >= 1 (> 1 is useful for
>                            slow machines to avoid unexpected timeout).
> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index fc072cadfd..23e5ce8775 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -139,8 +139,17 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
>  	unsigned int i, j = 0;
>  	int skip_fuse;
>  	enum tst_fs_impl sup;
> +	const char *only_fs;
>  
>  	skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
> +	only_fs = getenv("LTP_SINGLE_FS_TYPE");
> +
> +	if (only_fs) {
> +		tst_res(TINFO, "WARNING: testing only %s", only_fs);
> +		if (tst_fs_is_supported(only_fs))
> +			fs_types[0] = only_fs;
> +		return fs_types;
> +	}
>  
>  	for (i = 0; fs_type_whitelist[i]; i++) {
>  		if (tst_fs_in_skiplist(fs_type_whitelist[i], skiplist)) {
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index f92ff858e9..ce2b8239d7 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -483,6 +483,7 @@ static void print_help(void)
>  	fprintf(stderr, "LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)\n");
>  	fprintf(stderr, "LTP_DEV              Path to the block device to be used (for .needs_device)\n");
>  	fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
> +	fprintf(stderr, "LTP_SINGLE_FS_TYPE   Testing only specified filesystem instead all supported (for .all_filesystems)\n");
>  	fprintf(stderr, "LTP_TIMEOUT_MUL      Multiply timeout (must be number >= 1)\n");
>  	fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm\n");
>  	fprintf(stderr, "TMPDIR               Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);

Other than that the rest looks fine, for the patchset:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
