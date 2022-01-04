Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8522C433F5
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 08:35:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 325DE3C9048
	for <ltp@archiver.kernel.org>; Tue,  4 Jan 2022 09:34:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46C433C222E
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 09:34:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 787AA1400049
 for <ltp@lists.linux.it>; Tue,  4 Jan 2022 09:34:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B01E31F386;
 Tue,  4 Jan 2022 08:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641285288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXQKv8A0d124M/J4Lxy1dcVs++pBl+lhj94dZGvsjJo=;
 b=eIJMQ7pckxSPNtsWk2MYp/pAZAbnmaA9TLHfA51W0HoBcnL3EhxkLKdQgUC/9oBJbskcoM
 ki1QgLu1i2Wk9Qx8tEA/R4t/kLGlc48PWSbg+bmOobHhVoTLimb0LAGNSfyQr6NEUysJru
 0mITgJ/u4ukk+wQTju7h8yuNJAdHWTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641285288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZXQKv8A0d124M/J4Lxy1dcVs++pBl+lhj94dZGvsjJo=;
 b=chVJfUL7t05gVZMWnSonjYj19nBLdsAAM64U3VMh3JxrrUQOg/3VX+8+Bi0XHfOXvIQy2z
 dz+C17zqhTFdBBAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 835DC13ACD;
 Tue,  4 Jan 2022 08:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NBCJHqgG1GGubgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jan 2022 08:34:48 +0000
Date: Tue, 4 Jan 2022 09:34:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YdQGplLdFnsmhlSO@pevik>
References: <20220104073754.721-1-andrea.cervesato@suse.com>
 <20220104073754.721-2-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220104073754.721-2-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Refactoring aio-stress.c using LTP API
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

Hi Andrea,

...
>  			for (i = 0; i < io->io_oper->reclen; i++) {
>  				if (io->buf[i] != verify_buf[i]) {
> -					fprintf(stderr, "%d:%c:%c ", i,
> -						io->buf[i], verify_buf[i]);
> +					ret = asprintf(&msg, "%d:%c:%c ", i, io->buf[i], verify_buf[i]);
> +					if (ret < 0)
> +						tst_brk(TBROK, "asprintf memory allocation error");
> +					ptr += sprintf(ptr, msg);
Actually, this is problematic for -Werror=format-security which we use in CI.
Simple "%s" fixes that. It can be done before merge.

ptr += sprintf(ptr, "%s", msg); 

@Richie: I wonder if make check could also actually compile the code with
extra CFLAGS from build.sh.

...
>  	for (i = 0; i < DEVIATIONS; i++) {
> -		fprintf(stderr, " %.0f < %d", lat->deviations[i],
> -			deviations[i]);
> +		ret = asprintf(&msg, " %.0f < %d", lat->deviations[i], deviations[i]);
> +		if (ret < 0)
> +			tst_brk(TBROK, "asprintf memory allocation error");
> +		ptr += sprintf(ptr, msg);
And here as well.

>  		total_counted += lat->deviations[i];
> +		free(msg);
>  	}
> -	if (total_counted && lat->total_io - total_counted)
> -		fprintf(stderr, " < %.0f", lat->total_io - total_counted);
> -	fprintf(stderr, "\n");
> +
> +	if (total_counted && lat->total_io - total_counted) {
> +		ret = asprintf(&msg, " < %.0f", lat->total_io - total_counted);
> +		if (ret < 0)
> +			tst_brk(TBROK, "asprintf memory allocation error");
> +		ptr += sprintf(ptr, msg);
and here.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
