Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CF8C7EE25
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 15:49:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BA9A3CB504
	for <ltp@archiver.kernel.org>; Thu,  8 Jun 2023 17:49:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC9EB3CAED5
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 17:49:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF1EA1400FAB
 for <ltp@lists.linux.it>; Thu,  8 Jun 2023 17:49:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 626F31FDE9;
 Thu,  8 Jun 2023 15:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1686239379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXpJZZAZ0ot7DysUeuH5F7C6x0hni50AYd034vohOqo=;
 b=JKf11wBW6jWpkQxeaKdp6ZgyltruoQC28QE2pGmyIU6E1WT0bXr5Sk0jrONiMq2NokA5u7
 ryIRQZLimCnSQ/GcinYpBHkrH8YBfWTgbohoQaZXCnQWeg1y/JxI1crhINbkJP1RDiXsM/
 /beKvXkY6GuYUfxl8/hd3JiZ9pdhfaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1686239379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DXpJZZAZ0ot7DysUeuH5F7C6x0hni50AYd034vohOqo=;
 b=IPJOlbLFBG9dW+q4jm+Y5mYRgQx9Sbldr4ZTEk16zOY2Q7NFz/gdRPsVF2WI9RGCzrCXFx
 eJ7u0oxXvMhxPVDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46301138E6;
 Thu,  8 Jun 2023 15:49:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hKbAD5P4gWQQJAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 08 Jun 2023 15:49:39 +0000
Message-ID: <952e26cf-9b35-38ea-3e1e-32a25ec3306b@suse.cz>
Date: Thu, 8 Jun 2023 17:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Murphy Zhou <jencce.kernel@gmail.com>, ltp@lists.linux.it
References: <20230607123653.3897079-1-jencce.kernel@gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230607123653.3897079-1-jencce.kernel@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] safe_mount: safe_umount: print debug info
 about the operation
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

On 07. 06. 23 14:36, Murphy Zhou wrote:
> Make the source and the target to mount/umount visible. It's
> good for debugging.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>   lib/safe_macros.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index af6dd0716..6add92f06 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -898,7 +898,15 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>   	       const void *data)
>   {
>   	int rval = -1;
> +	char mpath[PATH_MAX];
>   
> +	if (!realpath(target, mpath))
> +		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> +			"realpath(%s, s) failed", target);
> +
> +	tst_resm_(file, lineno, TINFO,
> +		"Mounting %s to %s fstyp=%s flags=%lx",
> +		source, mpath, filesystemtype, mountflags);

This is much better, but realpath() failure is not a fatal error here, 
just a minor inconvenience. So it'd be better to do this:

if (realpath(...)) {
	tst_resm_(... TINFO, "Mounting %s to %s...", ...);
} else {
	tst_resm_(... TINFO | TERRNO, "Cannot resolve absolute path to %s", ...);
}

>   	/*
>   	 * Don't try using the kernel's NTFS driver when mounting NTFS, since
>   	 * the kernel's NTFS driver doesn't have proper write support.
> @@ -948,6 +956,13 @@ int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
>   		const char *target)
>   {
>   	int rval;
> +	char mpath[PATH_MAX];
> +
> +	if (!realpath(target, mpath))
> +		tst_brkm_(file, lineno, TBROK | TERRNO, cleanup_fn,
> +			"realpath(%s, s) failed", target);
> +
> +	tst_resm_(file, lineno, TINFO, "Umounting %s", mpath);

Same here.

>   
>   	rval = tst_umount(target);
>   

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
