Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01493C54E41
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 14:45:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58E593D0BD7
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 15:45:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C0B33C9907
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 15:45:25 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0A7B0601423
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 15:45:23 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A22A676ADF;
 Tue,  5 Mar 2024 14:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709649922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fmR2+fcoLDWGpuFnSBzhJ3iAepwmakk0YlGYriqRfGs=;
 b=Lu5QW666K8FDq/EaI74oD6CyWRyknXTGEswmgeZazjLZPGo2JRuryxzWDEktqudbf2Oe2f
 x0b3MMFvKJcLYA+0zrNmgAzA6lwT+hE+3RMmnN3QdBrlTRiVdY9DZhHcwe85CYknnhMb8J
 T0I41EoxNOhsdbkX1dGmCOGuCrixILI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709649922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fmR2+fcoLDWGpuFnSBzhJ3iAepwmakk0YlGYriqRfGs=;
 b=hqGlZi4zZZ+vfCHmxvUHWtUzfU3B4f217uR/U1FZSBY7D+6oHyP/T65WlGXMj18fg/msqQ
 kmOJVvc7pAwku7Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709649922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fmR2+fcoLDWGpuFnSBzhJ3iAepwmakk0YlGYriqRfGs=;
 b=Lu5QW666K8FDq/EaI74oD6CyWRyknXTGEswmgeZazjLZPGo2JRuryxzWDEktqudbf2Oe2f
 x0b3MMFvKJcLYA+0zrNmgAzA6lwT+hE+3RMmnN3QdBrlTRiVdY9DZhHcwe85CYknnhMb8J
 T0I41EoxNOhsdbkX1dGmCOGuCrixILI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709649922;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fmR2+fcoLDWGpuFnSBzhJ3iAepwmakk0YlGYriqRfGs=;
 b=hqGlZi4zZZ+vfCHmxvUHWtUzfU3B4f217uR/U1FZSBY7D+6oHyP/T65WlGXMj18fg/msqQ
 kmOJVvc7pAwku7Cw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 838CB13466;
 Tue,  5 Mar 2024 14:45:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id RjwHHwIw52W0SwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 05 Mar 2024 14:45:22 +0000
Date: Tue, 5 Mar 2024 15:45:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240305144520.GA4052380@pevik>
References: <20240301062716.3023-1-wegao@suse.com>
 <20240305141057.8754-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240305141057.8754-1-wegao@suse.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.28 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.98)[99.91%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] libswap.c: Improve calculate swap dev number
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

> I encounter a dead loop on following code in our test on ppc64 machine:
> while ((c = fgetc(fp)) != EOF)

FYI it fails also on aarch64 and s390x, thus I'll add it to the commit message
before merge. I also try to have look why it's broken.

> Use fgets instead of fgetc can avoid above issue.

LGTM. I probably merge it tonight.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  libs/libltpswap/libswap.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index c10db91c0..a26ea25e4 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -13,6 +13,7 @@

>  #define TST_NO_DEFAULT_MAIN
>  #define DEFAULT_MAX_SWAPFILE 32
> +#define BUFSIZE 200

>  #include "tst_test.h"
>  #include "libswap.h"
> @@ -279,16 +280,14 @@ int tst_count_swaps(void)
>  {
>  	FILE *fp;
>  	int used = -1;
> -	char c;
> +	char buf[BUFSIZE];

>  	fp = SAFE_FOPEN("/proc/swaps", "r");
>  	if (fp == NULL)
>  		return -1;

> -	while ((c = fgetc(fp)) != EOF) {
> -		if (c == '\n')
> -			used++;
> -	}
> +	while (fgets(buf, BUFSIZE, fp) != NULL)
> +		used++;

>  	SAFE_FCLOSE(fp);
>  	if (used < 0)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
