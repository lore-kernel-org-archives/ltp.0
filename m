Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0974FFEEF25
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 11:44:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A17033C1987
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 13:44:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0FF03C054A
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:44:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B1E0140077C
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:44:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A4A85BD6C;
 Tue,  7 Apr 2026 11:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775562255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Az2cLOQCzlRcqAaXlPttZ9FaMWyVKpJuFd5cVhbPSxo=;
 b=0k8gaSPl9BbK5ddBYtdvT418ULGARWBSKkyR19+jyou26ArvD+E17x87xfq9h17ol7uypi
 DiegGNEkaZEAL5g/mtfFOVdn8D7ZXOOE9fyNtKRrZ5GtjYFlwdhHrXiiMn3Ir1i/M6RnQj
 PVsYewuEzNx3wZs8QBppoILZ3VZ6zrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775562255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Az2cLOQCzlRcqAaXlPttZ9FaMWyVKpJuFd5cVhbPSxo=;
 b=gAsKl5AjOaFRxBNObkASyOo1FE82PfJA9xf0UKMjG6+kUFeNxFZkK24Tqc/cAnBIQcSz7H
 KkvJIbwYcOwrlzDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1775562255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Az2cLOQCzlRcqAaXlPttZ9FaMWyVKpJuFd5cVhbPSxo=;
 b=0k8gaSPl9BbK5ddBYtdvT418ULGARWBSKkyR19+jyou26ArvD+E17x87xfq9h17ol7uypi
 DiegGNEkaZEAL5g/mtfFOVdn8D7ZXOOE9fyNtKRrZ5GtjYFlwdhHrXiiMn3Ir1i/M6RnQj
 PVsYewuEzNx3wZs8QBppoILZ3VZ6zrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1775562255;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Az2cLOQCzlRcqAaXlPttZ9FaMWyVKpJuFd5cVhbPSxo=;
 b=gAsKl5AjOaFRxBNObkASyOo1FE82PfJA9xf0UKMjG6+kUFeNxFZkK24Tqc/cAnBIQcSz7H
 KkvJIbwYcOwrlzDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 588054A0B0;
 Tue,  7 Apr 2026 11:44:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RKNGEw/u1Gm/ZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Apr 2026 11:44:15 +0000
Date: Tue, 7 Apr 2026 13:44:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <adTuFXSac4aMwjqF@yuki.lan>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-5-chrubis@suse.cz>
 <ac8vdjEM0awKPmHE@redhat.com> <adTW1Jmq3vfkTWSO@yuki.lan>
 <adTtRQ66M4UUgtVR@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adTtRQ66M4UUgtVR@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/17] lib: tst_kconfig: Add module presence checks
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
> > I do not have strong opition, if you agree that these names are better
> > we can rename them.
> 
> Yes, I have a bit preference to rename.

I will rename the config module checks in this patchset and add a rename
for the runtime checks on the top of it later on then.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
