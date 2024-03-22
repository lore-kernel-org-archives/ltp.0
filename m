Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9428DC54E71
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 05:01:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2A1F3CFBC6
	for <ltp@archiver.kernel.org>; Fri, 22 Mar 2024 06:01:07 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CC9A3CF1E5
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 06:00:53 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B6D17600C3B
 for <ltp@lists.linux.it>; Fri, 22 Mar 2024 06:00:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4836138024;
 Fri, 22 Mar 2024 05:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711083650;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Iv4CkwTmb23mCbNTpBXqdZ/zrPmEcSILV65zvMBv+E=;
 b=unnfl1bU8ccXqOUnXQ21kjE8j3ORxx6qoorczXyk37cXnyAe1wytSjnrb3kFQ7hPfhdQQn
 qEuMbdyRYMej1gb41PLOrtb04Atlp0vXZMlEt+4Y/7NRlKwWzxTsRvNqdKBJJnpXsS+K12
 ryF0USWcTIY0I9hMY67U8EnrM714bRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711083650;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Iv4CkwTmb23mCbNTpBXqdZ/zrPmEcSILV65zvMBv+E=;
 b=dIlIcBUxI30I3Ctt3BgWiq679FlYpfU64ueYB8el4IeMN3mIQrMnXVcTvWBdenP3xezZV3
 Df4R1D+IqJUuX3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711083648;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Iv4CkwTmb23mCbNTpBXqdZ/zrPmEcSILV65zvMBv+E=;
 b=2DOS+9sWQtGHRn7r6g0a0L+OcGokACCBuaLIyxXIY6sLzdLW743f/xoClbQbCEazLiCQu+
 O05YRgvWVkdnADuje/Q9S2Bs90xHAt6fY5hylkiVrGo9pA0sZN510CAIHYVfFz4MPutcs+
 2lTXvAqY99e5Nt6en03TrupWLneWmEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711083648;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Iv4CkwTmb23mCbNTpBXqdZ/zrPmEcSILV65zvMBv+E=;
 b=Ws8+Rhs7oc1KTJgC/2xuWnvSloknvMh8csKCFD1jwP4Gibbhkfk4r/ZoG2r3APSAAWqg0F
 VUKcDF6fg+577EDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 379C7136AD;
 Fri, 22 Mar 2024 05:00:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SbPnDIAQ/WU1cQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 22 Mar 2024 05:00:48 +0000
Date: Fri, 22 Mar 2024 06:00:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240322050046.GA572447@pevik>
References: <20240322030208.3278120-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240322030208.3278120-1-liwang@redhat.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.01)[46.90%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] libswap: add two methods to create swapfile
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

Hi Li,

...
> Signed-off-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
...
-int make_swapfile(const char *swapfile, int blocks, int safe)
+int make_swapfile_(const char *file, const int lineno,
+			const char *swapfile, unsigned int num,
+			int safe, enum swapfile_method method)
 {
 	struct statvfs fs_info;
-	unsigned long blk_size, bs;
+	unsigned long blk_size;
+	unsigned int blocks = 0;
 	size_t pg_size = sysconf(_SC_PAGESIZE);
-	char mnt_path[100];
+	char mnt_path[128];

nit: why this increase to 128? Why not PATH_MAX?

>  	/* To guarantee at least one page can be swapped out */
> -	if (blk_size * blocks < pg_size)
> -		bs = pg_size;
> -	else
> -		bs = blk_size;
> +	if (blk_size * blocks < pg_size) {
> +		tst_res(TWARN, "Swapfile size is less than the system page size. \
> +			Using page size (%lu bytes) instead of block size (%lu bytes).",

libswap.c:163: WARNING: Avoid line continuations in quoted strings

This will fix it:

		tst_res(TWARN, "Swapfile size is less than the system page size. "
			"Using page size (%lu bytes) instead of block size (%lu bytes).",

> +			(unsigned long)pg_size, blk_size);
> +		blk_size = pg_size;
> +	}

>  	if (sscanf(swapfile, "%[^/]", mnt_path) != 1)
> -		tst_brk(TBROK, "sscanf failed");
> +		tst_brk_(file, lineno, TBROK, "sscanf failed");

> -	if (!tst_fs_has_free(mnt_path, bs * blocks, TST_BYTES))
> -		tst_brk(TCONF, "Insufficient disk space to create swap file");
> +	if (!tst_fs_has_free(mnt_path, blk_size * blocks, TST_BYTES))
> +		tst_brk_(file, lineno, TCONF, "Insufficient disk space to create swap file");

>  	/* create file */
> -	if (prealloc_contiguous_file(swapfile, bs, blocks) != 0)
> -		tst_brk(TBROK, "Failed to create swapfile");
> +	if (prealloc_contiguous_file(swapfile, blk_size, blocks) != 0)
> +		tst_brk_(file, lineno, TBROK, "Failed to create swapfile");

>  	/* Fill the file if needed (specific to old xfs filesystems) */
>  	if (tst_fs_type(swapfile) == TST_XFS_MAGIC) {
> -		if (tst_fill_file(swapfile, 0, bs, blocks) != 0)
> -			tst_brk(TBROK, "Failed to fill swapfile");
> +		if (tst_fill_file(swapfile, 0, blk_size, blocks) != 0)
> +			tst_brk_(file, lineno, TBROK, "Failed to fill swapfile");
>  	}

>  	/* make the file swapfile */
> -	const char *argv[2 + 1];
> -
> -	argv[0] = "mkswap";
> -	argv[1] = swapfile;
> -	argv[2] = NULL;
> +	const char *argv[] = {"mkswap", swapfile, NULL};

libswap.c:186: WARNING: char * array declaration might be better as static const

This will fix it:

	const char *const argv[] = {"mkswap", swapfile, NULL};

>  	return tst_cmd(argv, "/dev/null", "/dev/null", safe ?
> -				   TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING : 0);
> +			TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING : 0);

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
