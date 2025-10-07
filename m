Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DADCCD185
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 15:50:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 276B43CE510
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 17:50:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18E043CE486
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 17:49:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5636C1400BC7
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 17:49:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9CC7F336F1;
 Tue,  7 Oct 2025 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759852195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syJ+jBKrpgpFnF3GO32sXbWdtv8XLxO3vYa/LfEY69U=;
 b=KVDj/7a+WGkgufVGSTmTIhdCGOL0HXMFrukjgtFUVrBFE9OgSiQ6uZCzWLL5Pk9wfAwoFu
 7yCBXZwHf2WH+EvcIFkdOWbTscx0N7MHoiFpvNA/NX2hivF0eJO0egF9JzaNajlrxGnx+6
 SI+FpfanrTlT1vUW4wYr7Vv5rC+3B5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759852195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syJ+jBKrpgpFnF3GO32sXbWdtv8XLxO3vYa/LfEY69U=;
 b=sgKoqNH7xcXVVregsDkj8oVmzOZAi8o9MzKMs0zzbVGBslkx8+FMYuUDdCTd4EGxwEXgGS
 MN3vF5KqQvLCmcBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="KVDj/7a+";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sgKoqNH7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759852195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syJ+jBKrpgpFnF3GO32sXbWdtv8XLxO3vYa/LfEY69U=;
 b=KVDj/7a+WGkgufVGSTmTIhdCGOL0HXMFrukjgtFUVrBFE9OgSiQ6uZCzWLL5Pk9wfAwoFu
 7yCBXZwHf2WH+EvcIFkdOWbTscx0N7MHoiFpvNA/NX2hivF0eJO0egF9JzaNajlrxGnx+6
 SI+FpfanrTlT1vUW4wYr7Vv5rC+3B5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759852195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=syJ+jBKrpgpFnF3GO32sXbWdtv8XLxO3vYa/LfEY69U=;
 b=sgKoqNH7xcXVVregsDkj8oVmzOZAi8o9MzKMs0zzbVGBslkx8+FMYuUDdCTd4EGxwEXgGS
 MN3vF5KqQvLCmcBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F3A413693;
 Tue,  7 Oct 2025 15:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lfA2HqM25Wj0VQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 Oct 2025 15:49:55 +0000
Date: Tue, 7 Oct 2025 17:49:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
Message-ID: <20251007154954.GB140031@pevik>
References: <20251006-remove_todo-v1-1-5bab5f6f77f5@suse.com>
 <20251007083814.GA109182@pevik> <aOTnruayNBq5JYDK@yuki.lan>
 <20251007154419.GA140031@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251007154419.GA140031@pevik>
X-Rspamd-Queue-Id: 9CC7F336F1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto,gmane.org:url];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Remove TODO
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Hi!
> > > > TODO file is not updated and it talks about goals we already reached via
> > > > new LTP documentation. In general, it contains generic and random topics
> > > > which none is updating anymore, so it's better to remove it in order to
> > > > create less confusion for new comers. If we really want to have a TODO
> > > > list, probably the best place would be doc/ folder.

> > > I vote to have it. So yes, update it and convert it to REST format and move to
> > > doc/.

> > Well the TODO list points in there are mostly generic and are not going
> > to be finished anytime soon. E.g. "write more syscall tests" I'm not
> > sure how useful such documentation will be. Maybe we need a "where to
> > start" guide for a new devs, but I'm afraid that it would have to be
> > written from scratch.

> I'm not against the removal. "Write more syscall tests" contains valid points
> (LWN, man pages git repo), but agree it'd have to be completely rewritten.
> If anybody writes that, mentioning CVE reproducers in kernel and (g)libc commit
> messages would be also useful.

-[3] http://dir.gmane.org/gmane.linux.kernel.api
And link to https://lore.kernel.org/linux-api/ might be useful, although I
personally don't follow it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
