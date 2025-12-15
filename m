Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBA4D5B84D
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 16:15:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89B923D0281
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 17:15:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEA533C1817
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:15:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 82A4510006D0
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 17:15:17 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43896337DC;
 Mon, 15 Dec 2025 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765815316;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XqQ9M4/EsGiFRwQAUU0dM9gzw5gKyKCKQzFocwFheLw=;
 b=WZpnAMwU/zMeFbvO4FqPpTaDLf++IPUuLbJs1IX/wdgH1bmTse6KDrHIi2OyicKE9qGqKO
 NLCZya1Lc5dAkBnxD5AQo8GI/A8Zg/JsWRW0q1LRoXwxqZebv7kZk8q26fjygztgi3YhQZ
 vhPolbsrLaYKPR7Xq34bWuxg+DBLEAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765815316;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XqQ9M4/EsGiFRwQAUU0dM9gzw5gKyKCKQzFocwFheLw=;
 b=XDRLyCvxusL7vc9D6xpRFJ//Zox61bw+NSl2Pe0sie1Zj0bfOL0J51s6ownufSxREb5LmC
 jnAv6vt3w+INd6DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765815316;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XqQ9M4/EsGiFRwQAUU0dM9gzw5gKyKCKQzFocwFheLw=;
 b=WZpnAMwU/zMeFbvO4FqPpTaDLf++IPUuLbJs1IX/wdgH1bmTse6KDrHIi2OyicKE9qGqKO
 NLCZya1Lc5dAkBnxD5AQo8GI/A8Zg/JsWRW0q1LRoXwxqZebv7kZk8q26fjygztgi3YhQZ
 vhPolbsrLaYKPR7Xq34bWuxg+DBLEAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765815316;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XqQ9M4/EsGiFRwQAUU0dM9gzw5gKyKCKQzFocwFheLw=;
 b=XDRLyCvxusL7vc9D6xpRFJ//Zox61bw+NSl2Pe0sie1Zj0bfOL0J51s6ownufSxREb5LmC
 jnAv6vt3w+INd6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AC063EA63;
 Mon, 15 Dec 2025 16:15:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nhzxFxM0QGn+AQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Dec 2025 16:15:15 +0000
Date: Mon, 15 Dec 2025 17:14:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ben Copeland <ben.copeland@linaro.org>
Message-ID: <20251215161458.GB282302@pevik>
References: <20251215-fix_ci-v1-1-792d418fc240@suse.com>
 <20251215155532.GD272695@pevik>
 <CAL0q8a6bP0TJn4xCBoL0sRKeLatXYMw3qUGJQszZ5+1tHv83Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAL0q8a6bP0TJn4xCBoL0sRKeLatXYMw3qUGJQszZ5+1tHv83Qw@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.991]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: fix patch download when using curl
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > > -        curl -k "${{ inputs.SERIES_MBOX }}" | git am
> > > +        curl -k -L --max-redirs 1 --location-trusted "${{ inputs.SERIES_MBOX }}" | git am

> > Hopefully --max-redirs 1 is enough.
> > Thanks for looking into this!

> I suggest adding --retry to the CURL call. --retry 3. At least then
> when curl fails, it won't fail on the first?

+1, sounds reasonable.

Kind regards,
Petr

> Ben

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
