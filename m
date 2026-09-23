Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBA1C98302
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 05:34:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AE583E5D4E
	for <ltp@archiver.kernel.org>; Wed, 23 Sep 2026 07:34:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD64F3E52A5
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 07:34:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D2D461000A4D
 for <ltp@lists.linux.it>; Wed, 23 Sep 2026 07:34:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3B97C21D6F;
 Wed, 23 Sep 2026 05:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790141640;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IrsHonG1A6pg0DUuqVpoWDZbZsZ9111Y1VtyJ9KDJwM=;
 b=gE/EkSaZfZSNjvRu6GIOClVdM/uCSitUnzPg83F77J9JuSwhF2kb/2juOqBEndFbOs8zQf
 dv0Ab98E4pofN4UZpEGuDK7r+5G262uvBxJRE1rAFQnQjpeAjk0/pA8I7XWABkrmWG49HZ
 LNvRkBLRrtpqY3A160mBU6lkRyxi0UQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790141640;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IrsHonG1A6pg0DUuqVpoWDZbZsZ9111Y1VtyJ9KDJwM=;
 b=fg39eGYkpJYysA1yUrD8arFYHDEq2w99K0nnUoFvf07FG3j1Dn+DAIUWEfl7qPts5xKZK9
 29zFq63OemHGqFDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sOVmyo6I;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DKgP5OTu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790141636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IrsHonG1A6pg0DUuqVpoWDZbZsZ9111Y1VtyJ9KDJwM=;
 b=sOVmyo6IwO+FnzgsOl6gCw9hAjfhjFn3zKqrphGPdXNqrqNc/Zvm3gJvaDoUqlogsjFmSz
 gotW2yOqTgfzMA523LhahLKpF5HgfVRCvIV9z5bnoFl1LvC36OMJuIrYuxHVe0TKuimHkW
 3kfHXb64SxzPgv4wgCCA7lIcIzeZR0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790141636;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IrsHonG1A6pg0DUuqVpoWDZbZsZ9111Y1VtyJ9KDJwM=;
 b=DKgP5OTuH5Vnyo5VfM+nKcJQXiC5f2PGdYqTiqTr/PlhvNKbeLf98DFXaKyF5GRVnoFooz
 VHxt99kw8My8WDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C99D9134E8;
 Wed, 23 Sep 2026 05:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s/qFJ8Nks2oBawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 23 Sep 2026 05:33:55 +0000
Date: Wed, 23 Sep 2026 07:33:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260923053354.GA104786@pevik>
References: <20260922160911.2271754-2-pvorel@suse.cz>
 <20260922184007.13630-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260922184007.13630-1-linuxtestproject.agent@gmail.com>
X-Rspamd-Queue-Id: 3B97C21D6F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[configure.ac:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/keyctl.h: Remove <keyutils.h>
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

Hi all,

> Hi Cyril,
nit: I managed to confuse agent (there are more authors in the patchset,
maybe it should ask the sender :)).

> On Tue Sep 22 18:09:08 2026 +0200, Cyril Hrubis wrote:
> > lapi/keyctl.h: Remove <keyutils.h>

> --- [PATCH 4/4] ---

> > Follow-up: bc8ead0f06 ("lapi/keyctl.h: Remove <keyutils.h>")

> Commit hash bc8ead0f06 does not exist in the repository. It refers to
> patch 1 in this series (875e1f2966dc).

Obviously this is ok.

> >  LTP_CHECK_FORTIFY_SOURCE
> >  LTP_CHECK_KERNEL_DEVEL
> > -LTP_CHECK_KEYUTILS_SUPPORT
> >  LTP_CHECK_LIBMNL

> Removing LTP_CHECK_KEYUTILS_SUPPORT leaves the LIBRARIES summary in
> configure.ac printing "keyutils: yes" unconditionally. Also remove
> "keyutils: ${have_keyutils:-yes}" from the summary and "keyutils.h"
> from AC_CHECK_HEADERS_ONCE.

Sigh. I'll send v2 of this commit. It likely will have to wait after the
release anyway.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
