Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 357A2C02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 13:03:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C90D73C19B9
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 14:03:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 243083C07B5
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 14:03:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9E5BC612DCF
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 14:03:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 061FB2117C;
 Mon, 20 Jan 2025 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737378199;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TKlCL8uUY0ax0eyLdD8SaQRQlMmxt4XfVlU1XxJoUt0=;
 b=gvKHNG4hXOA3lqM8q9UzWMaTChm1n1T5mhk7aDOZvns88qs1sFXe+8Lq/l2pXmCGHLZ9Ef
 mOFKUMTyBW6efkJPgapgNL/10qwad1/XvHGdixoh9HgsvCjdsLZLmQIhBEY3SI+wCVf5wl
 kX8rubu4EZ037ugQ+mrsCJHyvQz+J/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737378199;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TKlCL8uUY0ax0eyLdD8SaQRQlMmxt4XfVlU1XxJoUt0=;
 b=GXP5VviEhKZpQJCrOoiUYAsTa/iRMMvE/BooaiYAGDm1LfSnNW+BEgHaC1mDa2JkfwoGha
 8wWZu94Nq5OmSOBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gvKHNG4h;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GXP5VviE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737378199;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TKlCL8uUY0ax0eyLdD8SaQRQlMmxt4XfVlU1XxJoUt0=;
 b=gvKHNG4hXOA3lqM8q9UzWMaTChm1n1T5mhk7aDOZvns88qs1sFXe+8Lq/l2pXmCGHLZ9Ef
 mOFKUMTyBW6efkJPgapgNL/10qwad1/XvHGdixoh9HgsvCjdsLZLmQIhBEY3SI+wCVf5wl
 kX8rubu4EZ037ugQ+mrsCJHyvQz+J/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737378199;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TKlCL8uUY0ax0eyLdD8SaQRQlMmxt4XfVlU1XxJoUt0=;
 b=GXP5VviEhKZpQJCrOoiUYAsTa/iRMMvE/BooaiYAGDm1LfSnNW+BEgHaC1mDa2JkfwoGha
 8wWZu94Nq5OmSOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C952C1393E;
 Mon, 20 Jan 2025 13:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 08hdL5ZJjmf4eQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Jan 2025 13:03:18 +0000
Date: Mon, 20 Jan 2025 14:03:17 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250120130317.GA806253@pevik>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250115224154.GA664782@pevik>
 <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
 <20250120090740.GB794282@pevik> <20250120091137.GC794282@pevik>
 <CAEemH2e03yTcWBDw=BK7O6SU69mVXhO4zv2LUDgPLe0kD=w12Q@mail.gmail.com>
 <Z45BxqUsOQXm12My@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z45BxqUsOQXm12My@yuki.lan>
X-Rspamd-Queue-Id: 061FB2117C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] pidns05 timeout (was: [PATCH 1/2] lib:
 multiply the timeout if detect slow kconfigs)
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
> > Yes, I understand your concern. I agree that we can avoid the
> > kconfig detection for most faster test cases.

> > After reviewing my previous pre-release LTP test and compare to
> > the current main branch test, it doesn't show much more time-consuming,
> > maybe there is different HW/kernel factors, but the performance
> > impact can be ignored.

> I've just send a patch that caches the detection results, because in the
> case of pins05 we did parse the config for each SAFE_CLONE() call.

Thanks! Elegant solution, I should have come up with static myself instead of
complaining :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
