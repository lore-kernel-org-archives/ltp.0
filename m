Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F283C77B73
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 08:40:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE6CC3CCB5E
	for <ltp@archiver.kernel.org>; Mon,  5 Jun 2023 10:40:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBFDA3CB839
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 10:39:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2F25D140096C
 for <ltp@lists.linux.it>; Mon,  5 Jun 2023 10:39:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 373681F8BB;
 Mon,  5 Jun 2023 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1685954389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAXXgXmCQeyPcwkUZtAf3JCVtl3wbohizfsL8KtPm0k=;
 b=c6Wl3Ie4ipqBKxjeXqL6v+5E2+U/wzauRmDkgoZTVKYkobz0nEc4C5VN5v3pU6Bbvaf/56
 Vd3VHsXTddl2hnMcNOe1qo78796NPD16Z3/4XRMKSQYVxCA8J4N3blHe+Xoi4M/9Oct93H
 7qOUWYeDlMD2Mn5WMlZzjQpgiPcT90w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1685954389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAXXgXmCQeyPcwkUZtAf3JCVtl3wbohizfsL8KtPm0k=;
 b=UMGJoT928UaO5eBlHaB+4u5fEV7J3Beh5kgWdZD8hHQfTg3jFM29z5ogJlPmqscZz0oZwn
 NdauSVkOjgf/e0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 257FD139C8;
 Mon,  5 Jun 2023 08:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5OZMCFWffWQODwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 05 Jun 2023 08:39:49 +0000
Message-ID: <233a0f31-e4de-de65-4752-d43cb1ae3c1f@suse.cz>
Date: Mon, 5 Jun 2023 10:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Murphy Zhou <jencce.kernel@gmail.com>, ltp@lists.linux.it
References: <20230604095117.3543342-1-jencce.kernel@gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230604095117.3543342-1-jencce.kernel@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] SAFE_MOUNT: print debug info about mounting
 operation
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 04. 06. 23 11:51, Murphy Zhou wrote:
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>   lib/safe_macros.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index af6dd0716..a66285a0e 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -898,7 +898,24 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>   	       const void *data)
>   {
>   	int rval = -1;
> +	char cdir[PATH_MAX], mpath[PATH_MAX];
>   
> +	if (!getcwd(cdir, PATH_MAX)) {
> +		tst_resm(TWARN | TERRNO, "Failed to find current directory");
> +		return 0;

You return success when nothing was mounted. That is clearly wrong. 
Either call tst_brkm_(... TBROK ...) if the failure is so serious that 
the test cannot continue, or don't return at all.

> +	}
> +
> +	rval = snprintf(mpath, PATH_MAX, "%s/%s", cdir, target);

The C library has a function for resolving paths: realpath(). Please use 
that.

> +	if (rval < 0 || rval >= PATH_MAX) {
> +		tst_resm(TWARN | TERRNO,
> +			 "snprintf() should have returned %d instead of %d",
> +			 PATH_MAX, rval);
> +		return 0;

Returning here is also wrong.

> +	}
> +
> +	tst_resm_(file, lineno, TINFO,
> +		"Mounting %s to %s fstyp=%s flags=%x",
> +		source, mpath, filesystemtype, mountflags);
>   	/*
>   	 * Don't try using the kernel's NTFS driver when mounting NTFS, since
>   	 * the kernel's NTFS driver doesn't have proper write support.

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
