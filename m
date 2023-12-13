Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD4CC4332F
	for <ltp@archiver.kernel.org>; Wed, 13 Dec 2023 19:04:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A0A23CF554
	for <ltp@archiver.kernel.org>; Wed, 13 Dec 2023 20:04:50 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CCFF33CB55F
 for <ltp@lists.linux.it>; Wed, 13 Dec 2023 20:04:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ACAC61B61FFC
 for <ltp@lists.linux.it>; Wed, 13 Dec 2023 20:04:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC717210EC;
 Wed, 13 Dec 2023 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702494278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KsUWaYKnWlZqTLVs0KZ/cAEJNF2BysfwLhH++CEoMw=;
 b=FLKV50I8WibcDTZ78C9jaZefO8BmAOydnQVdH+RleRwnn9NEQ9dPkR3iVVX0s+Q4c1ob3t
 lcPnzV5vyI4VCA7Wtj7WzaQcXpkBWRCgRsXVdb++vgG2K2ogz7uZ5VHCuNZlnSzzPt5XZe
 tMzlauto+bvG187J+NjlSoVEIOJpMHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702494278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KsUWaYKnWlZqTLVs0KZ/cAEJNF2BysfwLhH++CEoMw=;
 b=codHbMsYd+1PtvAVeCDkLXj4A8wEm52WA+2CRwv9zz2MIG/MGYUm4MLihla+bStWKGw9F3
 6CzjLb/UxlR8fzBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702494278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KsUWaYKnWlZqTLVs0KZ/cAEJNF2BysfwLhH++CEoMw=;
 b=FLKV50I8WibcDTZ78C9jaZefO8BmAOydnQVdH+RleRwnn9NEQ9dPkR3iVVX0s+Q4c1ob3t
 lcPnzV5vyI4VCA7Wtj7WzaQcXpkBWRCgRsXVdb++vgG2K2ogz7uZ5VHCuNZlnSzzPt5XZe
 tMzlauto+bvG187J+NjlSoVEIOJpMHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702494278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6KsUWaYKnWlZqTLVs0KZ/cAEJNF2BysfwLhH++CEoMw=;
 b=codHbMsYd+1PtvAVeCDkLXj4A8wEm52WA+2CRwv9zz2MIG/MGYUm4MLihla+bStWKGw9F3
 6CzjLb/UxlR8fzBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D09CC137E8;
 Wed, 13 Dec 2023 19:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Lzk4MUUAemWudgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 Dec 2023 19:04:37 +0000
Date: Wed, 13 Dec 2023 20:04:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZXoAKxPxfXxU8bxw@rei>
References: <20231211161807.526714-1-pvorel@suse.cz>
 <20231211161807.526714-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231211161807.526714-2-pvorel@suse.cz>
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FLKV50I8;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=codHbMsY;
 dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither
 permitted nor denied by domain of chrubis@suse.cz)
 smtp.mailfrom=chrubis@suse.cz
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [4.81 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; DMARC_NA(1.20)[suse.cz];
 R_SPF_SOFTFAIL(4.60)[~all]; NEURAL_HAM_SHORT(-0.18)[-0.897];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: EC717210EC
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib/tests: Add test for testing tst_res()
 flags
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +#define FLAG(x) .flag = x, .str = #x
> +static struct tcase {
> +	int flag;
> +	const char *str;
> +} tcases[] = {
> +	{FLAG(TPASS)},
> +	{FLAG(TFAIL)},
> +	{FLAG(TBROK)},
> +	{FLAG(TCONF)},
> +	{FLAG(TWARN)},
> +	{FLAG(TINFO)},
> +};
> +
> +static void do_cleanup(void)
> +{
> +	tst_brk(TBROK, "TBROK message should be TWARN in cleanup");
> +}
> +
> +static void do_test(unsigned int n)
> +{
> +	int flag = tcases[n].flag;
> +	const char *str = tcases[n].str;
> +
> +	tst_res(flag, "%s message", str);
> +
> +	if (flag == TWARN || flag == TINFO)
> +		tst_res(TPASS, "%s message is not a result", str);

Maybe it would make sense the loop over the flags here instead, so that
we don't have to produce second TPASS message.

> +}
> +
> +static struct tst_test test = {
> +	.test = do_test,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.cleanup = do_cleanup,
> +};
> -- 
> 2.43.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
