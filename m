Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C39C5AD49
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 15:51:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 003F63C0319
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 17:51:56 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B7E03C0229
 for <ltp@lists.linux.it>; Mon, 26 May 2025 17:51:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 94C4D14000B4
 for <ltp@lists.linux.it>; Mon, 26 May 2025 17:51:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 824391F793;
 Mon, 26 May 2025 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748274697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shVeIiX5r6jYnSqZgzNlsHdqK3Zy3FZHc2brIl1HS8U=;
 b=3We3eVXzDxTVUILgBkV1MMoDrJxbbTkvdRm+hLOgVn9M109JK3r5zBGZET8s8/L1O31MBk
 1TvsrqdVs9ErQSJqGqlm0yqSutjg8cQXnh/AkZjjHxN1WXbcqn2dQJ4Dx825+FAf9oN/r0
 PUNGdYzJzgmLNZ4Y+XsRCZXRwNdvaqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748274697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shVeIiX5r6jYnSqZgzNlsHdqK3Zy3FZHc2brIl1HS8U=;
 b=u0Z/FoFU+1/t3fzbT6yFYzc8be/EtJrvHu9FU17yfCVWmgO8KlmVE1bXMQ5kE2S0lWJafz
 iaF8e/1omDzej+DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748274697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shVeIiX5r6jYnSqZgzNlsHdqK3Zy3FZHc2brIl1HS8U=;
 b=3We3eVXzDxTVUILgBkV1MMoDrJxbbTkvdRm+hLOgVn9M109JK3r5zBGZET8s8/L1O31MBk
 1TvsrqdVs9ErQSJqGqlm0yqSutjg8cQXnh/AkZjjHxN1WXbcqn2dQJ4Dx825+FAf9oN/r0
 PUNGdYzJzgmLNZ4Y+XsRCZXRwNdvaqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748274697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shVeIiX5r6jYnSqZgzNlsHdqK3Zy3FZHc2brIl1HS8U=;
 b=u0Z/FoFU+1/t3fzbT6yFYzc8be/EtJrvHu9FU17yfCVWmgO8KlmVE1bXMQ5kE2S0lWJafz
 iaF8e/1omDzej+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 578E61397F;
 Mon, 26 May 2025 15:51:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 56drFAmONGifaQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 26 May 2025 15:51:37 +0000
Date: Mon, 26 May 2025 17:51:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250526155132.GA151544@pevik>
References: <20250526143429.22997-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250526143429.22997-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] lib: LTP_SINGLE_FS_TYPE and
 LTP_FORCE_SINGLE_FS_TYPE
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

@Li @Jan Could you please have a look?
It'd be nice to include it in the release.

> Make the LTP_SINGE_FS_TYPE to use the test skiplists both for
> filesystems and fuse. This fixes the usecase where LTP users want to
> limit the tests with '.all_filesystems' to a single filesystem type
> for a testrun.

> The LTP_FORCE_SINGLE_FS_TYPE now replaces what previously
> LTP_SINGLE_FS_TYPE did and can be used for testing and for that purpose
> it ignores the test skiplists.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Suggested-by:  Petr Vorel <pvorel@suse.cz>
> CC: Jan Polensky <japo@linux.ibm.com>
> ---
>  doc/users/setup_tests.rst    |  5 ++-
>  lib/tst_supported_fs_types.c | 60 ++++++++++++++++++++++++------------
>  lib/tst_test.c               | 25 +++++++--------
>  testcases/lib/tst_test.sh    | 19 ++++++------
>  4 files changed, 67 insertions(+), 42 deletions(-)

> diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
> index 2cce85fdf..38976f3b0 100644
> --- a/doc/users/setup_tests.rst
> +++ b/doc/users/setup_tests.rst
> @@ -47,9 +47,12 @@ users.
>         printed by the test (suitable for a reproducible output).

>     * - LTP_SINGLE_FS_TYPE
> -     - Testing only - specifies filesystem instead all supported
> +     - Specifies single filesystem to run the test on instead all supported
>         (for tests with ``.all_filesystems``).

> +   * - LTP_FORCE_SINGLE_FS_TYPE
> +     - Testing only. Behaves like LTP_SINGLE_FS_TYPE but ignores test skiplists.
> +
>     * - LTP_DEV_FS_TYPE
>       - Filesystem used for testing (default: ``ext2``).

> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index bbbb8df19..5e9be1eda 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -147,40 +147,60 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
>  	return TST_FS_UNSUPPORTED;
>  }

> +int fs_could_be_used(const char *fs_type, const char *const *skiplist, int skip_fuse)
This should be also static. Please fix it before merge.
The rest LGTM, thanks for implementing it.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +{
> +	enum tst_fs_impl sup;
> +
> +	if (tst_fs_in_skiplist(fs_type, skiplist)) {
> +		tst_res(TINFO, "Skipping %s as requested by the test",
> +			fs_type);
> +		return 0;
> +	}
> +
> +	sup = tst_fs_is_supported(fs_type);
> +
> +	if (skip_fuse && sup == TST_FS_FUSE) {
> +		tst_res(TINFO,
> +			"Skipping FUSE based %s as requested by the test",
> +			fs_type);
> +		return 0;
> +	}
> +
> +	return sup != TST_FS_UNSUPPORTED;
> +}
> +
>  const char **tst_get_supported_fs_types(const char *const *skiplist)
>  {
>  	unsigned int i, j = 0;
>  	int skip_fuse;
> -	enum tst_fs_impl sup;
> -	const char *only_fs;
> +	const char *only_fs, *force_only_fs;

> -	skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
>  	only_fs = getenv("LTP_SINGLE_FS_TYPE");
> +	force_only_fs = getenv("LTP_FORCE_SINGLE_FS_TYPE");
> +
> +	if (only_fs && force_only_fs) {
> +		tst_brk(TBROK,
> +			"Only one of LTP_SINGLE_FS_TYPE and LTP_FORCE_SINGLE_FS_TYPE can be set");
> +		return NULL;
> +	}
> +
> +	skip_fuse = tst_fs_in_skiplist("fuse", skiplist);

>  	if (only_fs) {
>  		tst_res(TINFO, "WARNING: testing only %s", only_fs);
> -		if (tst_fs_is_supported(only_fs))
> +		if (fs_could_be_used(only_fs, skiplist, skip_fuse))
>  			fs_types[0] = only_fs;
>  		return fs_types;
>  	}

> -	for (i = 0; fs_type_whitelist[i]; i++) {
> -		if (tst_fs_in_skiplist(fs_type_whitelist[i], skiplist)) {
> -			tst_res(TINFO, "Skipping %s as requested by the test",
> -				fs_type_whitelist[i]);
> -			continue;
> -		}
> -
> -		sup = tst_fs_is_supported(fs_type_whitelist[i]);
> -
> -		if (skip_fuse && sup == TST_FS_FUSE) {
> -			tst_res(TINFO,
> -				"Skipping FUSE based %s as requested by the test",
> -				fs_type_whitelist[i]);
> -			continue;
> -		}
> +	if (force_only_fs) {
> +		tst_res(TINFO, "WARNING: force testing only %s", force_only_fs);
> +		fs_types[0] = force_only_fs;
> +		return fs_types;
> +	}

> -		if (sup)
> +	for (i = 0; fs_type_whitelist[i]; i++) {
> +		if (fs_could_be_used(fs_type_whitelist[i], skiplist, skip_fuse))
>  			fs_types[j++] = fs_type_whitelist[i];
>  	}

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index d1268535c..45fc28498 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -611,18 +611,19 @@ static void print_help(void)
>  	/* see doc/users/setup_tests.rst, which lists also shell API variables */
>  	fprintf(stderr, "Environment Variables\n");
>  	fprintf(stderr, "---------------------\n");
> -	fprintf(stderr, "KCONFIG_PATH            Specify kernel config file\n");
> -	fprintf(stderr, "KCONFIG_SKIP_CHECK      Skip kernel config check if variable set (not set by default)\n");
> -	fprintf(stderr, "LTPROOT                 Prefix for installed LTP (default: /opt/ltp)\n");
> -	fprintf(stderr, "LTP_COLORIZE_OUTPUT     Force colorized output behaviour (y/1 always, n/0: never)\n");
> -	fprintf(stderr, "LTP_DEV                 Path to the block device to be used (for .needs_device)\n");
> -	fprintf(stderr, "LTP_DEV_FS_TYPE         Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
> -	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT Values 1 or y discard the actual content of the messages printed by the test\n");
> -	fprintf(stderr, "LTP_SINGLE_FS_TYPE      Testing only - specifies filesystem instead all supported (for .all_filesystems)\n");
> -	fprintf(stderr, "LTP_TIMEOUT_MUL         Timeout multiplier (must be a number >=1)\n");
> -	fprintf(stderr, "LTP_RUNTIME_MUL         Runtime multiplier (must be a number >=1)\n");
> -	fprintf(stderr, "LTP_VIRT_OVERRIDE       Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
> -	fprintf(stderr, "TMPDIR                  Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
> +	fprintf(stderr, "KCONFIG_PATH             Specify kernel config file\n");
> +	fprintf(stderr, "KCONFIG_SKIP_CHECK       Skip kernel config check if variable set (not set by default)\n");
> +	fprintf(stderr, "LTPROOT                  Prefix for installed LTP (default: /opt/ltp)\n");
> +	fprintf(stderr, "LTP_COLORIZE_OUTPUT      Force colorized output behaviour (y/1 always, n/0: never)\n");
> +	fprintf(stderr, "LTP_DEV                  Path to the block device to be used (for .needs_device)\n");
> +	fprintf(stderr, "LTP_DEV_FS_TYPE          Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
> +	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y discard the actual content of the messages printed by the test\n");
> +	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
> +	fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
> +	fprintf(stderr, "LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1)\n");
> +	fprintf(stderr, "LTP_RUNTIME_MUL          Runtime multiplier (must be a number >=1)\n");
> +	fprintf(stderr, "LTP_VIRT_OVERRIDE        Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
> +	fprintf(stderr, "TMPDIR                   Base directory for template directory (for .needs_tmpdir, default: %s)\n", TEMPDIR);
>  	fprintf(stderr, "\n");

>  	fprintf(stderr, "Timeout and runtime\n");
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 50269d40f..c32bd8b19 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -482,15 +482,16 @@ tst_usage()

>  Environment Variables
>  ---------------------
> -KCONFIG_PATH         Specify kernel config file
> -KCONFIG_SKIP_CHECK   Skip kernel config check if variable set (not set by default)
> -LTPROOT              Prefix for installed LTP (default: /opt/ltp)
> -LTP_COLORIZE_OUTPUT  Force colorized output behaviour (y/1 always, n/0: never)
> -LTP_DEV              Path to the block device to be used (for .needs_device)
> -LTP_DEV_FS_TYPE      Filesystem used for testing (default: ext2)
> -LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for TST_ALL_FILESYSTEMS=1)
> -LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1, ceiled to int)
> -TMPDIR               Base directory for template directory (for .needs_tmpdir, default: /tmp)
> +KCONFIG_PATH             Specify kernel config file
> +KCONFIG_SKIP_CHECK       Skip kernel config check if variable set (not set by default)
> +LTPROOT                  Prefix for installed LTP (default: /opt/ltp)
> +LTP_COLORIZE_OUTPUT      Force colorized output behaviour (y/1 always, n/0: never)
> +LTP_DEV                  Path to the block device to be used (for .needs_device)
> +LTP_DEV_FS_TYPE          Filesystem used for testing (default: ext2)
> +LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for TST_ALL_FILESYSTEMS=1)
> +LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist
> +LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1, ceiled to int)
> +TMPDIR                   Base directory for template directory (for .needs_tmpdir, default: /tmp)
>  EOF
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
