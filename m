Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A87DCD4F24
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 10:34:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D51D73E1C39
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 12:34:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8322A3CD82A
 for <ltp@lists.linux.it>; Wed, 13 May 2026 12:34:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AF1721400108
 for <ltp@lists.linux.it>; Wed, 13 May 2026 12:34:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 219F46AE49;
 Wed, 13 May 2026 10:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778668443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Tv95+pLIAR00KSsSP4y29NiZlefLC9lVoPulKLULGo=;
 b=YP9m0ekYJc7/riP8YRyRJ25obFU3HW8BXWOK9UggnNOjdP5eb1Lae4c324aj4bF6g9UyvR
 NPT7n0aE13yfF2Iebd8MgXKqndkjPQf5ypGka0YI9Js+nHcg3YuLu3pCk45QEMlD/YUhyl
 z8a6YWM53rrv46S2MEicmbmfJSFmTo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778668443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Tv95+pLIAR00KSsSP4y29NiZlefLC9lVoPulKLULGo=;
 b=XcqFrVQ8KN4oj5xn99MYBteu1+ZGcdKbz6fSG1Vb8TPBO8Makh2q9PoKsdZnkA//qowavs
 bV4Lz/N98arse9AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778668443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Tv95+pLIAR00KSsSP4y29NiZlefLC9lVoPulKLULGo=;
 b=YP9m0ekYJc7/riP8YRyRJ25obFU3HW8BXWOK9UggnNOjdP5eb1Lae4c324aj4bF6g9UyvR
 NPT7n0aE13yfF2Iebd8MgXKqndkjPQf5ypGka0YI9Js+nHcg3YuLu3pCk45QEMlD/YUhyl
 z8a6YWM53rrv46S2MEicmbmfJSFmTo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778668443;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Tv95+pLIAR00KSsSP4y29NiZlefLC9lVoPulKLULGo=;
 b=XcqFrVQ8KN4oj5xn99MYBteu1+ZGcdKbz6fSG1Vb8TPBO8Makh2q9PoKsdZnkA//qowavs
 bV4Lz/N98arse9AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD1AC593A9;
 Wed, 13 May 2026 10:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id S2NaNJpTBGreLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 13 May 2026 10:34:02 +0000
Date: Wed, 13 May 2026 12:33:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260513103357.GA318856@pevik>
References: <20260331111857.10995-1-wegao@suse.com>
 <20260507025345.6722-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260507025345.6722-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8] fanotify22.c: handle multiple asynchronous
 error events
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
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

...
>  	if (memcmp(&fid->fsid, &ex->fid->fsid, sizeof(fid->fsid))) {
> -		tst_res(TFAIL, "%s: Received bad FSID type (%x...!=%x...)",
> -			ex->name, FSID_VAL_MEMBER(fid->fsid, 0),
> +		tst_res(TFAIL, "Received bad FSID type (%x...!=%x...)",
> +			FSID_VAL_MEMBER(fid->fsid, 0),
>  			ex->fid->fsid.val[0]);

I dared to factor out this unrelated change to a separated commit and merge the
patchset.

Removing ex->name which is ~ 50% of changes is completely unrelated.
When Andrea suggested it [1] it was for a new additions. Although this this
change is not a complicated, fanotify tests are quite complex, that's why it's
better to separate non-related change.

Thanks Jan for helping with the review.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/69c648d0.050a0220.2ca52b.c494@mx.google.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
