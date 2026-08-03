Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C749C55179
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 12:28:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 863CD3E7279
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 14:28:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A42213E90D7
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 14:27:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B48E11400331
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 14:27:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78C023EE3;
 Mon,  3 Aug 2026 12:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785760054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzH4YtbviqvPLFmegmwOctd5Sw6EDyUBJmgpLluMjKM=;
 b=p0THA5AGw5SIJSO3p/TsLLvQ+yHWdtAyYmo8KxBI+2bUOMXMksHJ7/om9CALCidSzrwXpV
 I204tl+0q3OHr9gbTic8TGLpvQlZEBINvWe32Pmsxlwi0iYrv+lob3dn4AkFgW/ke8j1WB
 SbJP3FEI2uk3NWiaB5QY51sUCQCG25c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785760054;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzH4YtbviqvPLFmegmwOctd5Sw6EDyUBJmgpLluMjKM=;
 b=p3txdsTkjq+zx8+YOdNKS2IWgz0TIbytaW7tdy0l8mWye029RotWzFVjva1rpkdxC4BIZE
 dFLeyKahSkk4JFDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785760050;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzH4YtbviqvPLFmegmwOctd5Sw6EDyUBJmgpLluMjKM=;
 b=DNkqq4S2XObKYvB6UcoCMgG6NIhnYnTeuWQtNPyuUzcVsTsTo6U6QZbOQeUT69INae7qD9
 ROItxs6efgcn32CLkK+N9530d3hPZQfOK13h6Ygv8bWufnFVIZEjjjY6PUvxnVfXb/NDjA
 aQAsUISuBLIIYp+zT9t4jPpEBRn8w8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785760050;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HzH4YtbviqvPLFmegmwOctd5Sw6EDyUBJmgpLluMjKM=;
 b=JSRRT8QL/ZBT3/DVb8KCGAjjZMCI6FUJUsyyCxY6M1nf4T2go5aaFuJggNKwMkfcAUVFd7
 qwDcrHgvhnYE1MDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CD01779A1;
 Mon,  3 Aug 2026 12:27:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fK2BETKJcGpaSgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Aug 2026 12:27:30 +0000
Date: Mon, 3 Aug 2026 14:27:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260803122728.GA242002@pevik>
References: <20260731200322.161590-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260731200322.161590-1-avinesh.kumar@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[http-stress.sh:url,dns-stress02-rmt.sh:url,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,dns-stress.sh:url,ssh-stress.sh:url];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] network: Remove outdated DNS stress tests
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

Hi Avinesh,

> These tests start a local named server and run $NS_TIMES
> (default: 10) dig queries from the remote host, forward and reverse.
> The check is that the first and last query return NOERROR with one
> answer record, and that no dig call in between exited non-zero.
> They are also broken: dns-stress02-rmt.sh passes 'dig -n' for ipv6,
> an option removed from bind long ago. dig prints "dig: -n removed",
> sends no query and exits 0.
> Remove these old broken tests based on legacy shell API.

Thanks, I always wanted to delete them.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Follow-up: 99c0b167d ("network: Remove outdated TCP stress tests")

...
> +++ b/runtest/net_stress.appl
> @@ -1,13 +1,10 @@

> -# Stress test for major application protocol (ssh, dns, http, ftp)
> +# Stress test for major application protocol (ssh, http, ftp)


>  ssh4-stress ssh-stress.sh
>  ssh6-stress ssh-stress.sh -6

FYI removal of SSH stress tests ...

> -dns4-stress dns-stress.sh
> -dns6-stress dns-stress.sh -6
> -
>  http4-stress http-stress.sh
>  http6-stress http-stress.sh -6

... and HTTP stress tests is blocked by

https://github.com/linux-test-project/ltp/issues/1207

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
