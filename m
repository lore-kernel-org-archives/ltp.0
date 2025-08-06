Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B74BC87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 19:50:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B123B3C85CB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 21:50:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F78C3C7B85
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 21:49:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DC27A60086E
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 21:49:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 749CD22B33;
 Wed,  6 Aug 2025 19:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754509785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4UXrDA4D1+s/d2tlhBcay8P2VchW9GkbM8uOQHlR9Vk=;
 b=BTnJrSWkGXrBjZ8OcAqAJr67H+5BROeUYGMk4ZFgz0Z9GELnXzo7xHKCK9Hv5bIXhuU9zb
 r+XHwi2ZkV0fMDI2gdyn8XNpncFEVoQCJBuxuyH0LOkHLpCICoUhWvFxgG8IWDsAnIKUKU
 tb5PkuDnPlatUO08yxdxTQvMEhVmztY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754509785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4UXrDA4D1+s/d2tlhBcay8P2VchW9GkbM8uOQHlR9Vk=;
 b=gM3NYLH+RuV/wNRRs163idP0bcbvaL4bIeCw6oJZQvbpyJ9lPravUb+opuIcd2g6y/JBYX
 7CW8P8FlGOKDuDAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754509785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4UXrDA4D1+s/d2tlhBcay8P2VchW9GkbM8uOQHlR9Vk=;
 b=BTnJrSWkGXrBjZ8OcAqAJr67H+5BROeUYGMk4ZFgz0Z9GELnXzo7xHKCK9Hv5bIXhuU9zb
 r+XHwi2ZkV0fMDI2gdyn8XNpncFEVoQCJBuxuyH0LOkHLpCICoUhWvFxgG8IWDsAnIKUKU
 tb5PkuDnPlatUO08yxdxTQvMEhVmztY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754509785;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4UXrDA4D1+s/d2tlhBcay8P2VchW9GkbM8uOQHlR9Vk=;
 b=gM3NYLH+RuV/wNRRs163idP0bcbvaL4bIeCw6oJZQvbpyJ9lPravUb+opuIcd2g6y/JBYX
 7CW8P8FlGOKDuDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 147A713AA8;
 Wed,  6 Aug 2025 19:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yXv/Admxk2igXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 06 Aug 2025 19:49:45 +0000
Date: Wed, 6 Aug 2025 21:49:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250806194935.GA434082@pevik>
References: <20250801100935.974351-1-pvorel@suse.cz>
 <CAEemH2cvLsgVYkLOuVFZ4FrhqoUBFF54xRW0CF-0JN-tOCO8KQ@mail.gmail.com>
 <CAEemH2c9h97nC6sj323oG2kDvkcEqxspA5DPRrgK=zGSpEFr6w@mail.gmail.com>
 <20250806115217.GB431066@pevik> <aJNYvU7O9qKCI1tU@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aJNYvU7O9qKCI1tU@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] Makefile: Add kernel modules related make
 targets
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

> Hi!
> > MODULE_DIRS := $(shell \
> > 	dirname $(grep -l 'include.*module\.mk' $(find testcases/ -type f -name 'Makefile')) | sort -u
> > )

> > Although this works, I wonder if we want to depend on a shell detection like
> > this (I'd appreciate others' opinion).

> Looks okay to me. It's much better than hardcoding the paths, we will
> likely forget to update any hardcoded info.

Good, thanks, going to send v3.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
