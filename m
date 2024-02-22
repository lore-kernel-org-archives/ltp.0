Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482B6C48BF8
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 08:41:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 512573CF125
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 09:41:50 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2891C3CB2D6
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 09:41:34 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 043D210005EE
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 09:41:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 613B81F44F;
 Thu, 22 Feb 2024 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708591290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zv2OL7Flmsgt9jTvLfPZWDgToDSfNHvZcy7MVrxeBm8=;
 b=inJRixoavD2IZNPPUannSN+jjLBZRTde76RUySJK/1WlXpRBsKvL5BhuXH/u/LYJPjXkj2
 J0FrkKUYSriGR3lEWRzt+/fCa+fDs5bk4vHshqmCsalL+Mw1KxCvcECuCZjNSTzWWdub4q
 Ja3sBPEZNbwcAShCCOyi1xfdsMj26nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708591290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zv2OL7Flmsgt9jTvLfPZWDgToDSfNHvZcy7MVrxeBm8=;
 b=F0Nq7OzXmw3DpLXvIie+xN/Qo6siHfEeGlZXVYZymyRDtJwvqJcs/3TiJFYdP46t3zLDsz
 OcjSLyFuPZdC4PDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708591290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zv2OL7Flmsgt9jTvLfPZWDgToDSfNHvZcy7MVrxeBm8=;
 b=inJRixoavD2IZNPPUannSN+jjLBZRTde76RUySJK/1WlXpRBsKvL5BhuXH/u/LYJPjXkj2
 J0FrkKUYSriGR3lEWRzt+/fCa+fDs5bk4vHshqmCsalL+Mw1KxCvcECuCZjNSTzWWdub4q
 Ja3sBPEZNbwcAShCCOyi1xfdsMj26nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708591290;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zv2OL7Flmsgt9jTvLfPZWDgToDSfNHvZcy7MVrxeBm8=;
 b=F0Nq7OzXmw3DpLXvIie+xN/Qo6siHfEeGlZXVYZymyRDtJwvqJcs/3TiJFYdP46t3zLDsz
 OcjSLyFuPZdC4PDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51A89133DC;
 Thu, 22 Feb 2024 08:41:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xPDFEroI12VIcwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 22 Feb 2024 08:41:30 +0000
Date: Thu, 22 Feb 2024 09:39:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZdcIT1WiEfV7MCQ-@rei>
References: <20240222044119.28500-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240222044119.28500-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=inJRixoa;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=F0Nq7OzX
X-Spamd-Result: default: False [0.04 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.15)[68.53%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 613B81F44F
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapoff01.c: Adjust blocks size base on
 pagesize
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
> The make_swapfile function will encounter no space error if pagesize
> is bigger then 4096, such as ppc64 system use default pagesize 65535.
                                                                    ^
								 65536?

Isn't this more about Btrfs though? Looking at the make_swapfile() we do
use statvfs to get filesystem block size and if that is Btrfs with 64k
blocks we end up with swapfile of a size of 4GB that sounds like a bit
too much I guess.

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/swapoff/swapoff01.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
> index c303588df..71d6c6c04 100644
> --- a/testcases/kernel/syscalls/swapoff/swapoff01.c
> +++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
> @@ -44,7 +44,12 @@ static void setup(void)
>  {
>  	is_swap_supported(TEST_FILE);
>  
> -	if (make_swapfile(SWAP_FILE, 65536, 1))
> +	int blocks = 65535;
> +
> +	if (getpagesize() > 4096)
> +		blocks = 65535 * 4096 / getpagesize();
> +
> +	if (make_swapfile(SWAP_FILE, blocks, 1))
>  		tst_brk(TBROK, "Failed to create file for swap");


I do not think that this is a right solution though. Is there any reason
why we pass number of blocks to the make_swapfile instead of megabytes?

>  }
>  
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
