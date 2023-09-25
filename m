Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86FFCE7A81
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:17:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8F933CF2C2
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 17:17:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE1403CE234
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:17:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0C832603446
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:17:30 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A4001F45F;
 Mon, 25 Sep 2023 15:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695655050;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSrt011W6FftyMqRuiQhFxLX+QRAslo64dH0VpnqonM=;
 b=mJAbhZ2et7lUmtd+eV6h3CWYVYd+E1Ysc0vLEei06AbytznDP/8/fwaNTWolv7QBnof874
 NzvWe8qwtG+Ph0phq45ZIip9jMVdoDNUhoNVR6em/oDvax0ai+MSZvaFs+c4WDpUWXfEhH
 4ePvPcLmSQdo4R1EPkCAXpyzjlIR/IA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695655050;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wSrt011W6FftyMqRuiQhFxLX+QRAslo64dH0VpnqonM=;
 b=KRITBiYHpWgYRNL15EwwIJvXrGdBuioewMjAMhigFPgoUZDwDLqEVSyiIAKWj0TwWxiWB4
 YRxsOks3Nl+7exAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27F5B13580;
 Mon, 25 Sep 2023 15:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5hI/CIqkEWUrUQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Sep 2023 15:17:30 +0000
Date: Mon, 25 Sep 2023 17:17:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <20230925151728.GE60471@pevik>
References: <20230925144206.16895-1-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230925144206.16895-1-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Skip cgroup-related tests if `/sys/fs/cgroup`
 readonly
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Otherwise clone303 fails with TBROK when `/sys/fs/cgroup` is mounted as
> read-only which is normal in a container. The test result should better
> be TCONF like it is already done in case of a permission error.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

IMHO another candidate for merging before release.

Kind regards,
Petr

> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>  lib/tst_cgroup.c | 3 +++
>  1 file changed, 3 insertions(+)

> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index fdeac6059..5240aadaa 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -383,6 +383,9 @@ static void cgroup_dir_mk(const struct cgroup_dir *const parent,
>  		tst_brk(TCONF | TERRNO,
>  			"Lack permission to make '%s/%s'; premake it or run as root",
>  			dpath, dir_name);
> +	} else if (errno == EROFS) {
> +		tst_brk(TCONF | TERRNO, "'%s/%s' must not be read-only",
> +			dpath, dir_name);
>  	} else {
>  		tst_brk(TBROK | TERRNO,
>  			"mkdirat(%d<%s>, '%s', 0777)",

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
