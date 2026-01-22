Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2C1C44500
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 12:18:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F27363CB407
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 13:18:32 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B68223C2F34
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:18:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D5E986008CD
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:18:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 99372336A6;
 Thu, 22 Jan 2026 12:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769084287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LbHPLPvadeYaSxivlmHnkzGoL06a/04G3/RFGBIxpsA=;
 b=eFsXnI2DOcWhZX9Q8wlvtGOPo7GTHrdwBmNe3BYgNI74agETmBXUn/MqoVwTvw6B9SfOQb
 bngAdiZc2nNfR0iZxy0mPCAabfltaRkR6A5T7x+Evh25+Gmzl5HNaffUyiMbw9iCZ4ehJN
 PDv1zxaHkI9pXHSCAhDutZ80mUtC6Ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769084287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LbHPLPvadeYaSxivlmHnkzGoL06a/04G3/RFGBIxpsA=;
 b=3lIhVywi/VBuw2GEjFiFxKyodTkqarnEuE6o7oZboROsseDZ2CfUO3v5f9ZFlyRry8BJBL
 Bu7sPsxrP3qPftAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769084287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LbHPLPvadeYaSxivlmHnkzGoL06a/04G3/RFGBIxpsA=;
 b=eFsXnI2DOcWhZX9Q8wlvtGOPo7GTHrdwBmNe3BYgNI74agETmBXUn/MqoVwTvw6B9SfOQb
 bngAdiZc2nNfR0iZxy0mPCAabfltaRkR6A5T7x+Evh25+Gmzl5HNaffUyiMbw9iCZ4ehJN
 PDv1zxaHkI9pXHSCAhDutZ80mUtC6Ro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769084287;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LbHPLPvadeYaSxivlmHnkzGoL06a/04G3/RFGBIxpsA=;
 b=3lIhVywi/VBuw2GEjFiFxKyodTkqarnEuE6o7oZboROsseDZ2CfUO3v5f9ZFlyRry8BJBL
 Bu7sPsxrP3qPftAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6974B13533;
 Thu, 22 Jan 2026 12:18:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KZfiGH8VcmmLewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 Jan 2026 12:18:07 +0000
Date: Thu, 22 Jan 2026 13:17:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260122121756.GB64562@pevik>
References: <20260122102210.87453-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260122102210.87453-1-liwang@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd05: allow TCONF when UFFD-WP is
 unsupported
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
Cc: Christian Amann <camann@suse.com>, Ricardo Branco <rbranco@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> On system without enable CONFIG_HAVE_ARCH_USERFAULTFD_WP kernel option,
> test will fail like below:

>   userfaultfd05.c:95: TBROK: ioctl(3,((((2U|1U) << (((0+8)+8)+14)) |
>     (((0xAA)) << (0+8)) | ((((0x3F))) << 0) |
>     ((((sizeof(struct uffdio_api)))) << ((0+8)+8)))),...)
>    	 failed: EINVAL (22)

> The original test uses SAFE_IOCTL macro, which prematurely triggers
> TBROK and prevents the test from verifying UFFD_FEATURE_PAGEFAULT_FLAG_WP.

Good catch. I don't have any kernel without UFFD_FEATURE_PAGEFAULT_FLAG_WP,
therefore I didn't notice.

Fixes: efd8e51008 ("userfaultfd: Add test using UFFDIO_WRITEPROTECT")

> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Christian Amann <camann@suse.com>
> Cc: Ricardo Branco <rbranco@suse.com>
> ---
>  testcases/kernel/syscalls/userfaultfd/userfaultfd05.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
> index c4edc2529..9cb0bb08f 100644
> --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
> +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd05.c
> @@ -92,11 +92,11 @@ static void run(void)

>  	uffdio_api.api = UFFD_API;
>  	uffdio_api.features = UFFD_FEATURE_PAGEFAULT_FLAG_WP;
> -	SAFE_IOCTL(uffd, UFFDIO_API, &uffdio_api);
> +	if (ioctl(uffd, UFFDIO_API, &uffdio_api) < 0) {
> +		if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP))
> +			tst_brk(TCONF, "UFFD write-protect unsupported");

> -	if (!(uffdio_api.features & UFFD_FEATURE_PAGEFAULT_FLAG_WP)) {
> -		tst_brk(TCONF, "UFFD write-protect unsupported");
> -		return;
> +		tst_brk(TBROK | TERRNO, "ioctl_userfaultfd failed");
very nit: I would write "ioctl() on userfaultfd failed"?  I was thinking what
ioctl_userfaultfd is, but ok, there is man ioctl_userfaultfd(2).

Kind regards,
Petr
>  	}

>  	uffdio_register.range.start = (unsigned long) page;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
